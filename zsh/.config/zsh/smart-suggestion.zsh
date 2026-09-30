# Ctrl-O asks an LLM to complete the current line; shown through zsh-autosuggestions.
# The binary is built by ~/dotfiles/smart-suggestion/install.sh: upstream auto-update
# would replace it with a build that can't turn thinking off (10s+ per suggestion).
[[ -r $HOME/.config/smart-suggestion/smart-suggestion.plugin.zsh ]] || return 0

_zas=/opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -r $_zas ]] || _zas=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -r $_zas ]] || { unset _zas; return 0; }
source $_zas
unset _zas

export SMART_SUGGESTION_AI_PROVIDER=deepseek
export SMART_SUGGESTION_AUTO_UPDATE=false
export SMART_SUGGESTION_PROXY_MODE=false
# magpie's local gateway picks the vendor from the model name and trusts loopback,
# so the key is only a placeholder.
export DEEPSEEK_BASE_URL="http://127.0.0.1:3425/v1"
export DEEPSEEK_API_KEY=magpie
export DEEPSEEK_MODEL=bailian/deepseek-v4-flash-0731
export DEEPSEEK_ENABLE_THINKING=false

source $HOME/.config/smart-suggestion/smart-suggestion.plugin.zsh
