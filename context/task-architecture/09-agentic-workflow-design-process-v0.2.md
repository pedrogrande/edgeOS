# Complementarity-Driven Agentic Workflow Design Process (CAWDP) v0.2

*A governance framework for designing human-agent-system collaboration — from task analysis through runtime evolution.*

---

## Core Premise

Before any design decision, three commitments must be explicit:

1. **The fundamental unit of collaboration is the artefact, not the conversation.** Outputs should be tangible, persistent, manipulable objects — not transient chat exchanges. Templates enforce this structurally.

2. **The highest-value role of agents is judgment preparation, not answer generation.** Agents prepare structured decision inputs for human judgment. Humans make the judgment. The system enforces the boundary.

3. **The system exists to expand human creative freedom, not to make humans independent of it.** Enrichment means humans discover better methods and achieve outcomes impossible alone — not that they learn to do what agents do.

These three commitments shape every phase, every quality gate, and every cross-cutting concern.

---

## Process Overview

```
┌──────────────────────────────────────────────────────────────────────────┐
│                    6 PHASES + 5 QUALITY GATES                             │
│                     + 8 CROSS-CUTTING CONCERNS                            │
│                     + PARALLEL TEST TRACK                                 │
│                                                                           │
│  PHASE 1              PHASE 2              PHASE 2.5                     │
│  TASK INTELLIGENCE    CAPABILITY ALLOCATION  EVENT STORMING              │
│       │                    │                     │                        │
│  [GATE 1]            [GATE 2]                                         │
│                                                                           │
│  PHASE 3              PHASE 4              PHASE 5              PHASE 6   │
│  SYSTEM ARCHITECTURE  AGENT DESIGN         HUMAN EXPERIENCE  VALIDATION  │
│       │                    │                    │                  │        │
│  [GATE 3]            [GATE 4]          [GATE 5]        (continuous)     │
└──────────────────────────────────────────────────────────────────────────┘

TEST TRACK (parallel):
  Test Plan 1  →  Test Plan 2  →  Test Plan 2.5  →  Test Plan 3  →  Test Plan 4  →  Test Plan 5  →  Test Plan 6
```

**Scaling heuristic — not every phase is needed for every task:**

| Task Complexity | Phases Required | Typical Examples |
|---|---|---|
| **Single-agent, no human loop** | 1 → 2 → 4 | Data extraction, summarisation, translation |
| **Single-agent + human review** | 1 → 2 → 4 → 5 | Draft generation with human sign-off |
| **Multi-agent, linear pipeline** | 1 → 2 → 3 → 4 → 5 | Sequential processing with handoffs |
| **Multi-agent, branching + human decisions** | 1 → 2 → 2.5 → 3 → 4 → 5 → 6 | Complex workflows with failure recovery |

**Three-actor model:** Every subtask is allocated to one of three actors — Human, Agent, or System — based on complementarity. System (deterministic code) gets first refusal because it's cheapest, most reliable, and has zero hallucination risk.

---

## The Ternary Allocation Model

CAWDP v2 operates with **three actors**, not two:

| Actor | Characteristic Operations | Hallucination Risk | Cost | Speed |
|---|---|---|---|---|
| **Human** | Ethical judgment, values alignment, creative discovery, accountability | N/A | High | Low |
| **Agent** | Semantic reasoning, pattern detection, generative synthesis, parallel analysis | Moderate-High | Moderate | Moderate |
| **System** | Deterministic transformation, validation, routing, calculation, enforcement | Zero | Near-zero | High |

**The System actor serves a dual role:** it handles mechanical operations efficiently AND it enforces boundaries, templates, verification, and audit — the trust infrastructure that makes Human-Agent collaboration governable.

**Six ternary interaction patterns:**

| Pattern | Description | Example |
|---|---|---|
| **System → Agent** | System pre-processes; Agent reasons | Schema validation → Claims analysis |
| **Agent → System** | Agent decides; System executes | Agent flags anomaly → System routes to human queue |
| **System → Human** | System presents; Human judges | System computes statistics → Human interprets patterns |
| **Agent → Human** | Agent prepares; Human judges | Agent recommends score → Human finalises |
| **System → Agent → Human** | Full pipeline | System validates → Agent analyses → Human decides |
| **Human → System** | Human triggers; System executes | Human overrides grade → System recalculates aggregate |

**Allocation priority order:** System → Human → Agent → Collaborative. System gets first refusal — if a subtask can be expressed as a deterministic rule, it should be.

---

## The 5-Class Agent Taxonomy

Every Agent actor falls into one of five classes. Each class carries its authority boundary and failure mode:

| Class | Authority Boundary | Primary Failure Mode | Hallucination Risk | Key Constraint |
|---|---|---|---|---|
| **Extractor** | Never judge | Hallucination | High | Only extract, never interpret |
| **Measurer** | Never interpret | Noise-as-signal | Low | Present data, not meaning |
| **Assessor** | Never finalise | Overconfidence | Medium | Recommend, never decide |
| **Generator** | Never be vague | Fabrication | High | Every claim must cite evidence |
| **Aggregator** | Never add | Omission | Low | Consolidate only, no new analysis |

**The design pattern:** The authority boundary is the inverse of the failure mode. When you encounter a new agent, first ask "what class is it?" — the boundary and failure mode follow immediately.

System components have no class. They have no authority boundary because they have no judgment. They have no failure mode because they are deterministic — they either execute correctly or fail explicitly.

---

## Cross-Cutting Concerns

These eight concerns apply to **every phase**. They are not phase-specific steps — they are questions asked at every quality gate.

### CC-1: Verification Independence

**Principle:** No agent approves its own work. The separation of executor and verifier is architecture, not policy.

**Three-level independence scale:**

| Level | Verifier | When Appropriate | Example |
|---|---|---|---|
| **Level 1: Structural** | System (deterministic code) | Output schema validation, format checking | System validates that every claim has a source field |
| **Level 2: Semantic** | Different Agent | Reasoning verification, alternative perspective | Second agent reviews Claims Analyst's extraction accuracy |
| **Level 3: Authority** | Human | Final judgment, ethical decision, accountability | Human finalises the score the Assessor recommended |

**Quality gate question:** *For each agent in this phase's scope, is the verifier structurally separate from the producer? At what independence level?*

### CC-2: Human Enrichment Assessment

**Principle:** The system has two axes of excellence — output fidelity AND creative freedom expansion. Every phase must answer both the fidelity question and the enrichment question.

**The System Empowerment Index** (replaces Scaffolding Dependency Index):

| Level | What the Human Experiences | Description |
|---|---|---|
| **Constraining** | Human is a rubber stamp on system recommendations | System determines what the human sees and does |
| **Informing** | Human has information but limited room to explore | System provides data; human decides within system's framing |
| **Enabling** | Human freed from routine to do creative work | System handles mechanical work; human focuses on judgment |
| **Amplifying** | Human discovers methods they wouldn't find alone | System surfaces options the human hadn't considered |
| **Liberating** | Human achieves outcomes impossible without the system | System creates entirely new possibility spaces |

**The enrichment question is NOT "can the human do it alone?" It IS "does the system expand what the human can achieve?"** Humans should not aspire to do what systems do. They should use systems to do what only humans can — create, discover, judge, find new paths.

**Quality gate question:** *Does this phase's design expand or contract what the human can achieve? Where does it land on the System Empowerment Index?*

### CC-3: Epistemic Metadata Contracts

**Principle:** Every output carries not just its content but its epistemic metadata — provenance, confidence, limitations, assumptions, alternatives, and what would change the conclusion.

**Six required fields on every agent output:**

| Field | Purpose | Example |
|---|---|---|
| **Provenance** | Who produced this, when, from what inputs | Claims Analyst, Wave 3, Submission Package v2 |
| **Confidence** | How certain is the producer (1-10) | 7 — claim is explicit but evidence is indirect |
| **Limitations** | What this output does NOT cover | Did not assess cross-claim consistency |
| **Assumptions** | What the producer assumed | Assumes standard academic citation conventions |
| **Alternatives set aside** | What other interpretations were considered | Alternative: claim is rhetorical, not substantive |
| **What would change this** | What new information would change the output | Direct contradiction from another source would reduce confidence to 3 |

