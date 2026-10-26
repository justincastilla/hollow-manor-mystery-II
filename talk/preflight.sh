#!/usr/bin/env bash
# Checks that this machine is ready to give the demo. Run it from anywhere in the repo.
set -uo pipefail

repo="$(cd "$(dirname "$0")/.." && pwd)"
stage="$(dirname "$repo")/hollow-manor-mystery-stage"
failures=0

pass() { printf '  ✓ %s\n' "$1"; }
fail() { printf '  ✗ %s\n    → %s\n' "$1" "$2"; failures=$((failures + 1)); }

echo "🕯️  Preflight for the Works-on-My-Machine Murder"

if command -v flox >/dev/null 2>&1; then
  pass "Flox installed ($(flox --version 2>/dev/null))"
else
  fail "Flox is not installed" "https://flox.dev/docs/install-flox/"
fi

if [ -f "$repo/.flox/env/manifest.lock" ]; then
  pass "Lockfile present"
else
  fail "No .flox/env/manifest.lock" "run 'flox activate' once in $repo, then commit the lockfile"
fi

key="$(sed -n 's/^RUNPOD_API_KEY=//p' "$repo/.env" 2>/dev/null | tail -n 1)"
if [ -n "$key" ] && [ "$key" != "rpa_your_key_here" ]; then
  pass ".env has a RUNPOD_API_KEY"
else
  fail "No usable RUNPOD_API_KEY in $repo/.env" "cp .env.example .env and add a demo key with a spend limit"
fi

if (exec 3<>/dev/tcp/127.0.0.1/8666) 2>/dev/null; then
  fail "Port 8666 is already in use" "stop the other server (flox services stop, or Ctrl-C it)"
else
  pass "Port 8666 is free"
fi

if curl -sS -o /dev/null --max-time 5 https://api.runpod.ai 2>/dev/null; then
  pass "Runpod is reachable"
else
  fail "Can't reach api.runpod.ai" "check the network, or plan to use the screen recording"
fi

if [ -d "$stage/.git" ]; then
  if [ -e "$stage/.flox" ]; then
    fail "The stage copy already has a .flox" "rerun talk/stage.sh for a fresh 'before' copy"
  else
    pass "Stage copy ready at $stage"
  fi
else
  fail "No stage copy" "run talk/stage.sh"
fi

if [ "$failures" -eq 0 ]; then
  echo "All clear. The manor awaits."
else
  echo "$failures problem(s) to fix before the curtain goes up."
  exit 1
fi
