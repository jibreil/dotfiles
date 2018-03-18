
#!/bin/bash

# Nougat
# Helps organize screenshots

saveourship(){

   echo -e  "Nougat - screenshot wrapper created to help organize screenshots\n"
   echo -e  " -h - Saves our ship.\n"
   echo     " -s - Silent. By default, nougat will output the path to the file to STDOUT."
   echo -e  "              This is to make it easier to implement into other file uploaders.\n"
   echo     " -t - Places screenshot into /tmp"
   echo -e  "      (useful if you only need a quick screenshot to send to a friend)\n"
   echo -e  " -f - Takes a full screen screenshot (default is select area)\n"
   echo -e  " -c - Puts the screenshot into your clipboard\n"
   echo -e  " -u - Hide cursor. (maim backend ONLY, see -b)"
   echo     " -b - Select backend to use"
   echo -e  "              Supported backends are \`maim', \`scrot', \`imagemagick', and \`tty'."
   echo -e  "              nougat will detect available backends if -b"
   echo -e  "              is not specified. nougat prefers maim to scrot.\n"
   echo -e  "              If the user is not in an X session, nougat will screenshot\n"
   echo     "              the TTY."
   echo     " -p - Cleans the \`all' subdirectory of $NOUGAT_SCREENSHOT_DIRECTORY."
   echo     "              Particularly useful as it cleans any links that no"
   echo -e  "              longer point to a screenshot (i.e. deleted screeenshot).\n"
   echo     " -S - Selects all images matching the argument."
   echo     "              Image matching is done with the following string"
   echo     "              structure: \`YEAR-MONTH-DAY+HOUR:MINUTE:SECOND'."
   echo     "              The month is the number, unlike in the filenames."
   echo     "              Using an asterisk specifies a wildcard."
   echo     "              For example:"
   echo     "                            # To select all images ..."
   echo -e  "                            $ nougat -S \"*-*-*+*:*:*\"\n"
   echo     "                            # Select all images on October 16th of any year ..."
   echo -e  "                            $ nougat -S \"*-10-16+*:*:*\"\n"
   echo     "                            # Select all images taken at 01:22 ..."
   echo -e  "                            $ nougat -S \"*-*-*+01:22:*\"\n"
   echo     "              Selecting images is particularly useful as you can"
   echo     "              remove multiple images at a time, or upload recent"
   echo     "              screenshots all at once with something like ..."
   echo -e  "                            $ image-uploader \$(nougat -S \"*-*-*+22:34:*\")\n"
   echo     " Be sure to configure your screenshot directory."
   echo     " This can be done by exporting \$NOUGAT_SCREENSHOT_DIRECTORY."
   echo     " Place the export statement in your shell's profile."
   echo     " Do not leave a trailing slash (e.g. use /directory rather than /directory/)"
   echo     " Example:"
   echo     "  export NOUGAT_SCREENSHOT_DIRECTORY=$HOME/Screenshots"

}

temp=false
fullscreen=false
silent=false
copytoclipboard=false
backend=""
specifieddirectory=""
cursor=true

supportedbackends=("maim" "scrot" "imagemagick")

cleanup(){

    if [[ -f "/tmp/nougat_temp.png" ]]
    then
        rm /tmp/nougat_temp.png
    fi

}

maimbackend(){

    maimopts=""

    if [[ "$fullscreen" == "false" ]]
    then
        maimopts="-s"
    fi

    if [[ "$cursor" == "false" ]]
    then
        maimopts="${maimopts} -u"
    fi

    command maim $maimopts /tmp/nougat_temp.png

}

scrotbackend(){

    scrotopts=""

    if [[ "$fullscreen" == "false" ]]
    then
        scrotopts="-s"
    fi

    command scrot ${scrotopts} /tmp/nougat_temp.png

}

