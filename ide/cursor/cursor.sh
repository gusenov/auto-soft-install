ARCH="x64"
PACKAGE_FORMAT="rpm"
VERSION="2.4"
DOWNLOAD_URL="https://api2.cursor.sh/updates/download/golden/linux-$ARCH-$PACKAGE_FORMAT/cursor/$VERSION"

# В bash результат команды можно записать в переменную через $() или обратные кавычки.
FILE_NAME=$(curl -s -L -I -o /dev/null -w "%{url_effective}\n" "$DOWNLOAD_URL" | awk -F/ '{print $NF}')
# -s → тихий режим (не выводит прогресс).
# -L → следовать редиректам.
# -I → только заголовки (не скачиваем тело).
# -o /dev/null → игнорировать вывод тела.
# -w "%{url_effective}\n" → выводит финальный URL после редиректов.
FILE_PATH="/tmp/$FILE_NAME"

function download()
{

    # Флаг -L заставляет curl автоматически следовать HTTP-редиректам (коды 3xx), 
    # пока не дойдет до итогового URL.
    curl -o "/tmp/$FILE_NAME" -L "$DOWNLOAD_URL"
    echo "$FILE_PATH"
}

function install()
{
    sudo dnf install "$FILE_PATH"
}

download
install
