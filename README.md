# Interview Skills

Research-backed interview preparation, evidence-based post-interview review, and personalized thank-you email drafts.

## Why This Exists

Most interview prep is too generic. It tells candidates to "research the company" without turning that research into sharp talking points, company-specific questions, or a clear theory of what the role is meant to solve.

This skill helps an agent build a practical interview brief from public sources:

- Company background, business model, culture, leadership, and recent developments
- Public-company financials or private-company traction signals
- Role analysis and function-specific market context
- Interviewer background checks using public, professional information only
- Tailored questions, candidate positioning, and likely interview themes
- Question-by-question review of the user's own interview notes or transcript, keeping actual answers separate from improved answers
- A prioritized improvement plan, next-round preparation, and a thank-you email grounded in the actual conversation

## Quick Start

Install the skill folder into your global Codex skills directory:

```bash
cp -R skills/interview-skills ~/.codex/skills/interview-skills
```

Then ask Codex:

```text
Use $interview-skills to prepare me for a hiring manager interview at Stripe for a product manager role.
```

If you know the interviewer, include their name or public profile:

```text
Use $interview-skills to prepare me for a final round at OpenAI. The role is finance strategy, and my interviewer is Jane Doe, VP Finance.
```

For post-interview review, provide your own notes or transcript:

```text
Use $interview-skills to review my interview transcript. Go question by question through what I actually answered, identify strengths and gaps, improve my answers, and draft a concise thank-you email based on our conversation.
```

If you provide another candidate's interview experience, the skill extracts question themes and practice suggestions. It does not evaluate your performance or invent a conversation for your thank-you email. Email output is a draft; sending requires a separate explicit instruction.

## Available Skill

| Skill | What it does | Use when |
| --- | --- | --- |
| `interview-skills` | Builds prep briefs, reviews actual interview evidence, and drafts personalized thank-you emails | Preparing for interviews; reviewing interview notes or transcripts; improving answers and preparing the next round |

## Example Outputs

- [Quick screen](examples/quick-screen.md)
- [Hiring manager round](examples/hiring-manager-round.md)
- [Interviewer background check](examples/interviewer-background-check.md)

## Methodology

The skill uses public, professional, interview-relevant sources and labels evidence quality:

- `Confirmed`: official company, filing, investor, regulatory, or direct public profile source
- `Reported`: reputable press or trade publication
- `Anecdotal`: forum, review site, social media, or unverified individual account
- `Inferred`: reasoned conclusion from multiple facts, with the basis stated

See [methodology](docs/methodology.md) and [privacy and source standards](docs/privacy-and-source-standards.md).

## Repository Structure

```text
interview-skills/
|-- README.md
|-- LICENSE
|-- AGENTS.md
|-- skills/
|   `-- interview-skills/
|       |-- SKILL.md
|       |-- SKILL.zh-CN.md
|       |-- agents/
|       |   `-- openai.yaml
|       `-- references/
|           |-- research-checklist.md
|           |-- research-checklist.zh-CN.md
|           |-- post-interview-review.md
|           |-- post-interview-review.zh-CN.md
|           |-- thank-you-email-template.md
|           `-- thank-you-email-template.zh-CN.md
|-- examples/
|-- docs/
`-- scripts/
    `-- validate.sh
```

`SKILL.md` is the agent execution guide. `README.md` is the human-facing project guide. `examples/` show expected output shapes. `docs/` explain research standards. `scripts/` contains lightweight validation.

## License

MIT.
