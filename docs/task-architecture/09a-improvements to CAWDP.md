This is a significant evolution. You've identified three structural gaps and asked me to explore further. Let me work through all of this systematically — first your three additions, then the missing principles from v0.3, then the wider exploration space.

---

# CAWDP v2: From Design-Time Process to Lifecycle Process

**The meta-insight:** CAWDP v1 was a *design-time* process — it produces a specification and then stops. Your three additions, plus the missing v0.3 principles, push it toward a *lifecycle* process — one that governs the system from initial task analysis through runtime operation, temporal evolution, and ongoing governance.

---

## ENHANCEMENT 1: System as Third Actor

This is the most structurally significant change. It transforms CAWDP from a **binary allocation model** (Human/Agent) to a **ternary allocation model** (Human/Agent/System).

### Why This Matters

In the original marking pipeline, several subtasks were assigned to "Agent" that don't need semantic reasoning at all:

| Subtask | Assigned To | Actually Needs |
|---|---|---|
| Schema validation of submissions | Agent (Format Sentinel) | Deterministic code — validate structure against schema |
| Score aggregation calculations | Agent (Grade Finaliser) | Deterministic code — apply weighted formula |
| Conditional routing | Agent (orchestration) | Deterministic code — if X, route to Y |
| File format conversion | Agent | System — convert PDF to text |
| Threshold checking | Agent (Drift Detector component) | System — flag if value > threshold |
| Record assembly | Agent (Record Assembler) | System — merge JSON objects by schema |

Using an LLM for deterministic operations is **expensive, unreliable, and wasteful** — you're paying for semantic reasoning capability that isn't needed and introducing hallucination risk where none should exist.

### The Ternary Capability Profile

**System** (deterministic code/scripts/rules) has a distinct capability fingerprint:

| Dimension | System Score | Why |
|---|---|---|
| **Consistency** | 9 | Perfect determinism — same input, same output, always |
| **Hallucination risk** | 0 | None — no generative capability |
| **Speed** | 9 | Milliseconds for rule application |
| **Scalability** | 9 | Trivially parallelisable |
| **Cost per invocation** | 9 | Near-zero |
| **Parallelisation** | 9 | Embarrassingly parallel |
| **Output consistency** | 9 | Deterministic |
| **Semantic understanding** | 0 | Cannot interpret meaning |
| **Adaptation** | 0 | Only what's explicitly encoded |
| **Judgment** | 0 | Cannot make qualitative decisions |
| **Novelty handling** | 0 | Fails on unseen patterns |
| **Domain expertise** | 0 | Only explicit rules |
| **Context sensitivity** | 0 | No situational awareness |
| **Ethical reasoning** | 0 | Only explicit constraints |
| **Reasoning depth** | 0 | No abstract reasoning |

### New Cognitive Operation Type: Mechanical

Phase 1's cognitive operation classification needs a new member:

| Operation | Description | Best Actor | Example |
|---|---|---|---|
| **Mechanical** | Deterministic transformation, validation, routing | **System** | Schema validation, format conversion, threshold checking, formula application |
| Structural | Mapping form/organisation | Agent or System | Depends on whether interpretation is needed |
| Domain-semantic | Interpreting domain meaning | Agent | Requires semantic understanding |
| Comparative-semantic | Comparing across instances | Agent | Requires judgment |
| Statistical | Numerical pattern detection | Agent (complex) or System (simple) | Depends on complexity |
| Generative | Producing novel text | Agent | Requires semantic capability |
| Evaluative | Making quality judgments | Human or Agent (recommendation) | Depends on authority |
| Synthesis | Consolidating multiple sources | Agent or Human | Depends on nature of consolidation |

**The critical distinction:** Mechanical operations are **provably correct**. Agent operations are **probably correct**. Human operations are **accountably correct**. When a subtask can be mechanical, it SHOULD be mechanical — it removes an entire failure mode category from the pipeline.

### Updated Complementarity Allocation Algorithm

