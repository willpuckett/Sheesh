#!/bin/bash

PROJECT=sheesh
LAYOUTS=('ENGRAMMER')
COLS=8
ZMK_KEYMAP="config/boards/shields/${PROJECT}/${PROJECT}.keymap"
# See [this link](https://github.com/caksoylar/keymap-drawer/blob/main/KEYMAP_SPEC.md#colsthumbs-notation-specification)
# for info on cols-thumbs notation
COLS_THUMBS='333^3+2> 2<+33^33'
# Or, pick a keyboard from https://config.qmk.fm
QMK_KEYBOARD=""

# Store the flag and variable in an array to expand 
# each element as a seperate shell word in the command later....
# https://unix.stackexchange.com/questions/444946/how-can-we-run-a-command-stored-in-a-variable
KMD_LAYOUT=(-n "$COLS_THUMBS") &&
    [[ -n $QMK_KEYBOARD ]] &&
    KMD_LAYOUT=(--qmk-keyboard "$QMK_KEYBOARD")

# Iterate over array keys
# https://devhints.io/bash#arrays
for i in "${!LAYOUTS[@]}"; do
    echo "Rendering Layout ${LAYOUTS[$i]}"
    BASE=".images/keymap_${LAYOUTS[$i]}"
    YML="$BASE.yml"
    # note you have to have the quotes for KMD_LAYOUT expansion
        keymap parse -c $COLS -z "$ZMK_KEYMAP" > "$YML" &&
        keymap draw "${KMD_LAYOUT[@]}" "$YML" > "$BASE.svg"
    [[ $? -ne 0 ]] && exit 1
    rm "$YML"
done


