# Did You Mean?

**Did You Mean?** is a Zsh plugin for [Oh My Zsh](https://ohmyz.sh/) that detects commands typed with the wrong keyboard layout and suggests the corresponding command.

Currently, it converts only Russian keyboard-layout input to English.

## Installation

Clone the repository into your Oh My Zsh custom plugins directory:

```zsh
git clone https://github.com/superjaba2000/zsh-did-you-mean.git \
  "${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/plugins/did-you-mean"
```

Add `did-you-mean` to the `plugins` array in `~/.zshrc`:

```zsh
plugins=(
  # ...
  
  did-you-mean
)
```

Reload the configuration:

```zsh
source ~/.zshrc
```

## Usage

If you type `ls` using the Russian keyboard layout (`ды`), the plugin suggests `ls` and asks for confirmation before executing it.

Press **Enter** or **Y** to accept the suggestion, or **n** to decline.

## Requirements

- Zsh
- Oh My Zsh

## License

See [LICENSE](LICENSE) for license terms.
