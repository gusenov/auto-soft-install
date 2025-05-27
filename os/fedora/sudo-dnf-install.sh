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
