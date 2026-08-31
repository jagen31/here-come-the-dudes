# danceart

Dance figures for [facade](https://github.com/jagen31/facade) (Art 4), in
[Rhombus](https://rhombus-lang.org) — the *dance* instantiation of the engine,
alongside [tonart4](https://github.com/jagen31/tonart4) (music) and
[programmart](https://github.com/jagen31/programmart) (programs). Ported from the
"dudes" of the tonart concert.

## Vocabulary

| form | meaning |
|---|---|
| `arm_diagram left right` | an object: a pose, arms at clock positions (0–12; left arm green, right blue) |
| `facing dir` | a coordinate: which way the dancer faces (`towards` / `away` / `left` / `right`) |
| `dance_html` | a realizer: render the poses in time order as a filmstrip of figures |

`import: danceart open` also brings all of facade (`realize`, `at`, the standard
coordinates, `--`, `dilate`, …).

## Usage

```
#lang rhombus/and_meta
import: danceart open

def html = realize dance_html:
             at [facing towards]:
               #{--} [1, arm_diagram 7.5 7.5]
                     [1, arm_diagram 4.5 4.5]
                     [1, arm_diagram 7.5 4.5]
                     [1, arm_diagram 4.5 7.5]
```

Figures are drawn by `private/dance-draw.rkt` (Racket + `2htdp/image`) and
written under `dance-figures/`.

## Layout

- `danceart-lib/` — the library (collection `danceart`)
  - `main.rhm` — public entry (re-exports facade + the dance lib)
  - `private/lib.rhm` — the vocabulary and the realizer
  - `private/dance-draw.rkt` — the figure drawer (Racket)
  - `tests/demo.rhm` — a worked example
- `danceart/` — the metapackage
