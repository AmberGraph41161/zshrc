### CUSTOM ALIASES ###
	#wayland crap
		alias forcexwayland="env -u WAYLAND_DISPLAY --" # so I can get fcitx crap to work
	
	#wine crap
		alias kakao="wine ~/.wine/drive_c/Program\ Files\ \(x86\)/Kakao/KakaoTalk/KakaoTalk.exe"

	#NVIM EVERYTHING!!!!
		alias edit="nvim"
		alias nvimzsh="nvim ~/.zshrc"
		alias nvims="nvim -S session.vim"
		alias bruh="tmux -u2" #"-u" flag unsures that UTF-8 or UNICODE characters print out

		alias ok="nvim ~/.zshrc"
		alias no="source ~/.zshrc"
		alias reloadzsh="source ~/.zshrc"
		alias zshreload="source ~/.zshrc"

	#Are You Sure What You Are About To Do Is Not Stupid?
		alias rm="rm -iv"
		alias mv="mv -iv"
		alias mkdir="mkdir -v"
		alias rmdir="rmdir -v"
		alias cp="cp -iv"
		alias ln="ln -iv"
	
	#Useful
		alias ls="ls --color=auto"
		alias ll="ls -l"
		alias lsls="ls -la"
		alias la="ls -a"
		alias lsd="find . -maxdepth 1 -type d"
		alias cls="clear"

		function rmfzf() { rm -iv "$(fzf)" }
		function cpfzf() { cp -iv "$(fzf)" "$1" }
		function mvfzf() { mv -iv "$(fzf)" "$1" }

		#deprecated
		#function cdfzf()
		#{
		#	local filepath=$(fzf)
		#	local truncatethispart=$(echo $filepath | grep -o -- '/[^/]*$')
		#	filepath="${filepath%$truncatethispart}/"

		#	cd $filepath

		#	#paranoia
		#	unset filepath
		#	unset truncatethispart
		#}
		function cdfzf()
		{
			cd ${$(fzf)%/*}
		}

	#CD Shortcuts
		alias cdnvim="cd ~/.config/nvim" #easier and faster to type letters and not "special chars" ya know?
		alias cddiscord="cd /opt/discord/resources/" #faster way to update discord idk
		alias cdmovies="cd $HOME/STUFF/MyPhotos/Saves/Movies" #MOVIE TIME YOOOOO
		alias cdmemes="cd $HOME/STUFF/MyPhotos/MEMES/"
		alias cdalacritty="cd ~/.config/alacritty/"
		alias cdcoding="cd $HOME/coding/projects/"
		alias cdytdl="cd $HOME/ytdl/"
		alias cdroms="cd $HOME/roms/"
		alias cdhypr="cd $HOME/.config/hypr/"

	#Shortcut Commands To Long Bois
		alias yt-dlpAUDIO="yt-dlp --extract-audio --audio-format mp3 --write-sub --embed-thumbnail --embed-metadata --retries 3" #personal preferred settings
		alias yt-dlpVIDEO="yt-dlp --format mp4 --embed-metadata --retries 3" #personal preferred settings

		function videoplusaudio()
		{
			#"https://superuser.com/questions/590201/add-audio-to-video-using-ffmpeg"
			#$1 should be .mp4 or video
			#$2 should be .mp3 or audio
			#$3 should be .mp4 or output video
			ffmpeg -i $1 -i $2 -c copy -map 0:v:0 -map 1:a:0 $3
		}

		function videotogif()
		{
			ffmpeg -i $1 -vf "fps=30,scale=320:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" -loop 0 $2
			# loop:
			# -1 no looping
			# 0 infinite looping
			# 1 loop once (play twice)
			# 10 (play 11 times)
		}

		function ffmpegtrimvideo()
		{
			#"https://stackoverflow.com/questions/18444194/cutting-multimedia-files-based-on-start-and-end-time-using-ffmpeg"

			# input, start, end, output
			#ffmpeg -i $1 -ss $2 -to $3 -c copy $4 #this doesn't work
			ffmpeg -ss $2 -to $3 -i $1 -c copy $4 #this works
		}

		function catintosatty()
		{
			cat $1 | satty --early-exit --copy-command 'wl-copy' --disable-notifications --filename -
		}
		

	#SHRED THE EVIDENCE HIDE THE EVIDENCE KILL THE EVIDENCE GET RID OF THE EVIDENCE
		alias shredshred="shred -fuzv"
		alias shredshredshred="shred -fuzvn10"

	#rice long bois
		alias pipes="pipes.sh -p 10 -t 1 -r 10000 -R"
		alias music="ncmpcpp"
		alias pokemon="krabby random | sed \"1,1d\""

### BASIC OPTIONS ###
	setopt HIST_APPEND #APPEND_HISTORY
	setopt HISTIGNORESPACE #Ignore commands that start with a space and don't append to history
	#setopt SHARE_HISTORY #share history across different/multiple zsh sessions open #will add the weird numba thingies to history that disappear after reloading user
	SAVEHIST=100000
	HISTSIZE=100000
	HISTFILE=~/.zhistory
	function clearhistory() { HISTSIZE=0; HISTSIZE=100000; }

	REPORTTIME=1 #seconds
	REPORTMEMORY=1024 #kilobytes

	KEYTIMEOUT=1

	#no annoying beep sounds
	unsetopt BEEP 
	setopt NOBEEP

	#command corrections
	setopt CORRECT #command name correction
	unsetopt CORRECT_ALL #correction for the rest of the command after the command name

	#prompt expansion
	setopt PROMPT_SUBST #"https://unix.stackexchange.com/questions/701806/how-to-get-a-shorter-path-prompt-in-powerline10k-zsh"
	setopt TRANSIENT_RPROMPT #RPROMPT follows you and isnt left behind in previous command

### PROMPT ###
	autoload -Uz colors && colors

	#"https://unix.stackexchange.com/questions/273529/shorten-path-in-zsh-prompt"
	#"https://stackoverflow.com/questions/30323993/zsh-shorten-length-of-current-path"
	#"https://unix.stackexchange.com/questions/451519/how-to-check-if-the-current-shell-session-is-in-the-gui-or-the-tty"
	case $(tty) in 
		(/dev/tty[1-9])
		### SIMPLE PROMPT ###
			#LEFT PROMPT
				if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ]; then
					PROMPT="[%F{red}%n%f][%F{orange}SSH%f] %F{cyan}%~%f %# " #include username
					#PROMPT="[%F{cyan}%~%f][%F{white}SSH%f] %# " #don't include username
				else
					PROMPT="[%F{red}%n%f] %F{cyan}%~%f %# " #include username
					#PROMPT="[%F{cyan}%~%f] %# " #don't include username
				fi

			#ERROR CORRECTION PROMPT SPROMPT
				SPROMPT="zsh: correct '%R' to '%r' [nyae]? "

			#RIGHT PROMPT RPROMPT
				RPROMPT_COMMANDSTATUS_0="%(0?.%F{green}ok%f." #good
				RPROMPT_COMMANDSTATUS_126="%(126?.%? %F{red}bad perms!%f." #executable file has insufficient permissions
				RPROMPT_COMMANDSTATUS_127="%(127?.%? %F{red}not found!%f." #command not found!
				RPROMPT_COMMANDSTATUS_130="%(130?.%? %F{red}cbreak!%f." #ctrl-c, abort
				RPROMPT_COMMANDSTATUS_139="%(139?.%? %F{red}cbreak!%f." #segmentation fault (segv)
				RPROMPT_COMMANDSTATUS_148="%(148?.%? %F{red}zbreak!%f." #ctrl-z, suspend
				RPROMPT_COMMANDSTATUS_END="%? %F{red}wut?%f))))))" #idk what error code you're giving me lol
				RPROMPT_COMMANDSTATUS="$RPROMPT_COMMANDSTATUS_0$RPROMPT_COMMANDSTATUS_126$RPROMPT_COMMANDSTATUS_127$RPROMPT_COMMANDSTATUS_130$RPROMPT_COMMANDSTATUS_139$RPROMPT_COMMANDSTATUS_148$RPROMPT_COMMANDSTATUS_END"

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

				ZLE_RPROMPT_INDENT=0
		;;

		(*)
		### FANCY PROMPT ###
			#LEFT PROMPT
				PROMPT_tri_left=""
				PROMPT_tri_right=""
				#PROMPT_tri_left_inverse=""
				#PROMPT_tri_right_inverse=""
				PROMPT_check_mark=""
				PROMPT_gear=""
				PROMPT_archlinux="󰣇"
				PROMPT_root_indicator=""
				if [ "$(whoami)" = "root" ]; then
					# PROMPT_root_indicator="!  "
					#PROMPT_root_indicator="%K{009}%F{white} # %k%f%F{009}%K{white}$PROMPT_tri_right%k%f" #salmon pink
					PROMPT_root_indicator="%K{160}%F{white} # %k%f%F{160}%K{white}$PROMPT_tri_right%k%f" #bright neon red
				fi

				#"https://stackoverflow.com/questions/69687223/how-to-colour-git-branch-name-in-zsh-prompt/69700413#69700413"
				#"https://stackoverflow.com/questions/36192523/zsh-prompt-customization"
				autoload -Uz add-zsh-hook
				coolFunctionNameForMyPrecmd()
				{
					## PWD precmd
					if [ "$HOME" != "$PWD" ]; then
						local pwdprecmdtemp=$(echo $PWD | sed "s|"$HOME"|\~|")

						#psvar[1]=$(printf "%.2s/" ${(s./.)pwdprecmdtemp%/*})${pwdprecmdtemp##*/}
						#psvar[1]=$(printf "%.2s/" ${(s./.)pwdprecmdtemp:h})${pwdprecmdtemp:t}

						psvar[1]=$(printf "%.2s/" ${(s./.)pwdprecmdtemp:h})
						psvar[2]=${pwdprecmdtemp:t}
					else
						psvar[1]="~"
						psvar[2]=""
					fi

					## GIT DIRECTORY DETECT precmd
						#gitDirectoryDetectStatusColor='160' #red
						#gitDirectoryDetectStatusColor='071' #green
					if [ -d './.git' ]; then
						if [ -z "$(git status --porcelain)" ]; then
							psvar[3]='git psvar color dummy text'
							psvar[4]=''
						else
							psvar[3]=''
							local gitShortStats="$(git diff --shortstat \
								| sed 's/, //g' \
								| sed 's/ files* changed/  /' \
								| sed 's/ insertions*(+)/+ /' \
								| sed 's/ deletions*(-)/- /')"
							psvar[4]="$gitShortStats"
						fi
						psvar[5]="  $(git branch --show-current)"
					else
						psvar[5]=''
					fi
				}
				add-zsh-hook precmd coolFunctionNameForMyPrecmd

				### old prompt bling saves: ###
					#PROMPT="%K{white}%F{234} $PROMPT_archlinux %f%k%K{027}%F{white}$PROMPT_tri_right%f %n %k%K{234}%F{027}$PROMPT_tri_right%F{white}%B SSH %b%f%k%K{033}%F{234}$PROMPT_tri_right%f %v%B%2v%b %k%F{033}$PROMPT_tri_right%f " #username
					#PROMPT="%K{234}%F{white} $PROMPT_archlinux %f%k%K{033}%F{234}$PROMPT_tri_right%f%k%K{033}%F{white} %B%n%b %f%k%K{027}%F{033}$PROMPT_tri_right%f %~ %k%F{027}$PROMPT_tri_right%f " #include username and archlinux logo
					#PROMPT="%K{234}%F{white} $PROMPT_archlinux %f%k%K{027}%F{234}$PROMPT_tri_right%f %v %k%F{027}$PROMPT_tri_right%f " #no username and archlinux logo
					#PROMPT="%K{white}%F{234} $PROMPT_archlinux %f%k%K{033}%F{white}$PROMPT_tri_right%f %v%B%2v%b %k%F{033}$PROMPT_tri_right%f " #no username and archlinux logo
					#PROMPT="%K{033}%F{white} %B%n%b %f%k%K{027}%F{033}$PROMPT_tri_right%f %~ %k%F{027}$PROMPT_tri_right%f " #include username no archlinux logo
					#PROMPT="[%F{green}%~%f] %# " #don't include username
					#PROMPT="%K{white}%F{234} $PROMPT_archlinux %f%k%K{033}%F{white}$PROMPT_tri_right%f %v%B%2v%b %k%F{033}$PROMPT_tri_right%f " #no username
					#PROMPT_PREFIX="%K{white}%F{234} $PROMPT_archlinux %f%k%K{033}%F{white}$PROMPT_tri_right%f"
					#PROMPT="%K{white}%F{234} $PROMPT_archlinux %f%k%K{027}%F{white}$PROMPT_tri_right%f %n %k%K{033}%F{027}$PROMPT_tri_right%f %v%B%2v%b %k%F{033}$PROMPT_tri_right%f " #username
					#PROMPT="%K{white}%F{234} $PROMPT_archlinux %f%k%K{234}%F{white}$PROMPT_tri_right%F{white}%B SSH %b%f%k%K{033}%F{234}$PROMPT_tri_right%f %v%B%2v%b %k%F{033}$PROMPT_tri_right%f " #no username

				if [ -n "$SSH_CLIENT" ] || [ -n "$SSH_CONNECTION" ] || [ -n "$SSH_TTY" ]; then
					#pstree -s $$
					#SSH_CLIENT
					#SSH_CONNECTION
					#SSH_TTY
					#psvar[6]='ssh psvar dummy text'
					PROMPT_PREFIX_SSH="%K{234}%F{white}$PROMPT_tri_right%F{white}%B SSH %b%f%k%(5V.%(3V.%K{022}.%K{213}).%K{033})%F{234}$PROMPT_tri_right%f"
				else
					#psvar[6]=''
					PROMPT_PREFIX_SSH="%(5V.%(3V.%K{022}.%K{213}).%K{033})%F{white}$PROMPT_tri_right%f"
				fi
				# as of Sunday, May 18, 2025, 00:07:33, holy crappa this is hot garbage of a mess
				PROMPT_PREFIX_GIT="%(5V.%(3V..%(4V.%4v%F{213}%K{124}$PROMPT_tri_right%f.  %F{213}%K{124}$PROMPT_tri_right%f))%5v %K{033}%(3V.%F{022}.%F{124})$PROMPT_tri_right%f.)"

				PROMPT="$PROMPT_root_indicator%K{white}%F{234} $PROMPT_archlinux %f%k$PROMPT_PREFIX_SSH$PROMPT_PREFIX_GIT %v%B%2v%b %k%F{033}$PROMPT_tri_right%f "

			#ERROR CORRECTION PROMPT SPROMPT
				SPROMPT="zsh: correct '%R' to '%r' [nyae]? "

			#RIGHT PROMPT RPROMPT
				RPROMPT_COMMANDSTATUS_0="%(0?.%F{071}$PROMPT_tri_left%f%K{071}%F{white} ok $PROMPT_check_mark %f%(1j.%K{071}%F{075}$PROMPT_tri_left%f.)." #good
				RPROMPT_COMMANDSTATUS_126="%(126?.%F{black}$PROMPT_tri_left%f%K{black}%F{white} %? %f%k%K{black}%F{160}$PROMPT_tri_left%f%k%K{160}%F{white} bad perms! %f%(1j.%K{160}%F{075}$PROMPT_tri_left%f%k.)." #executable file has insufficient permissions
				RPROMPT_COMMANDSTATUS_127="%(127?.%F{black}$PROMPT_tri_left%f%K{black}%F{white} %? %f%k%K{black}%F{160}$PROMPT_tri_left%f%k%K{160}%F{white} not found! %f%(1j.%K{160}%F{075}$PROMPT_tri_left%f%k.)." #command not found!
				RPROMPT_COMMANDSTATUS_130="%(130?.%F{black}$PROMPT_tri_left%f%K{black}%F{white} %? %f%k%K{black}%F{160}$PROMPT_tri_left%f%k%K{160}%F{white} cbreak! %f%(1j.%K{160}%F{075}$PROMPT_tri_left%f%k.)." #ctrl-c, abort
				RPROMPT_COMMANDSTATUS_139="%(139?.%F{black}$PROMPT_tri_left%f%K{black}%F{white} %? %f%k%K{black}%F{160}$PROMPT_tri_left%f%k%K{160}%F{white} segv! %f%(1j.%K{160}%F{075}$PROMPT_tri_left%f%k.)." #segmentation fault (segv)
				RPROMPT_COMMANDSTATUS_148="%(148?.%F{black}$PROMPT_tri_left%f%K{black}%F{white} %? %f%k%K{black}%F{160}$PROMPT_tri_left%f%k%K{160}%F{white} zbreak! %f%(1j.%K{160}%F{075}$PROMPT_tri_left%f%k.)." #ctrl-z, suspend
				RPROMPT_COMMANDSTATUS_END="%F{black}$PROMPT_tri_left%f%K{black}%F{white} %? %f%k%K{black}%F{160}$PROMPT_tri_left%f%k%K{160}%F{white} wut? %f%(1j.%K{160}%F{075}$PROMPT_tri_left%f%k.)))))))" #idk what error code you're giving me lol
				RPROMPT_COMMANDSTATUS="$RPROMPT_COMMANDSTATUS_0$RPROMPT_COMMANDSTATUS_126$RPROMPT_COMMANDSTATUS_127$RPROMPT_COMMANDSTATUS_130$RPROMPT_COMMANDSTATUS_139$RPROMPT_COMMANDSTATUS_148$RPROMPT_COMMANDSTATUS_END"

				RPROMPT_JOBSTATUS="%(1j.%(2j.%K{075}%F{white} %j jobs $PROMPT_gear %f.%K{075}%F{white} %j job $PROMPT_gear %f).)"
				#RPROMPT_JOBSTATUS="%(1j.%(2j. [%F{cyan}%j jobs%f]. [%F{cyan}%j job%f]). )"

				function zle-line-init zle-keymap-select { #ripped this off the internet lol
					RPROMPT_VISTATUS_NORMAL="%F{029}$PROMPT_tri_left%f%K{029}%F{white} NORMAL %f%k"
					RPROMPT_VISTATUS_INSERT="%F{069}$PROMPT_tri_left%f%K{069}%F{white} INSERT %f%k"
					RPROMPT_VISTATUS="${${KEYMAP/vicmd/$RPROMPT_VISTATUS_NORMAL}/(main|viins)/$RPROMPT_VISTATUS_INSERT}"
					RPROMPT="$RPROMPT_COMMANDSTATUS$RPROMPT_JOBSTATUS$RPROMPT_VISTATUS"
					zle reset-prompt
				}
				zle -N zle-line-init
				zle -N zle-keymap-select

				RPROMPT="$RPROMPT_COMMANDSTATUS$RPROMPT_JOBSTATUS$RPROMPT_VISTATUS"

				#get rid of stupid whitespace at the end of RPROMPT "https://superuser.com/questions/655607/removing-the-useless-space-at-the-end-of-the-right-prompt-of-zsh-rprompt"
				ZLE_RPROMPT_INDENT=0
		;;
	esac

