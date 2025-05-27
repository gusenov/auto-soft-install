# https://docs.flutter.dev/get-started/install/linux/web
# https://docs.flutter.dev/platform-integration/linux/setup

echo "Install packages"

PACKAGES=(
    # web apps

    "curl"
    "git" 
    "unzip" 
    
    # В Fedora пакет, предоставляющий поддержку для xz (LZMA), называется xz, 
    # а не xz-utils, как в Ubuntu/Debian.
    "xz"  # "xz-utils" 
    
    "zip" 

    # В Fedora пакет, аналогичный libglu1-mesa из Ubuntu/Debian, называется mesa-libGLU.
    # Это предоставит необходимые библиотеки для работы с OpenGL, 
    # которые требуются для Flutter и других приложений, использующих графику.
    "mesa-libGLU"  # "libglu1-mesa"

    # to debug JavaScript code for web apps
    "google-chrome-stable"

    "code"

    # Linux

    "clang"
    "cmake"
    "ninja-build"
    
    # В Fedora пакет pkg-config — это просто метапакет (или виртуальный пакет), 
    # который на самом деле устанавливает основной пакет pkgconf-pkg-config.
    # Команда dnf list installed pkg-config ничего не выводит, 
    # потому что такого реального пакета нет — он виртуальный.
    "pkgconf-pkg-config"  # "pkg-config"

    # В Fedora аналог пакета libgtk-3-dev из Ubuntu/Debian — это gtk3-devel.
    "gtk3-devel"  # "libgtk-3-dev"
    
    # В Fedora аналог пакета libstdc++-12-dev из Ubuntu/Debian — это libstdc++-devel.
    "libstdc++-devel"  # "libstdc++-12-dev"

    # В Fedora эквивалентом пакета mesa-utils из Ubuntu/Debian является тоже пакет с названием mesa-demos.
    # Этот пакет содержит утилиты, такие как glxinfo, eglinfo и другие инструменты для диагностики OpenGL/GLX/EGL, аналогично mesa-utils в Ubuntu.
    "mesa-demos"
)

SHOULD_EXIT=false

for PACKAGE in ${PACKAGES[@]}; do

    # &> /dev/null — это способ полностью скрыть вывод команды, чтобы он нигде не отображался.
    # &> — это оператор оболочки, который говорит: «отправить всё (и stdout, и stderr)».

    if dnf list installed "$PACKAGE" &> /dev/null; then
        :  # встроенная команда Bash для “ничего не делать”
        # echo "$PACKAGE installed"
    else
        # echo "$PACKAGE is not installed"
        echo "sudo dnf install $PACKAGE"

        SHOULD_EXIT=true
    fi
done

if [ "$SHOULD_EXIT" = true ] ; then
    exit 1
fi

echo "Flutter extension"

EXTENSIONS=(
    "Dart-Code.flutter"
)

is_extension_installed() {
    code --list-extensions | grep --ignore-case "$1"
}

for EXTENSION in ${EXTENSIONS[@]}; do

    # &> /dev/null — это способ полностью скрыть вывод команды, чтобы он нигде не отображался.
    # &> — это оператор оболочки, который говорит: «отправить всё (и stdout, и stderr)».

    if is_extension_installed "$EXTENSION" &> /dev/null; then
        :  # встроенная команда Bash для “ничего не делать”
        # echo "$EXTENSION installed"
    else
        # echo "$EXTENSION is not installed"
        echo "code --install-extension $EXTENSION"
    fi
done

BUNDLE_VERSION="3.32.0-stable"
BUNDLE_NAME="flutter_linux_$BUNDLE_VERSION.tar.xz"
BUNDLE_URL="https://storage.googleapis.com/flutter_infra_release/releases/stable/linux/$BUNDLE_NAME"

FOLDER_WHERE_INSTALL="$HOME/development/"
echo "Folder where install: $FOLDER_WHERE_INSTALL"

if [ ! -d "$FOLDER_WHERE_INSTALL/flutter" ]; then
    # Ключ -p (или --parents) заставляет команду mkdir создавать директорию только если её ещё нет, 
    # и не выводить ошибку, если она уже существует.
    mkdir -p "$FOLDER_WHERE_INSTALL"

    BUNDLE_FILE="$HOME/Downloads/$BUNDLE_NAME"
    if [ ! -f "$BUNDLE_FILE" ]; then
        
        echo "Download"

        # -s — тихий режим (не выводит прогресс и ошибки).
        curl -o "$BUNDLE_FILE" "$BUNDLE_URL"
        
        echo "Extract"
        tar -xf "$BUNDLE_FILE" -C "$FOLDER_WHERE_INSTALL"
    fi
fi

echo "PATH"

PATH_COMMAND='export PATH="$HOME/development/flutter/bin:$PATH"'

if grep -q "$PATH_COMMAND" "$HOME/.bash_profile"; then
    echo "Path command found"
else
    echo "Path command not found"
    echo "$PATH_COMMAND" >> "$HOME/.bash_profile"
fi
