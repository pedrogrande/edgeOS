# CAWDP ↔ Framework Cross-Influence Analysis

This is a two-way analysis. CAWDP is a *process* (how to design agentic systems). The framework is a *governing intent* (what principles those systems must embody). They operate at different layers but share DNA. The question is: where do they reinforce, where do they contradict, and what does each add that the other doesn't have?

---

## Part 1: Where CAWDP Validates and Strengthens Existing Principles

These are principles where CAWDP provides the operational mechanism that the framework declares but doesn't specify how to deliver.

### Cluster 2 — Trust Architecture: Strongly Validated

| Principle | Framework Says | CAWDP Operationalises As |
|---|---|---|
| **T1** Verification Precedes Trust | "Independent party verifies against pre-defined criteria" | CC-1 Verification Independence with 3 explicit levels: System (structural), Agent (semantic), Human (authority). Verification level assigned per subtask based on risk, not assumed uniformly. |
| **T2** Proof Is the Product | "Structured evidence that work meets specification" | Template Architecture — Verification Templates and Decision Templates are typed proof documents with schemas. Proof is not prose. |
| **T3** Authority Is Structural | "Authority derives from what an actor structurally holds" | The 5-class taxonomy gives this operational teeth: an Extractor structurally holds no judgment capability, a Measurer structurally holds no interpretation capability. Authority boundaries are the inverse of failure modes — this is a design pattern, not a declaration. |
| **T5** No Self-Judgment | "Executor and verifier always structurally separate" | CC-1 makes this explicit. CAWDP adds a useful nuance: System CAN verify its own work at Level 1 (structural verification) because System is deterministic. Self-verification is only a problem for probabilistic actors. |
| **T6** Resilience Through Structure | "Trustworthy outputs even when individual actors fail" | FMEA (Phase 3 Step 3.3) systematically identifies every failure mode, its detection probability, impact, and recovery path. System serves as the containment layer — it catches agent failures before they propagate downstream. |

**What CAWDP adds to this cluster:** The framework declares that trust should be structural. CAWDP specifies the *mechanisms* — verification levels, template schemas, FMEA tables, System enforcement points. T1 through T6 go from aspirations to engineering specifications.

### Cluster 3 — Human-Agent Complementarity: Significantly Extended

| Principle | Framework Says | CAWDP Operationalises As |
|---|---|---|
| **C1** Deliberate Role Allocation | "Humans and agents are complementary by design" | The ternary complementarity matrix (H/A/S across 15 dimensions) makes this quantified, not qualitative. The allocation algorithm (System → Human → Agent → Collaborative) gives it a decision rule. The framework only considers Human and Agent — CAWDP adds System as a third actor with distinct capabilities. |
| **C2** Governed Autonomy | Three modes: autonomous, recommended, human-led | Progressive Autonomy (4 levels: shadow → advisory → supervised → autonomous) with quantified advancement criteria. Agents *earn* autonomy through measured performance, they don't start with it. The framework's modes are deployment states; CAWDP's levels are an earning trajectory. |
| **C3** Uncertainty Surfaces Immediately | "Encountering unresolvable condition must surface it" | Epistemic Metadata Contracts (CC-3) make uncertainty not just surfaced but *quantified and propagated*. Every output carries confidence, limitations, assumptions, alternatives set aside, and what would change the conclusion. Uncertainty is a structured data type, not a signal. |
| **C4** Structural Ethics | "Actions that shouldn't happen must be structurally impossible" | CC-4 Information Boundaries enforced by System infrastructure. Template enforcement (agents structurally cannot produce unstructured outputs). Cost budgets (agents structurally cannot exceed budget). Specification aging (system structurally cannot operate on stale specs). Structural ethics applies to more domains than the framework currently addresses. |

**What CAWDP adds to this cluster:** The ternary model is the biggest extension — C1 currently describes a binary world. The complementarity algorithm gives C1 a decision rule. Epistemic Metadata gives C3 a data format. Boundary Stress Testing (Phase 4 Step 4.3) gives C4 a validation method. The principles are sound; CAWDP gives them implementation paths.

