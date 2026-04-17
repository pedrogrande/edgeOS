# The Complementarity-Driven Agentic Workflow Design Process (CAWDP)

*A repeatable methodology for designing human-agent collaboration systems — from single-agent tasks to complex multi-agent pipelines.*

---

## Origin & Purpose

This process was extracted from a retrospective review of an assignment-marking workflow design (23 agents, 4 pipeline stages, 13 human-only subtasks). The review identified 7 weaknesses and 6 missing steps. This methodology integrates every correction.

**Core premise:** The agent's highest-value role is *judgment preparation*, not *answer generation*. Every design decision in this process serves that principle.

---

## Process Overview

```
┌─────────────────────────────────────────────────────────────────────┐
│                    6 PHASES + 5 QUALITY GATES                       │
│                                                                     │
│  PHASE 1          PHASE 2          PHASE 3          PHASE 4         │
│  TASK             CAPABILITY       SYSTEM           AGENT           │
│  INTELLIGENCE     ALLOCATION       ARCHITECTURE     DESIGN         │
│      │               │               │               │              │
│  [GATE 1]       [GATE 2]        [GATE 3]        [GATE 4]          │
│                                                                     │
│              PHASE 5              PHASE 6                           │
│              HUMAN EXPERIENCE     VALIDATION & ITERATION            │
│                  │                    │                              │
│              [GATE 5]           (continuous)                        │
└─────────────────────────────────────────────────────────────────────┘
```

**Scaling heuristic — not every phase is needed for every task:**

| Task Complexity | Phases Required | Typical Examples |
|---|---|---|
| **Single-agent, no human loop** | 1 → 2 → 4 | Data extraction, summarisation, translation |
| **Single-agent + human review** | 1 → 2 → 4 → 5 | Draft generation, analysis with human sign-off |
| **Multi-agent, linear pipeline** | 1 → 2 → 3 → 4 → 5 | Sequential processing with handoffs |
| **Multi-agent, branching + human decisions** | 1 → 2 → 2.5 → 3 → 4 → 5 → 6 | Complex workflows like the marking pipeline |

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

| Cognitive Operation | Description | Example |
|---|---|---|
| **Structural** | Mapping form/organisation | "Count slides, identify sections" |
| **Domain-semantic** | Interpreting domain-specific meaning | "Identify blockchain claims" |
| **Comparative-semantic** | Comparing across instances | "Detect synthesis patterns across submissions" |
| **Structural-semantic** | Auditing structural-intent alignment | "Is reflection section actually reflective?" |
| **Statistical** | Numerical pattern detection | "Flag outlier word counts" |
| **Generative** | Producing novel text/structure | "Draft constructive feedback" |
| **Evaluative** | Making quality judgments | "Score against rubric criteria" |
| **Synthesis** | Consolidating multiple sources | "Merge flags into unified report" |

**Artifact:** `Task Decomposition Map` — each subtask annotated with cognitive operation type, dependencies, and estimated cognitive load.

### Step 1.2: Cognitive Load Analysis *(NEW — addresses Weakness 7)*

**What:** For each subtask, estimate the working memory demands, number of distinct cognitive operations, and switching cost.

**How:**
1. For each subtask, ask: *How many distinct cognitive operations are bundled here?*
2. If >2, flag for potential further decomposition
3. Estimate working memory demand: how many things must be held simultaneously?
4. Estimate switching cost: how much context must be loaded/unloaded?

**Decomposition granularity check:**
- **Under-decomposed:** >3 cognitive operations per subtask → decompose further
- **Right-sized:** 1-2 cognitive operations per subtask
- **Over-decomposed:** subtask is trivially simple and its output doesn't justify a separate agent → consider merging

**Artifact:** `Cognitive Load Assessment` — per-subtask: operation count, working memory demand, switching cost, granularity verdict.

### Step 1.3: Expert Validation *(NEW — addresses Missing Step 1)*

**What:** Validate the decomposition with domain experts before proceeding.

**How:**
1. Present decomposition to 1-3 domain experts
2. Ask: "Do you recognise these subtasks? Would you decompose differently?"
3. Capture any subtasks they identify that you missed
4. Confirm the cognitive operation labels match expert mental models

**Effort heuristic:** 30-60 minute conversation per expert. Skip only if you ARE the domain expert AND you can articulate your expertise explicitly.

