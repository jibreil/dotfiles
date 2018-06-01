#!/usr/bin/env bash

# Nougat version 2

# All features from nougat 1
# ~/.config/nougat

saveourship() {
cat << EOF
Nougat - screenshot wrapper created to help organize screenshots
 -h - Saves our ship.
 -i - Output image to stdout. This implies -s (silent).
 -s - Silent. By default, nougat will output the path to the file to STDOUT.
              This is to make it easier to implement into other file uploaders.
 -t - Places screenshot into /tmp
      (useful if you only need a quick screenshot to send to a friend)
 -f - Takes a full screen screenshot (default is select area)
 -m - Takes a full screen screenshot of the currently focused monitor.
      \`xdotool\` is required (\`nougat\` fallsback to a regular fullscreen screenshot without it).

 -c - Puts the screenshot into your clipboard
 -b - Select backend to use
              Supported backends are \`maim', \`scrot' (without -m), and \`imagemagick'.
              nougat will detect available backends if -b
              is not specified. nougat prefers maim to scrot and imagemagick.
 -p - Cleans the link directory of Nougat based on the linking policy.
              Particularly useful as it cleans any links that no
              longer point to a screenshot (i.e. deleted screeenshot).
EOF
}

temporary=false
clean=false
silent=false
stdout=false
fullscreen=false
focused_monitor=false
copytoclipboard=false

backend=""
backend_options=""

backends=('maim' 'scrot' 'imagemagick')

### BACKENDS

maimbackend() {
    require maim

    maimopts=''

    [[ $fullscreen == false ]] && maimopts=-s
    [[ $focused_monitor == true ]] && maimopts=--geometry=$(getcurrentmonitor)
    [[ $maimopts == "--geometry=" ]] && maimopts=''
    maimopts="$maimopts --hidecursor"

    maim $maimopts $backend_options /tmp/nougat_temp.png
}

scrotbackend() {
    require scrot

    scrotopts=''

    [[ $fullscreen == false ]] && scrotopts=-s

    scrot $scrotopts $backend_options /tmp/nougat_temp.png
}

imagemagickbackend() {
    require import

    importopts=''

    [[ $fullscreen == false && $focused_monitor == false ]] && {
        require slop

        slop=$(slop -qof '%wx%h+%x+%y')

        [[ -n $slop ]] && importopts="-crop $slop"
    } || {
      [[ $focused_monitor == true ]] && importopts="-crop $(getcurrentmonitor)"
      [[ $importopts == "-crop " ]] && importopts=''
    }

    import -window root $importopts $backend_options /tmp/nougat_temp.png
}

### END BACKENDS

nobackend() {
    if [[ -z $backend ]]; then
        return 0
    else
        return 1
    fi
}

testfor() {
    command -v "$1" &> /dev/null

    return "$?"
}

require() {
    command -v "$1" &> /dev/null || {
        echo "$1 is not installed and is required"
        exit 1
    }
}

getconfigdir() {
    CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}"

    echo "$CONFIG_DIR"
}

# Print's the current screens geometry
# Modified from:
# https://superuser.com/a/1238384
getcurrentmonitor() {
    # We require xdotool to get the mouse co-ordinates (used to tell which monitor we're on)
    # Without xdotool we silently fallback to a regular fullscreen screenshot
    testfor xdotool || return 1
    testfor xrandr  || return 1

    xrandr="$(xrandr --nograb)"
    [[ -z "$xrandr" ]] && return 1

    OFFSET_RE="\+([-0-9]+)\+([-0-9]+)"

    # Get the window position
    eval "$(xdotool getmouselocation --shell)"

    # Loop through each screen and compare the offset with the window
    # coordinates.
    monitor_index=0
    while read -r name width height xoff yoff
    do
        if [[ "${X}" -ge "$xoff" && \
            "${Y}" -ge "$yoff" && \
            "${X}" -lt "$(($xoff+$width))" && \
            "${Y}" -lt "$(($yoff+$height))" ]]; then
            monitor=$name
            break
        fi
        ((monitor_index++))
    done <<< $(grep -w connected <<< "$xrandr" |
        sed -r "s/^([^ ]*).*\b([-0-9]+)x([-0-9]+)$OFFSET_RE.*$/\1 \2 \3 \4 \5/" |
        sort -nk4,5)

    # If we found a monitor, get its geometry.
    if [[ "$monitor" ]]
    then
        geometry="$(grep -E "^$monitor\s" <<< "$xrandr")"
        geometry="${geometry/$monitor/}"
        geometry="${geometry/connected/}"
        geometry="${geometry/primary/}"
        awk '{print $1}' <<< "$geometry"
        return $?
    fi

    return 1
}

getcanonicals() {
    read -r year month day hour minute second <<< "$(date +'%Y %B %d %H %M %S')"

    suffix=''
    [[ $fullscreen == true ]] && suffix=_full

    . "$(getconfigdir)/nougat"

    ORG_FULLPATH="$NOUGAT_SCREENSHOT_DIRECTORY/$NOUGAT_ORGANIZATION_POLICY"

    [[ -n $NOUGAT_LINKING_POLICY ]] &&
      LINK_FULLPATH="$NOUGAT_SCREENSHOT_DIRECTORY/$NOUGAT_LINKING_POLICY" ||
      LINK_FULLPATH=""

    echo "$(dirname "$ORG_FULLPATH")" \
        "$(basename "$ORG_FULLPATH")" \
        "$([[ -n $LINK_FULLPATH ]] && dirname  "$LINK_FULLPATH")" \
        "$([[ -n $LINK_FULLPATH ]] && basename "$LINK_FULLPATH")"
}

init() {
    CONFIG_DIR=$(getconfigdir)

    [[ ! -f $CONFIG_DIR/nougat ]] && {
        mkdir -p "$CONFIG_DIR"

        if [[ -n $NOUGAT_SCREENSHOT_DIRECTORY ]]; then
            # Support for V1 configurations
            echo 'NOUGAT_SCREENSHOT_DIRECTORY="'"$NOUGAT_SCREENSHOT_DIRECTORY"'"' > "$CONFIG_DIR/nougat"
        else
            echo 'NOUGAT_SCREENSHOT_DIRECTORY="$HOME/Screenshots"' > "$CONFIG_DIR/nougat"
        fi

        cat >> "$CONFIG_DIR/nougat" << EOF
NOUGAT_ORGANIZATION_POLICY="\${year}/\${month}/\${day}/\${hour}:\${minute}:\${second}\${suffix}"
NOUGAT_LINKING_POLICY="All/\${year}-\${month}-\${day}.\${hour}:\${minute}:\${second}\${suffix}"
MAIM_BACKEND_OPTIONS=""
SCROT_BACKEND_OPTIONS=""
IMAGEMAGICK_BACKEND_OPTIONS=""
EOF
    }

    while getopts 'hstfmcpui b:S:' option; do
        case $option in
            h)
                saveourship
                exit 0
                ;;
            b) setbackend $OPTARG;;
            # Hide cursor
            p) clean=true;;
            s) silent=true;;
            t) temp=true;;
            c) copytoclipboard=true;;
            f) fullscreen=true;;
            m)
               fullscreen=true
               focused_monitor=true
              ;;
            i)
               stdout=true
               silent=true
               ;;
        esac
    done

    local exitcode; exitcode="$?"

    nobackend &&
        testfor maim && backend=maim && return "$exitcode"

    nobackend &&
        testfor scrot && backend=scrot && return "$exitcode"

    nobackend &&
        testfor import && backend=imagemagick && return "$exitcode"
}

setbackend() {
    supported=false

    for (( index=0; index<${#backends}; index++ )); do
        [[ ${backends[$index]} == "$1" ]] && {
            supported=true
            break
        }
    done

    [[ $supported == false ]] && {
        echo "Unsupported backend $1"
        exit 1
    }

    cmd="$1"

    [[ $cmd == imagemagick ]] && cmd=import

    testfor $cmd && backend="$1"
}

runbackend() {

    . "$(getconfigdir)/nougat"

    case $backend in
        maim)
            backend_options="$MAIM_BACKEND_OPTIONS"
            maimbackend
            ;;
        scrot)
            backend_options="$SCROT_BACKEND_OPTIONS"
            scrotbackend
            ;;
        imagemagick)
            backend_options="$IMAGEMAGICK_BACKEND_OPTIONS"
            imagemagickbackend
            ;;
        *)
            echo 'No supported backend found'
            exit 1
            ;;
    esac

    [[ ! -f /tmp/nougat_temp.png ]] && exit 1
}

stdout() {
  if [[ ! -t 1 ]]; then
    cat "$1"
  else
    cat >&2 <<EOF
Refusing to output stdout to a terminal.

Did you mean to pipe me to another script?

$1
EOF
    exit 1
  fi
}

organize() {
    read -r fullpath filename linkpath linkname <<< "$(getcanonicals)"

    [[ $copytoclipboard == true ]] && {
        require xclip
        xclip -selection clipboard -t image/png /tmp/nougat_temp.png
    }

    [[ $temp == true ]] && {
        [[ $silent == false ]] && echo "/tmp/$linkname.png"

        mv /tmp/nougat_temp.png "/tmp/$linkname.png"

        [[ $stdout == true ]] && stdout "/tmp/$linkname.png"

        exit 0
    }

    mkdir -p "$fullpath"
    [[ -n $linkpath ]] && mkdir -p "$linkpath"

    mv /tmp/nougat_temp.png "$fullpath/$filename.png"
    [[ -n $linkpath ]] && ln -s "$fullpath/$filename.png" "$linkpath/$linkname.png"

    [[ $silent == false ]] && echo "$fullpath/$filename.png"

    [[ $stdout == true ]] && stdout "$fullpath/$filename.png"

    exit 0
}

clean() {
    . "$(getconfigdir)/nougat"

    linkdir=$(dirname "$NOUGAT_SCREENSHOT_DIRECTORY/$NOUGAT_LINKING_POLICY")
    [[ $silent == false ]] && echo "$linkdir"

    [[ ! -d $linkdir || -z $(ls -1 "$linkdir") ]] && return 0

    for file in "$linkdir/"*; do
        link=$(readlink -f "$file")

        if [[ ! -f $link ]]; then rm "$file"; fi
    done
}

screenshot() {
    runbackend
    organize
}

init "$@"

[[ $clean == true ]] && {
    clean
    x="$?"

    [[ $# -eq 1 ]] && {
        [[ $1 == -p || $1 == -ps || $1 == -sp ]] && exit "$x"
    }

    [[ $# -eq 2 ]] && {
        [[ $1 == -p || $1 == -s ]] && {
            [[ $2 == -p || $2 == -s ]] && exit "$x"
        }
    }
}

screenshot
