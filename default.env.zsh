# my key bindings
# my functions 
function toggle-light {
  EVENT_NAME='stream_light'
  curl -s https://maker.ifttt.com/trigger/$EVENT_NAME/json/with/key/XXXXXXXXXXXXXXXX &> /dev/null
}
zle -N toggle-light

function prepend-sudo {
  if [[ $BUFFER != "sudo "* ]]; then
    BUFFER="sudo $BUFFER"; CURSOR+=5
  fi
}
zle -N prepend-sudo

bindkey -M vicmd s prepend-sudo
bindkey '^[t' toggle-light
