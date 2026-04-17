<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# answer these questions:

```
## Section 2 — Agent Inventory

*Define every agent that exists in the system before specifying any of them in detail.*

| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **2.1 — Agent Roster** | Agent title? |  |
|  | What is the agent's role archetype — Executor, Reviewer, Orchestrator, Synthesiser, Articulation Agent, or Exploration Agent? |  |
|  | Does the agent hold more than one archetype? If so, does that create a self-judgment risk (T5)? |  |
|  | Are there tasks in the workflow that currently have no assigned agent — and should they? |  |
| **2.2 — Role Archetype Definitions** | For each Executor agent: what does it produce, and what does it never evaluate or verify? |  |
|  | For each Reviewer agent: what does it verify against, and what does it never produce or modify? |  |
|  | For each Orchestrator agent: what does it coordinate, and what decisions does it make vs. route? |  |
|  | For each Synthesiser agent: what inputs does it integrate, and how is its output verified? |  |
|  | For each Articulation Agent: what implicit or rough input does it clarify, and for whom? |  |
|  | For each Exploration Agent: when is it deployed, and how is its output prevented from prematurely narrowing the option space? |  |
| **2.3 — Cognitive Orientations** | What cognitive orientation does each agent hold — critical, optimistic, creative, factual, procedural, or synthesising? |  |
|  | Are any two agents in the same workflow stage assigned the same orientation? If so, is that deliberate — or a design gap? |  |
|  | Which workflow stages require cognitive diversity by design — multiple agents with different orientations before a decision is made? |  |
|  | How is cognitive diversity preserved as the system scales — and prevented from converging toward homogeneity? |  |
| **2.4 — Theory of Mind** | Which agents operate in multi-agent pipelines where they must model what upstream agents believe, assumed, and are uncertain about? |  |
|  | How does each agent in a pipeline receive upstream epistemic context — not just outputs, but confidence levels, assumptions, and discarded alternatives? |  |
|  | How does each agent signal its own uncertainty and reasoning to downstream agents? |  |
```

Here are the Section 2 answers drawn entirely from the **Magazine Article Writer** design document.

***

## 2.1 — Agent Roster

The system defines five named agents.[^1]


| Agent | Role Archetype | Self-Judgment Risk? |
| :-- | :-- | :-- |
| **Research Agent** | Executor + Synthesiser (searches, aggregates, summarises, and cites sources from multiple inputs) | No — the Fact-Check Agent is its structurally separate verifier |
| **Fact-Check Agent** | Reviewer (reads and verifies claims against sources only) | Partial — journalist sign-off is required on any disputed item the Fact-Check Agent itself flags, preventing it from being the final word on contested cases |
| **Editorial Review Agent** | Reviewer + Articulation Agent (assesses draft quality, flags voice inconsistencies, and surfaces structural incoherence to the journalist) | No — it cannot modify content, only flag it |
| **Outreach Draft Agent** | Executor (produces draft interview request text for journalist review) | No — the journalist is the mandatory human reviewer of all output |
| **Submission Prep Agent** | Executor (formats and packages the article to editor specifications) | No — the journalist's explicit trigger is the verification gate |

**Dual archetypes and T5 risk:**[^1]

- The Research Agent holds both Executor and Synthesiser roles. This creates no self-judgment risk because it is not involved in verifying its own outputs.
- The Editorial Review Agent holds both Reviewer and Articulation Agent roles (it not only checks but frames issues for the journalist). This is acceptable because it remains structurally incapable of modifying the content it reviews.

**Workflow stages with no assigned agent:**[^1]

- **Interview transcription and note synthesis** — the document notes that "Interview transcription supports the journalist's recall" but no Transcription Agent is formally named. Note synthesis passes through Editorial Review Agent check before entering the research record, but the synthesis task itself is unassigned to a specific agent.
- **Workflow orchestration** — there is no named Orchestrator agent. Sequencing and handoffs appear to rely on the task-initiation framework and journalist triggers rather than a dedicated coordinating agent. This is an implicit design gap.
- **Pattern analytics reporting (G3)** — the monthly "journalism patterns" digest is described functionally but has no named agent responsible for generating it.

***

## 2.2 — Role Archetype Definitions

**Executors**[^1]

- *Research Agent* — produces research briefs, Source Manifests, counterargument briefs, and expert shortlists. It never evaluates whether its own output is sufficiently verified, never modifies article drafts, and never contacts sources.
- *Outreach Draft Agent* — produces draft interview request text. It never sends communications, accesses the journalist's email or calendar, or evaluates candidate suitability beyond credential verification.
- *Submission Prep Agent* — produces a formatted submission package. It never modifies article content, never submits without journalist trigger, and never evaluates the editorial quality of the package it prepares.

**Reviewers**[^1]

- *Fact-Check Agent* — verifies claims in the research brief and article against primary sources using defined verification criteria (every claim mapped to a named accessible source; no single-source claims on contested facts). It never modifies any content, never accesses outreach tools, and never initiates communications. Its output is a structured pass, flag, or failure report.
- *Editorial Review Agent* — verifies article drafts against the journalist's style baseline, structural coherence standards, and factual claim coverage. It never rewrites content, never contacts the editor, and never accesses source contacts. Critically, both reviewers are structurally incapable of modifying what they assess.

