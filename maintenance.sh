#!/bin/bash

echo "=== Stage 1: Failed Services ==="
systemctl --failed

echo "=== Stage 2: System Update ==="
sudo pacman -Syu
if command -v paccache &>/dev/null; then
    paccache -rk2
else
    echo "paccache not found, skipping cache cleanup (install pacman-contrib)"
fi

echo "=== Stage 3: Journal Vacuum ==="
journalctl --vacuum-time=2weeks

echo "=== Stage 4: AUR Update ==="
if command -v yay &>/dev/null; then
    echo "yay found, updating AUR packages..."
    yay -Syu
fi
if command -v paru &>/dev/null; then
    echo "paru found, updating AUR packages..."
    paru -Syu
fi
