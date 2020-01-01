
TMUX_POWERLINE_SEG_WTTR_UPDATE_PERIOD_DEFAULT="600"
TMUX_POWERLINE_SEG_WTTR_CITY_DEFAULT="Beijing"
#    c    Weather condition,
#    C    Weather condition textual name,
#    h    Humidity,
#    t    Temperature,
#    w    Wind,
#    l    Location,
#    m    Moonphase
#    M    Moonday,
#    p    precipitation (mm),
#    P    pressure (hPa),
TMUX_POWERLINE_SEG_WTTR_FORMAT_DEFAULT="%l:+%C+%t"

generate_segmentrc() {
    read -d '' rccontents  << EORC
# How often to update the weather in seconds.
export TMUX_POWERLINE_SEG_WTTR_UPDATE_PERIOD="${TMUX_POWERLINE_SEG_WTTR_UPDATE_PERIOD_DEFAULT}"
# Use City name like: Beijing, Hangzhou etc...
TMUX_POWERLINE_SEG_WTTR_LOCATION="${TMUX_POWERLINE_SEG_WTTR_CITY_DEFAULT}"
# wttr.in output format
TMUX_POWERLINE_SEG_WTTR_FORMAT="${TMUX_POWERLINE_SEG_WTTR_FORMAT_DEFAULT}"
EORC
    echo "$rccontents"
}

run_segment() {
    __process_settings
    local tmp_file="${TMUX_POWERLINE_DIR_TEMPORARY}/wttr.in-${TMUX_POWERLINE_SEG_WTTR_LOCATION}.txt"
    local weather=$(__wttr_weather)

    if [ -n "$weather" ]; then
        echo "$weather"
    fi
}

__process_settings() {
    if [ -z "$TMUX_POWERLINE_SEG_WTTR_UPDATE_PERIOD" ]; then
        export TMUX_POWERLINE_SEG_WTTR_UPDATE_PERIOD="${TMUX_POWERLINE_SEG_WTTR_UPDATE_PERIOD_DEFAULT}"
    fi
    if [ -z "$TMUX_POWERLINE_SEG_WTTR_LOCATION" ]; then
        export TMUX_POWERLINE_SEG_WTTR_LOCATION="${TMUX_POWERLINE_SEG_WTTR_CITY_DEFAULT}"
    fi
    if [ -z "$TMUX_POWERLINE_SEG_WTTR_FORMAT" ]; then
        export TMUX_POWERLINE_SEG_WTTR_FORMAT="${TMUX_POWERLINE_SEG_WTTR_FORMAT_DEFAULT}"
    fi
}

__wttr_weather() {
    local information=""
    if [ -f "$tmp_file" ]; then
        if shell_is_osx || shell_is_bsd; then
            last_update=$(stat -f "%m" ${tmp_file})
        elif shell_is_linux; then
            last_update=$(stat -c "%Y" ${tmp_file})
        fi

        time_now=$(date +%s)
        up_to_date=$(echo "(${time_now}-${last_update}) < ${TMUX_POWERLINE_SEG_WTTR_UPDATE_PERIOD}" | bc)
        if [ "$up_to_date" -eq 1 ]; then
            __read_tmp_file
        fi
    fi

    if [ -z "$information" ]; then
        information=$(curl --max-time 2 -s wttr.in/${TMUX_POWERLINE_SEG_WTTR_LOCATION}?format="${TMUX_POWERLINE_SEG_WTTR_FORMAT}")
        if [ "$?" -eq "0" ]; then
            echo "$information" > ${tmp_file}
        elif [ -f "${tmp_file}" ]; then
            __read_tmp_file
        fi
    fi

    if [ -n "$information" ]; then
        echo "$information"
    fi
}

__read_tmp_file() {
    if [ ! -f "$tmp_file" ]; then
        return
    fi
    cat "${tmp_file}"
    exit
}

