<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# this is why it is smart for us to use a case study to better understanding the strengths and gaps of the design tool, along with regular reviews.

Can you provide a written version of the workflow topology that I can create a diagram from

Here is a complete diagram specification you can work from in any tool — Miro, Lucidchart, FigJam, draw.io, or similar.

***

## Diagram Overview

**Orientation:** Top to bottom (portrait). Stages flow vertically; swim lanes run horizontally left to right.

**Reading convention:** The main article workflow runs down the centre. The parallel/continuous track runs as a separate band at the bottom (or as a side panel if space is limited).

***

## Shape Key

| Shape | Meaning |
| :-- | :-- |
| **Filled circle** | Start / End |
| **Rounded rectangle** | Human action (journalist-owned task) |
| **Rectangle** | Agent action |
| **Rectangle, dashed border** | Conditional agent action (only fires on certain article types) |
| **Rectangle, double border** | Human-only zone — structurally protected from agent entry |
| **Hexagon** | Human gate — mandatory human action before workflow can proceed |
| **Diamond** | System decision point (pass / fail / branch) |
| **Parallelogram** | Artifact / document produced |
| **Cylinder** | Data store (audit log, Source Manifest store, workspace) |
| **Thick dashed line** | Parallel continuous track boundary |


***

## Swim Lanes (left to right)

1. **Journalist** — all human actions, gates, and human-only zones
2. **Executor Agents** — agents that produce outputs
3. **Reviewer Agents** — agents that verify, flag, or check
4. **Continuous Agents** — always-running background agents
5. **Infrastructure** — Workflow Orchestrator + Audit Log

***

## Main Workflow — Node \& Connection Specification

### START

- **Node:** `START` — filled circle — Journalist lane

***

### Stage 0 — Story Initiation

- **Node:** `Story Idea & Angle Decision` — rounded rectangle — Journalist lane
    - *Note on shape: double-border. This is a permanently human-led task — no agent input at this stage.*
- **Connection:** START → Story Idea \& Angle Decision (solid arrow)
- **Connection:** Story Idea \& Angle Decision → Stage 1 Research (solid arrow, labelled *"Journalist initiates article"*)

***

### Stage 1 — Research

- **Node:** `Research Agent — Source Aggregation` — rectangle — Executor Agents lane
    - *Mode: Agent-autonomous*
- **Connection:** → produces → `Source Manifest` (parallelogram)
- **Node:** `Adversarial Research Agent — Counterargument Brief` — rectangle, **dashed border** — Executor Agents lane
    - *Fires conditionally: investigative, political, legal, medical, or social justice articles only*
    - *Runs in parallel with Research Agent*
- **Connection:** → produces → `Adversarial Brief` (parallelogram, dashed border)
- **Connection:** Source Manifest + Adversarial Brief → Human Gate 1 (solid arrows merging)
- **Node:** `HUMAN GATE 1: Journalist Reviews Source Manifest` — hexagon — Journalist lane
    - *Label: "Reviews, annotates, selects sources, rejects sources — required before proceeding"*
    - *Note: Journalist may also review Adversarial Brief here if present*
- **Connection:** Human Gate 1 → Stage 1a Verification (solid arrow)

***

### Stage 1a — Research Verification

- **Node:** `Fact-Check Agent — Source Verification` — rectangle — Reviewer Agents lane
    - *Input: Source Manifest only — no access to Research Agent reasoning chain*
    - *Output:* `Verification Report` (parallelogram)
- **Node:** `Pass / Flag / Fail?` — diamond — Reviewer Agents lane
- **Connection (PASS):** → Stage 2 Expert Outreach (solid arrow, labelled *"Pass"*)
- **Connection (FLAG):** → `HUMAN GATE: Journalist Resolves Flag` (hexagon, Journalist lane) → Research Agent revises specific item → back to Fact-Check Agent (feedback loop arrow, labelled *"Revise \& re-verify"*)
- **Connection (FAIL):** → `Quarantine` (rectangle, Reviewer lane, red border) + `Journalist Notified` → Research Agent must address each item specifically → back to Fact-Check Agent

***

### Stage 2 — Expert Outreach

- **Node:** `Expert Discovery Agent — Candidate Search` — rectangle — Executor Agents lane
    - *Credential verification: 2 independent sources required*
    - *Conflict-of-interest check included*
    - *Output:* `Expert Shortlist` (parallelogram) — multiple candidates, not a single recommendation
- **Node:** `HUMAN GATE 2: Journalist Selects Expert Candidate` — hexagon — Journalist lane
    - *Label: "Journalist selects from shortlist — agent does not rank-order without disclosure"*
    - *Note: If conflict flags are unresolved, route to C3 uncertainty path before gate*
- **Node:** `Outreach Draft Agent — Draft Request` — rectangle — Executor Agents lane
    - *Input: Journalist-confirmed candidate selection*
    - *Output:* `Draft Request Text` (parallelogram)