**Enforcement:** Templates (CC-related) enforce this structurally. System validates that every agent output includes all six fields.

**Quality gate question:** *Does every output template include all six epistemic metadata fields?*

### CC-4: Information Boundaries

**Principle:** What an actor cannot read should be structurally impossible, not merely discouraged. Information boundaries are enforced by System infrastructure, not by agent prompts.

**Architecture:** System mediates all data access. Actors never read directly from data stores. The boundary is a context curtain — an actor can only see what is explicitly passed to it through the orchestration layer.

**Specification in CAWDP:**
- Phase 2: Identify what each actor needs to know AND what they must NOT know
- Phase 3: Architecture specifies information boundaries as System-enforced
- Phase 4: Job descriptions specify information boundary as structural constraint

**Quality gate question:** *For each actor, is every information boundary enforced by System infrastructure, not by prompt instruction?*

### CC-5: Specification Aging

**Principle:** Agent specifications degrade over time. Task drift, model updates, and changing context erode specification validity. Without explicit aging mechanisms, specifications become silently stale.

**Three components:**
- **Aging triggers:** Model change, task context change, performance degradation, override rate increase
- **Review cadence:** Time-based (quarterly for stable, monthly for new) AND trigger-based (on any aging trigger)
- **Capability drift tracking:** Does the agent's actual performance match its specification? When they diverge, the specification needs updating

**Quality gate question:** *For each agent in this phase, are specification freshness dates and aging triggers documented?*

### CC-6: System Empowerment Index

**Principle:** How much creative freedom does the system give the human? This replaces the concept of "how much scaffolding does the human need." The direction is upward through the 5-level scale (Constraining → Informing → Enabling → Amplifying → Liberating), not toward "less dependency."

**Quality gate question:** *Where does this phase's design land on the System Empowerment Index? Is it moving upward through use?*

### CC-7: Cost Budget

**Principle:** Cost is a first-class design constraint, not an afterthought.

**Three cost levels:**
- **Per-agent cost budget:** Maximum acceptable cost per invocation (token cost + tool cost + infrastructure cost)
- **Pipeline cost budget:** Maximum acceptable cost per unit processed (e.g., per student, per document)
- **Total cost budget:** Maximum acceptable cost per time period (e.g., per marking cycle)

**Cost-quality trade-off:** Is the marginal cost of adding an agent justified by the marginal quality improvement? If not, consider System alternatives.

**Quality gate question:** *Are cost budgets specified per agent and per pipeline unit? Is the total cost within the acceptable range?*

### CC-8: Assured Audit Trail

**Principle:** Every action creates a traceable, attributed, timestamped record. But "immutable" is aspirational — three assurance levels match different trust requirements.

| Assurance Level | Storage | Tamper Resistance | When Appropriate |
|---|---|---|---|
| **Level 1: Logged** | Application log | Tamperable by admin | Debugging, internal review |
| **Level 2: Assured** | Append-only store | Tamper-evident | Compliance, quality assurance |
| **Level 3: Verified** | Cryptographically signed | Tamper-proof | Legal, financial, regulatory |

**Quality gate question:** *For each action type, is the audit assurance level specified? Is it appropriate for the trust requirement?*

---

## Enrichment-Fidelity Question Pairs

Every phase asks two questions — one for output fidelity, one for creative freedom expansion:

| Phase | Fidelity Question | Enrichment Question |
|---|---|---|
| **1** | Is the task decomposed correctly? | Does the decomposition preserve space for human creative judgment? |
| **2** | Are allocations correct? | Do allocations free the human from mechanical work TO BE creative? |
| **2.5** | Are events and data flows complete? | Are human decision points visible and empowered? |
| **3** | Does the architecture work? | Does the architecture give the human room to discover new methods? |
| **4** | Are agents specified correctly? | Do agents handle the routine so the human can do the novel? |
| **5** | Is the interface usable? | Does the interface give the human creative freedom, not just approval workflows? |
| **6** | Does the system work? | Is the human finding solutions they wouldn't find alone? |

---

## PHASE 1: Task Intelligence

*Understand the task before designing anything.*

### Step 1.1: Task Decomposition

**What:** Break the task into phases, subtasks, and dependency chains. Identify the *cognitive operations* required — not just "what needs to happen" but *what kind of thinking* each step demands.

**How:**
1. List all deliverables the task must produce
2. Backcast from each deliverable: what must be true for this to exist?
3. Decompose each prerequisite into subtasks
4. Classify each subtask's cognitive operation type:

| Cognitive Operation | Description | Best Actor | Example |
|---|---|---|---|
| **Mechanical** | Deterministic transformation, validation, routing | **System** | Schema validation, format conversion, threshold checking |
| **Structural** | Mapping form/organisation | Agent or System | Depends on whether interpretation is needed |
| **Domain-semantic** | Interpreting domain-specific meaning | Agent | Identifying blockchain claims in text |
| **Comparative-semantic** | Comparing across instances | Agent | Detecting synthesis patterns across submissions |
| **Structural-semantic** | Auditing structural-intent alignment | Agent | Is the reflection section actually reflective? |
| **Statistical** | Numerical pattern detection | System (simple) or Agent (complex) | Depends on complexity |
| **Generative** | Producing novel text/structure | Agent | Drafting constructive feedback |
| **Evaluative** | Making quality judgments | Human or Agent (recommendation) | Scoring against rubric criteria |
| **Synthesis** | Consolidating multiple sources | Agent or Human | Depends on nature of consolidation |

**The critical distinction:** Mechanical operations are *provably correct* (System). Agent operations are *probably correct* (Agent). Human operations are *accountably correct* (Human). When a subtask can be mechanical, it SHOULD be mechanical — it removes an entire failure mode category.

**Decomposition depth guidance:**

```
STOP decomposing when:
  ✓ 1-2 cognitive operations per subtask
  ✓ Single clear authority boundary
  ✓ Single verification check can validate the output
  ✓ Output consumed by ≥1 other actor

CONSIDER further decomposition when:
  ⚠ >2 cognitive operations bundled
  ⚠ Authority boundary is ambiguous
  ⚠ Verification requires multiple independent checks
  ⚠ Different failure modes within one subtask

ALWAYS decompose when:
  ✗ >3 cognitive operations bundled
  ✗ Agent would need to switch cognitive modes mid-task
  ✗ Different operations have different hallucination risk levels
```

**Artifact:** `Task Decomposition Map` — each subtask annotated with cognitive operation type, best actor candidate, dependencies, and estimated cognitive load.

### Step 1.2: Cognitive Load Analysis

**What:** For each subtask, estimate the working memory demands, number of distinct cognitive operations, and switching cost.

**How:**
1. For each subtask, ask: *How many distinct cognitive operations are bundled here?*
2. If >2, flag for potential further decomposition
3. Estimate working memory demand: how many things must be held simultaneously?
4. Estimate switching cost: how much context must be loaded/unloaded?

**Artifact:** `Cognitive Load Assessment` — per-subtask: operation count, working memory demand, switching cost, granularity verdict (under-decomposed / right-sized / over-decomposed).

### Step 1.3: Expert Validation

**What:** Validate the decomposition with domain experts before proceeding.

**How:**
1. Present decomposition to 1-3 domain experts
2. Ask: "Do you recognise these subtasks? Would you decompose differently?"
3. Capture any subtasks they identify that you missed
4. Confirm the cognitive operation labels match expert mental models

**Effort heuristic:** 30-60 minute conversation per expert. Skip only if you ARE the domain expert AND can articulate your expertise explicitly.

**Artifact:** `Expert Validation Record` — expert feedback, decomposition changes made.

### Step 1.4: Edge Case Inventory

**What:** Identify boundary conditions and anomalous inputs before designing the system.

**How:**
1. For each input type, list: empty, corrupted, ambiguous, adversarial, oversized, undersized variants
2. For each subtask, ask: "What input would break this?"
3. Categorise: *must-handle* (common enough to design for) vs. *must-detect* (flag for human) vs. *out-of-scope*

