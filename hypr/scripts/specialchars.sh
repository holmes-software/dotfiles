#!/bin/bash

# Special characters picker using rofi
# Select a character and it will be copied to clipboard

declare -A chars=(
    # Math & Science
    ["∞  infinity"]="∞"
    ["°  degree"]="°"
    ["±  plus-minus"]="±"
    ["×  multiplication"]="×"
    ["÷  division"]="÷"
    ["≠  not equal"]="≠"
    ["≈  approximately equal"]="≈"
    ["≤  less than or equal"]="≤"
    ["≥  greater than or equal"]="≥"
    ["√  square root"]="√"
    ["∑  summation"]="∑"
    ["∏  product"]="∏"
    ["∫  integral"]="∫"
    ["∂  partial derivative"]="∂"
    ["∇  nabla / del"]="∇"
    ["π  pi"]="π"
    ["μ  mu / micro"]="μ"
    ["Ω  omega / ohm"]="Ω"
    ["α  alpha"]="α"
    ["β  beta"]="β"
    ["γ  gamma"]="γ"
    ["δ  delta"]="δ"
    ["λ  lambda"]="λ"
    ["σ  sigma"]="σ"
    ["θ  theta"]="θ"
    ["φ  phi"]="φ"
    ["ε  epsilon"]="ε"
    ["∝  proportional to"]="∝"
    ["∅  empty set"]="∅"
    ["∈  element of"]="∈"
    ["∉  not element of"]="∉"
    ["∩  intersection"]="∩"
    ["∪  union"]="∪"
    ["⊂  subset of"]="⊂"
    ["⊃  superset of"]="⊃"
    ["⊕  xor / direct sum"]="⊕"

    # Superscripts
    ["⁰  superscript 0"]="⁰"
    ["¹  superscript 1"]="¹"
    ["²  superscript 2"]="²"
    ["³  superscript 3"]="³"
    ["⁴  superscript 4"]="⁴"
    ["⁵  superscript 5"]="⁵"
    ["⁶  superscript 6"]="⁶"
    ["⁷  superscript 7"]="⁷"
    ["⁸  superscript 8"]="⁸"
    ["⁹  superscript 9"]="⁹"
    ["ⁿ  superscript n"]="ⁿ"

    # Subscripts
    ["₀  subscript 0"]="₀"
    ["₁  subscript 1"]="₁"
    ["₂  subscript 2"]="₂"
    ["₃  subscript 3"]="₃"
    ["₄  subscript 4"]="₄"
    ["₅  subscript 5"]="₅"
    ["₆  subscript 6"]="₆"
    ["₇  subscript 7"]="₇"
    ["₈  subscript 8"]="₈"
    ["₉  subscript 9"]="₉"

    # Currency
    ["€  euro"]="€"
    ["£  pound"]="£"
    ["¥  yen"]="¥"
    ["¢  cent"]="¢"
    ["₿  bitcoin"]="₿"
    ["₽  ruble"]="₽"
    ["₩  won"]="₩"

    # Arrows
    ["←  left arrow"]="←"
    ["→  right arrow"]="→"
    ["↑  up arrow"]="↑"
    ["↓  down arrow"]="↓"
    ["↔  left-right arrow"]="↔"
    ["↕  up-down arrow"]="↕"
    ["⇐  left double arrow"]="⇐"
    ["⇒  right double arrow"]="⇒"
    ["⇔  left-right double arrow"]="⇔"

    # Typography & Punctuation
    ["—  em dash"]="—"
    ["–  en dash"]="–"
    ["…  ellipsis"]="…"
    ["«  left guillemet"]="«"
    ["»  right guillemet"]="»"
    ["‹  left single guillemet"]="‹"
    ["›  right single guillemet"]="›"
    ["•  bullet"]="•"
    ["·  middle dot"]="·"
    ["†  dagger"]="†"
    ["‡  double dagger"]="‡"
    ["§  section sign"]="§"
    ["¶  pilcrow / paragraph"]="¶"
    ["©  copyright"]="©"
    ["®  registered trademark"]="®"
    ["™  trademark"]="™"
    ["′  prime"]="′"
    ["″  double prime"]="″"

    # Fractions
    ["½  one half"]="½"
    ["⅓  one third"]="⅓"
    ["⅔  two thirds"]="⅔"
    ["¼  one quarter"]="¼"
    ["¾  three quarters"]="¾"
    ["⅛  one eighth"]="⅛"
    ["⅜  three eighths"]="⅜"
    ["⅝  five eighths"]="⅝"
    ["⅞  seven eighths"]="⅞"

    # Misc symbols
    ["♠  spade"]="♠"
    ["♣  club"]="♣"
    ["♥  heart"]="♥"
    ["♦  diamond"]="♦"
    ["★  black star"]="★"
    ["☆  white star"]="☆"
    ["☐  ballot box"]="☐"
    ["☑  ballot box checked"]="☑"
    ["☒  ballot box x"]="☒"
    ["♩  quarter note"]="♩"
    ["♪  eighth note"]="♪"
    ["♫  beamed eighth notes"]="♫"
    ["♬  beamed sixteenth notes"]="♬"
    ["☀  sun"]="☀"
    ["☁  cloud"]="☁"
    ["☂  umbrella"]="☂"
    ["☃  snowman"]="☃"
    ["⚡  lightning"]="⚡"
    ["❄  snowflake"]="❄"
    ["✓  check mark"]="✓"
    ["✗  x mark"]="✗"
    ["✦  four pointed star"]="✦"
    ["⚙  gear"]="⚙"
    ["⚠  warning"]="⚠"
    ["⚔  crossed swords"]="⚔"
    ["⚖  scales"]="⚖"
    ["⚗  alembic"]="⚗"
    ["♻  recycling"]="♻"
    ["☯  yin yang"]="☯"
    ["☮  peace"]="☮"
)

# Build the menu list (sorted)
menu=$(for key in "${!chars[@]}"; do echo "$key"; done | sort)

# Show rofi menu
chosen=$(echo "$menu" | rofi -dmenu -i -p "Special Characters" -theme-str 'window {width: 600px;}')

# Exit if nothing selected
[[ -z "$chosen" ]] && exit 0

# Get the actual character from the label
char="${chars[$chosen]}"

# Copy to clipboard
echo -n "$char" | wl-copy

# Optional: also type it immediately via wtype
# wtype "$char"