### Cluster 5 — Quality and Performance: Operationalised

| Principle | Framework Says | CAWDP Operationalises As |
|---|---|---|
| **Q1** Expand, Never Collapse | "Increases options, perspectives, information" | System Empowerment Index (5 levels) makes this measurable. "Constraining" through "Liberating." Q1's intent and the SEI are the same principle expressed at different layers. |
| **Q3** Cognitive Diversity by Design | "Multiple perspectives before solution selection" | Coalition Formation Review (Phase 4 Step 4.6) checks epistemic complementarity. IDS (Information Diversity Score) measures whether diversity is actually happening at runtime. Declining IDS is a leading indicator of quality degradation. |
| **Q4** Validate Before Scale | "No significant work proceeds until core assumptions validated" | Progressive Autonomy makes this the deployment path. The test plan parallel track makes testing concurrent with design, not sequential. Validation happens at every phase gate, not just at the end. |
| **Q5** Problem Precedes Solution | "Problem clearly defined and validated before ideation" | Phase 1 (Task Intelligence) is explicitly this. Decomposition depth guidance prevents premature commitment. Expert validation (Step 1.3) ensures the problem is real before designing solutions. |
| **Q6** Lifecycle Efficiency | "Measured across full lifecycle, not single stages" | The entire v2 reframing from "design-time process" to "governance framework" operationalises this. Cost budgets track lifecycle cost. Specification aging ensures the system is evaluated over time, not just at deployment. |

---

## Part 2: Where CAWDP Contradicts Existing Principles

These are the critical corrections — principles where CAWDP's evidence from the design process shows the framework's current framing is flawed.

### ⚠️ H2 — Amplification, Not Dependency (MAJOR REVISION NEEDED)

**Current framing:**
> "Every interaction is designed to leave the human more capable, more aware, and more themselves than before. If a feature increases reliance on the system rather than the human's own capacity, it fails this principle."

**The problem:** The second sentence contradicts the first. "Leaves the human more capable" and "increases reliance on the system" are treated as opposites. They're not. Using a system to achieve outcomes you couldn't achieve alone IS being more capable — it's capability through the system, not capability independent of the system.

**CAWDP's evidence:** In the marking pipeline, the human who uses 17 agents to focus 100% of their time on genuine judgment is MORE capable than the human doing everything manually. They are not "reliant" on the system in a diminishing sense — they are amplified by it. The system doesn't withdraw; it enables capabilities that didn't exist before.

**Proposed revision:**

> **H2 — Amplification, Not Dependency**
> Every interaction is designed to expand what the human can achieve. The system is a platform for human creative freedom, not training wheels to be removed. Humans use the system to discover better methods, find new solutions, and address challenges they couldn't tackle alone. The measure is not "can the human do it without the system?" — it is "can the human achieve things WITH the system that were impossible without it?"

### ⚠️ G1 — Scaffold, Don't Substitute (FUNDAMENTAL REVISION NEEDED)

**Current framing:**
> "The AI does what the human cannot yet do alone, and deliberately withdraws as capability grows. The goal is always to make itself less necessary for that task."

**The problem:** This is the most directly contradicted principle. Three flaws:

1. **"Withdraws as capability grows"** — implies the end state is the human doing the task without the system. But humans will NOT get better at doing what agents do (consistency, scale, speed, deterministic processing). The scaffolding should NOT withdraw from mechanical operations — it should expand creative operations.

2. **"Make itself less necessary"** — the system should become MORE necessary for creative freedom, not less necessary for mechanical operations. The direction is wrong.

3. **The "Scaffold" metaphor itself** — scaffolding is temporary by definition. It comes down when the building is complete. But the system is not scaffolding — it's the foundation. The building doesn't stand without it.

**CAWDP's evidence:** The System Empowerment Index direction is Constraining → Informing → Enabling → Amplifying → Liberating. The goal is MORE system empowerment, not LESS system dependency. A human at Level 5 (Liberating) is not "less dependent" — they're achieving outcomes impossible without the system.

