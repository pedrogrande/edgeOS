# HUMAN Framework Agentic System Design Template
*Version 2.0 — March 2026*
*Companion to the HUMAN Framework Principles Reference*
*Complete this document before beginning the Architecture Template*

---

## How to Use This Template

1. **Work through clusters in order** — Purpose before Trust before Complementarity before Growth before Quality. Each cluster builds on the last.
2. **Trace every answer to a principle** — if an answer cannot be connected to a named HUMAN principle, question whether it belongs in the design.
3. **Complete Section 6 (Agent Inventory) before submitting** — this document is not complete until every agent the system requires is named and its principle constraints are recorded. The Architecture Template begins where this section ends.
4. **Complete Section 7 (Phasing Register) before submitting** — every deferred decision must be recorded here, not left inline. An inline deferral is an invisible risk.
5. **Attach a Workflow Topology diagram** — a sequential diagram of stages, handoffs, and human gates is a required output of this document. Without it, the Architecture Template cannot begin Section 2.
6. **This document feeds four downstream specs** — Agent Specifications, Data & Schema, Workflow & State Machine, and Infrastructure & Integration all depend on decisions made here.

---

## Cluster 1 — Purpose

### H1 — Human Flourishing Is the Measure

| Question | Your Response |
|---|---|
| What does genuine human flourishing look like for the people this system serves? | |
| How will you measure whether the system is serving human dignity and growth — not just task completion? | |
| What outcomes would indicate the system is causing harm, even if outputs are technically correct? | |
| Who are the humans in scope — by role, not by name? | |
| What does "success" look like for each of them? | |

### H2 — Amplification, Not Dependency

| Question | Your Response |
|---|---|
| Which capabilities do you want humans to grow through using this system? | |
| Which features risk creating reliance rather than growth — and how will you detect this? | |
| How will you know, six months in, whether the human is more capable or more dependent? | |
| What would you deliberately not automate in order to preserve human skill development? | |
| How does the system's design change as the human's capability grows? | |

### H3 — Dignity Is the Constraint

| Question | Your Response |
|---|---|
| What decisions or actions must remain with the human — regardless of efficiency gains? | |
| Where could optimisation or automation diminish the human's sense of agency or worth? | |
| When principles conflict, how is dignity prioritised structurally — not just stated in a policy? | |
| What would a user feel if they observed every action this system takes on their behalf? | |
| Are there any populations for whom this system could cause disproportionate harm? | |

### H4 — Connection Over Isolation

| Question | Your Response |
|---|---|
| How does this system strengthen human-to-human relationships, not replace them? | |
| Which tasks inherently involve human relationships that agents must not absorb? | |
| How will you detect if users are substituting agent interactions for human ones? | |
| What mechanisms actively route humans back to each other rather than to the agent? | |

### H5 — Consent Is Continuous

| Question | Your Response |
|---|---|
| How does the human understand what the system is doing on their behalf at each stage? | |
| Where are the opt-out points — and are they meaningful, not just nominal? | |
| How is ongoing consent maintained beyond the onboarding agreement? | |

---

## Cluster 2 — Trust Architecture

### T1 — Verification Precedes Trust

| Question | Your Response |
|---|---|
| What are the pre-defined criteria that every output must be verified against before being treated as complete? | |
| Who or what performs verification — and are they structurally independent from the executor? | |
| What happens to an output that fails verification? | |
| Are verification criteria defined before the task begins, not after? | |
| Which outputs carry the highest risk if unverified? Are those verified most rigorously? | |

### T2 — Proof Is the Product

| Question | Your Response |
|---|---|
| What structured evidence document will accompany each major output? | |
| How does that document map evidence to criteria — not just assert compliance? | |
| Who can read, audit, and challenge the proof document? | |
| What format does the proof document take, and where is it stored? | |
| How is the proof document linked immutably to the output it certifies? | |

### T3 — Authority Is Structural