```
For each subtask:
  // SYSTEM FIRST — eliminate hallucination risk where possible
  IF cognitive operation = Mechanical:
    → SYSTEM-LED (deterministic code)
  
  // HUMAN GATE — protect authority domains
  IF any dimension in {Ethical Judgment, Values Alignment, Decision Authority}
     has H-S gap ≥ 6 AND H-A gap ≥ 6:
    → HUMAN-LED
  
  // AGENT ADVANTAGE — semantic at scale
  IF any dimension in {Parallelisation, Output Consistency, Scalability}
     has A-S gap ≥ 5 AND A-H gap ≥ 5:
    → AGENT-LED
  
  // SYSTEM FOR CONSISTENCY — where determinism matters more than semantics
  IF consistency requirement = 9 AND semantic need < 3:
    → SYSTEM-LED
  
  // COLLABORATIVE — everything else
  → DEFAULT TO COLLABORATIVE
     (specify which actors collaborate and in what ratio)
```

**The new decision priority order:** System → Human → Agent → Collaborative. System gets first refusal because it's the cheapest, most reliable, and has zero hallucination risk. Human protects authority domains. Agent handles semantic reasoning at scale. Collaborative handles the genuinely hybrid cases.

### The Ternary Interaction Patterns

Not all three actors interact with each other equally. The key patterns:

| Pattern | Description | Example |
|---|---|---|
| **System → Agent** | System pre-processes; Agent reasons | Schema validation → Claims analysis |
| **Agent → System** | Agent decides; System executes | Agent flags anomaly → System routes to human queue |
| **System → Human** | System presents; Human judges | System computes statistics → Human interprets patterns |
| **Agent → Human** | Agent prepares; Human judges | Agent recommends score → Human finalises |
| **System → Agent → Human** | Full pipeline | System validates → Agent analyses → Human decides |
| **Human → System** | Human triggers; System executes | Human overrides grade → System recalculates aggregate |

### Impact on CAWDP Phases

- **Phase 1:** Add "Mechanical" to cognitive operation classification. Add a System-feasibility check: *Can this subtask be expressed as a deterministic rule?*
- **Phase 2:** Expand complementarity matrix to 3 columns (H/A/S). New allocation algorithm with System-first priority.
- **Phase 2.5:** Event Storming now surfaces **System-enforced events** (e.g., `SchemaValidationPassed`, `ThresholdExceeded`) alongside agent and human events.
- **Phase 3:** Architecture distinguishes between **semantic pipeline segments** (Agent-mediated) and **mechanical pipeline segments** (System-enforced). Orchestration specifies which engine handles which transitions.
- **Phase 4:** Agent job descriptions now specify what System components handle upstream/downstream — agents don't duplicate System work.
- **Phase 5:** Human experience offloads mechanical information to System — humans only see what requires their judgment.

### A New Insight: System as Containment Layer

System components serve a second function beyond efficiency: **failure containment**. When an agent produces output that fails a System-enforced schema validation, the System catches it before it propagates downstream. This is the pipeline's **immune system** — deterministic code that catches semantic errors.

```
Agent Output → System Schema Validation → PASS → downstream
                                  → FAIL → quarantine + human alert
```

This means every agent's output should pass through a System-enforced validation checkpoint before reaching any consumer. The checkpoint enforces the output schema from the job description.

---

## ENHANCEMENT 2: Template Architecture

You've identified a critical gap: CAWDP v1 discusses data *objects* flowing between stages but doesn't specify the **templates** that structure those objects. Templates are the concrete mechanism that resolves type collision — they enforce typed, decomposable outputs instead of prose.

### The Template Taxonomy

Templates serve different functions at different points in the pipeline:

