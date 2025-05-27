PACKAGES=(
    "spotify"
)

for PACKAGE in ${PACKAGES[@]}; do

    # &> /dev/null — это способ полностью скрыть вывод команды, чтобы он нигде не отображался.
    # &> — это оператор оболочки, который говорит: «отправить всё (и stdout, и stderr)».

    if snap list "$PACKAGE" &> /dev/null; then
        :  # встроенная команда Bash для “ничего не делать”
        # echo "$PACKAGE installed"
    else
        # echo "$PACKAGE is not installed"
        echo "sudo dnf install $PACKAGE"
    fi
done