**Artifact:** `Expert Validation Record` — expert feedback, decomposition changes made.

### Step 1.4: Edge Case Inventory *(NEW — addresses Missing Step 5)*

**What:** Identify boundary conditions and anomalous inputs before designing the system.

**How:**
1. For each input type, list: empty, corrupted, ambiguous, adversarial, oversized, undersized variants
2. For each subtask, ask: "What input would break this?"
3. Categorise: *must-handle* (common enough to design for) vs. *must-detect* (flag for human) vs. *out-of-scope*

**Artifact:** `Edge Case Catalog` — per input type: edge cases, expected handling, categorisation.

---

### 🔴 QUALITY GATE 1: Task Intelligence Complete

**Checklist before proceeding:**
- [ ] Every subtask has a cognitive operation classification
- [ ] No subtask bundles >3 cognitive operations (or explicitly justified)
- [ ] Cognitive load assessment completed for all subtasks
- [ ] Domain expert validation obtained (or expertise self-attestation documented)
- [ ] Edge case catalog has ≥3 cases per input type
- [ ] All deliverables trace back through dependency chains

**If not passed:** Return to decomposition. Missing edge cases or unvalidated decomposition will cascade into architectural failures.

---

## PHASE 2: Capability Allocation

*Determine what humans do, what agents do, and why.*

### Step 2.1: Complementarity Analysis

**What:** Map each subtask against capability dimensions to determine Human/Agent/Collaborative assignment.

**How:**
1. Score each subtask on 15 capability dimensions (1-9 scale) for BOTH Human and Agent:

| Dimension | Human Score Considerations | Agent Score Considerations |
|---|---|---|
| **Reasoning depth** | Abstract reasoning, novel problems | Pattern matching, defined-rule reasoning |
| **Ethical judgment** | Moral reasoning, value conflicts | Rule-based ethics, bias detection |
| **Values alignment** | Organisational culture, implicit norms | Explicit rule compliance |
| **Decision authority** | Accountability, stakeholder trust | Recommendation generation |
| **Domain expertise** | Tacit knowledge, intuition | Explicit knowledge, data access |
| **Parallelisation** | Sequential processing limit | Infinite parallel execution |
| **Output consistency** | Fatigue drift, mood variation | Deterministic given same input |
| **Speed** | Minutes to hours per unit | Seconds per unit |
| **Novelty handling** | Adaptive, creative | Fallback to training distribution |
| **Context sensitivity** | Reads room, adjusts | Follows instructions literally |
| **Precision** | Human error rate | Computational accuracy |
| **Scalability** | Linear time scaling | Near-constant time scaling |
| **Explainability** | Can articulate reasoning | Can cite sources, show chains |
| **Cultural sensitivity** | Lived experience, nuance | Training data patterns |
| **Error type** | Omission, fatigue errors | Hallucination, overconfidence |

2. Calculate H-A gap for each dimension
3. Apply the **Complementarity Allocation Algorithm:**

```
For each subtask:
  IF any dimension in {Ethical Judgment, Values Alignment, Decision Authority}
     has gap ≥ 6 (Human dominant) → HUMAN-LED
  
  IF any dimension in {Parallelisation, Output Consistency, Scalability}
     has gap ≥ 5 (Agent dominant) → AGENT-LED
  
  IF dimensions in both sets have gaps above thresholds → COLLABORATIVE
  
  IF no dimensions exceed either threshold → DEFAULT TO COLLABORATIVE
     (insufficient evidence for exclusive assignment)
```

**Critical improvement over original process:** Scores must be **model-specific** and **human-profile-specific** *(addresses Weakness 1)*:
- Specify which LLM (e.g., GPT-4, Claude 3.5, local model) — scores vary dramatically
- Specify human profile (e.g., subject-matter expert, trained operator, novice) — expertise changes gaps
- Document the rationale for each score — enables later empirical testing

**Artifact:** `Complementarity Matrix` — per subtask: 15 H/A scores, gap scores, allocation decision, model reference, human profile, rationale.

### Step 2.2: Actor Analysis *(NEW — addresses Weakness 3)*

**What:** Identify all human actors, not just "the human."

**How:**
1. List every human role that interacts with the system
2. For each role, specify: expertise level, decision authority, time availability, cognitive load tolerance
3. Map which subtasks each human role owns
4. Identify inter-human coordination needs (e.g., multiple markers needing calibration)