### KEYBINDS ###
	#note to self:
	#	use "cat" and hit enter, click home and end keys to see what is sent to terminal
	#	bind what is sent to terminal to desired result
	#	can also use "showkey -a" (better option) (ctrl-d to terminate showkey)

	#man this is stupid. should be a given IMO
		bindkey "^[[1~" beginning-of-line
		bindkey "^[[4~" end-of-line
		bindkey "^[[3~" delete-char

	#vim editing keys
		export EDITOR=nvim
		export VISUAL=nvim

		bindkey -v
		bindkey -a "^[[1~" vi-beginning-of-line
		bindkey -a "^[[4~" vi-end-of-line

		autoload edit-command-line; zle -N edit-command-line
		bindkey -M vicmd "^v" edit-command-line

	#tab completion menu keybinds
		autoload -Uz compinit && compinit
		
		#this is manually defined. can get with "dircolors"
		#you can also just have a .dir_colors with "dircolors -p > ~/.dir_colors" and evaluate/source said file with 'eval "$(dircolors -b ~/.dircolors)"'
		LS_COLORS='rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=00:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.7z=01;31:*.ace=01;31:*.alz=01;31:*.apk=01;31:*.arc=01;31:*.arj=01;31:*.bz=01;31:*.bz2=01;31:*.cab=01;31:*.cpio=01;31:*.crate=01;31:*.deb=01;31:*.drpm=01;31:*.dwm=01;31:*.dz=01;31:*.ear=01;31:*.egg=01;31:*.esd=01;31:*.gz=01;31:*.jar=01;31:*.lha=01;31:*.lrz=01;31:*.lz=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.lzo=01;31:*.pyz=01;31:*.rar=01;31:*.rpm=01;31:*.rz=01;31:*.sar=01;31:*.swm=01;31:*.t7z=01;31:*.tar=01;31:*.taz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tgz=01;31:*.tlz=01;31:*.txz=01;31:*.tz=01;31:*.tzo=01;31:*.tzst=01;31:*.udeb=01;31:*.war=01;31:*.whl=01;31:*.wim=01;31:*.xz=01;31:*.z=01;31:*.zip=01;31:*.zoo=01;31:*.zst=01;31:*.avif=01;35:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.webp=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:*~=00;90:*#=00;90:*.bak=00;90:*.crdownload=00;90:*.dpkg-dist=00;90:*.dpkg-new=00;90:*.dpkg-old=00;90:*.dpkg-tmp=00;90:*.old=00;90:*.orig=00;90:*.part=00;90:*.rej=00;90:*.rpmnew=00;90:*.rpmorig=00;90:*.rpmsave=00;90:*.swp=00;90:*.tmp=00;90:*.ucf-dist=00;90:*.ucf-new=00;90:*.ucf-old=00;90:';
		export LS_COLORS

			#zstyle ':completion:*:default' list-colors '=(#b)*(XX *)=32=31' '=*=32'
		zstyle ':completion:*' list-colors "${(@s.:.)LS_COLORS}" #colored completion menu
		zstyle ':completion:*' menu select #colored menu selection
		zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]} l:|=* r:|=*' ### case insensitive path-completion  #ripped from "https://scriptingosx.com/2019/07/moving-to-zsh-part-5-completions/"
			#zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' #Case insensitive tab completion
		zstyle ':completion:*' rehash true #automatically find new executable in path
		zmodload zsh/complist
		_comp_options+=(globdots)

		bindkey -M menuselect "h" vi-backward-char
		bindkey -M menuselect "j" vi-down-line-or-history
		bindkey -M menuselect "k" vi-up-line-or-history
		bindkey -M menuselect "l" vi-forward-char

		#man zshmodules
		bindkey -M menuselect "^[" send-break
		bindkey "^I" menu-complete #TAB
		bindkey "^[[Z" reverse-menu-complete #SHIFT-TAB

	#history search completion
		eval "$(fzf --zsh)"
		#bindkey -M isearch "^r" history-incremental-search-backward
		bindkey -M isearch "^r" history-incremental-search-backward

	#expand alias
		bindkey "^Z" _expand_alias

