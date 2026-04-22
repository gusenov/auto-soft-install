#!/bin/bash
set -x  # echo on

QDB_VERSION="9.3.5"

# https://questdb.com/docs/deployment/systemd/
function Download_Oracle()
{

# Download and install the JDK
curl -s https://download.oracle.com/java/17/latest/jdk-17_linux-x64_bin.tar.gz -o jdk.tar.gz
mkdir -p ~/jdk
tar -xzf jdk.tar.gz -C ~/jdk --strip-components=1
export JAVA_HOME=~/jdk
export PATH=$JAVA_HOME/bin:$PATH

}

function Install_OpenJDK()
{

sudo apt update
sudo apt install -y openjdk-17-jdk-headless

# Проверка
java -version

}

function Download_QuestDB()
{

cur_dir=$(pwd)

# The first time pushd dir is called, pushd pushes the current directory onto the stack, then cds to dir and pushes it onto the stack.
pushd "$cur_dir"

cd /tmp

# https://questdb.com/download/
curl -L https://github.com/questdb/questdb/releases/download/$QDB_VERSION/questdb-$QDB_VERSION-rt-linux-x86-64.tar.gz -o questdb.tar.gz

# popd removes the top directory off the stack, revealing a new top. Then it cds to the new top directory.
popd

}

# https://questdb.com/docs/deployment/systemd/
function Run_systemd_as_a_user_with_its_own_privileges()
{

# В user-сервисе QuestDB работает от вашего обычного пользователя, у которого есть доступ ко всем вашим файлам, SSH-ключам, .bashrc и т.д.

# Download and set up QuestDB
Download_QuestDB
mkdir -p ~/questdb/binary
tar -xzf /tmp/questdb.tar.gz -C ~/questdb/binary --strip-components 1
mv ~/questdb/binary/questdb.jar ~/bin/

# touch questdb.service
# Next, move your questdb.service file into your user's systemd config:
mv ./HOME/.config/systemd/user/questdb.service  ~/.config/systemd/user/questdb.service

# Enable the service:
systemctl --user enable questdb.service

# Start the service:
systemctl --user start questdb

# Check out the service status:
systemctl --user status questdb.service

# Your QuestDB instance should now be accessible at localhost, with services available at the following default ports:

# Web Console & REST API is available on port 9000
# PostgreSQL wire protocol available on 8812
# InfluxDB line protocol 9009 (TCP and UDP)
# Health monitoring & Prometheus /metrics 9003

}

function Run_systemd_as_the_system_from_root_permissions()
{

# в системном сервисе QuestDB работает от пользователя questdb, у которого нет shell и нет доступа к домашним директориям других пользователей. 
# Если процесс скомпрометирован — атакующий получает только то, что принадлежит questdb.
# Для продакшена с публичным доступом системный сервис предпочтительнее.

# Создаём директории
sudo mkdir --parents /opt/questdb/data
sudo mkdir --parents /opt/questdb/conf

# Создаём системного пользователя
sudo useradd --system --create-home --home-dir /opt/questdb --shell /bin/false questdb
sudo chown --recursive questdb:questdb /opt/questdb

# Скачиваем последнюю версию
Download

# Распаковываем и копируем
tar xzf "questdb.tar.gz"
sudo cp -r "questdb-${QDB_VERSION}-rt-linux-x86-64/"* /opt/questdb/
sudo chown --recursive questdb:questdb /opt/questdb

# sudo nano /etc/systemd/system/questdb.service
mv ./etc/systemd/system/questdb.service /etc/systemd/system/questdb.service

# Включаем и запускаем:

sudo systemctl daemon-reload


sudo systemctl enable questdb
# Created symlink '/etc/systemd/system/multi-user.target.wants/questdb.service' → '/etc/systemd/system/questdb.service'.

# systemctl enable questdb создаёт symlink в /etc/systemd/system/multi-user.target.wants/ — это и есть механизм автозапуска. 
# При загрузке Debian systemd увидит сервис и запустит его автоматически.
# Проверить можно так:
sudo systemctl is-enabled questdb
# Должно вернуть enabled.


sudo systemctl start questdb
#sudo systemctl status questdb

# Логи и диагностика

# Просмотр логов сервиса
# journalctl -u questdb -f

# Логи самого QuestDB
#tail -f /opt/questdb/data/log/questdb-rolling.log*

# Порты QuestDB
# | Порт | Протокол        | Назначение                              |
# | ---- | --------------- | --------------------------------------- |
# | 9000 | HTTP            | Web Console + REST API                  |
# | 9009 | ILP             | InfluxDB Line Protocol (быстрая запись) |
# | 8812 | PostgreSQL wire | Подключение любых PG-клиентов           |
}

function Firewall()
{

# по умолчанию QuestDB не имеет аутентификации на Web Console, так что держать порты закрытыми правильно.
# Если приложение на том же сервере, UFW вообще не трогайте — localhost-трафик UFW не блокирует по умолчанию.

# Только если нужен доступ к Web Console с конкретного IP
sudo ufw allow from YOUR_IP to any port 9000 comment "QuestDB Web"

# Если приложение на другом сервере шлёт данные по ILP
sudo ufw allow from APP_SERVER_IP to any port 9009

# ILP для агентов в локальной сети
sudo ufw allow from 192.168.1.0/24 to any port 9009 comment "QuestDB ILP"

# Если нужен PostgreSQL-клиент с конкретного IP
sudo ufw allow from YOUR_IP to any port 8812

# PostgreSQL-клиенты
sudo ufw allow from 192.168.1.0/24 to any port 8812 comment "QuestDB PG"

sudo ufw reload

}

# Download_Oracle
# Install_OpenJDK

# Run_systemd_as_a_user_with_its_own_privileges
# Run_systemd_as_the_system_from_root_permissions

# Firewall
