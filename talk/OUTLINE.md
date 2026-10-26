# Outline: The Works-on-My-Machine Murder

**Length:** about 15½ minutes (13 with the cuts in `SCRIPT.md`). **Audience:** people new to Flox. **Slot:** directly after the *Murder at Hollow Manor* demo.

**Premise:** The game the audience just watched is well written: one Python file, no dependencies, secrets kept server-side. It still only runs on the machine it was built on. Each reason is a clue; each Flox command is the evidence that cracks it.

**One-sentence takeaway:** A Flox environment is one file that says which tools, settings, and services a project needs, and every machine that activates it gets the same thing.

## Run of show

| Time | Beat | Slides | Demo |
| --- | --- | --- | --- |
| 0:00 to 1:00 | **Cold open:** it worked on their machine; on mine, the manor stays dark | 1 to 2 | `python3 server.py` in the stage copy |
| 1:00 to 3:30 | **Meet the detective:** what Flox is, what an environment is, and Nix underneath | 3 to 6 | None |
| 3:30 to 6:00 | **Clue 1, two Pythons:** README says 3.9+, Dockerfile says 3.12, laptop says whatever | 7 to 8 | `flox init`, `flox install python312`, `flox activate` |
| 6:00 to 8:30 | **Clue 2, the key in the shell:** `export` puts the API key in shell history | 9 to 10 | `history \| grep rpa_`, `flox edit` with `[vars]` and `[hook]` |
| 8:30 to 11:00 | **Clue 3, the foreground process:** the server dies with its terminal tab | 11 | `[services]`, `flox activate --start-services`, play one question |
| 11:00 to 13:00 | **The accusation:** a clean machine runs it with one command | 12 | `git clone`, `flox activate --start-services` |
| 13:00 to 14:00 | **The reveal:** recap the clues | 13 | None |
| 14:00 to 15:00 | **Postscript:** why the same environment works for AI agents | 14 | None |
| 15:00 to 15:30 | **Epilogue:** the suspect was never the code | 15 | None |

## What the audience should leave with

1. **`flox init` and `flox install`** put the project's tools in the project, not on the laptop. Leave the environment and your own setup is untouched.
2. **The manifest is what you asked for; the lockfile is exactly what you got.** Commit both.
3. **Settings go in `[vars]`; secrets get loaded by a hook** from a file that never leaves your machine. The manifest is shared, so a secret never goes in it.
4. **`[services]`** runs the project's processes for you, with logs.
5. **`flox activate`** is the whole onboarding doc, and `flox push` / `flox activate -r` shares it through FloxHub without a clone.
6. **Flox is built on Nix**, so it gets Nix's guarantees without the Nix language.
7. **Agents benefit most:** one file to read, `flox activate --` to run, and changes that land in the project's diff.

## Deliberately left out

Containers (`flox containerize`), composition (`[include]`), and builds. They're good follow-up material, but one loop done well is enough for this slot. If there's Q&A, the closing slide points to the docs for each.
