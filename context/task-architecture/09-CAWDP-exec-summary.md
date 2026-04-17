# CAWDP v0.2 — Executive Summary

## Complementarity-Driven Agentic Workflow Design Process

---

### The Problem

Most agentic systems are designed by asking "what can the AI do?" and then building around that. This produces systems that are technically impressive but structurally flawed — agents that hallucinate in roles they shouldn't hold, humans reduced to rubber-stamping machine outputs, and pipelines that fail silently when individual agents produce bad outputs.

The root causes are consistent: the wrong actor does the wrong task, outputs are undifferentiated walls of text, verification is aspirational rather than structural, and the human ends up less capable, not more.

### What CAWDP Is

CAWDP is a six-phase governance framework that designs agentic systems around a different question: **who should do what, and how do we know it's right?** It produces implementation-ready specifications for human-agent-system collaboration where every actor's role, boundary, and verification is explicit, testable, and structurally enforced.

### The Core Principle

> **The agent prepares judgment. The human makes judgment. The system enforces boundaries.**

Each actor has a distinct role:

| Actor | Role | Hallucination Risk | Cost |
|---|---|---|---|
| **Human** | Ethical judgment, creative discovery, accountability | None | High |
| **Agent** | Semantic reasoning, pattern detection, parallel analysis | Moderate-High | Moderate |
| **System** | Deterministic transformation, validation, routing, enforcement | Zero | Near-zero |

System gets first refusal on any subtask — if it can be expressed as a deterministic rule, it should be. This removes an entire failure mode category from the pipeline.

### The Six Phases

```
Phase 1 → TASK INTELLIGENCE
            Decompose the task. Classify cognitive operations.
            Identify what type of thinking each step requires.

Phase 2 → CAPABILITY ALLOCATION
            Score each subtask across 15 capability dimensions for H/A/S.
            Allocate using the complementarity algorithm.
            (Optional) Phase 2.5: Event Storm for multi-agent workflows.

Phase 3 → SYSTEM ARCHITECTURE
            Design the pipeline, data flows, templates, and failure recovery.
            Every data object has a typed schema. Every failure mode has a recovery path.

Phase 4 → AGENT DESIGN
            Classify agents. Set authority boundaries (the inverse of failure modes).
            Write job descriptions precise enough for implementation.
            Stress-test every boundary with adversarial inputs.

Phase 5 → HUMAN EXPERIENCE DESIGN
            Budget cognitive load. Design decision interfaces.
            Ensure every interaction expands the human's creative freedom.

Phase 6 → VALIDATION & ITERATION
            Run the tests that were designed alongside every phase.
            Deploy agents progressively (shadow → advisory → supervised → autonomous).
            Monitor pipeline health. Refine specifications as they age.
```

### What Makes It Different

**Three actors, not two.** System handles everything deterministic — validation, routing, calculation, enforcement. This is cheaper, faster, and more reliable than assigning mechanical work to an LLM.

**Templates, not prose.** Every data flow uses typed, structured templates. This resolves the type collision problem where 17+ distinct information types get compressed into undifferentiated text. Templates are the engineering solution to a communications problem.

**Boundaries are structural.** "Don't interpret" is a prompt instruction that fails under pressure. "The agent structurally cannot access interpretive tools" is architecture. Information boundaries, verification independence, and audit trails are enforced by System code, not by prompts.

**Testing runs alongside design.** Every design decision generates a test. Test plans are created in Phase 1, not Phase 6. Quality gates include test readiness checks. Validation is concurrent with design, not sequential.

**Enrichment is measurable.** The System Empowerment Index (Constraining → Informing → Enabling → Amplifying → Liberating) measures whether the system expands or contracts human creative freedom. The goal is not independence from the system — it's achieving more through the system than was possible without it.

### What It Produces

A complete, traceable specification chain from task analysis to deployment:

```
Task Decomposition Map
  → Complementarity Matrix (H/A/S scores, model-specific)
    → Event Storm Map (if multi-agent)
      → System Architecture Document
        → Template Architecture (7 typed template types)
          → Agent Job Descriptions (with authority boundaries, stress tests)
            → Human Experience Specification (with SEI assessment)
              → Test Plans (one per phase)
                → Validation Report
                  → Progressive Autonomy Plan
```

Every specification traces back to a design decision. Every design decision traces back to evidence. Every quality gate checks both fidelity (does it work?) and enrichment (does it expand human freedom?).

### Eight Cross-Cutting Concerns

Every phase is governed by eight concerns that appear at every quality gate:

| # | Concern | One-Line Summary |
|---|---|---|
| CC-1 | Verification Independence | No agent approves its own work. Three independence levels. |
| CC-2 | Human Enrichment | Every phase asks: does this expand creative freedom? |
| CC-3 | Epistemic Metadata | Every output carries provenance, confidence, limitations, assumptions, alternatives, and what would change it. |
| CC-4 | Information Boundaries | Structurally enforced, not prompt-instructed. |
| CC-5 | Specification Aging | Specs degrade. Freshness dates and aging triggers. |
| CC-6 | System Empowerment Index | Measuring Constraining → Liberating, not dependent → independent. |
| CC-7 | Cost Budget | Cost is a first-class design constraint. |
| CC-8 | Assured Audit Trail | Three assurance levels matching trust requirements. |

### Five Quality Gates

Each gate has three layers of checks: fidelity (does it work?), enrichment (does it expand freedom?), and cross-cutting (are all structural guarantees in place?). No phase proceeds until its gate passes.

### When to Use It

| Task Complexity | Phases | Example |
|---|---|---|
| Single-agent, no human loop | 1 → 2 → 4 | Data extraction, summarisation |
| Single-agent + human review | 1 → 2 → 4 → 5 | Draft generation with sign-off |
| Multi-agent, linear pipeline | 1 → 2 → 3 → 4 → 5 | Sequential processing |
| Multi-agent, branching + human decisions | 1 → 2 → 2.5 → 3 → 4 → 5 → 6 | Complex workflows with failure recovery |

### The Bottom Line

CAWDP produces agentic systems where:
- **The right actor does the right task** — System handles the deterministic, Agent handles the semantic, Human handles the creative
- **Boundaries are structural, not declarative** — the system enforces what agents cannot do
- **Every output carries its epistemic metadata** — provenance, confidence, limitations are never optional
- **Testing is concurrent with design** — no phase passes without test readiness
- **The human ends up more free, not less** — the system amplifies creative capability, it doesn't replace it