| Template Type | Purpose | Enforced By | Example |
|---|---|---|---|
| **Input Template** | Structures what an agent receives | System (pre-processing) | Structured submission package with typed fields |
| **Output Template** | Structures what an agent produces | System (post-validation) | Claims analysis with: claim, source, confidence, domain tags |
| **Handoff Template** | Standardises data packages between agents/humans | System (routing) | Enhanced Submission Package: format results + claims + anomalies + reflection status |
| **Verification Template** | Structures verification checklists | System (gate enforcement) | Format Sentinel verification: file type ✓, slide count ✓, section headers ✓ |
| **Decision Template** | Structures human decision inputs | System (presentation) | Score recommendation: criterion, evidence, recommendation, confidence, alternatives considered |
| **Feedback Template** | Structures agent-to-human feedback | Agent (generation) | Student feedback: strength evidence, improvement area, specific suggestion, rubric alignment |
| **Escalation Template** | Structures escalation to human | System (routing) | Escalation: agent, issue, evidence, urgency, recommended action |

### Templates as Type Collision Resolution

This directly connects to your bidirectional type collision insight. The 17+ distinct information types you identified (claims, evidence, assumptions, options, criteria, actions, questions, connections, constraints, confidence, perspectives, patterns, gaps, tensions, dependencies, outcomes, provenance) were all encoded as a single output type (prose). Templates are the **structural mechanism** that decomposes these types:

```
Instead of:
  "The student discussed Bitcoin's first-mover advantage and mentioned 
   network effects but didn't provide evidence for centralisation claims 
   and the reflection section seems shallow (confidence: medium)"

Template-enforced output:
  CLAIMS:
    - claim: "BTC has first-mover advantage"
      evidence: "Slide 3, cited Nakamoto"
      confidence: 8/10
    - claim: "Network effects drive adoption"  
      evidence: "Slide 5, no citation"
      confidence: 5/10
  GAPS:
    - gap: "Centralisation claims lack evidence"
      type: evidence_gap
      severity: high
  REFLECTION_ASSESSMENT:
    - depth: shallow
    - evidence: "No double-loop learning indicators"
    - confidence: 6/10
```

### Templates as Agent Constraint Mechanisms

Templates also serve as **input-side type collision resolution**. Instead of giving an agent free-form context, templates constrain what the agent receives:

```
Instead of: "Here's everything about this submission [wall of text]"

Template-enforced input:
  SUBMISSION_PACKAGE:
    format_report: {file_type: pptx, slides: 12, sections: [...]}
    claims: [{claim, source, confidence}, ...]
    anomalies: [{type, description, severity}, ...]
    reflection_status: {depth, evidence, confidence}
```

This is the **input-side** equivalent of your output type collision insight. The agent receives typed, structured input — not an undifferentiated context dump.

### Template Design as a CAWDP Step

This needs to be explicit in the process:

**Phase 3, new Step 3.4: Template Architecture**

*For every data flow identified in the pipeline architecture, design the template that structures it.*

How:
1. For each data object in the architecture, ask: *What types of information does this object carry?*
2. Decompose each type into a typed field (not prose)
3. For each field, specify: type (string/number/boolean/array/object), constraints (required/optional, range, format), provenance (which actor produces it)
4. For each template, specify: validation rules (System-enforced), consumers (which actors read it), mutability (append-only/replaceable/immutable)
5. **Stress-test**: Can this template carry the information the consumer needs? Is any information the consumer needs NOT in the template?

**Phase 4 integration:** Every agent job description now includes an Input Template and Output Template as typed schemas — not prose descriptions.

**Phase 6 integration:** Template validation becomes part of MVA testing — does the agent actually produce output conforming to its output template?

---

## ENHANCEMENT 3: Recovering the Missing v0.3 Principles

CAWDP v1 addressed task decomposition, capability allocation, system architecture, agent design, human experience, and validation. But it's missing several principles from your Agent Design Principles v0.3 that should be **cross-cutting concerns** — not phase-specific steps, but questions asked at EVERY phase.

### Cross-Cutting Concern 1: Verification Independence

**Principle:** No agent approves its own work. The separation of executor and verifier is architecture, not policy.

**v0.3 refinement:** Three-level independence scale:
- **Level 1 (Structural):** Different code path verifies — simple rule checks (System can do this)
- **Level 2 (Semantic):** Different agent verifies — another agent checks reasoning (Agent does this)
- **Level 3 (Authority):** Different actor type verifies — human verifies agent output (Human does this)

