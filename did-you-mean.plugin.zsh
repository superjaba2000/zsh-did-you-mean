# Russian-to-English keyboard layout correction plugin for Zsh

_ru_layout_language() {
    local locale="${LC_ALL:-${LC_MESSAGES:-${LANG:-en_US}}}"

    locale="${locale%%.*}"
    locale="${locale%%@*}"

    case "$locale" in
        ru|ru_*)
            print -r -- ru
            ;;
        *)
            print -r -- en
            ;;
    esac
}

_ru_layout_fix() {
    local input="$1"
    local ru='ёйцукенгшщзхъфывапролджэячсмитьбю'
    local en="\`qwertyuiop[]asdfghjkl;'zxcvbnm,."

    local result=""
    local char
    local i

    for (( i = 1; i <= ${#input}; i++ )); do
        char="${input[i]}"
        if [[ "$ru" == *"$char"* ]]; then
            local pos=${ru[(i)$char]}
            result+="${en[$pos]}"
        else
            result+="$char"
        fi
    done

    print -r -- "$result"
}

command_not_found_handler() {
    local original="$1"
    local fixed
    local reply

    fixed=$(_ru_layout_fix "$original")

    if [[ "$fixed" != "$original" ]] && (( $+commands[$fixed] )); then
        case "$(_ru_layout_language)" in
            ru)
                printf 'Команда «%s%s%s» не найдена. Имелось в виду %s«%s»%s? [%sY%s/n%s] ' \
                    $'\e[31m' "$original" $'\e[0m' \
                    $'\e[36m' "$fixed" $'\e[0m' \
                    $'\e[1;32m' $'\e[0m' $'\e[0m' >/dev/tty
                ;;
            *)
                printf 'Command «%s%s%s» not found. Did you mean %s%s%s? [%sY%s/n%s] ' \
                    $'\e[31m' "$original" $'\e[0m' \
                    $'\e[36m' "$fixed" $'\e[0m' \
                    $'\e[1;32m' $'\e[0m' $'\e[0m' >/dev/tty
                ;;
        esac

        read -r reply </dev/tty

        if [[ -z "$reply" || "$reply" == [YyДд] ]]; then
            shift
            "$fixed" "$@"
            return $?
        fi
    fi

    print -u2 -- "$original: command not found"
    return 127
}
