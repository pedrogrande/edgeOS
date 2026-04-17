<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# Ok, this step has identified agents that were missing from the original document. What are your recommendations for the full roster for this system?

Based on the gaps identified across Sections 1 and 2, here is the recommended full roster — retaining, refining, and extending the original five agents.

***

## Recommended Full Roster

The original design names five agents. The analysis surfaces **four missing agents** and **one agent that should be split**, bringing the recommended total to **nine agents**.[^1]

***

## Retained Agents (Unchanged)

These three require no structural changes:

- **Fact-Check Agent** — Reviewer; verifies claims against primary sources; well-scoped and cleanly separated from its executors[^1]
- **Editorial Review Agent** — Reviewer + Articulation Agent; assesses draft quality and surfaces issues to the journalist without modifying content[^1]
- **Submission Prep Agent** — Executor; formats and packages the submission; its authority is tightly bounded and its verifier (the journalist trigger) is clear[^1]

***

## Refined Agents (Existing, but Restructured)

### Research Agent → Split into Two

The document already describes a **parallel Research Agent instance** deployed for investigative and sensitive topics, with a *different search strategy* to surface what the primary instance misses.  Running this as a configuration of the same agent conflates two genuinely different cognitive orientations.[^1]


| Agent | Archetype | Orientation | Role |
| :-- | :-- | :-- | :-- |
| **Research Agent** | Executor + Synthesiser | Factual | Primary source aggregation, Source Manifest production, confidence-tier assignment |
| **Adversarial Research Agent** | Exploration | Divergent / Creative | Runs a structurally different search strategy in parallel; explicitly targets blind spots and underrepresented perspectives; delivers a counterargument brief before drafting |

The Adversarial Research Agent's output is never merged automatically — it is delivered alongside the primary brief so the journalist sees both. Its only job is to widen the option space, never to narrow it.[^1]

### Outreach Draft Agent → Split into Two

The current Outreach Draft Agent combines **expert discovery** (an exploratory task requiring evaluative judgment about credentials and conflicts of interest) with **draft text production** (a procedural task). These are different cognitive orientations and mixing them in one agent creates a subtle self-judgment risk: the same agent that identifies the candidate also produces the communication supporting that candidate.[^1]


| Agent | Archetype | Orientation | Role |
| :-- | :-- | :-- | :-- |
| **Expert Discovery Agent** | Exploration | Critical + Factual | Identifies expert candidates, verifies credentials against two independent sources, flags undisclosed conflicts of interest, surfaces candidate shortlist for journalist selection |
| **Outreach Draft Agent** | Executor | Procedural | Produces draft interview request text for journalist review and personalisation, based on a candidate the journalist has already selected |

The Expert Discovery Agent produces a shortlist with documented reasoning; it never drafts communications. The Outreach Draft Agent receives a journalist-confirmed selection; it never evaluates candidate suitability.[^1]

***

## New Agents (Missing from Original)

### 1 — Interview Note Synthesis Agent

**Gap:** The document states "the agent may transcribe and structure notes afterward" and that note synthesis requires Editorial Review Agent verification before notes enter the research record — but no agent is named as responsible for this work.[^1]


| Property | Detail |
| :-- | :-- |
| **Archetype** | Executor |
| **Orientation** | Procedural + Synthesising |
| **Produces** | Structured interview notes: timestamped quote extracts, attributed claims, open questions flagged for follow-up |
| **Structurally cannot** | Interpret, editorially frame, or evaluate the significance of what was said; modify the journalist's own written notes |
| **Verifier** | Editorial Review Agent — note synthesis passes through an ERA check before entering the research record, to prevent the journalist's memory biases embedding unchecked [^1] |


***

### 2 — Workflow Orchestrator Agent

**Gap:** The document's sequencing logic is entirely implicit — task initiation, agent handoffs, SLA tracking, deadline estimation, and escalation are described functionally but no agent owns them.  Without an explicit Orchestrator, these responsibilities default to the journalist, which is a coordination cost the system is supposed to reduce.[^1]


| Property | Detail |
| :-- | :-- |
| **Archetype** | Orchestrator |
| **Orientation** | Procedural |
| **Coordinates** | Task sequencing, agent handoffs, verification queue state, deadline SLA tracking, escalation notifications |
| **Decides** | Routing only — which agent receives which input at which stage |
| **Structurally cannot** | Make any editorial judgment, modify any content, approve any verification step, or bypass a human-gated checkpoint |
| **Key constraint** | The Orchestrator cannot unlock a downstream stage that requires journalist approval — it can only queue, notify, and escalate. It has no override path. |


***

### 3 — Pattern Analytics Agent

**Gap:** The G3 "Your journalism patterns" monthly digest, the G5 knowledge pattern library, the dependency detection signals (H2), and the source diversity audit (Q1/Q3) are all described in detail — but no agent is named as responsible for generating, validating, or delivering any of them.[^1]


| Property | Detail |
| :-- | :-- |
| **Archetype** | Synthesiser |
| **Orientation** | Factual + Synthesising |
| **Produces** | Monthly patterns digest (source diversity, structural habits, interview patterns); dependency risk signals; source library updates; pattern validation prompts when data is stale or contradicted |
| **Inputs** | Journalist action logs, source annotation history, editorial review flags, editor feedback records |
| **Structurally cannot** | Share pattern data with editors or the publication without explicit journalist consent; encode a pattern without minimum three data points and journalist approval [^1] |
| **Verifier** | Journalist reviews and approves every new pattern entry before it influences future recommendations |


***

## Summary: Full Roster

| \# | Agent | Archetype | Orientation | Status |
| :-- | :-- | :-- | :-- | :-- |
| 1 | Research Agent | Executor + Synthesiser | Factual | Retained |
| 2 | Adversarial Research Agent | Exploration | Divergent | New (formalised from implicit parallel instance) |
| 3 | Fact-Check Agent | Reviewer | Critical | Retained |
| 4 | Editorial Review Agent | Reviewer + Articulation | Critical + Procedural | Retained |
| 5 | Expert Discovery Agent | Exploration | Critical + Factual | New (split from Outreach Draft Agent) |
| 6 | Outreach Draft Agent | Executor | Procedural | Refined (narrowed scope) |
| 7 | Submission Prep Agent | Executor | Procedural | Retained |
| 8 | Interview Note Synthesis Agent | Executor | Procedural + Synthesising | New |
| 9 | Workflow Orchestrator Agent | Orchestrator | Procedural | New |
| 10 | Pattern Analytics Agent | Synthesiser | Factual + Synthesising | New |

One open question remains from the document's Phase 2 list: **voice preservation measurement**.  The Editorial Review Agent currently uses a "style baseline" to check voice consistency, but no agent builds or maintains that baseline. Whether this warrants a dedicated Style Baseline Agent or becomes a function of the Pattern Analytics Agent is a design decision that should be resolved before the Editorial Review Agent's verification criteria can be considered structurally complete.[^1]

<div align="center">⁂</div>

[^1]: agentic-system-design-responses-author.md

