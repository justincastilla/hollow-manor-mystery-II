# Checklist: rehearsal, day of, and fallbacks

## One-time setup

1. **Install Flox** on both demo machines: https://flox.dev/docs/install-flox/
2. **Clone this repo** on the main machine.
3. **Get a demo key.** In Runpod, create an API key for the demo and set a spend limit on the account. Then `cp .env.example .env` and paste it in.
4. **Generate and commit the lockfile.** Run `flox activate` once in the repo. Flox resolves `python312` and writes `.flox/env/manifest.lock`. Commit and push it, so the clean machine gets the exact same build. (This repo was put together without access to the Flox catalog, so the lockfile has to come from your first activation.)
5. **Run the finished version end to end:** `flox activate --start-services`, play one question, `exit`.
6. **Rehearse against your installed Flox version.** If any command's output differs from `talk/SCRIPT.md`, update the script.

## Day of

- [ ] `talk/stage.sh` to build a fresh "before" copy at `../hollow-mansion-stage`
- [ ] `talk/preflight.sh` shows all ✓
- [ ] Run `flox install python312` once somewhere other than the stage, so the package is already cached. Venue Wi-Fi is the real killer.
- [ ] Terminal: large font, short prompt (`PS1='$ '`), stage copy open, history cleared of anything you wouldn't show
- [ ] Editor: `talk/snippets/` open next to the terminal
- [ ] Browser: `talk/slides/index.html` on slide 1, full screen (`F`); a second tab ready for `http://localhost:8666`
- [ ] Clean machine: Flox and git installed, terminal open, nothing cloned yet, demo key ready to paste
- [ ] Notifications off on both machines

## Things to know

- **Portraits cost a few cents.** The server generates seven portraits the first time someone enters the manor and caches them in memory only, so every fresh start regenerates them. Talk over the few seconds it takes.
- **Never show the real key.** The `history` beat uses `rpa_DEMO_not_real`. Don't `cat .env` on screen.
- **`DAILY_BUDGET_USD` is set to 2** in `[vars]`, so a runaway demo can't spend more than that in a day.
- **Leaving the last `flox activate` shell stops the service.** If the game vanishes, check you didn't `exit` one shell too many.

## Fallbacks

| If this breaks | Do this |
| --- | --- |
| A live `flox` step in the stage copy | `cd` to this repo, where the finished environment lives, and carry on from the next beat |
| The network | Play your screen recording of the 7:00 to 11:30 section; record it at your final rehearsal |
| The clean machine | Clone into a new directory on the main machine and run the accusation there |
| The browser deck | Open `talk/slides/slides.pdf` |
| Runpod is down or the key fails | Show the log line with the error reference, say "the spirits aren't answering," and keep going: the point is that the environment ran, not the model |
