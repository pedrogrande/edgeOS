# HUMAN Framework — Principles Reference
*Version 2.0 — March 2026*
*Revised to include the Single-Responsibility Agent Principle*

---

## About This Document

The HUMAN Framework provides 26 principles across five clusters for designing agentic systems that serve human flourishing. This document is the canonical principles reference. It is the upstream source for two companion documents: the **Agentic System Design Template** and the **Agentic System Architecture Template**. Every answer in those templates must be traceable to a principle here.

**What changed in Version 2.0:**
A new principle — **A1: Single-Responsibility Agents** — has been added to the framework as a standalone cluster: **Agent Integrity**. This principle was identified through architectural review as a necessary structural complement to T5 (No Self-Judgment). It formalises the design rule that an agent holding two distinct cognitive orientations or two distinct task types is a design signal requiring review, and that agent separation is always preferable to role consolidation when in doubt.

---

## Cluster 1 — Purpose

These principles define why the system exists and for whom.

### H1 — Human Flourishing Is the Measure

Every design decision is evaluated against a single test: does this make the humans in the system more capable, more aware, and more connected than before? Output volume, task completion rate, and efficiency are not measures of success unless they serve this test. Flourishing is defined for each human role in the system — it is not generic.

### H2 — Amplification, Not Dependency

The system is designed to amplify human capability, not to replace it. Any feature that performs a task the human could learn to perform themselves must include a detection mechanism for dependency formation and a plan for capability withdrawal as the human grows. Features that permanently remove a task from the human's scope require explicit justification against H1.

### H3 — Dignity Is the Constraint

When principles conflict, human dignity is the tiebreaker. No efficiency gain, accuracy improvement, or automation benefit overrides the human's sense of agency, authorship, and worth. The test is: *what would a user feel if they observed every action this system takes on their behalf?* Any action that would cause embarrassment, surprise, or a sense of loss of control is redesigned or removed.

### H4 — Connection Over Isolation

The system strengthens human-to-human relationships rather than substituting for them. Agent interactions that could displace a human relationship — with a colleague, source, editor, or mentor — are redesigned to route the human back to that relationship. The system makes humans better prepared for human interactions; it does not replace them.

### H5 — Consent Is Continuous

Humans in the system understand and actively consent to what the system does on their behalf — not once at onboarding, but continuously. The system surfaces its actions visibly, explains its reasoning on request, and provides a meaningful opt-out at every stage. Consent cannot be assumed from prior use.

---

## Cluster 2 — Trust Architecture

These principles define how trust is built, maintained, and verified.

### T1 — Verification Precedes Trust

No output is treated as complete until it has been verified against pre-defined criteria. Verification criteria are defined before the task begins, not after. The criteria are visible to the human at task initiation. The human may add criteria; they may not remove framework-mandated ones.

### T2 — Proof Is the Product

Every major output is accompanied by a structured proof document that maps evidence to criteria — not just asserts compliance. The proof document is a first-class artifact: version-controlled, linked immutably to the output it certifies, and accessible to all authorised parties. Submitting an output without its proof document is architecturally prevented.

### T3 — Authority Is Structural

Agent authority is enforced by architecture, not by policy or prompt instruction. An agent holds only the API connections its role requires. Forbidden capabilities are missing connections, not stated rules. Authority is granted at system configuration time and cannot be escalated at runtime. Any agent that needs a capability it does not hold must surface this as uncertainty and route to a human.

### T4 — All Actions Witnessed

Every action taken by every agent and every human in the system is logged in an immutable, append-only audit log with full attribution and timestamp. Nothing is omitted from the log for privacy — only access is restricted. The log is stored separately from the operational system and cannot be modified by any actor.

### T5 — No Self-Judgment

No agent evaluates, verifies, or certifies its own outputs. Every executor has a structurally separate verifier. This separation applies to human actors as well as agents. The verifier cannot modify what it verifies — it can only pass, flag, or reject with documented reasoning. Verification steps are not skippable under time pressure.

### T6 — Resilience Through Structure

