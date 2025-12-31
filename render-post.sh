#!/usr/bin/env bash
set -euo pipefail

# Usage: ./render-post.sh <post-name>
# Examples:
#   ./render-post.sh 2025-12-31-toy-post
#   ./render-post.sh 2025-12-31-toy-post.qmd
#   ./render-post.sh posts/2025-12-31-toy-post.qmd

# Extract just the base name without path or extension
post="${1%.qmd}"
post_base=$(basename "$post")

echo "Rendering post: ${post_base}.qmd"

if [[ -f "posts/${post_base}.nix" ]]; then
  echo "Found post-specific Nix file: posts/${post_base}.nix"
  echo "Merging with posts/default.nix..."
  nix-shell --expr '
    let pkgs = import (fetchTarball "https://github.com/rstats-on-nix/nixpkgs/archive/2024-12-14.tar.gz") {};
    in import ./posts/default.nix {
      extraPackages = import ./posts/'"${post_base}"'.nix { inherit pkgs; };
    }
  ' --run "quarto render posts/${post_base}.qmd"
else
  echo "No post-specific Nix file found, using posts/default.nix"
  nix-shell posts/default.nix --run "quarto render posts/${post_base}.qmd"
fi
