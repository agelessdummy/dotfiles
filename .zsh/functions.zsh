#https://itchyny.hatenablog.com/entry/20130227/1361933011
# http://www.joshuad.net/zshrc-config/
# intellegently extract archives based on extension. 

alias -s {gz,tgz,zip,lzh,bz2,tbz,Z,tar,arj,xz}=extract
function extract() {
  case $1 in
    *.tar.gz|*.tgz) tar xzvf $1;;
    *.tar.xz) tar Jxvf $1;;
    *.zip) unzip $1;;
    *.lzh) lha e $1;;
    *.tar.bz2|*.tbz) tar xjvf $1;;
    *.tar.Z) tar zxvf $1;;
    *.gz) gzip -d $1;;
    *.bz2) bzip2 -dc $1;;
    *.Z) uncompress $1;;
    *.tar) tar xvf $1;;
    *.arj) unarj $1;;
  esac
}

# Make a directory and cd into it
#function take {
function mkcd {
	mkdir -p $1
	cd $1
}

# web_search from terminal
function web_search() {
  emulate -L zsh

  # define search engine URLS
  typeset -A urls
  urls=(
    google      "https://www.google.com/search?q="
    ddg         "https://www.duckduckgo.com/?q="
    github      "https://github.com/search?q="
  )

  # check whether the search engine is supported
  if [[ -z "$urls[$1]" ]]; then
    echo "Search engine $1 not supported."
    return 1
  fi

  # search or go to main page depending on number of arguments passed
  if [[ $# -gt 1 ]]; then
    # build search url:
    # join arguments passed with '+', then append to search engine URL
    url="${urls[$1]}${(j:+:)@[2,-1]}"
  else
    # build main page url:
    # split by '/', then rejoin protocol (1) and domain (2) parts with '//'
    url="${(j://:)${(s:/:)urls[$1]}[1,2]}"
  fi

  open_command "$url"
}

#use generalized open command
function open_command() {
  emulate -L zsh
  setopt shwordsplit

  local open_cmd

  # define the open command
  case "$OSTYPE" in
    darwin*)  open_cmd='open' ;;
    cygwin*)  open_cmd='cygstart' ;;
    linux*)   open_cmd='xdg-open' ;;
    msys*)    open_cmd='start ""' ;;
    *)        echo "Platform $OSTYPE not supported"
              return 1
              ;;
  esac

  # don't use nohup on OSX
  if [[ "$OSTYPE" == darwin* ]]; then
    $open_cmd "$@" &>/dev/null
  else
    nohup $open_cmd "$@" &>/dev/null
  fi
}


# starts one or multiple args as programs in background
background() {
  for ((i=2;i<=$#;i++)); do
    ${@[1]} ${@[$i]} &> /dev/null &
  done
}

alias -s {htm,html}='background firefox'
alias -s {pdf,PDF}='background okular'
alias -s {mp4,MP4,mov,MOV,avi}='background vlc'
alias -s {zip,ZIP}="unzip -l"
alias -s {wav,ogg,mp3}='background mplayer'


#vim tags
function _get_tags {
  [ -f ./tags ] || return
  local cur
  read -l cur
  cur=`echo $cur | grep -o -- "-t[[:space:]]\+[[:alnum:]]\+" | cut -d' ' -f2`
  reply=(${=$(cat ./tags | grep "^${cur}" | cut -f1)})
}
compctl -x 'C[-1,-t]' -K _get_tags -- vim
#end vim tag

# http://fendrich.se/blog/2012/09/28/no/

function get_RAM {
  free -m | awk '{if (NR==3) print $4}' | xargs -i echo 'scale=1;{}/1000' | bc
}

function get_nr_jobs() {
  jobs | wc -l
}

function get_nr_CPUs() {
  grep -c "^processor" /proc/cpuinfo
}

function get_load() {
  uptime | awk '{print $11}' | tr ',' ' '
}

# Show dots while waiting for tab-completion
expand-or-complete-with-dots() {
	# toggle line-wrapping off and back on again
	[[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti rmam
	print -Pn "%{%F{red}......%f%}"
	[[ -n "$terminfo[rmam]" && -n "$terminfo[smam]" ]] && echoti smam

	zle expand-or-complete
	zle redisplay
}
zle -N expand-or-complete-with-dots
bindkey "^I" expand-or-complete-with-dots