The system is designed to fail safely. Single points of failure are identified and mitigated. Partial operation produces no false confidence: an unavailable verifier results in a hold, never a pass. Failure modes are explicitly designed for before deployment. Resilience is tested through deliberate failure injection before scale.

### T7 — Distributable Verification

Where possible, verification does not require a central trusted party. Quorum-based verification — multiple independent verifiers whose agreement constitutes a pass — is applied to high-stakes outputs. Verifier qualifications are defined before deployment. Disagreements between verifiers surface to a human with structured reasoning from each verifier; the human resolves and their resolution is attributed to them in the audit log.

---

## Cluster 3 — Human-Agent Complementarity

These principles define how humans and agents divide work.

### C1 — Deliberate Role Allocation

For every workflow stage, the assignment of tasks to agents versus humans is made deliberately and documented before deployment. The rationale for each assignment is recorded. No task is assigned to an agent by default — every agent task requires a positive justification. Human tasks are identified by what they uniquely contribute: significance judgment, relational conduct, creative authorship, ethical decision.

### C2 — Governed Autonomy

Every agent action is classified into one of three modes before deployment: agent-autonomous (the agent acts without human approval), agent-recommended (the agent produces output for human selection), or human-led (the human acts; the agent supports only). Mode assignments are made before deployment, reviewed and signed off by the human user, and cannot be changed at runtime without a documented design review. Out-of-bounds actions are detected, logged, and escalated.

### C3 — Uncertainty Surfaces Immediately

Any agent that encounters a condition it cannot resolve within its defined scope must halt and surface the uncertainty to the appropriate human decision-maker. Surfacing uncertainty is treated as correct behaviour, not as a failure. The system cannot proceed on unresolved uncertainty — the task is held, not abandoned. Response time SLAs for resolving surfaced uncertainty are set at task initiation.

### C4 — Structural Ethics

Ethical constraints are enforced by architecture — structurally impossible to violate — not by policy statements or prompt instructions. Constraints that are currently only policy-based are identified, the risk of policy failure under pressure is documented, and a plan and timeline for making them structural is recorded. The system steward reviews structural constraints quarterly against any new agent capabilities added.

---

## Cluster 4 — Growth and Learning

These principles define how the system and its users improve over time.

### G1 — Scaffold, Don't Substitute

Agent support is calibrated to the human's current capability level and deliberately withdrawn as capability grows. Scaffolding tiers are defined at onboarding and progression is triggered by demonstrated capability, not by time elapsed. Tasks where scaffolding is never appropriate — regardless of capability tier — are explicitly identified and structurally protected.

### G2 — Learning Is Always Happening

Learning opportunities are integrated into the standard workflow as optional depth layers — not as a separate training mode. Every workflow stage has at least one identified learning opportunity. The system tracks engagement with learning prompts without requiring it. Growth is a by-product of doing, not a parallel activity.

### G3 — Make the Invisible Visible

The system surfaces patterns, assumptions, and blind spots the human cannot see from within their own workflow. Pattern reports are delivered in a way that is empowering rather than surveilling — observations, not evaluations. The human owns all insights generated about them. Pattern data is stored in their personal workspace, exportable in full, and deleted on request. The organisation has no access without explicit human consent.

### G4 — Contribution Has a Record

Every human decision, judgment, and contribution is captured and attributed to them — distinguished from agent-generated content in the audit log. The record is portable: the human can export it at any time in machine-readable and human-readable formats. The record belongs to the human; it does not belong to the platform or the organisation.

### G5 — Knowledge Compounds

Patterns from past outcomes are crystallised into a validated knowledge library that improves future recommendations. A minimum data threshold is required before a pattern is encoded. The human reviews and approves each new pattern entry. Patterns carry recency weights that decay over time. Patterns contradicted by recent outcomes are flagged immediately and marked for review.

---

## Cluster 5 — Quality and Performance

These principles define what quality looks like in an agentic system.

### Q1 — Expand, Never Collapse