**Artifact:** `Actor Map` — roles, capabilities, constraints, inter-actor coordination requirements.

---

## PHASE 2.5: Event Storming *(NEW — addresses Weakness 4, Missing Step 3)*

*Only for multi-agent workflows with dependencies, data handoffs, and/or human decision points.*

### When to Use Event Storming

| Condition | Do Event Storming? |
|---|---|
| Single agent, no human loop | ❌ Skip — overhead exceeds value |
| Linear pipeline, no branching, no failure recovery | ⚠️ Optional — data flow is simple |
| Multi-agent with human decisions | ✅ Recommended |
| Multi-agent with branching/failure recovery | ✅ Essential |
| Multiple human actors | ✅ Essential |

### Step 2.5.1: Domain Event Mapping

**What:** Map every event that occurs in the system on a timeline.

**How:**
1. Write each domain event on a card (past tense): `SubmissionReceived`, `FormatChecked`, `AnomalyFlagged`, `ScoreRecommended`, `HumanOverrideIssued`
2. Arrange chronologically
3. For each event, identify:
   - **Command:** What triggers it? (who or what)
   - **Actor:** Who/what executes it?
   - **Data produced:** What structured output does it generate?
   - **Policy:** What happens next? (what events does it trigger?)

### Step 2.5.2: Failure Event Surfacing

**What:** Systematically identify events that shouldn't happen but will.

**How:**
For each happy-path event, ask:
1. *What if this produces wrong output?* → `AgentOutputDoubted`
2. *What if this times out?* → `AgentTimeoutExpired`
3. *What if this receives unexpected input?* → `UnexpectedInputReceived`
4. *What if the human disagrees?* → `HumanOverrideIssued`
5. *What if the human is absent?* → `HumanDecisionDeferred`

### Step 2.5.3: Data Flow Validation

**What:** For each event, verify that its input data exists and is accessible.

**How:**
1. For each event, ask: "What data does this event's actor need?"
2. Trace backwards: which prior events produce that data?
3. Flag any data that is *implied but not explicitly produced*
4. Verify data format compatibility (schema, structure, granularity)

### Step 2.5.4: Trigger Condition Specification

**What:** Define the exact conditions that trigger each event.

**How:**
1. For each event, write the condition as a boolean expression:
   - `FormatChecked` triggers when: `SubmissionReceived AND file is not corrupted`
   - `HumanOverrideIssued` triggers when: `ScoreRecommended AND human disagrees AND delta > threshold`
2. For each trigger, define the timeout: what happens if the condition is never met?
3. For each trigger, define the fallback: what happens if the triggering event fails?

**Artifact:** `Event Storm Map` — timeline of events, commands, actors, data flows, failure events, trigger conditions, timeouts, fallbacks.

**Key insight from original process:** Event Storming would have surfaced the Flag Aggregator *before* Stage 3 design (it emerged organically during design), and would have caught missing events like `ConsistencyCheckFailed`, `HumanOverrideScore`, `FeedbackRejectedByHuman`.

---

### 🔴 QUALITY GATE 2: Capability Allocation Complete

**Checklist before proceeding:**
- [ ] Every subtask has H/A scores with model reference and human profile
- [ ] Allocation decisions trace to specific gap scores
- [ ] Actor map includes all human roles (not just "the human")
- [ ] (If applicable) Event Storm map covers happy path + failure events
- [ ] (If applicable) Data flow validated for every event — no implied-but-not-produced data
- [ ] (If applicable) Trigger conditions specified with timeouts and fallbacks

**If not passed:** The most common failure here is implied data flow — agents assumed to receive data that no prior step explicitly produces. Fix before proceeding.

---

## PHASE 3: System Architecture

*Design the structure that everything lives in.*

### Step 3.1: Pipeline Architecture (Backcasting)

**What:** Design the data flow from final deliverables backwards.

**How:**
1. List final deliverables
2. For each, trace the dependency chain back through phases
3. Define the **data objects** that flow between stages:
   - Schema (what fields)
   - Producer (which agent/human creates it)
   - Consumer (which agent/human reads it)
   - Mutability (append-only, replaceable, immutable)
   - Persistence (ephemeral, session, permanent)