**Proposed revision:**

> **G1 — Amplify, Don't Automate**
> The system handles the mechanical so the human can do the creative. It does NOT withdraw as capability grows — it EXPANDS what the human can achieve. The goal is not to make the system less necessary but to make the human more free. The measure of growth is not independence from the system but creative freedom through it. Where the human's capability grows, the system's role shifts from enabling to amplifying to liberating — never to withdrawing.

### ⚠️ T4 — All Actions Witnessed (REFINEMENT NEEDED)

**Current framing:**
> "Every action leaves an immutable, attributed, timestamped record."

**The problem:** "Immutable" is aspirational and often unnecessary. Not every action needs cryptographic proof of immutability. A debugging log doesn't need the same assurance as a financial transaction.

**CAWDP's refinement:** CC-8 (Assured Audit Trail) replaces "immutable" with three assurance levels: Logged (tamperable), Assured (tamper-evident), Verified (tamper-proof). The assurance level must match the trust requirement.

**Proposed refinement:**

> **T4 — All Actions Witnessed**
> Every action leaves a traceable, attributed, timestamped record at an assurance level appropriate to its trust requirement. Not every action needs the same level of proof — the audit trail scales from logged (debugging), through assured (compliance), to verified (legal/financial). Privacy is protected through access control, never through selective logging.

### ⚠️ The Master Test (REFINEMENT NEEDED)

**Current master test:**
> **Human:** "Does this leave the person more capable, more aware, and more connected than before?"

**The problem:** "More capable" is ambiguous in the same way as H2. It can be read as "more capable of doing the task independently" (the training-wheels interpretation) or "more capable of achieving outcomes through the system" (the amplifier interpretation).

**Proposed refinement:**

> **Human:** "Does this leave the person achieving more, discovering more, and connected to more than before — through the system, not despite it?"

The addition of "through the system, not despite it" makes the direction explicit: capability is measured with the system, not without it.

---

## Part 3: New Principles CAWDP Suggests

These are elements that emerged from the CAWDP design process that have no direct counterpart in the framework. They're candidates for new principles or explicit additions to existing ones.

### Candidates for Cluster 2 — Trust Architecture

**Proposed T8 — Specifications Are Living**
Specifications degrade. Task drift, model updates, and changing context erode specification validity. Without explicit aging mechanisms, specifications become silently stale — and stale specs produce stale outputs while appearing current. Every specification has a freshness date and aging triggers. The system structurally cannot operate on a specification that has exceeded its freshness date without review.

*Why:* The framework has G5 (Knowledge Compounds) which addresses learning but not the inverse: specifications decaying. A system with perfect audit trails but stale specifications is trustworthy about the wrong things.

**Proposed T9 — Cost Is a Trust Constraint**
Cost determines whether a system is viable, not just whether it's correct. An agent system that exceeds its cost budget is a system that will be turned off — and an offline system is a failed system regardless of its accuracy. Every agent has a cost budget; every pipeline has a cost ceiling. Cost is a first-class design constraint, not an afterthought.

*Why:* The framework has no mention of cost. But cost is the constraint that determines whether any of the other principles are achievable in practice. A perfectly trustworthy system that's too expensive to run has failed.

### Candidates for Cluster 3 — Human-Agent Complementarity

**Proposed C5 — System Earns Autonomy**
Agent autonomy is not granted — it's earned through verified performance. Agents begin at the most constrained level and advance based on measurable criteria: accuracy thresholds, override rates, and consequence severity. No agent handling irreversible actions operates autonomously. The advancement path is explicit, quantified, and auditable.

*Why:* The framework's C2 (Governed Autonomy) defines the three modes but doesn't specify how an agent moves between them. CAWDP's Progressive Autonomy (shadow → advisory → supervised → autonomous) adds the earning mechanism. Without it, C2 describes states but not trajectories.

**Proposed C6 — Reversibility Determines Autonomy**
The reversibility of an action determines the autonomy mode appropriate for it. Read-only actions can be agent-autonomous. Reversible actions can be agent-recommended. Irreversible actions are human-led — not as a bypassable gate but as a structural requirement. The classification happens before deployment, not at runtime.

