# so that we can use gcp abc^..def
alias git="noglob git"

alias gb='git branch'
alias br='git branch -vv'
alias newbr='git switch -c'
alias sw='git switch'
alias switch='git switch'
alias delbr='git branch -d'
alias delremote='git push origin --delete'
alias gs='git status -s'
alias ga='git add'
alias gap='git add -p'
alias patch='gap'
alias gc='git commit -n'
alias commit='git commit'
alias gcm='git commit -n -m'
alias gcam='git commit -a -n -m'
alias gcamp='git commit -a -m'
alias amend='git commit -n --amend --no-edit'
alias all='git commit -a -m'
alias pull='git pull'
alias push='git push'
alias merge='git merge'
alias gf='git fetch'
alias nix='git reset --hard'
alias grh='git reset --hard'
alias clean='git clean --dry-run'
alias cleanf='git clean -f'
alias nuke='find . -name "node_modules" -type d -prune -exec rm -vrf '{}' +'
alias stash='git stash'
alias stashm='git stash push -m'
alias pop='git stash pop'
alias list='git stash list'
alias drop='git stash drop'
alias back='git reset HEAD~'
alias fixup="git log -n 20 --pretty=format:'%h %s' --no-merges | fzf | cut -c -7 | xargs -o git commit --fixup"
alias wip='git add . && git commit -n -m "wip."'
alias grbia='num=($1); echo $1 $num; if [[ ! "${num}" =~ ^[0-9]+$ ]]; then echo "grbia: Please enter a valid number."; return 1; fi; git rebase -i --autosquash HEAD~${num};'
alias check1='git diff | grep -C 2 "TODO\|console.log"'

alias ngrokgo='ngrok http --domain=lemming-coherent-boa.ngrok-free.app 8000'

alias prc='gh pr create -a @me'
alias prw='gh pr create -w'
alias prv='gh pr view -w'
alias prvt='gh pr view'

alias nuketags='git tag -l | xargs git tag -d && git fetch --tags'

alias format='npm format'
alias ns='npm start'
alias nrw='npm watch'
alias nt='npm test'
alias bk='npm run serve'
alias runbk='bk'

alias bin='trash'
alias rm='trash'

alias alacritty='code ~/.config/alacritty/alacritty.toml'
alias zshconf='nvim ~/.zshrc'
alias tmuxconf='code ~/.tmux.conf'
alias reloadtmux='tmux source ~/.tmux.conf'
alias comp='__git_complete'
alias reload='exec zsh'

alias hist="git log --pretty=format:'%h %ad | %s%d [%an]' --graph --date=short -n 10"
alias prune-dry="git branch --v | grep '\gone\]' | awk '{print \$1}'"
alias prune="git fetch && git branch --v | grep '\gone\]' | awk '{print \$1}' | xargs git branch -D"

alias letsgo="./start_tmux.sh"
alias alldone="tmux kill-server"
alias kill1="kill -s QUIT %1"
alias kill2="kill -s QUIT %2"
alias kill3="kill -s QUIT %3"
alias kill4="kill -s QUIT %4"

alias setalias="chezmoi edit ~/.oh-my-zsh/custom/aliases.zsh"

alias karabiner="keyboard"
alias keyboard="chezmoi edit ~/.keyboard/karabiner.json"

alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc"

# Spruce
alias setenv="export $(cat .env | xargs)"
alias dmc="npm run client:start"
alias dma="npm run api:start"
alias dms="npm run dev"
alias dev='git switch staging'
alias devp='git switch staging && git pull'
alias gpod='git merge origin staging'

# AI
alias csa="cursor-agent"
