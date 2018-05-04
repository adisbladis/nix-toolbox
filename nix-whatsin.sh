#!/usr/bin/env nix-shell
#! nix-shell -i bash -p nix jq

rev="$1"
if test "${rev}" = ""; then
    echo -e "nix-whatsin - Check what is in a nix channel at <rev>\n"
    echo "Usage: $0 <rev>"
    exit 1
fi

nix-env -f '<nixpkgs>' \
        -I "nixpkgs=https://github.com/nixos/nixpkgs-channels/archive/${rev}.tar.gz" \
        --query --available --json | \
    jq -r 'to_entries | map(.value) | map(.name) | join("\n")' | uniq