- **Node:** `HUMAN GATE 3: Journalist Reviews & Personalises Outreach` — hexagon — Journalist lane
    - *Label: "60-second minimum review window enforced before send option activates"*
    - *Note: Journalist sends — no agent send path exists*

***

### Stage 2a — Interview \& Note Synthesis

- **Node:** `INTERVIEW` — rectangle, **double border** — Journalist lane
    - *Label: "Human-led conversation. No agent involvement in the interview itself."*
    - *External input arrow from: Expert Source (actor outside system)*
- **Node:** `Interview Note Synthesis Agent — Transcript Structuring` — rectangle — Executor Agents lane
    - *Input: Interview transcript / recording*
    - *Output:* `Structured Interview Notes` (parallelogram)
- **Node:** `Editorial Review Agent — Note Verification` — rectangle — Reviewer Agents lane
    - *Purpose: Checks notes before they enter the research record — prevents journalist interpretation bias entering unverified*
    - *Output:* `Notes Verification Report` (parallelogram)
- **Node:** `HUMAN GATE 4: Journalist Approves Notes for Research Record` — hexagon — Journalist lane
    - *Label: "Notes enter research record only after journalist approval"*

***

### Stage 3 — Structuring

- **Node:** `Editorial Review Agent — Structural Options` — rectangle, **dashed border** — Executor Agents lane
    - *On request only — fires after journalist has proposed an approach first*
    - *Offers multiple options with tradeoffs, not a single recommendation*
    - *Output:* `Structural Options` (parallelogram)
- **Node:** `HUMAN GATE 5: Journalist Selects Structure` — hexagon — Journalist lane
    - *Label: "Journalist proposes approach first; agent responds. Not the reverse."*

***

### Stage 4 — Writing

- **Node:** `WRITING — Journalist Writes First Draft` — rectangle, **double border** — Journalist lane
    - *Label: "All first-draft writing is human-led. Agents do not generate prose."*
- **Node:** `Editorial Review Agent — Ongoing Style Flags` — rectangle — Reviewer Agents lane
    - *Continuous during writing stage*
    - *Output:* `Style Flag Report` (parallelogram)
    - *Note: ERA consumes Style Baseline (from Style Baseline Agent — continuous track) to run voice-consistency check*
- **Node:** `HUMAN GATE 6: Journalist Resolves Style Flags` — hexagon — Journalist lane

***

### Stage 5 — Editing \& Fact-Check

- **Node:** `Fact-Check Agent — Claim Map Verification` — rectangle — Reviewer Agents lane
    - *Input: Article draft + Claim Map*
    - *Output:* `Claim Map Verification Report` (parallelogram)
- **Node:** `Editorial Review Agent — Editorial Flags` — rectangle — Reviewer Agents lane
    - *Input: Article draft*
    - *Output:* `Editorial Flag Report` (parallelogram)
- **Node:** `All Flags Resolved?` — diamond — Reviewer Agents lane
- **Connection (NO):** → `HUMAN GATE: Journalist Resolves Flags` (hexagon, Journalist lane) → return to Fact-Check + ERA (feedback loop)
- **Connection (YES):** → Human Gate 7
- **Node:** `HUMAN GATE 7: Human Editor Review` — hexagon — Journalist lane
    - *Label: "Separate from journalist self-review — journalist cannot self-certify"*


#### Investigative Articles Only — Quorum Branch

- *Draw this as a conditional side-branch off Stage 5, dashed border*
- **Node:** `Fact-Check Agent Instance 1` — rectangle, dashed — Reviewer lane
- **Node:** `Fact-Check Agent Instance 2 (different knowledge base)` — rectangle, dashed — Reviewer lane
- **Node:** `Editorial Review Agent (quorum role)` — rectangle, dashed — Reviewer lane
- **Node:** `2 of 3 Agree?` — diamond
- **Connection (YES, 2/3):** → proceed to Stage 6
- **Connection (NO, 3-way disagreement):** → Route to Journalist + Editor jointly (hexagon, Journalist lane)

***

### Stage 6 — Submission Preparation

- **Node:** `Submission Prep Agent — Package & Hash Verification` — rectangle — Executor Agents lane
    - *Input: Article draft + Claim Map*
    - *Runs cryptographic hash check: article hash must match Claim Map hash*
    - *Output:* `Submission Package` (parallelogram)
- **Node:** `Hash Match?` — diamond — Executor Agents lane
- **Connection (NO):** → `Submission Blocked` (rectangle, red border) + `Journalist Notified` → return to editing stage (arrow back to Stage 5)
- **Connection (YES):** → Human Gate 8
- **Node:** `HUMAN GATE 8: Journalist Reviews Submission Package` — hexagon — Journalist lane
- **Node:** `HUMAN GATE 9: Journalist Explicit Submission Trigger` — hexagon — Journalist lane
    - *Label: "Irreversible action. No auto-submit. No agent can trigger this."*
    - *Note: Give this gate a visual treatment distinct from other gates — bolder border, colour fill — to signal irreversibility*