imagemagickbackend(){

    importopts=""

    if [[ "$fullscreen" == "false" ]]
    then

        command -v slop > /dev/null

        if [[ "$?" != "0" ]]
        then
            echo "slop is not installed"
            echo "Install slop for imagemagick backend support"
            exit 1
        fi

        slop=$(command slop -qof '%wx%h+%x+%y')

        if [[ "$slop" != "" ]]
        then

            importopts="-crop ${slop}"

        fi

    fi

    command import -window root ${importopts} /tmp/nougat_temp.png

}

ttybackend(){

    command ffmpeg -f fbdev -framerate 1 -i /dev/fb0 -frames:v 1 /tmp/nougat_temp.png

}

runbackend(){

    if [[ "$backend" == "" ]]
    then

        command -v maim > /dev/null

        if [[ "$?" == "0" ]]
        then
            backend="maim"
        else
            command -v scrot > /dev/null
            if [[ "$?" == "0" ]]
            then
                backend="scrot"
            else
                command -v import > /dev/null
                if [[ "$?" == "0" ]]
                then
                    backend="imagemagick"
                else
                    echo "No supported backend found"
                    exit 1
                fi
            fi
        fi

    fi

    case "$backend" in
        maim)
            maimbackend
            ;;
        scrot)
            scrotbackend
            ;;
        imagemagick)
            imagemagickbackend
            ;;
        tty)
            ttybackend
            ;;
    esac

}

screenshotpls(){

    runbackend

    if [[ ! -f "/tmp/nougat_temp.png" ]]
    then # Stops nougat from continuing and moving a non-existant file
        exit 0
    fi

    if [[ "$copytoclipboard" == "true" ]]
    then

        command -v xclip > /dev/null

        if [[ "$?" != "0" ]]
        then

            echo "xclip is not installed"
            echo "Install xclip for -c support"
            exit 1

        fi

        xclip -selection clipboard -t image/png /tmp/nougat_temp.png

    fi

    year=`date +'%Y'`
    month=`date +'%B'`
    day=`date +'%d'`

    path="${NOUGAT_SCREENSHOT_DIRECTORY}/${year}/${month}/${day}"

    name=`date +'%H:%M:%S'`

    if [[ "$fullscreen" == "true" ]]
    then
        name="${name}_full"
    fi

    name="${name}.png"

    if [[ "$temp" == "true" ]]
    then

        name="${year}-${month}-${day}.${name}"

        mv /tmp/nougat_temp.png /tmp/$name

        [[ "$silent" == "false" ]] && echo "/tmp/${name}"
        exit 0

    fi

    if [[ "$specifieddirectory" == "" ]]
    then

        mkdir -p $path

        linkname="${year}-${month}-${day}.${name}"
        ln -s $path/$name $NOUGAT_SCREENSHOT_DIRECTORY/all/$linkname

    else
        path="$specifieddirectory"
        name="${year}-${month}-${day}.${name}"
    fi

    if [[ "$silent" == "false" ]]
    then
        echo "$path/$name"
    fi

    mv /tmp/nougat_temp.png $path/$name

}