**Orchestrators:**  No formally named Orchestrator exists. The task-initiation framework and journalist-gated triggers perform this coordination function implicitly. This is noted as a Phase 2 consideration.[^1]

**Synthesisers:**[^1]

- The *Research Agent* functions as a Synthesiser at the brief-production stage — integrating web search results, source credentials, confidence tiers, and gap analysis into a unified Source Manifest. Its synthesised output (the Source Manifest) is verified by the structurally independent Fact-Check Agent before any downstream use.

**Articulation Agents:**[^1]

- The *Editorial Review Agent* partly fills this role — it takes the journalist's rough or first-pass draft and surfaces implicit issues (voice inconsistencies, structural incoherence, unsupported claims) with specific flagged passages. Its output is directed at the journalist, not at other agents.

**Exploration Agents:**[^1]

- A *second Research Agent instance* with a different search strategy is deployed in parallel for investigative pieces and any topic flagged as politically, legally, medically, or socially sensitive. It is deployed specifically to surface sources the primary Research Agent missed, and its output is delivered to the journalist alongside the primary brief — the journalist sees both. Its output is prevented from narrowing the option space by the rule that the system never presents a single "best" answer; divergence is the explicit goal of the parallel instance.

***

## 2.3 — Cognitive Orientations

The document does not use the orientation labels verbatim, but the orientations are derivable from each agent's defined function.[^1]


| Agent | Orientation | Rationale |
| :-- | :-- | :-- |
| Research Agent (primary) | **Factual** | Prioritises source retrieval, citation accuracy, and confidence-tier assignment |
| Research Agent (parallel instance) | **Exploratory / Creative** | Explicitly deployed to diverge from the primary instance's search strategy and surface non-obvious sources |
| Fact-Check Agent | **Critical** | Designed to challenge and interrogate — its only valid outputs are pass, flag, or reject |
| Editorial Review Agent | **Critical + Procedural** | Applies both structured rule-checking (style guide, format) and qualitative judgment (voice consistency, structural coherence) |
| Outreach Draft Agent | **Procedural** | Applies credential verification and draft templates within defined parameters |
| Submission Prep Agent | **Procedural** | Applies formatting rules and metadata requirements to a pre-approved output |

**Same orientation in the same stage?**  The Fact-Check Agent and Editorial Review Agent are both critical, but they operate at different stages (research verification vs. draft verification) and against different criteria, so the overlap is deliberate and not a design gap.[^1]

**Stages requiring mandatory cognitive diversity:**[^1]

- *Research stage* on investigative and sensitive topics — the parallel Research Agent instance (exploratory) runs alongside the primary (factual), ensuring the research brief reflects perspectives the primary search strategy would not have surfaced.
- *Editing stage* — the Editorial Review Agent (critical/procedural) is required to produce a counterargument brief before the journalist proceeds to draft, ensuring the article is tested against a critical perspective before any prose is written.

**Preserving diversity at scale:**  The document flags this as an open Phase 2 question — ensuring the Research Agent and its parallel instance are *genuinely* cognitively diverse (different training, different search strategies) rather than superficially different requires infrastructure not available in Phase 1. Quarterly source-diversity audits (political perspective, institutional type, geographic origin, demographic representation) serve as the current safeguard against convergence.[^1]

***

## 2.4 — Theory of Mind

**Which agents must model upstream epistemic context?**[^1]

- The *Fact-Check Agent* is the primary pipeline recipient — it receives the Research Agent's Source Manifest and must reason about confidence tiers, not just claim content.
- The *Editorial Review Agent* receives the journalist's draft and the Claim Map — it must reason about which claims have been verified and at what confidence level when deciding what to flag.

**How upstream epistemic context is passed — not just outputs:**[^1]

- The Source Manifest is the structured epistemic handoff between the Research Agent and the Fact-Check Agent. It carries: the specific claim supported by each source, source credentials, access date, and confidence tier (primary/secondary/tertiary). The Fact-Check Agent receives confidence levels and source metadata, not just assertions.
- Notably, the Fact-Check Agent is **structurally denied** access to the Research Agent's *reasoning chain* — it receives only the outputs. This is an intentional independence constraint (T5) to prevent the verifier from being anchored to the executor's logic.
- The Claim Map carries forward the Fact-Check Agent's verification status to the Editorial Review Agent, who can see which claims are verified, at what confidence, and which are disputed.

**How each agent signals its own uncertainty downstream:**[^1]

- The Research Agent halts and surfaces uncertainty (conflicting authoritative sources, recency concerns, unverifiable claims) to the journalist via a structured uncertainty report — not to the next agent in the pipeline. No agent is permitted to automatically resolve another agent's surfaced uncertainty; every uncertainty routes to a human decision point.
- The Fact-Check Agent signals failure via a structured failure report identifying specific claims and evidence gaps — quarantining the output rather than passing a degraded result downstream.
- Agents that need a capability they do not have must surface this as a C3 uncertainty and route to the journalist; they cannot signal capability gaps to other agents or self-escalate.

<div align="center">⁂</div>

[^1]: agentic-system-design-responses-author.md