- **Connection:** → `Submission to Editor` (rounded rectangle, Journalist lane)

***

### END

- **Node:** `END` — filled circle — Journalist lane
    - *Note: Editor feedback loop connects back into Pattern Analytics Agent (continuous track)*

***

## Parallel / Continuous Track

Draw this as a horizontal band separated from the main workflow by a thick dashed line. Label the band: **"Always Active — All Articles"**

These five agents run continuously throughout the entire article lifecycle, not at specific stages.


| Node | Type | Inputs | Outputs to |
| :-- | :-- | :-- | :-- |
| `Workflow Orchestrator Agent` | Rectangle — Infrastructure lane | All stage completion signals | All agents (sequencing); Journalist (SLA breach \& escalation notifications) |
| `Pattern Analytics Agent` | Rectangle — Continuous lane | Journalist action log; editorial flag history; editor feedback | Monthly digest → Journalist; Capability Assessment Agent |
| `Style Baseline Agent` | Rectangle — Continuous lane | Approved published articles store *(not draft articles)* | Style Baseline → Editorial Review Agent |
| `Source Relationship Agent` | Rectangle — Continuous lane | Source history; article history; external credential monitor | Reminders → Journalist (journalist decides all follow-up actions) |
| `Capability Assessment Agent` | Rectangle — Continuous lane | Journalist action log; Pattern Analytics outputs | Quarterly check-in prompts + dependency flags → Journalist + System Steward |

**Connection note:** Draw a light monitoring arrow from the Workflow Orchestrator to each stage gate in the main workflow, labelled *"SLA tracking"*. This arrow is monitoring only — not a control path.

***

## Artifact Summary

These are the named documents flowing through the system. Show them as parallelograms positioned near the agent that produces them.


| Artifact | Produced By | Consumed By |
| :-- | :-- | :-- |
| Source Manifest | Research Agent | Fact-Check Agent; Journalist |
| Adversarial Brief | Adversarial Research Agent | Journalist |
| Expert Shortlist | Expert Discovery Agent | Journalist |
| Draft Request Text | Outreach Draft Agent | Journalist |
| Structured Interview Notes | Interview Note Synthesis Agent | Editorial Review Agent; Research Record |
| Structural Options | Editorial Review Agent | Journalist |
| Style Flag Report | Editorial Review Agent | Journalist |
| Claim Map | Built incrementally; certified by Submission Prep Agent | Fact-Check Agent; Submission Prep Agent; Editor |
| Submission Package | Submission Prep Agent | Journalist |
| Style Baseline | Style Baseline Agent | Editorial Review Agent |
| Monthly Patterns Digest | Pattern Analytics Agent | Journalist |
| Capability Report | Capability Assessment Agent | Journalist; System Steward |


***

## Infrastructure Note

Add a **cylinder** labelled `Audit Log` in the Infrastructure lane. Draw a thin arrow from every agent node and every human gate into this cylinder, labelled *"All actions logged"*. This arrow does not represent workflow sequence — draw it lighter than the main flow arrows (grey, thinner weight) to distinguish it as an infrastructure connection rather than a task dependency.

***

## Visual Hierarchy Recommendations

- **Human gates** (hexagons): use a distinct colour — e.g., amber — to make every human decision point immediately visible
- **Human-only zones** (double border): use a different background fill — e.g., light blue — to signal structural protection
- **Conditional nodes** (dashed border): use grey or muted colouring to signal they are not always active
- **Fail/quarantine nodes**: red border or fill
- **The Submission Trigger** (Gate 9): bold border, distinct colour — it is the only truly irreversible action in the system and should read that way visually
- **Continuous track**: separate the band visually with a background colour distinct from the main workflow (e.g., light grey)
<span style="display:none">[^1][^10][^11][^12][^13][^14][^15][^16][^17][^18][^19][^2][^20][^3][^4][^5][^6][^7][^8][^9]</span>

<div align="center">⁂</div>

[^1]: magazine-article-writer-design-document.md

[^2]: human-framework-principles.md

[^3]: human-framework-design-template.md

[^4]: human-framework-architecture-template.md

[^5]: FuturesEdgeWhitepaper-20260128.md

[^6]: example-mission.md

[^7]: trust-is-the-answer.md

[^8]: trust-as-a-multiplier.md

[^9]: the-corporation.md

[^10]: requiem-for-the-american-dream.md

[^11]: profitable-impact.md

[^12]: post-scarcity-ecnomics.md

[^13]: place-of-sanctuary.md

[^14]: incentive-design-framework.md

[^15]: game-theory.md

[^16]: complex-adaptive-systems.md

[^17]: collective-intelligence.md

[^18]: 07-test-acceptance-template.md

[^19]: 06-infrastructure-integrations-template.md

[^20]: 05-workflow-state-template.md