Every interaction increases the human's options rather than converging on a single recommendation. Agents surface multiple perspectives on contested topics, multiple candidates for human selection, and multiple structural options with tradeoffs noted. The system never presents a single "best" answer to a judgment question. A divergence prompt is built into every suggestion that draws from a pattern library, to prevent convergence over time.

### Q2 — Right-Size the Interaction

Agent output is calibrated to what the human needs at this point in their capability development — not to what the system can produce. More output is not better output. The scaffolding tier system (G1) governs this calibration: explanation depth, option volume, and proactive suggestion frequency all reduce as capability grows.

### Q3 — Adversarial Perspective by Design

High-stakes outputs are tested against a structured adversarial perspective before the human proceeds. A dedicated Adversarial Research Agent or counterargument brief is a design requirement for investigative, sensitive, or contested topics — not an optional enhancement. The threshold for triggering adversarial review is defined before deployment, not decided at runtime.

### Q4 — Prove It in One Before Many

No capability is deployed at scale until it has been validated in a single-instance pilot that includes deliberate failure injection. The pilot tests not just correct operation but failure behaviour: does the system hold safely, or does it pass degraded outputs? Pilot results are documented before Phase 1 deployment approval is granted.

### Q5 — Measure What Matters

The system's performance metrics are defined at design time against H1 (human flourishing) — not derived post-hoc from what is easy to measure. Metrics that measure agent throughput without measuring human capability growth are insufficient. The metric set includes at least one direct measure of human capability, one measure of human network growth, and one measure of output quality as assessed by downstream human reviewers.

---

## Cluster 6 — Agent Integrity

This cluster contains one principle, added in Version 2.0 following architectural review.

### A1 — Single-Responsibility Agents

An agent that holds two distinct cognitive orientations (e.g., factual and critical) or two distinct task types (e.g., exploration and execution) is a design signal requiring review. Agent separation is always preferable to role consolidation when in doubt.

**The test:** If removing one function from an agent would produce a coherent, independently deployable agent, the functions should be separated.

**Why this matters:** Blended agents create latent self-judgment risks (violating T5), make tool inventory harder to scope precisely (violating T3), and produce coupling that is invisible until a failure propagates. A single-responsibility agent fails cleanly and is replaced cleanly.

**Application:** At every stage of agent specification, apply the single-responsibility test. If an agent holds two archetypes, ask whether one of those archetypes could be separated without losing capability. If in doubt, separate. The cost of an additional agent is lower than the cost of an undiscovered boundary violation or an undetected self-judgment failure.

**Corollary — cognitive diversity by design:** The separation of agents by orientation is not only a safeguard — it is an asset. A system with agents of genuinely different orientations (factual, critical, divergent, procedural, synthesising) produces better outputs under adversarial or ambiguous conditions than a system where all agents converge toward a single dominant orientation. Agent separation enables cognitive diversity; role consolidation erodes it.

---

## Cross-Principle Dependencies

Some principles cannot be satisfied independently — they depend on prior principles being in place.

| Principle | Depends On |
|---|---|
| T2 (Proof Is the Product) | T1 (criteria must exist before proof can be mapped to them) |
| T5 (No Self-Judgment) | T3 (structural authority must be in place for separation to be enforceable) |
| C2 (Governed Autonomy) | T3 (authority must be structural for mode assignments to be enforceable) |
| G1 (Scaffold, Don't Substitute) | H2 (amplification intent must be established before scaffolding tiers are designed) |
| G3 (Make the Invisible Visible) | G4 (contribution record must exist before patterns can be attributed) |
| A1 (Single-Responsibility Agents) | T5 (self-judgment risk analysis requires agent roles to be clearly separated first) |
| Q3 (Adversarial Perspective by Design) | A1 (requires a structurally separate Adversarial agent, not a mode of an existing agent) |

---

## Master Design Test

Apply this test at every design decision point:

> *Does this decision leave the human more capable, more aware, and more connected than they would be without it — and is that outcome enforced by structure, not just stated in a policy?*

If the answer to either part is no, the decision requires redesign before it proceeds.