*Why:* C2's three modes need an assignment rule. Reversibility classification provides that rule. Without it, the mode boundary is subjective — with it, the boundary is systematic.

**Proposed C7 — Three Actors, Not Two**
The complementarity model includes three actors, not two: Human (ethical judgment, creative discovery, accountability), Agent (semantic reasoning, pattern detection, parallel analysis), and System (deterministic transformation, validation, routing, enforcement). System gets first refusal on subtask allocation because it's the cheapest, most reliable, and has zero hallucination risk. Many subtasks currently assigned to Agents are better handled by System.

*Why:* The framework's C1 only considers Human and Agent. This means it assigns mechanical subtasks (schema validation, format conversion, threshold checking) to Agents — paying for semantic reasoning that isn't needed and introducing hallucination risk where none should exist. System as a third actor removes an entire failure mode category.

### Candidates for Cluster 4 — Growth and Learning

**Proposed G6 — Failure Modes Are Designed, Not Discovered**
Every agent's primary failure mode is identified before deployment, and its authority boundary is the inverse of that failure mode. Extractors hallucinate → boundary: never judge. Measurers interpret noise as signal → boundary: never interpret. Assessors become overconfident → boundary: never finalise. Generators fabricate → boundary: never be vague. Aggregators omit through addition → boundary: never add. The constraint is the inverse of the failure mode.

*Why:* The framework has T6 (Resilience Through Structure) but doesn't specify HOW to systematically identify and constrain failure modes. The "constrain the inverse" pattern is a reusable design principle that generalises beyond any specific agent class.

**Proposed G7 — Health Is Monitored, Not Assumed**
Pipeline health is measured through leading indicators that predict quality degradation before it appears in output accuracy. Information Diversity Score (IDS) detects convergent thinking. Unnecessary Path Ratio (UPR) detects over-specified pipelines. Override rate detects specification aging. Cost variance detects specification drift. Declining health triggers pipeline review, not just agent review.

*Why:* The framework doesn't address runtime pipeline health. G5 (Knowledge Compounds) implies improvement but doesn't address the inverse: pipelines degrading silently. IDS and UPR are leading indicators — they predict problems before they manifest in output quality.

### Candidates for Cluster 5 — Quality and Performance

**Proposed Q7 — Templates Resolve Type Collision**
Every data flow in the system uses typed, structured templates — not prose. Input templates resolve input-side type collision (17+ cognitive modes compressed into one input modality). Output templates resolve output-side type collision (17+ information types compressed into one output type). Templates enforce decomposable, typed artefacts as the fundamental unit of collaboration.

*Why:* The framework has Q1 (Expand, Never Collapse) and Q2 (Progressive Disclosure) but doesn't address the structural mechanism that makes them achievable. Without templates, the system defaults to prose — which collapses all information types into an undifferentiated wall of text. Templates are the engineering solution to a communications problem.

**Proposed Q8 — Test Is a Design Artifact**
Every design decision generates a test. Test plans are created alongside design decisions, not after them. Quality gates include test readiness checks. The person who makes a design decision is best positioned to define what would prove it wrong. Validation happens throughout, not just at the end.

*Why:* The framework has Q4 (Validate Before Scale) but positions validation as a pre-deployment activity. CAWDP's evidence shows that testing needs to run as a parallel track from Phase 1 onward. Test plans designed after the fact test what was built, not what was intended.