4. Identify execution topology:
   - **Sequential:** Phase N completes before Phase N+1 starts
   - **Parallel:** Multiple agents run simultaneously within a phase
   - **Event-driven:** Agents activate on trigger conditions
   - **Gated:** Phase transition requires quality check

### Step 3.2: Orchestration Design *(NEW — addresses Missing Step 3)*

**What:** Design the system that manages agent execution, not just the agents themselves.

**How:**
1. Specify execution engine: what triggers Wave 1? What waits for Wave 1 completion?
2. Define **orchestration policies:**
   - **Timeout policy:** How long before an agent is assumed failed?
   - **Retry policy:** How many retries? With what backoff?
   - **Partial completion policy:** Can the pipeline continue if one agent fails?
   - **Cascading failure policy:** What happens when a critical-path agent fails?
3. Define **progress tracking:** How is pipeline state represented? How does the human know where things stand?

### Step 3.3: Failure Mode & Effects Analysis (FMEA) *(NEW — addresses Weakness 4)*

**What:** For every agent and every pipeline transition, analyse what happens when things go wrong.

**How:**
1. For each agent, list its **primary failure mode** (from the 5-class taxonomy)
2. For each failure mode, assess:
   - **Detection probability:** How likely is the failure to be noticed?
   - **Impact radius:** How many downstream agents/humans are affected?
   - **Recovery path:** What's the fallback?
3. For each pipeline transition, list:
   - **Upstream failure:** What if the input is wrong?
   - **Transition failure:** What if the handoff fails?
   - **Downstream assumption:** What does the next agent assume about this input?

**FMEA template per agent:**

| Field | Content |
|---|---|
| Agent name | |
| Primary failure mode | (e.g., hallucination for Extractors, noise-as-signal for Measurers) |
| Detection method | (How will we know it failed?) |
| Detection probability | (High / Medium / Low) |
| Impact if undetected | (What goes wrong downstream?) |
| Recovery path | (Rerun? Skip? Flag? Human escalation?) |
| Containment boundary | (What stops the failure from propagating?) |

**Artifact:** `System Architecture Document` — pipeline diagram, data objects, orchestration policies, FMEA table.

---

### 🔴 QUALITY GATE 3: Architecture Complete

**Checklist before proceeding:**
- [ ] Every data object has schema, producer, consumer, mutability, persistence
- [ ] No data flow is implied — every consumer's input is explicitly produced
- [ ] Orchestration policies cover timeout, retry, partial completion, cascading failure
- [ ] FMEA completed for every agent and every pipeline transition
- [ ] Recovery paths specified for every failure mode
- [ ] Edge cases from Phase 1 mapped to handling in architecture

---

## PHASE 4: Agent Design

*Design each agent with the specificity needed for implementation.*

### Step 4.1: Agent Classification

**What:** Assign each agent to a class. This immediately gives you its boundary principle and failure mode.

**The 5-Class Taxonomy:**

| Class | Authority Boundary | Primary Failure Mode | Hallucination Risk | Key Constraint |
|---|---|---|---|---|
| **Extractor** | Never judge | Hallucination | High | Only extract, never interpret |
| **Measurer** | Never interpret | Noise-as-signal | Low | Present data, not meaning |
| **Assessor** | Never finalise | Overconfidence | Medium | Recommend, never decide |
| **Generator** | Never be vague | Fabrication | High | Every claim must cite evidence |
| **Aggregator** | Never add | Omission | Low | Consolidate only, no new analysis |

**Application:** When you encounter a new agent design problem, first ask: *Is this an Extractor, Measurer, Assessor, Generator, or Aggregator?* The boundary principle and failure mode follow immediately.

### Step 4.2: Authority Boundary Specification

**What:** Define what each agent must NOT do. The constraint is the **inverse of the failure mode.**

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

### Step 4.3: Boundary Stress Testing *(NEW — addresses Improvement 3)*

**What:** Before finalising the boundary, test it with inputs designed to push the agent toward its failure mode.

**How:**
For each agent, design 3-5 **boundary stress inputs:**
- *What input would tempt this Measurer to interpret?* → e.g., a statistical outlier that "obviously" means something
- *What input would tempt this Generator to be vague?* → e.g., a submission so weak that constructive feedback feels impossible
- *What input would tempt this Assessor to finalise?* → e.g., a near-perfect submission where scoring feels obvious

