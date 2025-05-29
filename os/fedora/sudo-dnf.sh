PACKAGES=(
    "gnome-pomodoro"
    "moreutils"
    "thunderbird"
    "git-gui"
    "snapd"
    "code"

    "xset"
    "xfce4-xkb-plugin"

    "chromium"
    "google-chrome-stable"

    "git-remote-gcrypt"
    "keepassxc"
    "openssl"

    "curl"
    "git" 
    "unzip" 
    "xz"
    "zip"
    "mesa-libGLU"
    
    "clang"
    "cmake"
    "ninja-build"
    "pkgconf-pkg-config"
    "gtk3-devel"
    "libstdc++-devel"
    "mesa-demos"
)

function install()
{
    for PACKAGE in ${PACKAGES[@]}; do

        # &> /dev/null — это способ полностью скрыть вывод команды, чтобы он нигде не отображался.
        # &> — это оператор оболочки, который говорит: «отправить всё (и stdout, и stderr)».

        if dnf list installed "$PACKAGE" &> /dev/null; then
            :  # встроенная команда Bash для “ничего не делать”
            # echo "$PACKAGE installed"
        else
            # echo "$PACKAGE is not installed"
            echo "sudo dnf install $PACKAGE"
        fi
    done
}

function check_update()
{
    for PACKAGE in ${PACKAGES[@]}; do
        dnf check-update "$PACKAGE" > /dev/null 2>&1
        rc=$?

        # dnf check-update возвращает 100 — если есть доступные обновления
        if [ $rc -eq 100 ]; then
            echo "There is update for $PACKAGE, updating..."
            sudo dnf update -y "$PACKAGE"
        elif [ $rc -eq 0 ]; then
            echo "No updates for $PACKAGE"
        else
            echo "Error occurred while checking updates ($rc)"
        fi
    done
}

check_update