### COLORS ###
	# Color man pages
		export LESS_TERMCAP_mb=$'\E[01;32m'
		export LESS_TERMCAP_md=$'\E[01;32m'
		export LESS_TERMCAP_me=$'\E[0m'
		export LESS_TERMCAP_se=$'\E[0m'
		export LESS_TERMCAP_so=$'\E[01;47;34m'
		export LESS_TERMCAP_ue=$'\E[0m'
		export LESS_TERMCAP_us=$'\E[01;36m'
		export LESS=-R

							### Options section
							#setopt correct                                                  # Auto correct mistakes
							#setopt extendedglob                                             # Extended globbing. Allows using regular expressions with *
							#setopt nocaseglob                                               # Case insensitive globbing
							#setopt rcexpandparam                                            # Array expension with parameters
							#setopt nocheckjobs                                              # Don't warn about running processes when exiting
							#setopt numericglobsort                                          # Sort filenames numerically when it makes sense
							#setopt nobeep                                                   # No beep
							#setopt appendhistory                                            # Immediately append history instead of overwriting
							#setopt histignorealldups                                        # If a new command is a duplicate, remove the older one
							#setopt autocd                                                   # if only directory path is entered, cd there.
							#setopt inc_append_history                                       # save commands are added to the history immediately, otherwise only when shell exits.
							#setopt histignorespace                                          # Don't save commands that start with space
							#
							#zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' # Case insensitive tab completion
							#zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"         # Colored completion (different colors for dirs/files/etc)
							#zstyle ':completion:*' rehash true                              # automatically find new executables in path
							#zstyle ':completion:*' menu select                              # Highlight menu selection
							## Speed up completions
							#zstyle ':completion:*' accept-exact '*(N)'
							#zstyle ':completion:*' use-cache on
							#zstyle ':completion:*' cache-path ~/.zsh/cache
							#HISTFILE=~/.zhistory
							#HISTSIZE=10000
							#SAVEHIST=10000
							##export EDITOR=/usr/bin/nano
							##export VISUAL=/usr/bin/nano
							#WORDCHARS=${WORDCHARS//\/[&.;]}                                 # Don't consider certain characters part of the word
