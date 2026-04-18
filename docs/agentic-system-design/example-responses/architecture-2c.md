<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# Let's always go with an additional agent if in doubt

Noted — that's a clean design principle: **a focused agent is always preferable to a blended one**. Applying it to the full picture from the document, it resolves the open question and surfaces two more unassigned functions that were hiding in plain sight.[^1]

***

## Three Additions Under the "If in Doubt" Principle

### 11 — Style Baseline Agent

The document's verification criteria explicitly state that article drafts must be checked for "voice consistency with journalist's style baseline" — but no agent builds or maintains that baseline.  The Editorial Review Agent currently *uses* it without any agent being responsible for *producing* it. Without a dedicated agent, the baseline is either static (set at onboarding and never updated) or informal (the Editorial Review Agent is implicitly constructing it, which is a self-judgment risk — it would be reviewing against a model it built itself).[^1]


| Property | Detail |
| :-- | :-- |
| **Archetype** | Synthesiser |
| **Orientation** | Factual + Synthesising |
| **Produces** | A versioned style baseline derived from the journalist's approved article history — sentence length distributions, vocabulary range, structural openings, tonal markers |
| **Updates when** | The journalist approves a new published article as a baseline sample; never updates from drafts |
| **Structurally cannot** | Evaluate any draft against the baseline (that is the Editorial Review Agent's job); modify any content |
| **Verifier** | Journalist reviews and approves each baseline update before it takes effect |


***

### 12 — Source Relationship Agent

The document describes source cultivation as a journalist responsibility, with the agent "providing reminders and context, never initiating contact."  The Phase 2 open questions explicitly flag this as a candidate feature: *"a relationship cultivation layer that reminds the journalist of source history and suggests follow-up connection points without initiating contact."*  Applying the principle, this is a distinct function — long-horizon relationship memory across articles — that belongs to no existing agent without scope creep.[^1]


| Property | Detail |
| :-- | :-- |
| **Archetype** | Executor |
| **Orientation** | Procedural + Synthesising |
| **Produces** | Source history summaries (last contacted, topics covered, accuracy record); timely reminders for follow-up; flags when a source's stated credentials or position have changed |
| **Structurally cannot** | Initiate any contact with sources; send any communication; share source contact data with any other agent or external system |
| **Verifier** | Journalist reviews all reminders; no action is taken without journalist decision |


***

### 13 — Capability Assessment Agent

The document describes detailed dependency detection signals in H2 — tracking the ratio of unmodified agent-prepared materials, flagging zero journalist-originated angles in a 30-day window, and running quarterly capability check-ins.  These are currently unassigned. Giving this function to the Pattern Analytics Agent would collapse two genuinely different orientations into one: pattern observation (factual/synthesising) and human capability evaluation (critical). Under the principle, they stay separate.[^1]


| Property | Detail |
| :-- | :-- |
| **Archetype** | Reviewer |
| **Orientation** | Critical |
| **Produces** | Quarterly capability check-in prompts; monthly dependency risk signals; flags when journalist annotation rate, angle-origination rate, or source modification rate drops below threshold |
| **Structurally cannot** | Modify the journalist's workflow, reduce agent scaffolding autonomously, or share capability data with editors or the publication without explicit journalist consent |
| **Verifier** | Journalist and system steward jointly review any capability flag that triggers a scaffolding tier change |


***

## Final Roster — 13 Agents

| \# | Agent | Archetype | Orientation |
| :-- | :-- | :-- | :-- |
| 1 | Research Agent | Executor + Synthesiser | Factual |
| 2 | Adversarial Research Agent | Exploration | Divergent |
| 3 | Fact-Check Agent | Reviewer | Critical |
| 4 | Editorial Review Agent | Reviewer + Articulation | Critical + Procedural |
| 5 | Expert Discovery Agent | Exploration | Critical + Factual |
| 6 | Outreach Draft Agent | Executor | Procedural |
| 7 | Submission Prep Agent | Executor | Procedural |
| 8 | Interview Note Synthesis Agent | Executor | Procedural + Synthesising |
| 9 | Workflow Orchestrator Agent | Orchestrator | Procedural |
| 10 | Pattern Analytics Agent | Synthesiser | Factual + Synthesising |
| 11 | Style Baseline Agent | Synthesiser | Factual + Synthesising |
| 12 | Source Relationship Agent | Executor | Procedural + Synthesising |
| 13 | Capability Assessment Agent | Reviewer | Critical |

This roster now has no workflow function described anywhere in the design document that is either unassigned or silently absorbed into an agent with a different primary purpose.  Every agent has a single dominant orientation, and no agent both executes and reviews the same class of output.[^1]

<div align="center">⁂</div>

[^1]: agentic-system-design-responses-author.md