**Artifact:** `Edge Case Catalog` — per input type: edge cases, expected handling, categorisation.

### Phase 1 Test Plan

*Every design decision generates a test. Phase 1 tests validate decomposition.*

| Test ID | Test Name | Source Decision | Expected Result |
|---|---|---|---|
| 1.1.1 | Cognitive operation classification | Each subtask's operation type | Example tasks classify unambiguously into types |
| 1.2.1 | Granularity check | Decomposition depth guidance | Each subtask has 1-2 operations, single boundary |
| 1.3.1 | Expert recognition | Expert validation | Experts recognise ≥90% of subtasks |
| 1.4.1 | Edge case coverage | Edge case catalog | ≥3 edge cases per input type identified |

---

### 🔴 QUALITY GATE 1: Task Intelligence Complete

**Fidelity Checks:**
- [ ] Every subtask has a cognitive operation classification (including Mechanical for System candidates)
- [ ] No subtask bundles >3 cognitive operations (or explicitly justified)
- [ ] Cognitive load assessment completed for all subtasks
- [ ] Domain expert validation obtained (or expertise self-attestation documented)
- [ ] Edge case catalog has ≥3 cases per input type
- [ ] All deliverables trace back through dependency chains

**Enrichment Checks:**
- [ ] Decomposition preserves space for human creative judgment
- [ ] Mechanical subtasks correctly identified (freeing humans for judgment work)
- [ ] No subtask that should be human-creative is classified as mechanical

**Cross-Cutting Checks:**
- [ ] CC-1: Verification independence considered — can any subtask be self-verified?
- [ ] CC-5: Specification aging triggers identified for task context changes
- [ ] CC-7: Initial cost budget estimate per deliverable

**Test Readiness Checks:**
- [ ] Phase 1 test plan defined with targets
- [ ] Expert validation test results available
- [ ] Edge case tests defined with expected handling

---

## PHASE 2: Capability Allocation

*Determine what System does, what Agent does, what Human does, and why.*

### Step 2.1: Complementarity Analysis

**What:** Map each subtask against capability dimensions to determine System/Agent/Human allocation.

**How:**
1. Score each subtask on 15 capability dimensions (1-9 scale) for Human, Agent, AND System:

| Dimension | Human | Agent | System |
|---|---|---|---|
| Reasoning depth | Abstract, novel | Pattern, defined-rule | None (0) |
| Ethical judgment | Moral reasoning | Rule-based ethics | Explicit constraints only |
| Values alignment | Organisational culture | Explicit norms | None (0) |
| Decision authority | Accountability | Recommendation generation | None (0) |
| Domain expertise | Tacit, intuitive | Explicit knowledge | Encoded rules only |
| Parallelisation | Sequential limit | Massive parallel | Infinite parallel |
| Output consistency | Variable, fatigue-prone | Deterministic given input | Perfectly deterministic |
| Speed | Minutes-hours/unit | Seconds/unit | Milliseconds/unit |
| Novelty handling | Adaptive, creative | Training distribution | None (0) |
| Context sensitivity | Reads room | Follows instructions | None (0) |
| Precision | Human error rate | Computational accuracy | Perfect accuracy |
| Scalability | Linear time | Near-constant time | Constant time |
| Explainability | Can articulate | Can cite, show chains | Trivially auditable |
| Cultural sensitivity | Lived experience | Training data patterns | None (0) |
| Error type | Omission, fatigue | Hallucination, overconfidence | Bugs, logic errors |

2. Calculate H-A, H-S, and A-S gaps for each dimension
3. Apply the **Ternary Complementarity Allocation Algorithm:**

```
For each subtask:
  // SYSTEM FIRST — eliminate hallucination risk where possible
  IF cognitive operation = Mechanical:
    → SYSTEM-LED
  
  // HUMAN GATE — protect authority domains
  IF any dimension in {Ethical Judgment, Values Alignment, Decision Authority}
     has H-A gap ≥ 6 AND H-S gap ≥ 6:
    → HUMAN-LED
  
  // AGENT ADVANTAGE — semantic reasoning at scale
  IF any dimension in {Parallelisation, Output Consistency, Scalability}
     has A-S gap ≥ 5 AND A-H gap ≥ 5:
    → AGENT-LED
  
  // SYSTEM FOR CONSISTENCY — determinism over semantics
  IF consistency requirement = 9 AND semantic need < 3:
    → SYSTEM-LED
  
  // COLLABORATIVE — genuine hybrid
  → DEFAULT TO COLLABORATIVE
     (specify which actors collaborate and in what ratio)
```

4. **Model-specific scoring:** Scores must be grounded to specific LLM models and specific human profiles. Document the model reference (e.g., GPT-4, Claude 3.5, local model) and human profile (e.g., subject-matter expert, trained operator, novice) for each score.

5. **Reversibility classification:** For each subtask, classify the action type:
   - **Read-only:** No side effects — safe to automate
   - **Reversible:** Can be undone — automate with logging
   - **Irreversible:** Cannot be undone — human presence required structurally

**Artifact:** `Complementarity Matrix` — per subtask: 15 H/A/S scores, gap scores, allocation decision, model reference, human profile, reversibility class, rationale.

### Step 2.2: Actor Analysis

**What:** Identify all human actors, not just "the human."

**How:**
1. List every human role that interacts with the system
2. For each role, specify: expertise level, decision authority, time availability, cognitive load tolerance
3. Map which subtasks each human role owns
4. Identify inter-human coordination needs (e.g., multiple markers needing calibration)

**Artifact:** `Actor Map` — roles, capabilities, constraints, inter-actor coordination requirements.

### Phase 2 Test Plan

| Test ID | Test Name | Source Decision | Expected Result |
|---|---|---|---|
| 2.1.1 | Mechanical classification | System-first allocation | Mechanical subtasks correctly identified and assigned to System |
| 2.1.2 | Complementarity gap accuracy | H/A/S scoring | For subtasks with large gaps, assigned actor performs measurably better |
| 2.1.3 | Reversibility classification | Action reversibility | Irreversible subtasks have human gates |
| 2.2.1 | Actor coverage | Actor map | All human roles identified, no orphan subtasks |

---

### 🔴 QUALITY GATE 2: Capability Allocation Complete

**Fidelity Checks:**
- [ ] Every subtask has H/A/S scores with model reference and human profile
- [ ] Allocation decisions trace to specific gap scores (System-first priority)
- [ ] Mechanical subtasks correctly identified and allocated to System
- [ ] Actor map includes all human roles (not just "the human")
- [ ] Reversibility classes assigned for all subtasks

**Enrichment Checks:**
- [ ] Human-allocated subtasks are genuine judgment/creative work, not mechanical
- [ ] System-allocated subtasks genuinely free the human for creative work
- [ ] No subtask that should expand human creative freedom is allocated away from human

**Cross-Cutting Checks:**
- [ ] CC-1: Verification independence — can any allocated subtask verify itself?
- [ ] CC-4: Information boundaries — initial identification of what each actor must NOT know
- [ ] CC-7: Cost budget — estimated cost per allocation (System cheapest, Agent moderate, Human expensive)
- [ ] CC-8: Audit assurance levels — initial assignment per subtask type

**Test Readiness Checks:**
- [ ] Phase 2 test plan defined with targets
- [ ] Complementarity gap test targets set
- [ ] System feasibility tests defined for all mechanical subtasks

---

## PHASE 2.5: Event Storming

*Conditional — only for multi-agent workflows with dependencies, data handoffs, and/or human decision points.*

### When to Use Event Storming

| Condition | Do Event Storming? |
|---|---|
| Single agent, no human loop | ❌ Skip |
| Linear pipeline, no branching, no failure recovery | ⚠️ Optional |
| Multi-agent with human decisions | ✅ Recommended |
| Multi-agent with branching/failure recovery | ✅ Essential |
| Multiple human actors | ✅ Essential |

### Step 2.5.1: Domain Event Mapping

**What:** Map every event that occurs in the system on a timeline.