**How it cuts across CAWDP:**
- Phase 2: Complementarity analysis assigns verification level per subtask based on risk
- Phase 3: Architecture specifies verification chain for each pipeline segment
- Phase 4: Job descriptions specify who verifies this agent and at what level
- Phase 6: Validation tests whether verification independence is actually enforced

**Quality gate addition:** Every gate now asks: *For each agent in this phase's scope, is the verifier structurally separate from the producer?*

### Cross-Cutting Concern 2: Human Enrichment Assessment

**Principle:** The system has two axes of excellence — output fidelity AND epistemic enrichment. Every layer, every phase, must answer both the fidelity question and the enrichment question.

**How it cuts across CAWDP:**
- Phase 1: Does the task decomposition identify what the human learns by doing this task?
- Phase 2: Does the allocation preserve human learning opportunities? (Don't automate away the learning)
- Phase 3: Does the architecture include feedback that develops human capability?
- Phase 4: Does each agent's output include scaffolding that develops understanding?
- Phase 5: Is the human experience designed to leave the human more capable?
- Phase 6: Is human capability measured alongside system accuracy?

**The enrichment fidelity question per phase:**

| Phase | Fidelity Question | Enrichment Question |
|---|---|---|
| 1 | Is the task decomposed correctly? | Does the decomposition reveal what the human would learn? |
| 2 | Are allocations correct? | Do allocations preserve human learning opportunities? |
| 3 | Does the architecture work? | Does the architecture develop human capability? |
| 4 | Are agents specified correctly? | Do agents scaffold rather than replace human judgment? |
| 5 | Is the interface usable? | Does the interface leave the human more capable? |
| 6 | Does the system work? | Is the human more capable after N runs? |

### Cross-Cutting Concern 3: Epistemic Metadata Contracts

**Principle:** Every output carries not just its content but its epistemic metadata — provenance, confidence, limitations, assumptions, alternatives set aside.

**v0.3 formalisation:** Every agent output includes:

| Metadata Field | Purpose | Example |
|---|---|---|
| **Provenance** | Who produced this, when, from what inputs | Claims Analyst, Wave 3, from Submission Package v2 |
| **Confidence** | How certain is the producer | 7/10 — claim is explicit but evidence is indirect |
| **Limitations** | What this output does NOT cover | Did not assess cross-claim consistency |
| **Assumptions** | What the producer assumed | Assumes standard academic citation conventions |
| **Alternatives set aside** | What other interpretations were considered | Alternative: claim is rhetorical, not substantive — set aside due to citation |
| **What would change this** | What new information would change the output | Direct contradiction from another source would reduce confidence to 3/10 |

**How it cuts across CAWDP:**
- Phase 3: Every data object in the architecture includes epistemic metadata fields
- Phase 4: Every agent job description's output template includes epistemic metadata
- Phase 5: Human experience presents epistemic metadata alongside content — humans calibrate trust
- Phase 6: Validation checks whether agents actually produce epistemic metadata

**Connection to templates:** Epistemic metadata is itself a **template** — the Epistemic Metadata Contract is a standard template that every agent output must include. This is enforced by System (schema validation checks for metadata fields).

### Cross-Cutting Concern 4: Information Boundaries

**Principle:** What an agent cannot read should be structurally impossible, not merely discouraged. Information boundaries are infrastructure-enforced.

**v0.3 refinement:** Replace "forbidden reads" (a declarative constraint) with **information boundaries** (an architectural constraint). An agent structurally cannot access information outside its boundary — it's not a prompt instruction, it's a runtime enforcement.

**How it cuts across CAWDP:**
- Phase 2: Complementarity analysis identifies what each actor needs to know AND what they must NOT know
- Phase 3: Architecture specifies information boundaries as System-enforced (context curtains from your trust platform architecture)
- Phase 4: Job descriptions specify information boundary as a structural constraint, not a prompt instruction
- Phase 6: Validation tests whether information boundaries are actually enforced (can the agent access forbidden data through tool calls?)

**This is where System becomes critical:** Information boundaries are enforced by System code, not by agent prompts. The System mediates all data access — agents never read directly from data stores.

### Cross-Cutting Concern 5: Specification Aging

**Principle:** Agent specifications degrade over time. Task drift, model updates, and changing context all erode specification validity. Without explicit aging mechanisms, specifications become silently stale.

**v0.3 formalisation:**
- **Aging triggers:** Model change, task context change, performance degradation, override rate increase
- **Review cadence:** Time-based (quarterly for stable, monthly for new) AND trigger-based (on any aging trigger)
- **Capability drift tracking:** Does the agent's actual performance match its specification? When they diverge, the specification needs updating

**How it cuts across CAWDP:**
- Phase 6 (major impact): Iterative refinement protocol includes specification aging — agents are reviewed not just for performance but for specification relevance
- Phase 4: Job descriptions include a **specification freshness date** and **aging triggers**
- Cross-cutting: Every quality gate asks — *Are the specifications this gate relies on still current?*

### Cross-Cutting Concern 6: Scaffolding Dependency Index

**Principle:** How much human scaffolding does an agent require to perform correctly? High scaffolding dependency = agent is not truly autonomous = hidden human labor cost.

**Formalization:**

| Scaffolding Level | Description | Index Score |
|---|---|---|
| **Full scaffolding** | Agent cannot operate without human-set context, examples, and constraints | 5 |
| **Heavy scaffolding** | Agent needs examples and constraints but can operate once set up | 4 |
| **Moderate scaffolding** | Agent needs constraints but can discover its own approach | 3 |
| **Light scaffolding** | Agent needs goal clarification only | 2 |
| **Autonomous** | Agent operates from specification alone | 1 |

**How it cuts across CAWDP:**
- Phase 2: Scaffolding dependency is a factor in allocation — high dependency agents are more expensive than they appear
- Phase 4: Job descriptions include scaffolding dependency index — this is a hidden cost
- Phase 5: Human experience accounts for scaffolding labor — how much human time is spent setting up agents?
- Phase 6: Validation measures actual scaffolding cost vs. estimated

**The connection to Human Enrichment:** The scaffolding dependency index also applies to the human side — how much scaffolding does the HUMAN need from the system? Progressive human empowerment means the human's scaffolding dependency should DECREASE over time.

### Cross-Cutting Concern 7: Cost Budget

**Principle:** Every agent has a cost budget. The pipeline has a total cost budget. Cost is a first-class design constraint, not an afterthought.

**v0.3 formalisation:**
- **Per-agent cost budget:** Maximum acceptable cost per invocation (token cost + tool cost + infrastructure cost)
- **Pipeline cost budget:** Maximum acceptable cost per unit processed (e.g., per student, per document)
- **Cost-quality trade-off:** Is the marginal cost of adding an agent justified by the marginal quality improvement?
- **Cost monitoring:** Actual cost tracked against budget — overruns trigger review

**How it cuts across CAWDP:**
- Phase 2: Cost is a factor in allocation — System < Agent < Human on cost per unit
- Phase 4: Every job description includes a cost budget
- Phase 5: Human time is costed alongside agent cost
- Phase 6: Validation includes cost tracking — does the pipeline stay within budget?

### Cross-Cutting Concern 8: Assured Audit Trail

**Principle:** Every agent action creates a traceable, attributed, timestamped record. But "immutable" is aspirational — v0.3 replaces it with three assurance levels.

**v0.3 refinement:**
- **Level 1 (Logged):** Action recorded in application log — tamperable by system admin, suitable for debugging
- **Level 2 (Assured):** Action recorded in append-only store — tamper-evident, suitable for compliance
- **Level 3 (Verified):** Action recorded with cryptographic proof — tamper-proof, suitable for legal/financial

**How it cuts across CAWDP:**
- Phase 3: Architecture specifies audit assurance level per agent and per action type
- Phase 4: Job descriptions specify audit level for the agent's actions
- Phase 5: Human experience shows audit trail when the human needs to verify agent reasoning
- Phase 6: Validation tests audit trail completeness and assurance level

---

## FURTHER EXPLORATION: Elements You Haven't Raised (But Should Consider)

These emerge from the design space you've opened up. I've organised them by type.

### A. Runtime & Operational Concerns

**9. Progressive Autonomy**

Agents don't start with full authority. They earn it.

| Autonomy Level | Agent Can | Human Must |
|---|---|---|
| **Shadow mode** | Produce outputs, but none are used | Review all outputs against manual baseline |
| **Advisory mode** | Produce recommendations with full reasoning | Approve before action |
| **Supervised mode** | Act within bounded parameters | Review exceptions and overrides |
| **Autonomous mode** | Act within specification | Review only escalations |

The autonomy level is a function of: (1) accuracy on validation data, (2) override rate, (3) specification stability, (4) consequence severity. Agents handling irreversible actions never exceed supervised mode.

**CAWDP integration:** Phase 4 job descriptions include **initial autonomy level** and **advancement criteria**. Phase 6 validation measures performance against advancement thresholds.

**10. Fallback Model Tiers**

What happens when the primary model is unavailable or degraded?

| Tier | Model | When Used | Cost | Quality |
|---|---|---|---|---|
| **Tier 1** | Primary (e.g., Claude 3.5) | Normal operation | Full | Full |
| **Tier 2** | Secondary (e.g., GPT-4) | Primary unavailable | Full | Near-full |
| **Tier 3** | Local model | API unavailable | Free | Reduced |
| **Tier 4** | System fallback | No model available | Zero | Rules only |

Each agent should have a fallback specification: what does it produce when operating at Tier 3? Does it still meet minimum quality? Does it flag the reduced confidence?

**CAWDP integration:** Phase 4 job descriptions include fallback behavior per tier. Phase 3 architecture specifies which agents can degrade gracefully and which must halt.

**11. Pipeline Health Monitoring**

Your v0.3 principles include two pipeline health metrics (IDS and UPR) that have no home in CAWDP v1:

- **Information Diversity Score (IDS):** How semantically varied are messages between agents? Declining IDS = convergent thinking = pipeline homogenisation risk
- **Unnecessary Path Ratio (UPR):** How much reasoning was wasted? High UPR = over-specified pipeline

These are **leading indicators** — they predict quality degradation before it shows in output accuracy.

**CAWDP integration:** Phase 6 refinement protocol includes IDS and UPR as monitoring metrics. Declining IDS or rising UPR triggers a pipeline review, not just an agent review.

### B. Temporal & Evolutionary Concerns

**12. Temporal Dynamics (Cross-Cutting)**

CAWDP v1 designs the pipeline at a point in time. But pipelines evolve:

| Temporal Concern | Description | CAWDP Phase |
|---|---|---|
| **Specification aging** | Specs become stale | Cross-cutting (CC5) |
| **Model drift** | Model updates change agent behavior | Phase 6 monitoring |
| **Task evolution** | The task itself changes over time | Phase 1 re-validation trigger |
| **Human skill growth** | Humans become more capable (enrichment) | Phase 5 & 6 measurement |
| **Agent capability growth** | Agents improve through pattern extraction | Phase 6 improvement loops |
| **Trust accumulation** | Agents earn trust through verified performance | Progressive Autonomy |

**The key insight:** Temporal dynamics should be a **cross-cutting concern** with explicit review triggers, not just "we'll improve it later."

### C. Security & Trust Concerns

**13. Reversibility Classification**

From your Safety layer: before any action, classify it as:
- **Read-only:** No side effects (safe to retry, safe to automate)
- **Reversible:** Can be undone (automate with logging, human can override)
- **Irreversible:** Cannot be undone (human presence required structurally)

**CAWDP integration:** Phase 2 classifies every subtask's action reversibility. Phase 4 job descriptions include reversibility class. Phase 3 architecture ensures irreversible actions have System-enforced human gates.

**14. Coalition Formation Intelligence**

Your v0.3 ecosystem layer specifies that agents should be composed for **epistemic complementarity**, not just functional role coverage. This is absent from CAWDP v1.

**Example:** Two agents with the same cognitive orientation (both critical, both procedural) will produce convergent outputs. Two agents with complementary orientations (one critical, one optimistic) produce a richer option space.

**CAWDP integration:** Phase 4 agent roster design includes a **cognitive orientation diversity check** — are the agents in this wave composed for epistemic complementarity? Phase 6 monitors IDS as the metric for whether composition is working.

### D. Design Process Concerns

**15. Decomposition Depth Guidance**

CAWDP v1 says "decompose until 1-2 cognitive operations per subtask" but doesn't provide decision criteria for when to stop decomposing. The risk is both under-decomposition (monolith agents) and over-decomposition (trivial agents that cost more than they add).

**Decision framework:**

```
STOP decomposing when:
  ✓ 1-2 cognitive operations per subtask
  ✓ The subtask has a single clear authority boundary
  ✓ A single verification check can validate the output
  ✓ The subtask's output is consumed by ≥1 other actor
  
CONSIDER further decomposition when:
  ⚠ >2 cognitive operations bundled
  ⚠ Authority boundary is ambiguous ("never judge OR interpret")
  ⚠ Verification requires multiple independent checks
  ⚠ Different failure modes within one subtask

ALWAYS decompose when:
  ✗ >3 cognitive operations bundled
  ✗ Agent would need to switch cognitive modes mid-task
  ✗ Different operations have different hallucination risk levels
```

**16. The "Should This Be a Team?" Decision**

Agno gives you three composition primitives: single Agent, Team, Workflow. When does a task need each?

| Primitive | When to Use | Signal |
|---|---|---|
| **Agent** | Single cognitive operation, single authority boundary | One "never" constraint suffices |
| **Team** | Multiple operations need coordination, shared context | Multiple authority boundaries but shared data |
| **Workflow** | Sequential/parallel stages with data handoffs | Different stages have different actor types |

**CAWDP integration:** Phase 3 architecture includes a **composition decision** for each pipeline segment — is this an agent, a team, or a workflow?

---

## The Complete Cross-Cutting Concern Map

Here's every element mapped to where it lives in CAWDP and whether it's a step, a cross-cutting concern, or both:

| # | Element | Type | Primary Phase(s) | Cross-Cutting? |
|---|---|---|---|---|
| 1 | System as Third Actor | Structural change | 2, 3, 4 | ✅ Affects all phases |
| 2 | Template Architecture | New step | 3, 4 | ✅ Templates flow through all phases |
| 3 | Verification Independence | Cross-cutting | All | ✅ |
| 4 | Human Enrichment Assessment | Cross-cutting | All | ✅ |
| 5 | Epistemic Metadata Contracts | Cross-cutting | All | ✅ (enabled by templates) |
| 6 | Information Boundaries | Cross-cutting | 2, 3, 4 | ✅ |
| 7 | Specification Aging | Cross-cutting | 4, 6 | ✅ |
| 8 | Scaffolding Dependency Index | Cross-cutting | 2, 4, 5 | ✅ |
| 9 | Cost Budget | Cross-cutting | 2, 4, 6 | ✅ |
| 10 | Assured Audit Trail | Cross-cutting | 3, 4, 6 | ✅ |
| 11 | Progressive Autonomy | New concept | 4, 6 | ⚠️ Runtime concern |
| 12 | Fallback Model Tiers | New concept | 3, 4 | ⚠️ Operational concern |
| 13 | Pipeline Health Monitoring | New step | 6 | ⚠️ Monitoring concern |
| 14 | Temporal Dynamics | Cross-cutting | All | ✅ |
| 15 | Reversibility Classification | Cross-cutting | 2, 4 | ✅ |
| 16 | Coalition Formation Intelligence | New step | 4 | ⚠️ Agent composition concern |
| 17 | Decomposition Depth Guidance | Enhancement | 1 | ❌ Phase-specific |
| 18 | Composition Decision (Agent/Team/Workflow) | New step | 3 | ❌ Phase-specific |

---

## The Updated Quality Gate Framework

Every quality gate now has **three layers of checks:**

1. **Fidelity checks** (does the system produce correct outputs?)
2. **Enrichment checks** (does the system develop human capability?)
3. **Cross-cutting checks** (are all cross-cutting concerns addressed?)

Example for Gate 4 (Agent Design Complete):

```
FIDELITY CHECKS:
  ☐ Every agent classified in 5-class taxonomy (or identified as System component)
  ☐ Authority boundary = inverse of failure mode
  ☐ Boundary stress tests designed
  ☐ Job descriptions complete
  ☐ Cost-benefit assessment: no unnecessary agents
  ☐ Input/output templates specified as typed schemas

ENRICHMENT CHECKS:
  ☐ Every agent's output scaffolds human understanding, not replaces judgment
  ☐ Human learning opportunities preserved in allocation decisions
  ☐ Scaffolding reduces over time (not permanent dependency)

CROSS-CUTTING CHECKS:
  ☐ Verification independence: every agent has a separate verifier (level specified)
  ☐ Information boundaries: structurally enforced, not prompt-only
  ☐ Epistemic metadata: every output template includes provenance, confidence, limitations
  ☐ Scaffolding dependency index: documented per agent
  ☐ Cost budget: specified per agent and per pipeline unit
  ☐ Audit trail: assurance level specified per agent
  ☐ Specification freshness date and aging triggers documented
  ☐ Reversibility class assigned per agent's actions
  ☐ Progressive autonomy: initial level and advancement criteria specified
  ☐ Fallback behavior: specified for degraded model tiers
```

---

## The Key Insight: CAWDP v2 is a Governance Framework, Not Just a Design Process

CAWDP v1's weakness was clear from the review: **strong on design, weak on validation and human experience.** The three additions you've identified, plus the recovered v0.3 principles, push CAWDP toward something more ambitious:

| Aspect | CAWDP v1 | CAWDP v2 |
|---|---|---|
| **Scope** | Design-time | Lifecycle (design → runtime → evolution) |
| **Actor model** | Binary (Human/Agent) | Ternary (Human/Agent/System) |
| **Output structure** | Prose descriptions | Template-enforced typed schemas |
| **Verification** | Assumed separate | Explicitly specified (3-level independence) |
| **Enrichment** | Not assessed | Assessed at every phase |
| **Boundaries** | Prompt instructions | Infrastructure-enforced (System) |
| **Cost** | Afterthought | First-class budget constraint |
| **Audit** | Assumed immutable | Three assurance levels |
| **Temporal** | Point-in-time | Explicit aging and drift tracking |
| **Autonomy** | Full or nothing | Progressive (earned through evidence) |

The deepest structural change is the **System as third actor**. It transforms CAWDP from a process that designs *agent systems* into a process that designs *human-agent-system societies* — where deterministic code serves as both the mechanical backbone AND the enforcement layer for boundaries, templates, verification, and audit. System is not just efficient — it's the **trust infrastructure** that makes Human-Agent collaboration governable.The three enhancements you've identified, plus the wider exploration, reveal something fundamental: **CAWDP v1 designed agents. CAWDP v2 governs a society of actors.**

The single most structurally significant change is the **System as third actor**. It does three things simultaneously:

1. **Efficiency** — stops using LLMs for deterministic work (schema validation, routing, formula application)
2. **Reliability** — introduces a hallucination-free actor class that serves as the pipeline's immune system
3. **Enforceability** — makes every boundary, template, and verification check structurally enforced rather than prompt-instructed

The second most significant is **templates as the type collision mechanism** — they're the concrete answer to the bidirectional type collision problem you identified. Input templates resolve input-side type collision. Output templates resolve output-side type collision. Handoff templates resolve inter-agent type collision. Without templates, all your carefully designed typed schemas collapse back into prose at runtime.

And the eight cross-cutting concerns from v0.3 transform CAWDP from a *process you run once* into a *governance framework you live inside*. Every quality gate now asks not just "does it work?" but "does it work AND does it leave the human more capable AND are all the structural guarantees in place?"

For Future's Edge, the teachable extract from this round is: **ternary allocation, template-enforced outputs, and cross-cutting quality gates** are three design principles that generalise beyond any specific framework.