| Question | Your Response |
|---|---|
| What capabilities does each agent actually hold — and what is structurally impossible for it to do? | |
| How is authority granted — and by whom? Can it be escalated at runtime? | |
| What prevents an agent from claiming authority it was not granted? | |
| Are authority boundaries enforced by architecture, or only by policy? | |
| How do you audit whether agents operated within their structural authority? | |

### T4 — All Actions Witnessed

| Question | Your Response |
|---|---|
| What logging and audit infrastructure will record every action with attribution and timestamp? | |
| How is privacy protected — through access control, never through selective logging? | |
| Who has access to the audit log — and under what conditions? | |
| How long are logs retained, and are they immutable once written? | |
| What would the audit log reveal about a disputed action or outcome? | |

### T5 — No Self-Judgment

| Question | Your Response |
|---|---|
| For every executor role, who is the structurally separate verifier? | |
| Are there any stages where a single actor currently both executes and verifies? | |
| Does this separation apply to human actors as well as agents? | |
| How is the verifier's independence maintained under time pressure? | |
| What happens when the verifier is unavailable? | |

### T6 — Resilience Through Structure

| Question | Your Response |
|---|---|
| What are the single points of failure in this system — and how are they mitigated? | |
| If any one agent fails, what is the impact on systemic trust? | |
| What failure modes have you explicitly designed for? | |
| How is resilience tested before deployment at scale? | |

### T7 — Distributable Verification

| Question | Your Response |
|---|---|
| Does verification require a central trusted party? | |
| How could quorum-based verification be applied to high-stakes outputs? | |
| What qualifies a verifier to participate in the pool? | |
| How is consensus reached when verifiers disagree? | |

---

## Cluster 3 — Human-Agent Complementarity

### C1 — Deliberate Role Allocation

| Question | Your Response |
|---|---|
| For each workflow stage, which tasks are assigned to agents and which to humans — and why? | |
| Are any human tasks currently being assigned to agents by default? | |

### C2 — Governed Autonomy

| Question | Your Response |
|---|---|
| For every action class, which mode applies — agent-autonomous, agent-recommended, or human-led? | |
| Are these mode assignments made before deployment? | |
| How are out-of-bounds actions detected, recorded, and escalated? | |

### C3 — Uncertainty Surfaces Immediately

| Question | Your Response |
|---|---|
| What conditions should cause any agent to halt work and surface uncertainty? | |
| How does the system route surfaced uncertainty to the appropriate decision-maker? | |
| Is surfacing uncertainty treated as correct behaviour — or as a failure? | |
| What is the expected response time when uncertainty is surfaced? | |

### C4 — Structural Ethics

| Question | Your Response |
|---|---|
| Which ethical constraints are enforced by architecture — structurally impossible to violate? | |
| Which constraints are currently only policy-based — and what is the plan to make them structural? | |
| Under what pressure conditions might declarative ethics fail? | |
| Who is responsible for maintaining and updating structural ethical constraints as the system evolves? | |

---

## Cluster 4 — Growth and Learning

### G1 — Scaffold, Don't Substitute

| Question | Your Response |
|---|---|
| At what point does the system do something for the human that they cannot yet do alone? | |
| How does the system deliberately withdraw support as capability grows? | |
| Are there tasks where scaffolding is never appropriate? | |

### G2 — Learning Is Always Happening

| Question | Your Response |
|---|---|
| What learning opportunities exist in each workflow stage? | |
| How is growth treated as a by-product of doing — not a separate "training" activity? | |

### G3 — Make the Invisible Visible

| Question | Your Response |
|---|---|
| What patterns, assumptions, and blind spots can the system surface? | |
| How are self-awareness outputs delivered in a way that is empowering rather than surveilling? | |
| Who owns the insights generated about the human? | |

### G4 — Contribution Has a Record

| Question | Your Response |
|---|---|
| How are the human's decisions, judgments, and contributions captured and attributed to them? | |
| Is the record portable — can the human export it in full? | |
| How does the record build the human's reputation and trust over time? | |

### G5 — Knowledge Compounds

