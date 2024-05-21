#!/bin/bash


: ${DIALOG_OK=0}
: ${DIALOG_CANCEL=1}
: ${DIALOG_HELP=2}
: ${DIALOG_EXTRA=3}
: ${DIALOG_ITEM_HELP=4}
: ${DIALOG_ESC=255}

HEIGHT=50
WIDTH=50
MENU_HEIGHT=5
NOTIFICATION_HEIGHT=5
NOTIFICATION_WIDTH=50

LOG_FILE="./log.csv"
EXERCISES_FILE="./exercises.txt"

EXERCISES=""


function init(){
    if [ ! -f "$LOG_FILE" ]; then
        touch "$LOG_FILE"
        echo "exercise_name,reps,weight_kg" > "$LOG_FILE"
    fi
    if [ ! -f "$EXERCISES_FILE" ]; then
        touch "$EXERCISES_FILE"
        echo "1 Squat 2 Front-squat 3 Row 4 Narrow-row 5 Pull-down 6 Military-press" > "$EXERCISES_FILE"
    fi
    EXERCISES=($(cat "$EXERCISES_FILE"))
    return 0
}

function notification(){
    msg="$1"
    exec 3>&1
    local selection=$(dialog \
        --clear \
        --msgbox "$1" $NOTIFICATION_HEIGHT $NOTIFICATION_WIDTH \
        2>&1 1>&3)
    exec 3>&-
    return 0
}

function log_exercise_data_csv_file(){
    if [ $# -ne 4 ]; then
        notification "Error! Exercise not logged."
        return 1
    fi
    local exercise_name="$1"
    local reps="$2"
    local weight="$3"
    local file="$4"
    [ -z "$file" ] && return 1
    if [ ! -f "$file" ]; then
        touch "$4"
        echo "exercise_name,reps,weight_kg" > "$file"
    fi
    echo "$exercise_name,$reps,$weight" >> "$file"
    notification "Exercise logged."
    return 0
}

function log_exercise_data(){
    exec 3>&1
    local selection=$(dialog \
        --title "$1" \
        --clear \
        --cancel-label "Exit" \
        --inputbox "Reps and Weight(space separated):" $HEIGHT $WIDTH \
        2>&1 1>&3)
    exec 3>&-
    [ -z "$selection" ] && return 1
    local reps
    local weight
    read reps weight <<< "$selection"
    local log_file="$LOG_FILE"
    log_exercise_data_csv_file "$1" $reps $weight "$log_file"
    return 0
}

function log_exercise(){
    while true; do
        exec 3>&1
        local selection=$(dialog \
            --title "Log Exercise" \
            --clear \
            --cancel-label "Back" \
            --menu  "Select an exercise:" $HEIGHT $WIDTH $MENU_HEIGHT \
            ${EXERCISES[@]} \
            2>&1 1>&3)
        exec 3>&-
        local i=$((($selection-1)*2+1))
        local max_i=$((${#EXERCISES[@]}-1))
        [ $i -ge 0 -a $i -le $max_i ] || return 1
        log_exercise_data "${EXERCISES[$i]}"
    done
    return 0
}

function log_weight(){
    echo -e "Logging weight\n"
    sleep 5
    return 0
}

function add_exercise(){
    exec 3>&1
    selection=$(dialog \
        --title "Add Exercise" \
        --clear \
        --cancel-label "Back" \
        --inputbox  "Exercise name:" $HEIGHT $WIDTH \
        2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    # TODO: add the input exercise.
    return 0
}

init

while true; do
    exec 3>&1
    selection=$(dialog \
        --title "Mu-TRAINER" \
        --clear \
        --cancel-label "Exit" \
        --menu  "Select a command:" $HEIGHT $WIDTH $MENU_HEIGHT \
        "1" "Log Exercise" \
        "2" "Log Weight" \
        "3" "Add Exercise" \
        2>&1 1>&3)
    exit_status=$?
    exec 3>&-
    case "$exit_status" in
        $DIALOG_CANCEL)
            clear
            break
            ;;
        $DIALOG_ESC)
            clear
            echo "Program aborted." >&2
            exit 1
            ;;
    esac
    case "$selection" in
        1)
            log_exercise
            ;;
        2)
            log_weight
            ;;
        3)
            add_exercise
            ;;
    esac
done
