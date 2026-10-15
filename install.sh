#!/usr/bin/env bash
# Installs debug.h into /usr/local/include, a folder gcc and clang already search,
# so `#include <debug.h>` works from any C file. Asks for your sudo password.
#
#   curl -fsSL https://raw.githubusercontent.com/1sun12/dbg-macro-c/HEAD/install.sh | bash
#
# Everything lives inside main(), which only runs on the last line, so a
# download that gets cut off partway never runs half a script.

set -euo pipefail

URL="https://raw.githubusercontent.com/1sun12/dbg-macro-c/HEAD/debug.h"
DIR="/usr/local/include"

main() {
    # Download as your normal user; only the final copy needs root.
    tmp=$(mktemp)
    trap 'rm -f "$tmp"' EXIT
    curl -fsSL "$URL" -o "$tmp"
    grep -q dbg_fmt "$tmp" || { echo "error: the download doesn't look like debug.h" >&2; exit 1; }

    # Never overwrite somebody else's debug.h.
    if [ -e "$DIR/debug.h" ] && ! grep -q dbg_fmt "$DIR/debug.h"; then
        echo "error: $DIR/debug.h already exists and isn't from this project, so it was left alone" >&2
        exit 1
    fi

    local sudo=""
    if [ ! -w "$DIR" ] && [ "$(id -u)" -ne 0 ]; then
        sudo="sudo"
        echo "Copying into $DIR needs admin rights, so sudo will ask for your password."
    fi
    $sudo mkdir -p "$DIR"
    $sudo install -m 644 "$tmp" "$DIR/debug.h"
    echo "Installed $DIR/debug.h. #include <debug.h> now works from anywhere."
}

main "$@"
