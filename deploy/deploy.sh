#!/usr/bin/env bash
# Task Butler deploy script (macOS / Linux)
# Usage:
#   ./deploy.sh                    (interactive menu)
#   ./deploy.sh claude [path]       (default: ./CLAUDE.md)
#   ./deploy.sh agents [path]       (default: ./AGENTS.md)
#   ./deploy.sh chatgpt            (copies profile to clipboard via pbcopy/xclip)
#   ./deploy.sh generic <file>
#   ./deploy.sh uninstall <file>

set -euo pipefail

root="$(cd "$(dirname "$0")/.." && pwd)"
BEGIN="# ---- task-butler BEGIN ----"
END="# ---- task-butler END ----"

get_block() { # extract content between the LAST TWO "--------" marker lines
    # (single-block profiles: the two markers; chatgpt: the last/paste block)
    awk '
    /--------/ { n++; marks[n]=NR }
    { lines[NR]=$0 }
    END {
        if (n < 2) { exit 1 }
        first=marks[n-1]; last=marks[n]
        for (i=first+1; i<=last-1; i++) print lines[i]
    }
    ' "$1"
}

update_file() {
    local file="$1" block="$2" existing="" new
    mkdir -p "$(dirname "$file")" 2>/dev/null || true
    [[ -f "$file" ]] && existing="$(cat "$file")"
    local full="$BEGIN
$block
$END"
    if printf '%s' "$existing" | grep -qF "$BEGIN"; then
        new="$(printf '%s' "$existing" | awk -v b="$BEGIN" -v e="$END" -v blk="$full" '
            $0 == b { print blk; skip=1; next }
            $0 == e { skip=0; next }
            !skip { print }
        ')"
        printf '%s\n' "$new" > "$file"
        echo "Updated task-butler block in: $file"
    else
        if [[ -n "$existing" ]]; then
            printf '%s\n\n%s\n' "$existing" "$full" > "$file"
        else
            printf '%s\n' "$full" > "$file"
        fi
        echo "Appended task-butler block to: $file"
    fi
}

remove_block() {
    local file="$1"
    [[ -f "$file" ]] || { echo "File not found: $file"; return; }
    awk -v b="$BEGIN" -v e="$END" '
        $0 == b { skip=1; next }
        $0 == e { skip=0; next }
        !skip { print }
    ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
    echo "Removed task-butler block from: $file"
}

target="${1:-}"
[[ -z "$target" ]] && {
    echo "Task Butler deploy - choose a target:"
    echo "  1) claude    - append to CLAUDE.md"
    echo "  2) agents    - append to AGENTS.md"
    echo "  3) chatgpt   - copy to clipboard"
    echo "  4) generic   - append to a file you specify"
    echo "  5) uninstall - remove block from a file"
    read -r -p "Select 1-5: " choice
    case "$choice" in
        1) target=claude ;; 2) target=agents ;; 3) target=chatgpt ;;
        4) target=generic ;; 5) target=uninstall ;; *) echo "Invalid choice."; exit 1 ;;
    esac
}
path="${2:-}"

case "$target" in
    claude)
        [[ -z "$path" ]] && path="./CLAUDE.md"
        update_file "$path" "$(get_block "$root/profiles/claude.md")" ;;
    agents)
        [[ -z "$path" ]] && path="./AGENTS.md"
        update_file "$path" "$(get_block "$root/profiles/cli-agents.md")" ;;
    chatgpt)
        block="$(get_block "$root/profiles/chatgpt.md")"
        if command -v pbcopy >/dev/null 2>&1; then printf '%s' "$block" | pbcopy
        elif command -v xclip >/dev/null 2>&1; then printf '%s' "$block" | xclip -selection clipboard
        elif command -v xsel >/dev/null 2>&1; then printf '%s' "$block" | xsel --clipboard
        else echo "(No clipboard tool found - printing instead:)"; printf '%s\n' "$block"; fi
        echo "Paste into ChatGPT Custom Instructions 'How would you like ChatGPT to respond?'"
        ;;
    generic)
        [[ -z "$path" ]] && read -r -p "Target file path: " path
        update_file "$path" "$(get_block "$root/profiles/generic.md")" ;;
    uninstall)
        [[ -z "$path" ]] && read -r -p "File path to remove block from: " path
        remove_block "$path" ;;
    *) echo "Unknown target: $target (use claude|agents|chatgpt|generic|uninstall)"; exit 1 ;;
esac
echo "Done."