**Document the expected boundary-enforced response** vs. the tempted response. This becomes a test case for implementation.

### Step 4.4: Agent Job Description

**What:** Create a complete specification that enables a developer to implement the agent without further design decisions.

**Template:**

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

INPUT SCHEMA
  - Required inputs (what data, from which agent/human, in what format)
  - Optional inputs (what data improves quality if available)
  - Edge case handling (from Phase 1 edge case catalog)

OUTPUT SCHEMA
  - Structured output format (typed, not prose)
  - Required fields
  - Optional fields
  - Confidence/provenance metadata

CONTEXT & KNOWLEDGE
  - Domain knowledge required
  - Reference materials (specific documents, URLs, data)
  - System prompt context

TOOLS
  - Required tools (web search, calculator, etc.)
  - Optional tools

HARD CONSTRAINTS
  - Authority boundary (from Step 4.2)
  - Additional constraints specific to this agent
  - Prohibited actions

QUALITY CRITERIA
  - What does "good output" look like for this agent?
  - Measurable quality indicators
  - Failure indicators (signals that the agent is failing)

ERROR HANDLING
  - What to do on missing input → (flag? skip? error?)
  - What to do on ambiguous input → (request clarification? flag? proceed with confidence score?)
  - What to do on tool failure → (retry? fallback? flag?)

ESCALATION PROTOCOL
  - When to escalate to human
  - When to escalate to orchestrator
  - What information to include in escalation

PERFORMANCE EXPECTATIONS
  - Expected latency
  - Expected accuracy (if estimable)
  - Cost budget per invocation

ADVERSARIAL EXAMPLES *(NEW — addresses Improvement 4)*
  - 2-3 inputs designed to push toward failure mode
  - Expected boundary-enforced response for each
  - Common temptation and correct refusal

INTERACTION MAP
  - Upstream: which agents/humans provide input
  - Downstream: which agents/humans consume output
  - Parallel: which agents run alongside this one