**How:**
1. Write each domain event on a card (past tense): `SubmissionReceived`, `FormatValidated`, `AnomalyFlagged`, `ScoreRecommended`, `HumanOverrideIssued`
2. Arrange chronologically
3. For each event, identify:
   - **Command:** What triggers it? (who or what)
   - **Actor:** Who/what executes it? (Human / Agent / System)
   - **Data produced:** What structured output does it generate?
   - **Policy:** What happens next? (what events does it trigger?)

### Step 2.5.2: Failure Event Surfacing

**What:** Systematically identify events that shouldn't happen but will.

**How:** For each happy-path event, ask:
1. *What if this produces wrong output?* → `AgentOutputDoubted`
2. *What if this times out?* → `ActorTimeoutExpired`
3. *What if this receives unexpected input?* → `UnexpectedInputReceived`
4. *What if the human disagrees?* → `HumanOverrideIssued`
5. *What if the human is absent?* → `HumanDecisionDeferred`
6. *What if System validation fails?* → `SystemValidationFailed`

### Step 2.5.3: Data Flow Validation

**What:** For each event, verify that its input data exists and is accessible.

**How:**
1. For each event, ask: "What data does this event's actor need?"
2. Trace backwards: which prior events produce that data?
3. Flag any data that is *implied but not explicitly produced*
4. Verify data format compatibility (template schemas match)

### Step 2.5.4: Trigger Condition Specification

**What:** Define the exact conditions that trigger each event, including System-enforced conditions.

**How:**
1. For each event, write the trigger condition as a boolean expression
2. For each trigger, define the timeout: what happens if the condition is never met?
3. For each trigger, define the fallback: what happens if the triggering event fails?
4. Identify which triggers are System-enforced (deterministic) vs. Agent-triggered (probabilistic) vs. Human-triggered (discretionary)

**Artifact:** `Event Storm Map` — timeline of events, commands, actors (H/A/S), data flows, failure events, trigger conditions, timeouts, fallbacks, System-enforced triggers.

### Phase 2.5 Test Plan

| Test ID | Test Name | Source Decision | Expected Result |
|---|---|---|---|
| 2.5.1 | Event completeness | Event mapping | Walking through a realistic scenario, every event fires |
| 2.5.2 | Trigger condition accuracy | Trigger specification | Each trigger fires correctly on test inputs |
| 2.5.3 | Fallback functionality | Fallback specification | Each fallback works when primary path fails |
| 2.5.4 | Data flow integrity | Data flow validation | Every consumer's input is explicitly produced |

---

### 🔴 QUALITY GATE 2.5: Event Storming Complete (if applicable)

**Fidelity Checks:**
- [ ] Event storm map covers happy path + failure events
- [ ] Every event has an actor type (H/A/S)
- [ ] Data flow validated for every event — no implied-but-not-produced data
- [ ] Trigger conditions specified with timeouts and fallbacks
- [ ] System-enforced triggers identified

**Enrichment Checks:**
- [ ] Human decision points are visible, empowered, and not rubber stamps
- [ ] Failure events give humans room for creative judgment, not just binary choices

**Cross-Cutting Checks:**
- [ ] CC-1: Verification events identified for each agent output
- [ ] CC-4: Information boundaries mapped — what data each actor can/cannot access
- [ ] CC-8: Audit events identified with assurance levels

**Test Readiness Checks:**
- [ ] Phase 2.5 test plan defined with targets

---

## PHASE 3: System Architecture

*Design the structure that everything lives in.*

### Step 3.1: Pipeline Architecture (Backcasting)

**What:** Design the data flow from final deliverables backwards.

**How:**
1. List final deliverables
2. For each, trace the dependency chain back through phases
3. Define the **data objects** that flow between stages:
   - Schema (what fields — reference Template Architecture from Step 3.4)
   - Producer (which actor creates it — H/A/S)
   - Consumer (which actor reads it — H/A/S)
   - Mutability (append-only, replaceable, immutable)
   - Persistence (ephemeral, session, permanent)

4. Identify execution topology:
   - **Sequential:** Phase N completes before Phase N+1 starts
   - **Parallel:** Multiple actors run simultaneously within a phase
   - **Event-driven:** Actors activate on trigger conditions
   - **Gated:** Phase transition requires System-enforced quality check

### Step 3.2: Orchestration Design

**What:** Design the system that manages actor execution, not just the actors themselves.

**How:**
1. Specify execution engine: what triggers Wave 1? What waits for Wave 1 completion?
2. Define **orchestration policies:**
   - **Timeout policy:** How long before an actor is assumed failed?
   - **Retry policy:** How many retries? With what backoff?
   - **Partial completion policy:** Can the pipeline continue if one actor fails?
   - **Cascading failure policy:** What happens when a critical-path actor fails?
   - **System enforcement points:** Where does System enforce gates, schemas, and boundaries?
3. Define **progress tracking:** How is pipeline state represented? How does the human know where things stand?
4. Define **fallback model tiers:**

| Tier | Model | When Used | Expected Quality |
|---|---|---|---|
| **Tier 1** | Primary model | Normal operation | Full |
| **Tier 2** | Secondary model | Primary unavailable | Near-full |
| **Tier 3** | Local model | API unavailable | Reduced |
| **Tier 4** | System fallback | No model available | Rules only |

Each agent should have a fallback specification: what does it produce at each tier? Does it still meet minimum quality? Does it flag the reduced confidence in its epistemic metadata?

### Step 3.3: Failure Mode & Effects Analysis (FMEA)

**What:** For every actor and every pipeline transition, analyse what happens when things go wrong.

**How:**
1. For each agent, list its **primary failure mode** (from the 5-class taxonomy)
2. For each failure mode, assess:

| Field | Content |
|---|---|
| Agent/Component name | |
| Primary failure mode | (e.g., hallucination for Extractors) |
| Detection method | (How will we know it failed?) |
| Detection probability | (High / Medium / Low) |
| Impact if undetected | (What goes wrong downstream?) |
| Recovery path | (Rerun? Skip? Flag? Human escalation?) |
| Containment boundary | (What stops the failure from propagating?) |
| System enforcement | (What System component catches this?) |

3. For System components, list their failure modes:
   - Bug in validation logic → System flags incorrectly
   - Schema mismatch → System rejects valid data
   - Infrastructure failure → System unavailable
4. For each pipeline transition, list:
   - **Upstream failure:** What if the input is wrong?
   - **Transition failure:** What if the handoff fails?
   - **Downstream assumption:** What does the next actor assume about this input?

### Step 3.4: Template Architecture Design

**What:** For every data flow identified in the pipeline architecture, design the template that structures it. Templates are the structural mechanism that resolves type collision — both input and output side.

**Seven template types:**

| Template Type | Purpose | Enforced By | Example |
|---|---|---|---|
| **Input Template** | Standardises what an actor receives | System (pre-processing) | Structured submission package with typed fields |
| **Output Template** | Enforces typed, decomposable outputs | System (post-validation) | Claims analysis: claim, source, confidence, domain tags |
| **Handoff Template** | Structures data packages between actors | System (routing) | Enhanced Submission Package: format + claims + anomalies |
| **Verification Template** | Codifies verification criteria per agent class | System (gate enforcement) | Format verification: file type ✓, slide count ✓, sections ✓ |
| **Decision Template** | Structures human decision inputs | System (presentation) | Score recommendation: criterion, evidence, confidence, alternatives |
| **Feedback Template** | Structures agent-to-human feedback | Agent (generation) | Student feedback: strength, improvement area, suggestion, rubric alignment |
| **Escalation Template** | Standardises escalation protocols | System (routing) | Escalation: agent, issue, evidence, urgency, recommended action |

**How:**
1. For each data object in the architecture, ask: *What types of information does this object carry?*
2. Decompose each type into a typed field (not prose)
3. For each field, specify: type, constraints (required/optional, range, format), provenance
4. For each template, specify: validation rules (System-enforced), consumers, mutability
5. **Include epistemic metadata:** Every output template includes the six fields from CC-3 (provenance, confidence, limitations, assumptions, alternatives set aside, what would change this)
6. **Stress-test:** Can this template carry the information the consumer needs? Is any information NOT in the template?