setbackend() {

    supported=false

    for (( i=0; i<${#supportedbackends}; i++ ))
    do

        if [[ "${supportedbackends[$i]}" == "$1" ]]
        then

            supported=true
            break

        fi

    done

    if [[ "$supported" == "false" ]]
    then

        echo "Unsupported backend $1"
        exit 1

    fi

    cmd="$1"

    if [[ "$cmd" == "imagemagick" ]]
    then
        cmd="import"
    fi

    command -v "$cmd" > /dev/null
    if [[ "$?" != "0" ]]
    then
        echo "Backend not installed on your system."
        exit 1
    fi

    backend=$1

}

selectimgs() {

    # TODO: clean this

    images=()

    for file in "$NOUGAT_SCREENSHOT_DIRECTORY/all/"*
    do
        images+=("$file")
    done

    results=()

    expression=""

    read year month day hour minute second <<< ${1//[-:+]/ }

    yearexpr="([0-9]{4})"
    monthexpr="([A-Z]{1}[a-z]+)"

    # day, hour, minute, second
    genericexpr="([0-9]{2})"

    invaliderr="Invalid time string. Use an asterisk (*) for wildcards."

    if ! [[ "$year" =~ ^([0-9]{4}|\*{1})$ ]]
    then
        echo "$invaliderr"
        exit 1
    fi

    if ! [[ "$month" =~ ^([0-9]{2}|\*{1})$ ]]
    then
        echo "$invaliderr"
        exit 1
    fi

    if ! [[ "$day" =~ ^([0-9]{2}|\*{1})$ ]]
    then
        echo "$invaliderr"
        exit 1
    fi

    if ! [[ "$hour" =~ ^([0-9]{2}|\*{1})$ ]]
    then
        echo "$invaliderr"
        exit 1
    fi

    if ! [[ "$minute" =~ ^([0-9]{2}|\*{1})$ ]]
    then
        echo "$invaliderr"
        exit 1
    fi

    if ! [[ "$second" =~ ^([0-9]{2}|\*{1})$ ]]
    then
        echo "$invaliderr"
        exit 1
    fi

    # Probably should've made that a method, but I only want methods to be made
    # if they're going to be used by more than just a single component
    # in the program, with the exception of the screenshot backends

    monthname=""
    dayexpr="$genericexpr"
    hourexpr="$genericexpr"
    minexpr="$genericexpr"
    secexpr="$genericexpr"

    [[ "$year" != "*" ]] && yearexpr="$year"

    if [[ "$month" != "*" ]]
    then
        monthname=$(date -d "1970-$month-1" '+%B')
        monthexpr="$monthname"
    fi

    [[ "$day" != "*" ]] && dayexpr="$day"
    [[ "$hour" != "*" ]] && hourexpr="$hour"
    [[ "$minute" != "*" ]] && minexpr="$minute"
    [[ "$second" != "*" ]] && secexpr="$second"

    expression="$yearexpr\-$monthexpr\-$dayexpr\.$hourexpr:$minexpr:$secexpr(_full)?\.png"

    for (( index=0; index<${#images[@]}; index++ ))
    do

        image="${images[$index]}"
        match=$(echo "$image" | grep -P "$expression")

        if [[ "$image" == "$match" ]]
        then

            results+=("$image")

        fi

    done

    for (( index=0; index<${#results[@]}; index++ ))
    do

        echo $(readlink -f "${results[$index]}")

    done

}

clean() {

    for file in "$NOUGAT_SCREENSHOT_DIRECTORY/all/"*
    do

        linkto=$(readlink -f "$file")

        if [[ ! -f "$linkto" ]]
        then

            rm $file

        fi

    done

}

while getopts "hstfcpu b:S:" opt
do
    case $opt in
        h)
            saveourship
            exit 0
            ;;
        s)
            silent=true
            ;;
        t)
            temp=true
            ;;
        f)
            fullscreen=true
            ;;
        c)
            copytoclipboard=true
            ;;
        b)
            setbackend $OPTARG
            ;;
        S)
            selectimgs $OPTARG
            exit 0
            ;;
        p)
            clean
            exit 0
            ;;
        u)
            cursor=false
            ;;
    esac
done

if [[ "$NOUGAT_SCREENSHOT_DIRECTORY" == "" && "$temp" == "false" ]]
then
    echo "Screenshot directory unset. View nougat.sh -h"
    exit 1
elif [[ ! -d "$NOUGAT_SCREENSHOT_DIRECTORY" && "$temp" == "false" ]]
then
    echo "$NOUGAT_SCREENSHOT_DIRECTORY variable is not set to a directory."
    exit 1
else

    if [[ ! -d "$NOUGAT_SCREENSHOT_DIRECTORY/all" ]]
    then
        mkdir "$NOUGAT_SCREENSHOT_DIRECTORY/all"
    fi

    lastarg=""

    for i in "$@"
    do
       lastarg="$i"
    done

    if [[ -d "$lastarg" ]]
    then
        specifieddirectory="$lastarg/"
    fi

    cleanup
    screenshotpls

fi