```

### Step 4.5: Cost-Benefit Assessment *(NEW — addresses Weakness 5)*

**What:** Determine whether each agent justifies its complexity.

**How:**
For each agent, assess:
1. **Value added:** What would be lost if this agent were removed? Would a simpler alternative (script, template, rule) suffice?
2. **Complexity cost:** How complex is this agent to implement, maintain, and debug?
3. **Failure risk:** What's the probability and impact of this agent's failure mode?
4. **Verdict:**
   - **Essential:** Unique cognitive work that can't be achieved simpler
   - **Valuable:** Justified complexity — saves human time or improves quality
   - **Questionable:** Could be replaced by a script or simpler mechanism
   - **Unnecessary:** Adds no value beyond what's already provided

**Artifact:** `Agent Roster` — each agent with class, boundary, job description, cost-benefit verdict.

---

### 🔴 QUALITY GATE 4: Agent Design Complete

**Checklist before proceeding:**
- [ ] Every agent classified into 5-class taxonomy
- [ ] Authority boundary specified as inverse of failure mode
- [ ] Boundary stress tests designed (3-5 per agent)
- [ ] Job descriptions complete for all agents (using template)
- [ ] Adversarial examples included in each job description
- [ ] Cost-benefit assessment completed — no "unnecessary" agents remain
- [ ] Every agent's input schema traces to a producer in the architecture
- [ ] Every agent's output schema traces to a consumer in the architecture

---

## PHASE 5: Human Experience Design *(NEW — addresses Weakness 6 & Missing Step 4)*

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
   - **What the human needs** (context, prior agent outputs, comparison data)
   - **What the human doesn't need** (filter out information that's not decision-relevant)
2. Design the **navigation flow:** How does the human move between interaction points?
3. Design the **interruption model:** Can the human pause and resume? What state is preserved?

### Step 5.3: Override & Feedback Mechanisms

**What:** Design how the human corrects the system.

**How:**
1. For each human decision, define:
   - **Override mechanism:** How does the human change an agent's output?
   - **Feedback path:** Does the override inform the agent for future runs?
   - **Audit trail:** Is the override logged with rationale?
2. Distinguish between:
   - **Decision overrides** (human changes a specific output)
   - **Parameter adjustments** (human changes system configuration)
   - **Process interventions** (human changes the pipeline itself)

**Artifact:** `Human Experience Specification` — cognitive load budget, interface specification, navigation flow, override mechanisms.

---

### 🔴 QUALITY GATE 5: Human Experience Complete

**Checklist before proceeding:**
- [ ] Cognitive load budgeted for every human interaction point
- [ ] No interaction point exceeds cognitive load budget without a mitigation
- [ ] Interface specification covers what human sees, does, needs, doesn't need
- [ ] Navigation flow between interaction points is specified
- [ ] Override mechanisms specified for every human decision point
- [ ] Audit trail specified for all overrides

---

## PHASE 6: Validation & Iteration *(NEW — addresses Weakness 2, Missing Step 6)*

*Design without validation is speculation.*

### Step 6.1: Prototype Priority Matrix

**What:** Determine which agents to build first.

**How:**
Rank agents by **risk × value:**

| Risk Level | Value Level | Priority |
|---|---|---|
| High failure probability | High value if correct | 🔴 **Prototype first** |
| High failure probability | Low value | 🟡 Prototype with minimal investment |
| Low failure probability | High value | 🟢 Prototype to confirm expectations |
| Low failure probability | Low value | ⚪ Defer or skip prototyping |

**For the marking pipeline, this would be:**
- 🔴 Claims Analyst (high hallucination risk + high value)
- 🔴 Feedback Drafter (high fabrication risk + high value)
- 🟡 Drift Detector (low hallucination risk but interpretation risk)
- 🟢 Briefing Composer (aggregation, low risk)

### Step 6.2: Minimum Viable Agent Testing

**What:** Build and test the minimum implementation of each priority agent.

**How:**
1. Implement agent with job description specification
2. Test against:
   - **Accuracy:** Does it produce correct outputs on known-good inputs?
   - **Boundary adherence:** Does it respect its authority boundary on stress inputs?
   - **Failure mode activation:** What inputs trigger its characteristic failure mode?
   - **Edge case handling:** How does it handle the edge cases from Phase 1?
3. Record actual performance vs. estimated complementarity scores
4. Update complementarity matrix with empirical data

### Step 6.3: Pipeline Integration Testing

**What:** Test agents together, not just individually.

**How:**
1. Run the pipeline end-to-end on a small sample (3-5 instances)
2. Verify:
   - Data flow: does every agent receive the data it needs?
   - Timing: does the pipeline complete within expected time?
   - Human experience: does the cognitive load match the budget?
   - Failure recovery: what happens when an agent produces wrong output?
3. Measure: human time per unit, accuracy vs. manual, human satisfaction

### Step 6.4: Iterative Refinement Protocol

**What:** Define how the system improves over time.

**How:**
1. **Metrics to track:**
   - Per-agent: accuracy rate, failure rate, cost per invocation
   - Per-pipeline: total human time, error rate, human satisfaction
   - Per-deliverable: quality score vs. manual baseline
2. **Improvement triggers:**
   - Agent accuracy < threshold → retrain or redesign
   - Human override rate > threshold → boundary or specification needs revision
   - Human cognitive load > budget → interface or meta-agent redesign
   - New edge cases → update edge case catalog and agent specifications
3. **Review cadence:** After every N runs (N = 10 for high-frequency, 3 for low-frequency)

**Artifact:** `Validation Report` — prototype results, empirical complementarity scores, pipeline integration results, refinement protocol.

---

## The Complete Artifact Chain

Every decision must be traceable from final agent specification back to original task analysis:

```
Task Decomposition Map
  └→ Cognitive Load Assessment
       └→ Expert Validation Record
            └→ Edge Case Catalog
                 └→ Complementarity Matrix (model-specific, human-specific)
                      └→ Actor Map
                           └→ Event Storm Map (if applicable)
                                └→ System Architecture Document
                                     └→ FMEA Table
                                          └→ Agent Roster
                                               └→ Agent Job Descriptions (per agent)
                                                    └→ Boundary Stress Tests (per agent)
                                                         └→ Cost-Benefit Assessments (per agent)
                                                              └→ Human Experience Specification
                                                                   └→ Validation Report
                                                                        └→ Empirical Complementarity Scores