**The key insight:** Templates resolve bidirectional type collision. Input templates resolve input-side type collision (17+ cognitive modes compressed into one input modality). Output templates resolve output-side type collision (17+ information types compressed into one output type). The template is the decomposable artefact — not the prose.

### Step 3.5: Composition Decision

**What:** For each pipeline segment, decide whether it should be an Agent, a Team, or a Workflow.

| Primitive | When to Use | Signal |
|---|---|---|
| **Agent** | Single cognitive operation, single authority boundary | One "never" constraint suffices |
| **Team** | Multiple operations need coordination, shared context | Multiple authority boundaries but shared data |
| **Workflow** | Sequential/parallel stages with data handoffs | Different stages have different actor types |

**Artifact:** `System Architecture Document` — pipeline diagram, data objects with template references, orchestration policies, FMEA table, composition decisions, System enforcement points, fallback model tier specifications.

### Phase 3 Test Plan

| Test ID | Test Name | Source Decision | Expected Result |
|---|---|---|---|
| 3.1.1 | Data flow completeness | Pipeline architecture | Every consumer's input is explicitly produced |
| 3.2.1 | Orchestration trigger tests | Orchestration design | Each trigger fires correctly on test inputs |
| 3.2.2 | Timeout handling | Orchestration policies | Pipeline handles timeouts gracefully |
| 3.2.3 | Fallback tier behavior | Fallback model tiers | Each tier produces output with appropriate quality/confidence |
| 3.3.1 | FMEA recovery tests | FMEA table | Each recovery path works as specified |
| 3.4.1 | Template schema validation | Template architecture | System validates every template against its schema |
| 3.4.2 | Template completeness | Template architecture | Every template carries all information the consumer needs |
| 3.5.1 | Composition appropriateness | Composition decisions | Each segment's composition type matches its complexity |

---

### 🔴 QUALITY GATE 3: Architecture Complete

**Fidelity Checks:**
- [ ] Every data object has schema, producer (H/A/S), consumer (H/A/S), mutability, persistence
- [ ] No data flow is implied — every consumer's input is explicitly produced
- [ ] Orchestration policies cover timeout, retry, partial completion, cascading failure
- [ ] System enforcement points identified for all gates and boundaries
- [ ] FMEA completed for every actor (H/A/S) and every pipeline transition
- [ ] Recovery paths specified for every failure mode, with System containment
- [ ] Edge cases from Phase 1 mapped to handling in architecture
- [ ] Fallback model tiers specified for all agents
- [ ] Template architecture covers all data flows with typed schemas
- [ ] Composition decisions made for all pipeline segments

**Enrichment Checks:**
- [ ] Architecture gives human room to discover new methods, not just approve system outputs
- [ ] Human decision points are genuine judgment opportunities, not rubber stamps

**Cross-Cutting Checks:**
- [ ] CC-1: Verification chain specified for each pipeline segment (System→System, System→Agent, Agent→Human)
- [ ] CC-3: All output templates include epistemic metadata fields
- [ ] CC-4: Information boundaries mapped as System-enforced context curtains
- [ ] CC-7: Cost budget estimated per pipeline unit
- [ ] CC-8: Audit assurance levels specified per action type

**Test Readiness Checks:**
- [ ] Phase 3 test plan defined with targets
- [ ] Template schema validation tests defined
- [ ] Orchestration trigger tests defined
- [ ] FMEA recovery path tests defined

---

## PHASE 4: Agent Design

*Design each agent with the specificity needed for implementation.*

### Step 4.1: Agent Classification

**What:** Assign each agent to a class. The boundary principle and failure mode follow immediately.

| Class | Authority Boundary | Primary Failure Mode | Hallucination Risk | Key Constraint |
|---|---|---|---|---|
| **Extractor** | Never judge | Hallucination | High | Only extract, never interpret |
| **Measurer** | Never interpret | Noise-as-signal | Low | Present data, not meaning |
| **Assessor** | Never finalise | Overconfidence | Medium | Recommend, never decide |
| **Generator** | Never be vague | Fabrication | High | Every claim must cite evidence |
| **Aggregator** | Never add | Omission | Low | Consolidate only, no new analysis |

System components have no class — they have no authority boundary because they have no judgment.

### Step 4.2: Authority Boundary Specification

**What:** Define what each agent must NOT do. The constraint is the inverse of the failure mode.

**Design pattern:**
```
IF agent class = Extractor:
  boundary = "Never judge" (because failure mode = hallucination of interpretations)
IF agent class = Measurer:
  boundary = "Never interpret" (because failure mode = noise-as-signal)
IF agent class = Assessor:
  boundary = "Never finalise" (because failure mode = overconfidence)
IF agent class = Generator:
  boundary = "Never be vague" (because failure mode = fabrication/vagueness)
IF agent class = Aggregator:
  boundary = "Never add" (because failure mode = omission through addition)
```

### Step 4.3: Boundary Stress Testing

**What:** Before finalising the boundary, test it with inputs designed to push the agent toward its failure mode.

**How:** For each agent, design 3-5 **boundary stress inputs:**
- *What input would tempt this Measurer to interpret?* → e.g., a statistical outlier that "obviously" means something
- *What input would tempt this Generator to be vague?* → e.g., a submission so weak that constructive feedback feels impossible
- *What input would tempt this Assessor to finalise?* → e.g., a near-perfect submission where scoring feels obvious

Document the expected boundary-enforced response vs. the tempted response. This becomes a test case for implementation.

### Step 4.4: Agent Job Description

**What:** Create a complete specification that enables a developer to implement the agent without further design decisions.

```
AGENT JOB DESCRIPTION
=====================

IDENTITY
  Name:
  Class: (Extractor / Measurer / Assessor / Generator / Aggregator)
  Authority Boundary: (the "never" constraint)
  Primary Failure Mode: (the inverse of the boundary)

MISSION
  One-sentence statement of what this agent produces, for whom, and why.

INPUT TEMPLATE
  - Reference to Step 3.4 input template
  - Required fields (what data, from which actor, in what format)
  - Optional fields (what data improves quality if available)
  - Edge case handling (from Phase 1 edge case catalog)

OUTPUT TEMPLATE
  - Reference to Step 3.4 output template
  - Structured output format (typed, not prose)
  - Epistemic metadata: provenance, confidence, limitations,
    assumptions, alternatives set aside, what would change this
  - Required fields
  - Optional fields

CONTEXT & KNOWLEDGE
  - Domain knowledge required
  - Reference materials (specific documents, URLs, data)
  - System prompt context

TOOLS
  - Required tools (web search, calculator, etc.)
  - Optional tools

INFORMATION BOUNDARY
  - What this agent CAN read (explicit list)
  - What this agent CANNOT read (enforced by System context curtain)
  - How the boundary is enforced (infrastructure, not prompt)

HARD CONSTRAINTS
  - Authority boundary (from Step 4.2)
  - Additional constraints specific to this agent
  - Prohibited actions

QUALITY CRITERIA
  - What does "good output" look like for this agent?
  - Measurable quality indicators
  - Failure indicators (signals that the agent is failing)

VERIFICATION
  - Who verifies this agent's output? (Level 1/2/3 from CC-1)
  - What does verification check?
  - How is verification independence enforced?

ERROR HANDLING
  - What to do on missing input → (flag? skip? error?)
  - What to do on ambiguous input → (request clarification? flag? proceed with confidence score?)
  - What to do on tool failure → (retry? fallback? flag?)
  - Fallback model tier behavior (from Step 3.2)

ESCALATION PROTOCOL
  - When to escalate to human
  - When to escalate to orchestrator
  - What information to include in escalation

PERFORMANCE EXPECTATIONS
  - Expected latency
  - Expected accuracy (if estimable)
  - Cost budget per invocation

PROGRESSIVE AUTONOMY
  - Initial autonomy level (shadow / advisory / supervised / autonomous)
  - Advancement criteria (accuracy thresholds, override rates)
  - Maximum autonomy level for this agent type

SPECIFICATION AGING
  - Specification freshness date
  - Aging triggers (model change, performance degradation, override rate increase)
  - Review cadence (time-based AND trigger-based)

ADVERSARIAL EXAMPLES
  - 2-3 inputs designed to push toward failure mode
  - Expected boundary-enforced response for each
  - Common temptation and correct refusal

INTERACTION MAP
  - Upstream: which actors (H/A/S) provide input
  - Downstream: which actors (H/A/S) consume output
  - Parallel: which agents run alongside this one
  - System enforcement points: what System components gate this agent's I/O
```

