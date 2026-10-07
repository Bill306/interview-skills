#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SKILL="$ROOT/skills/interview-skills"

test -f "$ROOT/README.md"
test -f "$ROOT/LICENSE"
test -f "$ROOT/AGENTS.md"
test -f "$SKILL/SKILL.md"
test -f "$SKILL/SKILL.zh-CN.md"
test -f "$SKILL/agents/openai.yaml"
test -f "$SKILL/references/research-checklist.md"
test -f "$SKILL/references/research-checklist.zh-CN.md"
test -f "$SKILL/references/post-interview-review.md"
test -f "$SKILL/references/post-interview-review.zh-CN.md"
test -f "$SKILL/references/thank-you-email-template.md"
test -f "$SKILL/references/thank-you-email-template.zh-CN.md"

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
for link in re.findall(r"\]\((references/[^)]+)\)", text):
    if not (path.parent / link).is_file():
        raise SystemExit(f"Missing referenced resource: {link}")
required = ["Select the Mode", "Part 1: Preparation Before the First Round", "Must-Know List", "Part 2: Review and Thank-You Email After Every Round", "### 6. Review the Interview", "For post-interview review, produce:", "Additional review checks:"]
for item in required:
    if item not in text:
        raise SystemExit(f"Missing review integration: {item}")
print("interview-skills repo validation passed")
PY
