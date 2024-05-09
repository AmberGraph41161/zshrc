### CUSTOM ALIASES ###
	#Goofy ah aliases
		alias please="sudo"
		alias PLEASE="doas"

	#NVIM EVERYTHING!!!!
		alias edit="nvim"
		alias nvimzsh="nvim ~/.zshrc"
		alias nvims="nvim -S session.vim"
		alias bruh="tmux -u" #"-u" flag unsures that UTF-8 or UNICODE characters print out
		alias ok="nvim ~/.zshrc"

	#Are You Sure What You Are About To Do Is Not Stupid?
		alias rm="rm -iv" #prompt before removal, verbose
		alias mv="mv -iv" #prompt before removal, verbose
		alias mkdir="mkdir -pv" #create parent directories if not existing, verbose
		alias rmdir="rmdir -pv" #remove parent directories if existing, verbose
		alias cp="cp -iv" #prompt before overwrite, verbose
		alias ln="ln -iv" #prompt before doing link stuff just in case
	
	#Useful
		alias ls="ls --color=auto"
		alias ll="ls -l"
		alias lsls="ls -la"
		alias la="ls -a"
		alias lsd="find . -maxdepth 1 -type d"
		alias cls="clear"

		alias mixer="alsamixer"

		function rmfzf() { rm -iv "$(fzf)" }
		function cpfzf() { cp -iv "$(fzf)" "$1" }
		function mvfzf() { mv -iv "$(fzf)" "$1" }

	#CD Shortcuts
		alias cdnvim="cd ~/.config/nvim" #easier and faster to type letters and not "special chars" ya know?
		alias cddiscord="cd /opt/discord/resources/" #faster way to update discord idk
		alias cdmovies="cd ~/STUFF/MyPhotos/Saves/Movies" #MOVIE TIME YOOOOO
		alias cdmemes="cd ~/STUFF/MyPhotos/MEMES/"
		alias cdalacritty="cd ~/.config/alacritty/"
		alias cdcoding="cd ~/coding/projects/"
		alias cdytdl="cd ~/ytdl/"
		alias cdroms="cd ~/roms/"
		alias cdhypr="cd ~/.config/hypr/"

	#Shortcut Commands To Long Bois
		alias yt-dlpAUDIO="yt-dlp --extract-audio --audio-format mp3 --write-sub --embed-thumbnail --embed-metadata --retries 3" #personal preferred settings
		alias yt-dlpVIDEO="yt-dlp --format mp4 --embed-metadata" #personal preferred settings
		alias yt-dlpMP4="yt-dlp --format mp4 --embed-metadata" #personal preferred settings
		
	#Run Custom Written Binaries
		alias permutate="~/coding/binaries/permutate/permutate"
		alias rbv="~/coding/binaries/RBV/RBV"
		alias rgb="~/coding/binaries/betterSFMLrgb/main"

	#SHRED THE EVIDENCE HIDE THE EVIDENCE KILL THE EVIDENCE GET RID OF THE EVIDENCE
		alias shredshred="shred -fuzv"
		alias shredshredshred="shred -fuzvn10"

	#rice long bois
		alias neofetch="neofetch | lolcat" #RGB go BRRRRRR
		alias pipes="pipes.sh -p 10 -t 1 -r 10000 -R"
		alias music="ncmpcpp"
		alias musicc="~/.ncmpcpp/ncmpcpp-ueberzug"
		#alias chararbv="chara say "$(rbv)" | lolcat"
		alias pokemon="krabby random | sed \"1,1d\""

### BASIC OPTIONS ###
	setopt HIST_APPEND #APPEND_HISTORY
	SAVEHIST=100000

	REPORTTIME=1 #seconds
	REPORTMEMORY=1024 #kilobytes