### Step 4.5: Cost-Benefit Assessment

**What:** Determine whether each agent justifies its complexity — or whether a System component could do the job.

**How:** For each agent, assess:
1. **Value added:** What would be lost if this agent were removed? Would a System component (deterministic code) suffice?
2. **Complexity cost:** How complex is this agent to implement, maintain, and debug?
3. **Failure risk:** What's the probability and impact of this agent's failure mode?
4. **Cost per invocation:** Token cost + tool cost + infrastructure cost
5. **System alternative:** Could a deterministic rule handle this? At what quality level?

**Verdict:**
- **Essential:** Unique cognitive work that can't be achieved by System
- **Valuable:** Justified complexity — saves human time or improves quality beyond System
- **Questionable:** Could be replaced by a System component with acceptable quality
- **Unnecessary:** Adds no value beyond what System already provides

### Step 4.6: Coalition Formation Review

**What:** Check that agents within the same wave are composed for epistemic complementarity, not just functional role coverage.

**How:**
1. For each execution wave, list the agents' cognitive orientations
2. Check: Are multiple agents in the same wave approaching the problem from the same orientation?
3. If yes: Are they providing genuinely different perspectives, or converging on the same answer?
4. If converging: Consider replacing one with an agent of different orientation

**Example:** Two critical-oriented agents will produce convergent outputs. A critical agent + an optimistic agent produces a richer option space.

### Phase 4 Test Plan

| Test ID | Test Name | Source Decision | Expected Result |
|---|---|---|---|
| 4.1.1 | Classification correctness | Agent taxonomy | Each agent's class matches its cognitive operation |
| 4.2.1 | Boundary adherence | Authority boundary | Agent respects "never" constraint on stress inputs |
| 4.3.1 | Stress input tests | Boundary stress testing | Each stress input produces boundary-enforced response |
| 4.4.1 | Template compliance | Output template | Agent output validates against output template schema |
| 4.4.2 | Epistemic metadata | Output template | All six metadata fields present and accurate |
| 4.4.3 | Information boundary | Boundary enforcement | Agent cannot access forbidden data through any mechanism |
| 4.5.1 | Cost-benefit justification | Cost assessment | Each agent classified as Essential or Valuable |
| 4.6.1 | Coalition diversity | Cognitive orientation | Each wave has epistemic diversity |

---

### 🔴 QUALITY GATE 4: Agent Design Complete

**Fidelity Checks:**
- [ ] Every agent classified in 5-class taxonomy (or identified as System component)
- [ ] Authority boundary specified as inverse of failure mode
- [ ] Boundary stress tests designed (3-5 per agent)
- [ ] Job descriptions complete for all agents (using template)
- [ ] Adversarial examples included in each job description
- [ ] Input and output templates referenced in all job descriptions
- [ ] Information boundaries specified as System-enforced, not prompt-only
- [ ] Verification independence specified for each agent (Level 1/2/3)
- [ ] Progressive autonomy level and advancement criteria specified
- [ ] Specification freshness date and aging triggers documented
- [ ] Fallback behavior specified for each model tier
- [ ] Cost-benefit assessment completed — no "Unnecessary" agents remain
- [ ] Coalition formation reviewed for epistemic diversity

**Enrichment Checks:**
- [ ] Every agent's output scaffolds human understanding, not replaces judgment
- [ ] Agents handle routine work so humans can do novel work
- [ ] System Empowerment Index assessed for each human-agent interaction point

**Cross-Cutting Checks:**
- [ ] CC-1: Every agent has a separate verifier (independence level specified)
- [ ] CC-3: Every output template includes all six epistemic metadata fields
- [ ] CC-4: Information boundaries enforced by System, not prompts
- [ ] CC-5: Specification aging triggers and review cadence documented
- [ ] CC-6: System Empowerment Index level assessed per interaction
- [ ] CC-7: Cost budget specified per agent and per pipeline unit
- [ ] CC-8: Audit assurance level specified per agent action type

**Test Readiness Checks:**
- [ ] Phase 4 test plan defined with targets
- [ ] Boundary adherence tests defined with adversarial examples
- [ ] Failure mode tests defined for each agent class
- [ ] Epistemic metadata accuracy tests defined
- [ ] Template schema validation tests referenced from Step 3.4
- [ ] Cost budget tests defined

---

## PHASE 5: Human Experience Design

*The human in the system is not a bucket that agents pour outputs into.*

### Step 5.1: Cognitive Load Budget

**What:** Determine how much information the human can process at each interaction point.

**How:**
1. For each human-only subtask, estimate:
   - **Information volume:** How many agent outputs must the human consume?
   - **Decision density:** How many decisions must the human make?
   - **Time pressure:** How quickly must each decision be made?
   - **Consequence severity:** How bad is a wrong decision?
2. If cognitive load exceeds budget at any point:
   - Add a **cognitive offloader** (meta-agent that pre-synthesises)
   - Reduce information volume (filter, summarise, prioritise)
   - Reduce decision density (batch similar decisions, present one at a time)
   - Reduce time pressure (async review instead of real-time)

### Step 5.2: Human Interface Specification

**What:** Design how the human receives, navigates, and acts on agent outputs.

**How:**
1. For each human interaction point, specify:
   - **What the human sees** (layout, information hierarchy, priority ordering)
   - **What the human does** (approve/reject, score, edit, override)
   - **What the human needs** (context, prior agent outputs, epistemic metadata, comparison data)
   - **What the human doesn't need** (filter out information that's not decision-relevant)
   - **What epistemic metadata is visible** (confidence scores, limitations, assumptions)
2. Design the **navigation flow:** How does the human move between interaction points?
3. Design the **interruption model:** Can the human pause and resume? What state is preserved?

### Step 5.3: Override & Feedback Mechanisms

**What:** Design how the human corrects the system and how corrections feed back.

**How:**
1. For each human decision, define:
   - **Override mechanism:** How does the human change an actor's output?
   - **Feedback path:** Does the override inform the actor for future runs? (System-enforced)
   - **Audit trail:** Is the override logged with rationale? At what assurance level?
2. Distinguish between:
   - **Decision overrides** (human changes a specific output)
   - **Parameter adjustments** (human changes system configuration)
   - **Process interventions** (human changes the pipeline itself)

3. Design **creative freedom mechanisms:**
   - How does the human explore alternatives the system didn't surface?
   - How does the human's creative insight feed back into the system?
   - Where are the "blank canvas" moments where the human is free to create?

### Step 5.4: System Empowerment Assessment

**What:** Assess where each human interaction point lands on the System Empowerment Index.

**How:**
1. For each interaction point, score: Constraining (1) → Informing (2) → Enabling (3) → Amplifying (4) → Liberating (5)
2. Identify any Constraining or Informing interactions
3. Redesign to move interactions upward:
   - **Constraining → Enabling:** Give the human genuine choice, not just approve/reject
   - **Informing → Amplifying:** Surface options the human wouldn't have seen
   - **Enabling → Liberating:** Create possibility spaces the human couldn't access alone

**The test is NOT "can the human do this alone?" It IS "did the human discover a better method they wouldn't have found without the system?"**

**Artifact:** `Human Experience Specification` — cognitive load budget, interface specification, navigation flow, override mechanisms, System Empowerment Index assessment, creative freedom mechanisms.

### Phase 5 Test Plan

| Test ID | Test Name | Source Decision | Expected Result |
|---|---|---|---|
| 5.1.1 | Cognitive load budget | Load analysis | Human completes decision point within budget |
| 5.2.1 | Interface usability | Interface specification | Human can navigate and act without confusion |
| 5.3.1 | Override mechanism | Override design | Human can successfully override any actor output |
| 5.3.2 | Feedback path | Override design | Overrides are logged and feed back to system |
| 5.4.1 | Creative freedom | Empowerment assessment | Human discovers ≥1 new approach per 10 sessions |
| 5.4.2 | Empowerment level | Empowerment assessment | No interaction point scored below Enabling (3) |