```

---

## Quick Reference: Weakness → Process Fix Mapping

| Original Weakness | Process Fix | Phase |
|---|---|---|
| Theoretical complementarity scores | Model-specific + human-specific scoring; empirical validation | Phase 2 → Phase 6 |
| No prototyping or validation | Prototype Priority Matrix + MVA Testing + Integration Testing | Phase 6 |
| Assumed single human actor | Actor Analysis (Step 2.2) | Phase 2 |
| No failure mode analysis for pipeline | FMEA (Step 3.3) + Event Storming (Phase 2.5) | Phase 2.5, 3 |
| No cost-benefit analysis per agent | Cost-Benefit Assessment (Step 4.5) | Phase 4 |
| Human experience wasn't designed | Entire Phase 5 | Phase 5 |
| Didn't test decomposition granularity | Cognitive Load Analysis (Step 1.2) + granularity check | Phase 1 |

| Original Missing Step | Process Fix | Phase |
|---|---|---|
| Empirical validation of decomposition | Expert Validation (Step 1.3) | Phase 1 |
| Agent failure testing | Boundary Stress Testing (Step 4.3) + Adversarial Examples | Phase 4 |
| Pipeline orchestration design | Orchestration Design (Step 3.2) | Phase 3 |
| Human interface design | Entire Phase 5 | Phase 5 |
| Edge case specification | Edge Case Inventory (Step 1.4) | Phase 1 |
| Iterative refinement protocol | Iterative Refinement Protocol (Step 6.4) | Phase 6 |

| Original Improvement | Process Fix | Phase |
|---|---|---|
| Model-specific complementarity scoring | Required in Step 2.1 | Phase 2 |
| Cognitive load analysis | Step 1.2 | Phase 1 |
| Boundary stress tests | Step 4.3 | Phase 4 |
| Adversarial examples in job descriptions | Template field in Step 4.4 | Phase 4 |

---

## Curriculum Applicability for Future's Edge

**Teachable units that generalise beyond any specific workflow:**

| Unit | Core Concept | Applicable Beyond Agents |
|---|---|---|
| **The 5-Class Taxonomy** | Classify any AI component: Extractor, Measurer, Assessor, Generator, Aggregator | ✅ Any AI system |
| **"Constrain the Inverse"** | Authority boundary = inverse of failure mode | ✅ Any system design |
| **Complementarity Allocation Algorithm** | Quantified H/A gap → assignment decision | ✅ Any human-AI collaboration |
| **Type Collision (Bidirectional)** | 6+ cognitive modes ≠ 1 input surface | ✅ Any interface design |
| **Cognitive Load Budgeting** | Human information processing has limits | ✅ Any UX design |
| **Backcasting from Deliverables** | Design from outputs backward | ✅ Any project planning |
| **FMEA for Pipelines** | Failure mode analysis for interconnected systems | ✅ Any system reliability |

---

This process takes what was strong in the original journey (decomposition depth, boundary design, complementarity-driven assignment) and strengthens it with exactly what was missing (validation, failure analysis, human experience, empirical grounding). Every quality gate exists because a specific failure was identified in the review. The process is itself an example of its own principle: *constrain the inverse of the failure mode.*The methodology is documented above in full. Here's what makes it repeatable for *any* task:

**Three scaling levers** ensure you don't over-invest on simple tasks or under-invest on complex ones:

1. **Complexity heuristic** — the table at the top determines which phases you actually run. A single-agent data extraction skips Phases 2.5, 3, and 5 entirely. A complex multi-agent workflow runs all six.

2. **Quality gates, not phase transitions** — you don't move forward by finishing a phase. You move forward by *proving* you've addressed the failure modes that gate was designed to catch. Every checklist item traces to a weakness identified in the review.

3. **Reusable taxonomies that collapse decisions** — the 5-class taxonomy and the "constrain the inverse" principle mean that classifying an agent gives you its boundary, failure mode, and key constraint immediately. That's a decision accelerator, not a creative exercise every time.

**The key structural innovation:** the process is itself an example of its own principle. The quality gates constrain the inverse of each phase's characteristic failure mode — Phase 1 fails by under-decomposing → Gate 1 checks decomposition depth. Phase 3 fails by ignoring failures → Gate 3 checks FMEA completion. Phase 5 fails by ignoring the human → Gate 5 checks cognitive load budgets.

For Future's Edge, the seven teachable units at the bottom are the extractable curriculum content. Each one generalises beyond agentic systems entirely — they're principles of *human-AI collaboration design*, not just *agent design*.