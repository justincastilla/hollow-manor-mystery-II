# Speaker script: The Works-on-My-Machine Murder

Thirteen minutes, beat by beat. **Bold slide numbers** match `talk/slides/index.html`. Quoted lines are what to say; code blocks are what to type. Every live step happens in the stage copy that `talk/stage.sh` builds at `../hollow-mansion-stage` (the game with no Flox environment).

Keep `talk/snippets/` open in an editor beside the terminal for the two paste beats.

---

## 0:00 Cold open (1 min) · Slides 1 to 2

**Slide 1** is up as you walk on. Advance to **slide 2**.

> You just watched that game run beautifully. It worked on that machine. The storm's washed out the road, and now it's on mine.

Switch to the terminal, in the stage copy:

```bash
python3 --version
python3 server.py
```

The server prints *"RUNPOD_API_KEY is not set; the manor will stay dark."* Stop it with `Ctrl-C`.

> It starts, on a Python I never chose, with no key, and nothing told me how to fix either. The killer is still in the house. And it isn't Rosalind. It's the environment.

## 1:00 Meet the detective (1 min) · Slides 3 to 4

**Slide 3.**

> Tonight's detective is Flox. A Flox environment is one file: the tools, the settings, and the services this project needs. Every machine that activates it gets the same thing.

**Slide 4.**

> No container to build, no VM. You keep your shell, your editor, your dotfiles. Flox layers the project's tools on top while you're in the project, and takes them away when you leave.

## 2:00 Clue 1: two Pythons (2.5 min) · Slides 5 to 6

**Slide 5.**

> The README says Python 3.9 or later. The Dockerfile says 3.12. My laptop says something else again. Three witnesses, three different stories.

Terminal:

```bash
flox init
flox install python312
flox activate
python3 --version
which python3
exit
python3 --version
```

> Inside the environment: 3.12, from the project's `.flox` folder. Leave, and my laptop's Python is back, untouched. Nothing was installed globally.

**Slide 6.** Open `.flox/env/manifest.toml`, then glance at `.flox/env/manifest.lock`.

> Two files. The manifest is what I asked for: Python 3.12. The lockfile is exactly what I got, down to the build. Commit both, and everyone on the team gets this same Python.

## 4:30 Clue 2: the key in the shell (2.5 min) · Slides 7 to 8

**Slide 7.**

> Here's what the README tells you to do with the API key.

```bash
export RUNPOD_API_KEY=rpa_DEMO_not_real
history | grep rpa_
unset RUNPOD_API_KEY
```

> There it is, in my shell history, for good. The deploy docs pass it on the `docker run` command line, which is worse. The repo already gitignores `.env`. Nothing reads it.

```bash
flox edit
```

Paste `talk/snippets/1-vars-and-hook.toml` at the end and save.

**Slide 8.**

> One rule to take home. `[vars]` is for settings like the port and the daily budget. They're committed, so everyone shares them. Secrets get *loaded* by the hook, from a `.env` file that never leaves your machine. The manifest is shared, and can go to FloxHub, so a secret never goes in it.

```bash
flox activate
echo "$DAILY_BUDGET_USD"
exit
```

## 7:00 Clue 3: the foreground process (2.5 min) · Slide 9

**Slide 9.**

> Right now the server lives in whichever terminal tab I started it from. Close the tab, lose the game, lose the logs.

```bash
flox edit
```

Paste `talk/snippets/2-services.toml` at the end and save.

```bash
flox activate --start-services
flox services status
flox services logs manor --follow
```

Open `http://localhost:8666` and click *Enter the Manor*. Ask Madame Zora *"Did anyone leave the séance early?"* and point at the request arriving in the log. Keep the play to about 60 seconds.

> The environment runs the server for me, with the settings and the key already loaded.

`Ctrl-C` the logs, then `exit`. Leaving the last activation stops the service.

## 9:30 The accusation (2 min) · Slide 10

**Slide 10.** On the second, clean machine (only Flox and git installed):

```bash
git clone https://github.com/justincastilla/hollow-mansion-II.git
cd hollow-mansion-II
flox activate --start-services
```

The hook prints the `.env.example` hint. That's the beat:

> A brand-new teammate, and the environment tells them exactly what's missing. No digging through a README.

```bash
exit
cp .env.example .env     # paste the demo key
flox activate --start-services
```

Open the game on that machine. Same game, same Python, same settings.

> And you don't even need the clone: `flox push` sends the environment to FloxHub, and anyone on the team runs `flox activate -r` to step into it.

## 11:30 The reveal (1.5 min) · Slides 11 to 12

**Slide 11.** Walk the table, one row at a time.

> Two Pythons: `flox install` and the lockfile. The key in the shell: a hook, with settings in `[vars]`. The server nobody managed: `[services]`. And "works on my machine": `flox activate`.

**Slide 12.**

> The suspect was never the code. That game is good code. It was everything around the code. Everything you saw is in this repo, and the docs are at flox.dev. Thank you.

---

## Timing checkpoints

If you're behind at a checkpoint, take the cut listed.

| By | You should be | If behind, cut |
| --- | --- | --- |
| 2:00 | Typing `flox init` | Shorten slide 4 to one line |
| 4:30 | On slide 7 | Skip the second `python3 --version` outside the environment |
| 7:00 | On slide 9 | Skip `echo "$DAILY_BUDGET_USD"` |
| 9:30 | On slide 10 | Skip `flox services status`; ask Zora nothing, just show the page load in the log |
| 11:30 | On slide 11 | Skip the `.env.example` round-trip: say the line, show the hint, move on |