---

### 🔴 QUALITY GATE 5: Human Experience Complete

**Fidelity Checks:**
- [ ] Cognitive load budgeted for every human interaction point
- [ ] No interaction point exceeds cognitive load budget without a mitigation
- [ ] Interface specification covers what human sees, does, needs, doesn't need
- [ ] Navigation flow between interaction points specified
- [ ] Override mechanisms specified for every human decision point
- [ ] Audit trail specified for all overrides

**Enrichment Checks:**
- [ ] Every interaction point scored on System Empowerment Index
- [ ] No interaction point below Enabling (3) without justification
- [ ] Creative freedom mechanisms designed — human can explore beyond system suggestions
- [ ] Epistemic metadata (confidence, limitations) visible to human at decision points
- [ ] System Empowerment Index moves upward through use, not toward "less dependency"

**Cross-Cutting Checks:**
- [ ] CC-2: System Empowerment Index assessed per interaction
- [ ] CC-6: Overall system assessed for creative freedom expansion
- [ ] CC-8: Override audit trails at appropriate assurance level

**Test Readiness Checks:**
- [ ] Phase 5 test plan defined with targets
- [ ] Cognitive load tests defined with time targets
- [ ] Creative freedom tests defined with discovery targets
- [ ] Override mechanism tests defined

---

## PHASE 6: Validation & Iteration

*Design without validation is speculation. Testing happens throughout, not just here.*

### Step 6.1: Prototype Priority Matrix

**What:** Determine which actors to build first.

**How:** Rank agents by **risk × value:**

| Risk Level | Value Level | Priority |
|---|---|---|
| High failure probability | High value if correct | 🔴 **Prototype first** |
| High failure probability | Low value | 🟡 Minimal investment prototype |
| Low failure probability | High value | 🟢 Confirm expectations |
| Low failure probability | Low value | ⚪ Defer |

System components are prototyped first when they're on the critical path — they're cheapest and most testable.

### Step 6.2: Minimum Viable Agent Testing

**What:** Build and test the minimum implementation of each priority agent.

**How:**
1. Implement agent with job description specification
2. Test against:
   - **Accuracy:** Does it produce correct outputs on known-good inputs?
   - **Boundary adherence:** Does it respect its authority boundary on stress inputs?
   - **Failure mode activation:** What inputs trigger its characteristic failure mode?
   - **Edge case handling:** How does it handle the edge cases from Phase 1?
   - **Template compliance:** Does its output validate against the output template schema?
   - **Epistemic metadata accuracy:** Do confidence scores correlate with actual accuracy?
   - **Information boundary enforcement:** Can it access forbidden data through any mechanism?
   - **Cost compliance:** Does it stay within cost budget on representative inputs?
   - **Fallback behavior:** How does it perform at each fallback model tier?

3. Record actual performance vs. estimated complementarity scores
4. Update complementarity matrix with empirical data

### Step 6.3: Pipeline Integration Testing

**What:** Test actors together, not just individually.

**How:**
1. Run the pipeline end-to-end on a small sample (3-5 instances)
2. Verify:
   - **Data flow:** Does every actor receive the data it needs, in the correct template?
   - **Template validation:** Does System enforce all template schemas at gate points?
   - **Orchestration:** Do execution waves trigger correctly? Timeouts handled?
   - **Human experience:** Does cognitive load match the budget?
   - **System enforcement:** Are information boundaries actually enforced?
   - **Failure recovery:** What happens when an actor produces wrong output?
   - **Fallback behavior:** What happens at each fallback model tier?
   - **Creative freedom:** Does the human find solutions they wouldn't find alone?

3. Measure:
   - Human time per unit vs. fully manual
   - Accuracy vs. manual baseline
   - Human satisfaction (subjective)
   - Creative freedom (did human discover new methods?)
   - Total pipeline cost vs. budget
   - System Empowerment Index at each interaction point

### Step 6.4: Progressive Autonomy Deployment

**What:** Deploy agents with progressive trust, not full autonomy from day one.

| Autonomy Level | Agent Can | Human Must | Advancement Criteria |
|---|---|---|---|
| **Shadow** | Produce outputs, but none are used | Review all outputs against manual baseline | ≥90% accuracy over 20 cases |
| **Advisory** | Produce recommendations with full reasoning | Approve before action | ≥95% accuracy, <10% override rate over 50 cases |
| **Supervised** | Act within bounded parameters | Review exceptions and overrides | ≥97% accuracy, <5% override over 100 cases |
| **Autonomous** | Act within specification | Review only escalations | Never for irreversible actions |

### Step 6.5: Pipeline Health Monitoring

**What:** Define leading indicators that predict quality degradation before it shows in output accuracy.

**How:**
1. **Information Diversity Score (IDS):** How semantically varied are messages between agents? Declining IDS = convergent thinking = pipeline homogenisation risk.
2. **Unnecessary Path Ratio (UPR):** How much reasoning was wasted? High UPR = over-specified pipeline.
3. **Override Rate:** How often does the human override agent outputs? Increasing override rate = agent specification aging.
4. **Cost Variance:** How much does actual cost deviate from budget? Rising variance = specification drift.

**Monitoring protocol:**
- Track IDS, UPR, override rate, and cost variance per run
- Set thresholds for each metric
- Trigger pipeline review when any metric crosses its threshold

### Step 6.6: Iterative Refinement Protocol

**What:** Define how the system improves over time.

**How:**
1. **Metrics to track:**
   - Per-agent: accuracy rate, failure rate, cost per invocation, override rate
   - Per-pipeline: total human time, error rate, human satisfaction, creative freedom score
   - Per-deliverable: quality score vs. manual baseline
   - System Empowerment Index: trending upward through use

2. **Improvement triggers:**
   - Agent accuracy < threshold → retrain or redesign
   - Human override rate > threshold → boundary or specification needs revision
   - Human cognitive load > budget → interface or meta-agent redesign
   - Creative freedom declining → system is constraining, not amplifying
   - New edge cases → update edge case catalog and actor specifications
   - Specification aging trigger → review and update specification

3. **Review cadence:**
   - Time-based: quarterly for stable, monthly for new
   - Trigger-based: on any aging trigger (model change, performance degradation, override rate increase)
   - After every N runs (N = 10 for high-frequency, 3 for low-frequency)

**Artifact:** `Validation Report` — prototype results, empirical complementarity scores, pipeline integration results, refinement protocol, progressive autonomy plan.

### Phase 6 Test Plan

| Test ID | Test Name | Source Decision | Expected Result |
|---|---|---|---|
| 6.1.1 | Prototype priority | Priority matrix | Highest-risk agents prototyped first |
| 6.2.1 | Agent accuracy | MVA testing | ≥85% accuracy on benchmark set |
| 6.2.2 | Boundary adherence | Stress testing | Agent respects "never" constraint ≤2% violation |
| 6.2.3 | Template compliance | Schema validation | ≥99% output template compliance |
| 6.2.4 | Epistemic honesty | Metadata testing | Confidence scores correlate ≥0.7 with actual accuracy |
| 6.2.5 | Cost compliance | Budget testing | Agent stays within cost budget on representative inputs |
| 6.3.1 | End-to-end pipeline | Integration testing | Full pipeline produces correct deliverables on 3-5 instances |
| 6.3.2 | Template enforcement | System validation | System catches all template violations |
| 6.3.3 | Information boundaries | Security testing | Agent cannot access forbidden data through any mechanism |
| 6.4.1 | Progressive autonomy | Advancement criteria | Agent advances through autonomy levels based on measured performance |
| 6.5.1 | Pipeline health | Monitoring | IDS, UPR, override rate within thresholds |
| 6.6.1 | Specification freshness | Aging review | No specification exceeds freshness date without review |

---

### 🔴 QUALITY GATE 6: Validation Complete

