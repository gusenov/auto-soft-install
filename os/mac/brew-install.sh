function InstallHomebrew()
{
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
}

brew install git-gui
brew install git-remote-gcrypt
brew install gh

brew install gnupg
brew install pinentry-mac
#echo "pinentry-program $(which pinentry-mac)" >> ~/.gnupg/gpg-agent.conf

brew install copilot-cli  # https://github.com/features/copilot/cli
brew install gemini-cli  # https://geminicli.com/docs/get-started/installation/
brew install qwen-code  # https://github.com/QwenLM/qwen-code
brew install --cask claude-code  # https://code.claude.com/docs/en/quickstart
brew install --cask codex  # https://github.com/openai/codex
brew install --cask cursor-cli
brew install --cask cursor

brew install --cask vscodium  # https://vscodium.com/#install-with-brew-mac
brew install --cask jetbrains-toolbox
brew install --cask zed  # https://zed.dev/docs/installation
#brew install --cask zed@preview  # https://zed.dev/docs/installation
brew install --cask eclipse-cpp
brew install --cask sublime-text
brew install --cask sublime-merge
brew install --cask emacs  # https://www.gnu.org/software/emacs/download.html#nonfree
brew install --cask textmate

brew install --cask keepassxc
#brew install --cask lantern  # https://github.com/getlantern/lantern/tree/c747c12132fd629901a9f64ee4f3426d5b254836
brew install --cask protonvpn
#brew install tor
brew install --cask tor-browser

brew install --cask libreoffice
brew install --cask xnviewmp
brew install --cask inkscape