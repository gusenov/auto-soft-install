is_flatpak_installed() {
    flatpak list --app | grep -w "$1" > /dev/null 2>&1
    # Если пакет установлен, команда grep вернет строку с его описанием, и статус завершения будет равен 0. 
    # Если не установлен — строка будет пустой, и статус завершения будет отличен от 0.
}

PACKAGES=(
    "com.github.PintaProject.Pinta"
)

for PACKAGE in ${PACKAGES[@]}; do

    # &> /dev/null — это способ полностью скрыть вывод команды, чтобы он нигде не отображался.
    # &> — это оператор оболочки, который говорит: «отправить всё (и stdout, и stderr)».

    if is_flatpak_installed "$PACKAGE" &> /dev/null; then
        :  # встроенная команда Bash для “ничего не делать”
        # echo "$PACKAGE installed"
    else
        # flathub — это имя удалённого репозитория Flatpak, из которого будет производиться установка. 
        # Flathub — крупнейший основной репозиторий приложений Flatpak.

        # echo "$PACKAGE is not installed"
        echo "flatpak install flathub $PACKAGE"
    fi
done