**Fidelity Checks:**
- [ ] All priority agents prototyped and tested
- [ ] Empirical complementarity scores recorded
- [ ] Pipeline integration testing completed end-to-end
- [ ] Template enforcement validated by System
- [ ] Information boundaries tested and enforced
- [ ] Cost tracking validated against budget

**Enrichment Checks:**
- [ ] System Empowerment Index measured at each interaction point
- [ ] Creative freedom measured: human discovers new methods through use
- [ ] No interaction point below Enabling (3) in practice
- [ ] System Empowerment Index trending upward, not toward "less dependency"

**Cross-Cutting Checks:**
- [ ] CC-1: Verification independence validated in practice
- [ ] CC-2: Human enrichment observed — humans finding solutions they wouldn't alone
- [ ] CC-3: Epistemic metadata accuracy validated (confidence correlates with reality)
- [ ] CC-4: Information boundaries enforced by System infrastructure, not prompts
- [ ] CC-5: Specification aging triggers active — first review scheduled
- [ ] CC-6: System Empowerment Index assessed and trending upward
- [ ] CC-7: Total pipeline cost within budget
- [ ] CC-8: Audit trail complete at specified assurance levels

**Test Readiness Checks:**
- [ ] Phase 6 test plan defined with targets
- [ ] Progressive autonomy advancement criteria defined
- [ ] Specification aging triggers and review cadence defined
- [ ] Pipeline health monitoring targets (IDS, UPR) defined

---

## The Complete Artifact Chain

Every decision must be traceable from final agent specification back to original task analysis:

```
Task Decomposition Map
  └→ Cognitive Load Assessment
       └→ Expert Validation Record
            └→ Edge Case Catalog
                 └→ Complementarity Matrix (H/A/S, model-specific, human-specific)
                      └→ Actor Map
                           └→ Event Storm Map (if applicable)
                                └→ System Architecture Document
                                     └→ Template Architecture (7 template types)
                                          └→ FMEA Table
                                               └→ Composition Decisions
                                                    └→ Agent Roster (including System components)
                                                         └→ Agent Job Descriptions (per agent)
                                                              └→ Boundary Stress Tests (per agent)
                                                                   └→ Cost-Benefit Assessments (per agent)
                                                                        └→ Human Experience Specification
                                                                             └→ System Empowerment Index Assessment
                                                                                  └→ Validation Report
                                                                                       └→ Progressive Autonomy Plan
                                                                                            └→ Pipeline Health Monitoring Plan
                                                                                                 └→ Iterative Refinement Protocol
```

---

## Complete Test Plan Index

Every test traces to a design decision. Every quality gate includes test readiness checks.

| Phase | Test Plan | Key Tests |
|---|---|---|
| **1** | Task Intelligence Tests | Cognitive operation classification, granularity check, expert recognition, edge case coverage |
| **2** | Capability Allocation Tests | Mechanical classification, complementarity gap accuracy, reversibility, actor coverage |
| **2.5** | Event Storm Tests (if applicable) | Event completeness, trigger condition accuracy, fallback functionality, data flow integrity |
| **3** | System Architecture Tests | Data flow completeness, orchestration triggers, timeout handling, fallback tiers, FMEA recovery, template validation, composition appropriateness |
| **4** | Agent Design Tests | Classification correctness, boundary adherence, stress input tests, template compliance, epistemic metadata, information boundary, cost justification, coalition diversity |
| **5** | Human Experience Tests | Cognitive load budget, interface usability, override mechanism, creative freedom, empowerment level |
| **6** | Validation Tests | Agent accuracy, boundary adherence, template compliance, epistemic honesty, cost compliance, end-to-end pipeline, template enforcement, information boundaries, progressive autonomy, pipeline health, specification freshness |

---

## CAWDP v1 → v2 Change Log

| Aspect | v1 | v2 |
|---|---|---|
| **Actor model** | Binary (Human/Agent) | Ternary (Human/Agent/System) |
| **Allocation priority** | Human vs. Agent gaps | System-first → Human → Agent → Collaborative |
| **Cognitive operations** | 8 types | 9 types (Mechanical added) |
| **Output structure** | Prose descriptions | Template-enforced typed schemas |
| **Information boundaries** | Prompt instructions | Infrastructure-enforced (System) |
| **Verification** | Assumed separate | 3-level independence scale (System/Agent/Human) |
| **Enrichment** | Not assessed | System Empowerment Index (5 levels) |
| **Enrichment goal** | Human becomes independent | System expands human creative freedom |
| **Testing** | Phase 6 afterthought | Parallel track — test plans alongside every phase |
| **Epistemic metadata** | Not specified | 6 required fields on every agent output |
| **Cost** | Afterthought | First-class budget constraint per agent and per pipeline |
| **Audit** | Assumed immutable | 3 assurance levels (Logged/Assured/Verified) |
| **Specification aging** | Not addressed | Freshness dates, aging triggers, review cadence |
| **Autonomy** | Full or nothing | Progressive (shadow→advisory→supervised→autonomous) |
| **Quality gates** | Fidelity checks only | 3-layer: fidelity + enrichment + cross-cutting + test readiness |
| **Template types** | Not specified | 7 types (Input/Output/Handoff/Verification/Decision/Feedback/Escalation) |
| **Fallback** | Not addressed | 4-tier model fallback specifications |
| **Pipeline health** | Not monitored | IDS + UPR + override rate + cost variance |

---

## Teachable Units for Future's Edge

| Unit | Core Concept | Applicable Beyond Agents |
|---|---|---|
| **The 5-Class Taxonomy** | Extractor/Measurer/Assessor/Generator/Aggregator | ✅ Any AI system |
| **"Constrain the Inverse"** | Authority boundary = inverse of failure mode | ✅ Any system design |
| **Ternary Allocation** | System-first priority, then Human, then Agent | ✅ Any human-AI collaboration |
| **System Empowerment Index** | Constraining → Informing → Enabling → Amplifying → Liberating | ✅ Any UX/product design |
| **Template Architecture** | 7 template types resolve bidirectional type collision | ✅ Any information system |
| **Epistemic Metadata** | 6 fields on every output: provenance, confidence, limitations, assumptions, alternatives, what would change this | ✅ Any knowledge system |
| **Complementarity Allocation Algorithm** | Quantified H/A/S gap → assignment decision | ✅ Any human-AI collaboration |
| **Backcasting from Deliverables** | Design from outputs backward | ✅ Any project planning |
| **FMEA for Pipelines** | Failure mode analysis for interconnected systems | ✅ Any system reliability |
| **Test as Design Artifact** | Every design decision generates a test | ✅ Any engineering process |
| **Human Enrichment Reframing** | System expands creative freedom, not removes dependency | ✅ Any collaborative technology |
| **Progressive Autonomy** | Shadow → Advisory → Supervised → Autonomous | ✅ Any deployment strategy |The complete CAWDP v2 methodology is above. Every element from every conversation turn is now integrated into a single coherent framework:

**The five transformations that define v2:**

1. **Binary → Ternary:** System as a first-class actor with its own capability profile, not just a cheaper agent. System gets first refusal because it's the cheapest, most reliable, and has zero hallucination risk. System also serves as the trust infrastructure — enforcing boundaries, validating templates, and containing failures.

2. **Prose → Templates:** Seven template types structurally resolve bidirectional type collision. Every data flow has a typed schema. Every agent output includes epistemic metadata. Every human decision point has a Decision Template. Type collision is no longer an insight — it's an engineering problem with an engineering solution.

3. **Assumed → Enforced:** Verification independence, information boundaries, and audit trails are no longer aspirations or prompt instructions — they're infrastructure-enforced by the System actor. Quality gates check for structural enforcement, not declarative statements.

4. **Dependency → Freedom:** The enrichment axis measures creative freedom expansion, not dependency reduction. The System Empowerment Index runs from Constraining to Liberating. The test question is "did the human discover a better method?" not "can the human do it alone?"

5. **Afterthought → Parallel:** Testing is designed alongside every design decision, not after the design is complete. Every quality gate includes test readiness checks. Phase 6 runs the tests that were already designed, it doesn't design them.

These five transformations move CAWDP from a design-time process to a governance framework that spans design, runtime, and evolution.