### PROMPT ###
	#LEFT PROMPT
		PROMPT="[%F{red}%n%f] %F{green}%~%f %# "

		setopt CORRECT
		setopt CORRECT_ALL
		#SPROMPT="zsh: correct '%R' to '%r' [nyae]? " #default prompt
		SPROMPT="zsh: correct '%R' to '%r' [nyae]? "

	#RIGHT PROMPT RPROMPT
		RPROMPT_COMMANDSTATUS_0="%(0?.%F{green}ok%f." #good
		RPROMPT_COMMANDSTATUS_126="%(126?.%? %F{red}bad perms!%f." #executable file has insufficient permissions
		RPROMPT_COMMANDSTATUS_127="%(127?.%? %F{red}not found!%f." #command not found!
		RPROMPT_COMMANDSTATUS_130="%(130?.%? %F{red}cbreak!%f." #ctrl-c, abort
		RPROMPT_COMMANDSTATUS_148="%(148?.%? %F{red}zbreak!%f." #ctrl-z, suspend
		RPROMPT_COMMANDSTATUS_END="%? %F{red}wut?%f)))))" #idk what error code you're giving me lol
		RPROMPT_COMMANDSTATUS="$RPROMPT_COMMANDSTATUS_0$RPROMPT_COMMANDSTATUS_126$RPROMPT_COMMANDSTATUS_127$RPROMPT_COMMANDSTATUS_130$RPROMPT_COMMANDSTATUS_148$RPROMPT_COMMANDSTATUS_END"

		PROMPT="[%F{red}%n%f] %F{green}%~%f %# "
		RPROMPT_JOBSTATUS="%(1j.%(2j. [%F{cyan}%j jobs%f]. [%F{cyan}%j job%f]). )"

		function zle-line-init zle-keymap-select { #ripped this off the internet lol
			RPROMPT_VISTATUS_NORMAL="[%F{green}NORMAL%f]"
			RPROMPT_VISTATUS_INSERT="[%F{blue}INSERT%f]"
			RPROMPT_VISTATUS="${${KEYMAP/vicmd/$RPROMPT_VISTATUS_NORMAL}/(main|viins)/$RPROMPT_VISTATUS_INSERT}"
			RPROMPT="$RPROMPT_COMMANDSTATUS$RPROMPT_JOBSTATUS$RPROMPT_VISTATUS"
			zle reset-prompt
		}
		zle -N zle-line-init
		zle -N zle-keymap-select

		RPROMPT="$RPROMPT_COMMANDSTATUS$RPROMPT_JOBSTATUS$RPROMPT_VISTATUS"
		setopt TRANSIENT_RPROMPT #RPROMPT follows you and isnt left behind in previous command

### KEYBINDS ###
	#note to self:
	#	use "cat" and hit enter, click home and end keys to see what is sent to terminal
	#	bind what is sent to terminal to desired result

#man this is stupid. should be a given IMO
bindkey "^[[1~" beginning-of-line
bindkey "^[[4~" end-of-line
bindkey "^[[3~" delete-char

#vim editing keys
bindkey -v
bindkey -a "^[[1~" vi-beginning-of-line
bindkey -a "^[[4~" vi-end-of-line











#"
#prompt_command_execution_time() {
#  (( $+P9K_COMMAND_DURATION_SECONDS )) || return
#  (( P9K_COMMAND_DURATION_SECONDS >= _POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD )) || return
#
#  if (( P9K_COMMAND_DURATION_SECONDS < 60 )); then
#    if (( !_POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION )); then
#      local -i sec=$((P9K_COMMAND_DURATION_SECONDS + 0.5))
#    else
#      local -F $_POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION sec=P9K_COMMAND_DURATION_SECONDS
#    fi
#    local text=${sec}s
#  else
#    local -i d=$((P9K_COMMAND_DURATION_SECONDS + 0.5))
#    if [[ $_POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT == "H:M:S" ]]; then
#      local text=${(l.2..0.)$((d % 60))}
#      if (( d >= 60 )); then
#        text=${(l.2..0.)$((d / 60 % 60))}:$text
#        if (( d >= 36000 )); then
#          text=$((d / 3600)):$text
#        elif (( d >= 3600 )); then
#          text=0$((d / 3600)):$text
#        fi
#      fi
#    else
#      local text="$((d % 60))s"
#      if (( d >= 60 )); then
#        text="$((d / 60 % 60))m $text"
#        if (( d >= 3600 )); then
#          text="$((d / 3600 % 24))h $text"
#          if (( d >= 86400 )); then
#            text="$((d / 86400))d $text"
#          fi
#        fi
#      fi
#    fi
#  fi
#
#  _p9k_prompt_segment "$0" "red" "yellow1" 'EXECUTION_TIME_ICON' 0 '' $text
#}
#"
