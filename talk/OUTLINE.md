# Outline: The Works-on-My-Machine Murder

**Length:** 13 minutes. **Audience:** people new to Flox. **Slot:** directly after the *Murder at Hollow Manor* demo.

**Premise:** The game the audience just watched is well written: one Python file, no dependencies, secrets kept server-side. It still only runs on the machine it was built on. Each reason is a clue; each Flox command is the evidence that cracks it.

**One-sentence takeaway:** A Flox environment is one file that says which tools, settings, and services a project needs, and every machine that activates it gets the same thing.

## Run of show

| Time | Beat | Slides | Demo |
| --- | --- | --- | --- |
| 0:00 to 1:00 | **Cold open:** it worked on their machine; on mine, the manor stays dark | 1 to 2 | `python3 server.py` in the stage copy |
| 1:00 to 2:00 | **Meet the detective:** what a Flox environment is | 3 to 4 | None |
| 2:00 to 4:30 | **Clue 1, two Pythons:** README says 3.9+, Dockerfile says 3.12, laptop says whatever | 5 to 6 | `flox init`, `flox install python312`, `flox activate` |
| 4:30 to 7:00 | **Clue 2, the key in the shell:** `export` puts the API key in shell history | 7 to 8 | `history \| grep rpa_`, `flox edit` with `[vars]` and `[hook]` |
| 7:00 to 9:30 | **Clue 3, the foreground process:** the server dies with its terminal tab | 9 | `[services]`, `flox activate --start-services`, play one question |
| 9:30 to 11:30 | **The accusation:** a clean machine runs it with one command | 10 | `git clone`, `flox activate --start-services` |
| 11:30 to 13:00 | **The reveal:** recap, and the suspect was never the code | 11 to 12 | None |

## What the audience should leave with

1. **`flox init` and `flox install`** put the project's tools in the project, not on the laptop. Leave the environment and your own setup is untouched.
2. **The manifest is what you asked for; the lockfile is exactly what you got.** Commit both.
3. **Settings go in `[vars]`; secrets get loaded by a hook** from a file that never leaves your machine. The manifest is shared, so a secret never goes in it.
4. **`[services]`** runs the project's processes for you, with logs.
5. **`flox activate`** is the whole onboarding doc, and `flox push` / `flox activate -r` shares it through FloxHub without a clone.

## Deliberately left out

Containers (`flox containerize`), composition (`[include]`), and builds. They're good follow-up material, but 13 minutes is enough for one loop done well. If there's Q&A, the closing slide points to the docs for each.
