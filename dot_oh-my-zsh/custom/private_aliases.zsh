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
alias master='git switch master'
alias dev='git switch develop'
alias devp='git switch develop && git pull'
alias gpod='git merge origin develop'
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
alias check='npx lint-staged && npm run lint:pretty-quick && npm run typecheck:affected && cd -'

alias ngrokgo='ngrok http --domain=lemming-coherent-boa.ngrok-free.app 8000'

alias prc='gh pr create -a @me'
alias prw='gh pr create -w'
alias prv='gh pr view -w'
alias prvt='gh pr view'

alias nuketags='git tag -l | xargs git tag -d && git fetch --tags'

alias format='npm format'
alias nrb='npm run build:application'
alias nrbc='npm run build -w @novata/common'
alias nrbd='npm run build -w @novata/domain'
alias nrba='npm run build -w @novata/authz'
alias ns='npm start'
alias nrw='npm watch'
alias nt='npm test'
alias bk='npm run serve'
alias runbk='bk'
alias migrate='npm run db:migrate && npm run db:load:fiction'
alias migratet='npm run db:reset:integration'
alias newmigrate='npm run db:migrate:create -w @novata/server'
alias setupdb='npm run setup:oso && npm run setup:redis && npm run setup:localstack'
alias setuposo='export OSO_AUTH=e_0123456789_12345_osotesttoken01xiIn && export OSO_URL=http://localhost:8080 && export DATABASE_URL="postgresql://postgres:Pass2020NothingSpecial@localhost:5432/novata" && npm run sync:oso-fiction-factset && npm run sync:oso-policy'
alias dmc='npm run start -w @novata/client'
alias dms='generate && npm run start -w @novata/server'
alias dms2='nx start:server'
alias dmp='npm run dev -w @novata/privco-client'
alias dmsp='npm run dev -w @novata/privco-client & npm run start -w @novata/server'
alias dmps='dmsp'
alias dmsc1='npm run setup:localstack && dmsc'
alias dmsc='nx run-many --targets start -p @novata/client @novata/server'
alias dmkit='cd packages/novakit && npx storybook dev -p 6006 --no-open'
alias dmw='npm run start:queue'
alias generate='npm run db:generate'

alias testmld='npm run test -w @novata/multi-level-data'
alias testpri='npm run test -w @novata/privco-client'
alias testcar='npm run test -w @novata/carbon-navigator'
alias testcsr='npm run test -w @novata/csrd-client'
alias testdwa='npm run test -w @novata/data-workspace-api'
alias testdat='npm run test -w @novata/data-workspace'
alias testser='npm run test:integration -w @novata/server -- --watch --testPathPattern'
alias testdom='npm run test:integration -w @novata/domain -- --watch --testPathPattern'
alias testcli='npm run test:unit -w @novata/client -- --watch --testPathPattern'
alias testcom='npm run test:unit -w @novata/common -- --watch --testPathPattern'
alias testnov='npm run test:unit -w @novata/novakit -- --watch --testPathPattern'

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

alias iphone="open -a Simulator --args -CurrentDeviceUDID 4F593FB4-CCE0-468A-846D-E99B4DB5093F"

alias letsgo="./start_tmux.sh"
alias alldone="tmux kill-server"
alias kill1="kill -s QUIT %1"
alias kill2="kill -s QUIT %2"
alias kill3="kill -s QUIT %3"
alias kill4="kill -s QUIT %4"

alias setalias="nvim ~/.oh-my-zsh/custom/aliases.zsh"

alias karabiner="keyboard"
alias keyboard="nvim ~/.keyboard/karabiner.json"

alias jsc="/System/Library/Frameworks/JavaScriptCore.framework/Versions/Current/Helpers/jsc"
