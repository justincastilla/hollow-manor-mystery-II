#!/usr/bin/env bash
# Builds the "before" copy of the game to work in live: Jessica's files, no Flox environment.
# Usage: talk/stage.sh [stage-dir]    (default: ../hollow-manor-mystery-stage)
set -euo pipefail

repo="$(cd "$(dirname "$0")/.." && pwd)"
stage="${1:-$(dirname "$repo")/hollow-manor-mystery-stage}"
marker=".git/hollow-manor-mystery-stage"

if [ -e "$stage" ]; then
  if [ ! -e "$stage/$marker" ]; then
    echo "$stage exists and wasn't made by this script; refusing to replace it." >&2
    exit 1
  fi
  rm -rf "$stage"
fi
mkdir -p "$stage"

cp -R "$repo"/server.py "$repo"/case.py "$repo"/static "$repo"/Dockerfile \
  "$repo"/DEPLOY.md "$repo"/SPOILERS.md "$repo"/.gitignore "$repo"/.dockerignore "$stage"/
cp "$repo/GAME.md" "$stage/README.md"

(
  cd "$stage"
  git init -q
  git add -A
  git -c user.name="Hollow Manor" -c user.email="stage@localhost" commit -qm "Before Flox"
  touch "$marker"
)

# python3 ignores .env, so the cold open still fails; the Flox hook picks it up later.
if [ -f "$repo/.env" ]; then
  cp "$repo/.env" "$stage/.env"
else
  echo "No .env in $repo: copy .env.example to .env and add a demo key, then rerun." >&2
fi

echo "Stage ready: cd $(cd "$stage" && pwd)"