**Proposed Q9 — Epistemic Metadata Is Non-Negotiable**
Every agent output carries six fields of epistemic metadata: provenance (who produced this, when, from what), confidence (how certain), limitations (what this doesn't cover), assumptions (what was assumed), alternatives set aside (what other interpretations were considered), and what would change this (what new information would change the output). Without epistemic metadata, downstream actors — human and agent — inherit outputs blindly.

*Why:* The framework has C3 (Uncertainty Surfaces Immediately) but doesn't specify the data format for uncertainty. Epistemic metadata makes uncertainty structured, quantified, and propagable. It's the mechanism that makes C3 operable.

---

## Part 4: What CAWDP Gains from the Framework

CAWDP is a process; the framework is governing intent. CAWDP would be weaker without the framework's principles.

| Framework Element | What It Gives CAWDP |
|---|---|
| **H1** Human Flourishing | CAWDP has the SEI but doesn't name the *why* — flourishing is the human reason; SEI is the measurement. The principle gives CAWDP moral direction. |
| **H3** Dignity Is the Constraint | CAWDP doesn't have a tiebreaker. When fidelity and enrichment conflict, what wins? Dignity. This is the override principle CAWDP lacks. |
| **H4** Connection Over Isolation | CAWDP doesn't address human-to-human relationships. Pipeline monitoring measures cognitive diversity but not social connection. The framework adds a dimension CAWDP misses entirely. |
| **T7** Distributable Verification | CAWDP's verification independence doesn't address quorum-based verification. This is a trust architecture that scales without central authority — important for multi-organisation systems. |
| **G3** Make the Invisible Visible | CAWDP operationalises this through epistemic metadata and IDS, but the principle itself is more expansive — it includes surfacing human patterns, assumptions, and blind spots, not just system metadata. |
| **G4** Contribution Has a Record | CAWDP's audit trail is system-owned. The framework adds: the human OWNS their record — it's portable, not platform-locked. This is a dignity principle masquerading as a record-keeping one. |
| **Q2** Progressive Disclosure | CAWDP's template architecture implies this but doesn't make it explicit. The framework names the UX principle that makes templates usable for humans. |
| **The Master Test** | CAWDP has quality gates with many checkboxes. The framework has two questions. The master test is the elevator-pitch version — the thing you check when you don't have time for the full gate. |

---

## Part 5: Proposed Integration

### The Relationship Between Framework and CAWDP

They operate at different layers, and that's the point:

```
FRAMEWORK (What principles govern)
  ┃  "H2: Amplification, Not Dependency"
  ┃  "T1: Verification Precedes Trust"
  ┃  "C7: Three Actors, Not Two"
  ┃
  ┣━ CAWDP (How to design systems that embody those principles)
  ┃    Phase 2 Step 2.1: Ternary Complementarity Matrix
  ┃    CC-1: Verification Independence (3 levels)
  ┃    Phase 4 Step 4.2: Authority Boundary Specification
  ┃
  ┗━ AGNO (What code implements the design)
       Agent class: Extractor
       response_model: ClaimsOutputTemplate
       allowed_tools: ["web_search"]
```

The framework tells you WHAT must be true. CAWDP tells you HOW to make it true. Agno tells you WHAT CODE to write.

### The Principle-to-Process Traceability

Every CAWDP step should trace to at least one framework principle. Every framework principle should trace to at least one CAWDP step. Gaps in either direction reveal missing elements.

| Principle | CAWDP Steps That Operationalise It | Gap? |
|---|---|---|
| H1 Human Flourishing | SEI (CC-6), Enrichment Checks at every gate | ✅ Covered |
| H2 Amplification, Not Dependency | SEI direction (CC-2), Phase 5 Step 5.4 | ⚠️ Needs H2 revision first |
| H3 Dignity Is the Constraint | Not explicitly in CAWDP | ❌ **Gap — needs gate tiebreaker** |
| H4 Connection Over Isolation | Not in CAWDP | ❌ **Gap — needs Phase 5 addition** |
| T1 Verification Precedes Trust | CC-1 Verification Independence | ✅ Covered |
| T2 Proof Is the Product | Template Architecture (Step 3.4) | ✅ Covered |
| T3 Authority Is Structural | 5-class taxonomy (Step 4.1) | ✅ Covered |
| T4 All Actions Witnessed | CC-8 Assured Audit Trail (3 levels) | ✅ Covered (refined) |
| T5 No Self-Judgment | CC-1 Level specification | ✅ Covered |
| T6 Resilience Through Structure | FMEA (Step 3.3), System containment | ✅ Covered |
| T7 Distributable Verification | Not explicitly in CAWDP | ❌ **Gap — needs CC-1 extension** |
| C1 Deliberate Role Allocation | Ternary matrix (Step 2.1), allocation algorithm | ✅ Covered (extended to ternary) |
| C2 Governed Autonomy | Progressive Autonomy (Step 6.4) | ✅ Covered (with earning mechanism) |
| C3 Uncertainty Surfaces | CC-3 Epistemic Metadata | ✅ Covered |
| C4 Structural Ethics | CC-4 Information Boundaries, template enforcement | ✅ Covered |
| G1 Scaffold, Don't Substitute | CONTRADICTS CAWDP | ❌ **Needs revision** |
| G2 Learning Is Always Happening | Spec aging (CC-5), Phase 6 refinement | ✅ Covered (reframed) |
| G3 Make the Invisible Visible | CC-3, IDS monitoring | ✅ Covered |
| G4 Contribution Has a Record | CC-8 Audit Trail | ⚠️ Covered but missing portability/ownership |
| G5 Knowledge Compounds | Phase 6 refinement, pipeline intelligence | ✅ Covered |
| Q1 Expand, Never Collapse | SEI direction (CC-6) | ✅ Covered |
| Q2 Progressive Disclosure | Implicit in template architecture | ⚠️ Needs explicit Phase 5 step |
| Q3 Cognitive Diversity | Coalition Review (Step 4.6), IDS | ✅ Covered |
| Q4 Validate Before Scale | Test parallel track, Progressive Autonomy | ✅ Covered |
| Q5 Problem Precedes Solution | Phase 1 Task Intelligence | ✅ Covered |
| Q6 Lifecycle Efficiency | Cost budgets (CC-7), governance framework | ✅ Covered |

### The Gaps Summary

**Framework gaps that need CAWDP additions:**

| Gap | Framework Principle | Proposed CAWDP Addition |
|---|---|---|
| No dignity tiebreaker | H3 | Add to every quality gate: "When fidelity and enrichment conflict, which wins? Document the tiebreaker." |
| No human-to-human connection | H4 | Add to Phase 5: "Does the system strengthen or weaken human-to-human relationships?" |
| No quorum verification | T7 | Extend CC-1: Level 2+ can include multi-agent quorum verification |
| No record portability | G4 | Add to CC-8: "Is the human's contribution record portable and platform-independent?" |
| No progressive disclosure step | Q2 | Add to Phase 5: "How is complexity delivered in layers at the moment of relevance?" |

**CAWDP gaps that need Framework additions:**

| Gap | Proposed Principle | Cluster |
|---|---|---|
| No System as third actor | C7 Three Actors, Not Two | Cluster 3 |
| No specification aging | T8 Specifications Are Living | Cluster 2 |
| No cost constraint | T9 Cost Is a Trust Constraint | Cluster 2 |
| No autonomy earning | C5 System Earns Autonomy | Cluster 3 |
| No reversibility rule | C6 Reversibility Determines Autonomy | Cluster 3 |
| No failure mode pattern | G6 Failure Modes Are Designed | Cluster 4 |
| No pipeline health monitoring | G7 Health Is Monitored | Cluster 4 |
| No template mechanism | Q7 Templates Resolve Type Collision | Cluster 5 |
| No test-as-design-artifact | Q8 Test Is a Design Artifact | Cluster 5 |
| No epistemic metadata | Q9 Epistemic Metadata Is Non-Negotiable | Cluster 5 |

**Framework principles needing revision:**

| Principle | Revision Needed | Severity |
|---|---|---|
| **H2** Amplification, Not Dependency | Remove "reliance is failure"; replace with "creative freedom expansion" | 🔴 Major |
| **G1** Scaffold, Don't Substitute | Replace "withdraws" with "amplifies"; replace "less necessary" with "more empowering" | 🔴 Major |
| **T4** All Actions Witnessed | Replace "immutable" with assurance-level-appropriate | 🟡 Moderate |
| **Master Test** | Add "through the system, not despite it" to human question | 🟡 Moderate |

---

## The Unified Principle Set (Proposed)

Integrating all revisions and additions, the framework would move from 26 to 35 principles across five clusters:

### Cluster 1 — Purpose (4 → 4, with 1 revision)
- H1 Human Flourishing Is the Measure ✓
- H2 Amplification, Not Dependency *(revised)*
- H3 Dignity Is the Constraint ✓
- H4 Connection Over Isolation ✓

### Cluster 2 — Trust Architecture (7 → 9, with 1 revision, 2 new)
- T1 Verification Precedes Trust ✓
- T2 Proof Is the Product ✓
- T3 Authority Is Structural ✓
- T4 All Actions Witnessed *(refined — 3 assurance levels)*
- T5 No Self-Judgment ✓
- T6 Resilience Through Structure ✓
- T7 Distributable Verification ✓
- **T8 Specifications Are Living** *(new)*
- **T9 Cost Is a Trust Constraint** *(new)*

### Cluster 3 — Complementarity (4 → 7, with 3 new)
- C1 Deliberate Role Allocation *(extended to ternary)*
- C2 Governed Autonomy ✓
- C3 Uncertainty Surfaces Immediately ✓
- C4 Structural Ethics ✓
- **C5 System Earns Autonomy** *(new)*
- **C6 Reversibility Determines Autonomy** *(new)*
- **C7 Three Actors, Not Two** *(new)*

### Cluster 4 — Growth and Learning (5 → 7, with 1 revision, 2 new)
- **G1 Amplify, Don't Automate** *(revised from "Scaffold, Don't Substitute")*
- G2 Learning Is Always Happening ✓
- G3 Make the Invisible Visible ✓
- G4 Contribution Has a Record *(extended with portability)*
- G5 Knowledge Compounds ✓
- **G6 Failure Modes Are Designed, Not Discovered** *(new)*
- **G7 Health Is Monitored, Not Assumed** *(new)*

### Cluster 5 — Quality and Performance (6 → 8, with 3 new)
- Q1 Expand, Never Collapse ✓
- Q2 Progressive Disclosure ✓
- Q3 Cognitive Diversity by Design ✓
- Q4 Validate Before Scale ✓
- Q5 Problem Precedes Solution ✓
- Q6 Lifecycle Efficiency ✓
- **Q7 Templates Resolve Type Collision** *(new)*
- **Q8 Test Is a Design Artifact** *(new)*
- **Q9 Epistemic Metadata Is Non-Negotiable** *(new)*

### Updated Master Test

> **System:** *"Can this be verified, attributed, and audited — with epistemic metadata and at appropriate assurance levels?"*
> **Human:** *"Does this leave the person achieving more, discovering more, and connected to more than before — through the system, not despite it?"*

---

The framework and CAWDP are complementary layers. The framework answers "what must be true?" CAWDP answers "how do you make it true?" The 9 new principles are what CAWDP's design evidence reveals must be true — but that the framework hasn't yet declared. The 2 revisions are where CAWDP's evidence shows the framework's current declaration is pointed in the wrong direction.The deepest insight from this analysis: **the two contradictions (H2 and G1) share a single root error.** Both assume the system's ultimate purpose is to make itself unnecessary. CAWDP's evidence shows the opposite — the system's purpose is to make itself *more necessary* for the things only humans can do: create, discover, judge, find new paths. The System Empowerment Index direction is toward Liberating, not toward "less dependent."

The 9 new principles are the ones that CAWDP needed but the framework didn't declare. They cluster around three themes the framework is missing:

1. **System as actor** (C7, C5, C6) — the ternary model and its governance implications
2. **Structural mechanisms** (Q7, Q8, Q9, T8) — templates, testing, metadata, and specification aging as the engineering that makes principles operable
3. **Operational awareness** (T9, G6, G7) — cost, failure modes, and pipeline health as things you design for, not discover at runtime

Together, the framework and CAWDP form a three-layer stack: *what must be true* → *how to make it true* → *what code to write*. Neither is complete without the others.