| Question | Your Response |
|---|---|
| What patterns from past outcomes are being crystallised? | |
| How is knowledge validated before it is encoded as a pattern? | |
| How does the system prevent outdated or incorrect patterns from compounding harm? | |

---

## Cluster 5 — Quality and Performance

### Q1 — Expand, Never Collapse

| Question | Your Response |
|---|---|
| How does each interaction increase the human's options? | |
| Where does the system risk narrowing options — and how is that mitigated? | |
| How do you guard against the system's own biases narrowing the option space? | |

### Q2 — Right-Size the Interaction

| Question | Your Response |
|---|---|
| How is agent output volume calibrated to the human's current capability tier? | |
| What is the minimum output that serves the human at each scaffold tier? | |

### Q3 — Adversarial Perspective by Design

| Question | Your Response |
|---|---|
| For which output types is an adversarial perspective required before the human proceeds? | |
| What is the threshold for triggering adversarial review — and is it defined before deployment? | |
| Who or what provides the adversarial perspective — and are they structurally separate from the executor? | |

### Q4 — Prove It in One Before Many

| Question | Your Response |
|---|---|
| What single-instance pilot will validate this system before scale deployment? | |
| What deliberate failure injections will the pilot include? | |
| What constitutes a pass — and what would halt scale deployment? | |

### Q5 — Measure What Matters

| Question | Your Response |
|---|---|
| What are the system's performance metrics — and are they defined against H1, not just operational throughput? | |
| How often are metrics reviewed — and by whom? | |
| What would a metric result look like that triggers a design review? | |

---

## Section 6 — Agent Inventory

*This section is required before this document is considered complete. The Architecture Template begins where this section ends.*

*Apply the A1 Single-Responsibility test to every agent: if removing one function from an agent would produce a coherent, independently deployable agent, the functions should be separated. If in doubt, separate.*

### 6.1 — Agent Roster

For each agent in the system, complete the following:

| Agent Name | Primary Function | Archetype | Cognitive Orientation | HUMAN Principles That Directly Constrain It | Human Actors It Interacts With |
|---|---|---|---|---|---|
| | | | | | |

### 6.2 — Role Allocation Check

| Check | Status | Notes |
|---|---|---|
| Every workflow function has a named agent responsible for it | | |
| No agent holds two archetypes where one could be independently separated (A1) | | |
| No two adjacent agents in the pipeline share the same orientation (cognitive diversity) | | |
| Every executor has a named, structurally separate verifier (T5) | | |
| No workflow coordination function is implicitly assigned to the journalist or user | | |

### 6.3 — Workflow Topology

*Attach a sequential diagram showing: workflow stages in order, which agent is responsible for each stage, which stages have human gates (approval required before proceeding), and handoff points between agents.*

*Minimum required: a linear flow. Sufficient for Phase 1: a state diagram with hold/fail/pass transitions at each verification gate.*

**[Attach diagram here]**

---

## Section 7 — Phasing Register

*Every decision that is deferred out of Phase 1 must be recorded here. Inline deferrals scattered through the document are not acceptable — this register is the single source of truth for scope boundaries.*

| # | Deferred Decision | Risk If Left Unresolved | Trigger for Phase 1 Promotion | Owner |
|---|---|---|---|---|
| | | | | |

**Guidance on risk classification:**
- **Critical** — failure mode exists in Phase 1 that this decision would have closed; deferral requires a documented mitigation
- **High** — degraded quality or trust in Phase 1 without this; acceptable short-term but must have a resolution date
- **Medium** — Phase 1 operates safely without it; welcome enhancement
- **Low** — optimisation or scale concern; Phase 1 unaffected

---

## Document Sign-Off

Before this document proceeds to the Architecture Template, confirm:

| Gate | Confirmed By | Date |
|---|---|---|
| All 26 principles answered | | |
| Section 6 Agent Inventory complete | | |
| Section 7 Phasing Register complete | | |
| Workflow Topology diagram attached | | |
| No inline deferrals remain in the body | | |
| System steward named and accountable | | |

