<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# From the agentic system design example in this file, answer these questions:

```
# Agentic System Architecture Template


*Companion to the HUMAN Framework Agentic System Design Template*
*Complete the Design Template before beginning this document. Every section here should be traceable to a principle answer in that document.*


## How to Use This Template


1. **Work through sections in order** — each section builds on the last. Agent specifications cannot be completed before the system topology is settled.
2. **Trace every answer back to the design document** — if an architectural decision cannot be connected to a principle, question whether it belongs in the system.
3. **Distinguish structure from policy** — where a question asks how something is enforced, the answer must be architectural (infrastructure, schema, configuration) not a policy statement or prompt instruction.
4. **Leave nothing open** — an unanswered question is a future failure mode. Use the right column to record decisions, open questions, and the name of who is responsible for resolving them.
5. **This document is an input to six downstream specs** — Agent Specifications, Data & Schema, Workflow & State Machine, Infrastructure & Integration, and Test & Acceptance all depend on decisions made here.


***


## Section 1 — System Scope & Boundaries


*Before designing what exists inside the system, define exactly where the system ends.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **1.1 — System Purpose Statement** | In one sentence, what does this system do — and for whom? |  |
|  | What human workflow does this system support — and what parts of that workflow are explicitly outside scope? |  |
|  | What would a correct, complete output from this system look like? |  |
|  | What would a technically correct but purposively failed output look like? |  |
| **1.2 — Human Actors** | Who are all the humans in this system — by role, not by name? |  |
|  | Which humans are users (interact with the system directly)? |  |
|  | Which humans are affected parties (impacted by outputs but not direct users)? |  |
|  | Which humans are reviewers or gatekeepers (receive outputs for approval or publication)? |  |
|  | Which humans are system stewards (responsible for maintaining and evolving the system)? |  |
| **1.3 — System Boundaries** | What is the first action the system takes in a workflow? What triggers it? |  |
|  | What is the last action the system takes? What does it produce? |  |
|  | What external systems, services, or data sources does this system connect to? |  |
|  | What external systems must it never connect to — and how is that enforced structurally? |  |
|  | What happens at the boundary when an external system is unavailable? |  |
| **1.4 — Scope Constraints** | What classes of task are explicitly out of scope for every agent in this system? |  |
|  | What decisions must never be automated — regardless of confidence or efficiency? |  |
|  | Are there regulatory, legal, or ethical constraints that bound the system's scope? |  |
|  | Who has the authority to change the system's scope — and is that change itself auditable? |  |
```

Here are the answers to all Section 1 questions drawn directly from the **Magazine Article Writer** agentic system design example in the file.

***

## 1.1 — System Purpose Statement

- **What does this system do — and for whom?** It supports a journalist through the full magazine article workflow — research, expert outreach, structuring, writing, editing, and submission — amplifying their professional capability without replacing their voice or judgment.[^1]
- **What human workflow does it support — and what's out of scope?** In-scope: research logistics, source aggregation, fact-checking, editorial formatting, and submission prep. Explicitly out of scope: the interview itself, the journalist's editorial relationship with the publication, the final publish/don't-publish decision, and any contact with third parties without journalist approval.[^1]
- **What would a correct, complete output look like?** A submitted article package including a hash-verified Claim Map linking every factual assertion to its source, all verification passes complete, and an explicit journalist-triggered submission.[^1]
- **What would a technically correct but purposively failed output look like?** A system that maximises research volume, structural coherence, and submission throughput but produces articles editors describe as "competent but generic" and sources find impersonal — succeeding on every internal metric while failing the journalist's actual professional goal.[^1]

***

## 1.2 — Human Actors

- **All humans by role:** Journalist (primary user), expert sources and interview subjects (affected third parties), editors and publishers (reviewers/gatekeepers), readers (distal stakeholders).[^1]
- **Users (direct interaction):** The journalist — the sole direct interactor with the system.[^1]
- **Affected parties:** Expert sources and interview subjects (whose relationships and time are at stake); readers (whose trust in journalism depends on authentic, verified work).[^1]
- **Reviewers / gatekeepers:** Editors and publishers, who receive the submission package including the Claim Map and may challenge any entry.[^1]
- **System stewards:** A named system steward (initially the journalist or their editorial organisation) and a system administrator who has full audit log access for incident investigation.[^1]

***

## 1.3 — System Boundaries

- **First action and trigger:** The journalist initiates a task (selecting a task type: research brief, interview prep, draft, fact-check, or submission); the system displays the applicable verification criteria and the Research Agent begins web search and source aggregation.[^1]
- **Last action and output:** The journalist explicitly triggers submission; the system produces a formatted submission package (article + hash-verified Claim Map + metadata) and delivers it to the editor.[^1]
- **External systems connected to:** Web search APIs (Research Agent), the journalist's project workspace (version-controlled storage), and editor-specification formatting references (Submission Prep Agent).[^1]
- **External systems it must never connect to — and how enforced:** The Outreach Draft Agent has **no email API connection** at the infrastructure level; agents cannot access the journalist's personal communications outside the system. These are missing connections, not policy rules.[^1]
- **When an external system is unavailable:** Research can fall back to a manual journalist template with agent-failure notifications; if the Fact-Check Agent is unavailable, verification queues and holds — no content proceeds, and the journalist is notified with an estimated resolution time. No bypass exists.[^1]

***

## 1.4 — Scope Constraints

- **Tasks explicitly out of scope for every agent:**
    - Sending any communication to a third party
    - Accessing or reading the journalist's personal communications
    - Generating prose drafts without an explicit journalist trigger
    - Initiating contact with sources (reminders only, no outreach)
    - Modifying content during verification (verify-only agents can pass, flag, or reject — never edit)[^1]
- **Decisions that must never be automated:**
    - The story idea and the decision to pursue it
    - Who to interview and the conduct of the interview itself
    - The journalist's byline, voice, and stated perspective
    - Any decision affecting a source's reputation or public exposure
    - The final submission trigger[^1]
- **Regulatory, legal, or ethical constraints:** Audit logs are retained for a minimum of five years, aligning with standard journalistic source protection periods. Source contact information is redacted from editor-level log access. No source data is shared with any external party without journalist consent.[^1]
- **Who can change the system's scope — and is that auditable?** The named system steward reviews structural constraints quarterly. No new agent capability is deployed without a documented C4 (Structural Ethics) review. All scope changes require a documented design review — not a runtime request — making scope changes themselves auditable.[^1]

<div align="center">⁂</div>

[^1]: agentic-system-design-responses-author.md

