#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="$ROOT/skills/interview-skills"

test -f "$ROOT/README.md"
test -f "$ROOT/LICENSE"
test -f "$ROOT/AGENTS.md"
test -f "$SKILL/SKILL.md"
test -f "$SKILL/agents/openai.yaml"
test -f "$SKILL/references/research-checklist.md"

python3 - "$SKILL/SKILL.md" <<'PY'
import pathlib
import re
import sys

path = pathlib.Path(sys.argv[1])
text = path.read_text()
if not text.startswith("---\n"):
    raise SystemExit("SKILL.md missing YAML frontmatter")
match = re.match(r"^---\n(.*?)\n---", text, re.S)
if not match:
    raise SystemExit("SKILL.md frontmatter is malformed")
frontmatter = {}
for line in match.group(1).splitlines():
    if ":" not in line:
        raise SystemExit(f"Invalid frontmatter line: {line}")
    key, value = line.split(":", 1)
    frontmatter[key.strip()] = value.strip()
if frontmatter.get("name") != "interview-skills":
    raise SystemExit("Unexpected skill name")
description = frontmatter.get("description", "")
if not description:
    raise SystemExit("Missing description")
if len(description) > 1024:
    raise SystemExit("Description too long")
if "<" in description or ">" in description:
    raise SystemExit("Description cannot contain angle brackets")
print("interview-skills repo validation passed")
PY
