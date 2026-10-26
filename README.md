# 🕯️ Hollow Manor Mystery II: The Works-on-My-Machine Murder

A 13-minute talk and live demo for people new to [Flox](https://flox.dev). It follows the *Murder at Hollow Manor* demo: an AI murder-mystery game that runs beautifully on one machine. This talk shows why it only runs there, then fixes that live with a Flox environment.

> The suspect was never the code. It was everything around it.

The game itself is Jessica's ([JessicaGarson/hollow-manor-mystery](https://github.com/JessicaGarson/hollow-manor-mystery)); its original README is in [`GAME.md`](GAME.md). This repo adds the Flox environment that solves the case, plus everything needed to give the talk.

## What's here

| Path | What it is |
| --- | --- |
| [`talk/OUTLINE.md`](talk/OUTLINE.md) | One-page outline: the run of show and the takeaways |
| [`talk/SCRIPT.md`](talk/SCRIPT.md) | Full speaker script: what to say, what to type, beat by beat |
| [`talk/slides/index.html`](talk/slides/index.html) | The slide deck (works offline; `N` toggles speaker notes) |
| [`talk/slides/slides.pdf`](talk/slides/slides.pdf) | PDF of the deck, for when the browser won't cooperate |
| [`talk/snippets/`](talk/snippets/) | Manifest blocks to paste during `flox edit` |
| [`talk/CHECKLIST.md`](talk/CHECKLIST.md) | Rehearsal setup, day-of checklist, and fallbacks |
| [`talk/stage.sh`](talk/stage.sh) | Builds the "before" copy of the game (no Flox) to work in live |
| [`talk/preflight.sh`](talk/preflight.sh) | Checks the demo machine is ready |
| [`.flox/env/manifest.toml`](.flox/env/manifest.toml) | The finished environment: the solution to the case |

## Play the game with Flox

You need [Flox](https://flox.dev/docs/install-flox/) and a [Runpod API key](https://www.runpod.io/console/user/settings).

```bash
git clone https://github.com/justincastilla/hollow-manor-mystery-II.git
cd hollow-manor-mystery-II
cp .env.example .env              # add your RUNPOD_API_KEY; .env is gitignored
flox activate --start-services
flox services logs manor --follow
```

Then open http://localhost:8666. Settings live in `[vars]` in `.flox/env/manifest.toml`; anything in `.env` overrides them. `DEPLOY.md` lists every setting the server reads.

## Rehearse the talk

```bash
talk/preflight.sh                 # is this machine ready?
talk/stage.sh                     # build the "before" copy at ../hollow-manor-mystery-stage
cd ../hollow-manor-mystery-stage        # every live step happens here
```

Open `talk/slides/index.html` in a browser, then follow [`talk/SCRIPT.md`](talk/SCRIPT.md). Keys: `→`/`Space` next, `←` back, `N` speaker notes, `F` full screen.

## The clues and the fixes

| The clue | Where it hides | The Flox fix |
| --- | --- | --- |
| Two Pythons | `GAME.md` says 3.9+, the `Dockerfile` says 3.12, the laptop says whatever it ships | `flox install python312`, recorded in `manifest.lock` |
| The key in the shell | `export RUNPOD_API_KEY=...` lands in shell history | An `on-activate` hook loads the gitignored `.env`; settings go in `[vars]` |
| The foreground process | `python3 server.py` lives and dies with one terminal tab | `[services]`, with `flox services logs` |
| "Works on my machine" | All of the above | `flox activate` |
