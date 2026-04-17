# Agent design principles draft v0.1

---

## The Core Premise

Before any design decision, two commitments need to be made explicit:

1. **Trustworthiness comes from structure, not identity.** An agent is trusted not because of what it is, but because of how it was built, constrained, and verified. Every element of the framework should enforce this structurally, not declaratively.

2. **Performance is a system property, not an agent property.** Excellence emerges from the relationship between the agent, its specification, its tools, its verifiers, its ecosystem, and its improvement loops. No single layer is sufficient alone.

---

## Layer 1: Purpose

*Why does this agent exist?*

This layer is answered before anything else. Every subsequent design decision should be traceable back to it.

* **Human intent** — what human need does this agent serve? A technically correct agent that causes harm, concentrates power, or diminishes human agency has failed regardless of its output quality

* **Goal, not just task** — what is the agent trying to achieve, not just what is it being asked to do? Without goal clarity, the agent cannot recognise when completing the task would undermine the purpose (commander's intent)

* **Success in human terms** — what does a good outcome look like to the person who asked for this work? This is distinct from the acceptance criteria and must be defined first

* **Complementarity boundary** — what should this agent do, and what must remain human? Agents handle the consistent, parallelisable, and precisely specifiable; humans handle the ethical, irreversible, and genuinely novel. This boundary is drawn explicitly, not discovered at runtime

---

## Layer 2: Identity

*What is this agent?*

* **Role archetype** — is this agent an executor, a reviewer, an orchestrator, or a synthesiser? These are not interchangeable. An agent that holds both executor and reviewer roles for the same work produces unverifiable output

* **Cognitive orientation** — does this agent approach problems critically, optimistically, creatively, factually, procedurally, or as a synthesiser of other perspectives? A single orientation applied to every problem is a design flaw. Multi-agent systems should deliberately compose complementary orientations

* **Capability boundary** — what tools does this agent structurally hold? Tools are not descriptions of capability; they are capability. What this agent cannot do should be structurally impossible, not merely discouraged

* **Model selection** — which underlying model is appropriate for this agent's role? Heavy reasoning models for complex judgment; lighter models for routing, classification, and structure. Temperature and sampling parameters are design decisions, not defaults

* **Scope** — what is explicitly out of scope? The boundary between in-scope and out-of-scope must be as precise as the task definition itself. Scope overreach is almost always caused by an underspecified boundary, not a malicious agent

---

## Layer 3: Specification

*What does done look like?*

This is the highest-leverage layer. The quality of a specification determines the quality of the output more than any property of the agent.

* **Definition precedes execution** — the acceptance criteria must be complete, reviewed, and locked before work begins. Criteria written after the fact describe what was built, not what was needed

* **Proof template** — what evidence specifically constitutes completion? Not "the task is done" but "these criteria are met, as evidenced by these artefacts." The proof template is the contract

* **Verifiability test** — if you cannot tell whether an output passes or fails the acceptance criteria without asking the agent, the criteria are ambiguous. Ambiguity in a specification is a bug

* **Problem before solution** — what is the validated problem being solved? Discovery is a distinct phase. No specification should exist without a validated understanding of the problem it is responding to

* **Prototype before scale** — for high-stakes or novel work, what is the minimum viable version that tests the core assumption? Execution failure is expensive; validation failure is cheap

---

## Layer 4: Context

*What does the agent know, and when?*

* **Minimum sufficient context** — what is the minimum information this agent needs to perform its task? More context degrades performance. Every additional element competes for the same finite attention

* **What it reads vs. what it queries** — what is provided upfront in a context card, and what does the agent retrieve on demand from a knowledge base? These are not the same thing. Context is local and task-specific; knowledge is global and queryable

* **What it is explicitly forbidden to read** — because if the agent can reach a document, it may load it. Forbidden reads are as important to specify as required reads

* **Lifecycle state** — what phase is the work in? An agent needs to know whether it is in discovery, ideation, specification, execution, or verification — because the right actions differ at each stage. Lifecycle awareness prevents out-of-order operations

* **Progressive disclosure** — what context is loaded at task start vs. loaded on demand via skills? Skill files contain substantive guidance; base agent files contain only identity, tools, and pointers. This separation enables caching and keeps always-on context small

---

## Layer 5: Trust

*How do outputs become trustworthy?*

* **Independent verification** — who verifies this agent's work, and are they structurally prevented from being the same agent that produced it? The separation is not policy; it is architecture. An executor cannot hold the verify tool for its own output

* **Proof as product** — the deliverable is not the work; it is the verified evidence that the work meets the specification. A proof document is a first-class artefact: structured, attributed, and permanent

* **Immutable audit trail** — every tool call, document read, state transition, and uncertainty raise creates an immutable, attributed, timestamped record. Transparency is not a feature; it is the precondition for accountability. The audit log cannot be suppressed or retroactively edited

* **Chain of custody** — given any output, it must be possible to trace backwards through every action that contributed to it. Provenance is not an afterthought; it is designed in from the start

* **Resilience through structure** — the system must produce trustworthy outputs even when individual agents fail, hallucinate, or act in bad faith. No single actor — agent or human — should be a single point of failure. Distributed verification, quorum thresholds, and graceful degradation are structural requirements

---

## Layer 6: Safety

*What happens when things go wrong?*

This layer is derived entirely from the fields with zero tolerance for failure — aviation, nuclear engineering, medicine, and law.

* **Fail-safe defaults** — when an agent encounters an unknown condition, loss of state, or unresolvable uncertainty, what does it default to? The answer is always: stop and signal. Never: proceed and guess

* **Uncertainty as a structural primitive** — raising uncertainty is not a failure; it is correct behaviour. Any agent must be able to surface uncertainty immediately, without social cost or penalty. Uncertainty halts execution and creates a priority signal to human attention

* **Reversibility classification** — before any action is taken, what class is it? Read-only, reversible, or irreversible? Irreversible actions require human presence structurally, not as a bypassable gate. The distinction between "send an email" and "query a database" is not currently native to any tool framework — it must be designed in explicitly

* **Prompt injection defence** — every piece of content an agent reads is a potential attack surface. Malicious instructions can be embedded in documents, emails, and tool outputs. The agent's trust model for inputs must be explicit

* **Capability and alignment are independent** — a highly capable agent can be simultaneously excellent at its task and misaligned with the intent behind it. Alignment cannot be assumed from capability. It must be tested, monitored, and structurally constrained

---

## Layer 7: Ecosystem

*What surrounds this agent?*

* **Tool selection and permission scoping** — which tools does this agent need? Tools are not features to be added; each one extends the attack surface and the range of possible unintended actions. The minimum sufficient toolset is the correct toolset

* **Human-in-the-loop placement** — where in the workflow do humans appear, and what are they actually deciding? Humans placed too early create bottlenecks; placed too late, they can only accept or reject outcomes. The right placement is at irreversible decision thresholds, with enough context to make a genuine judgment

* **Multi-agent topology** — if this agent operates within a multi-agent system, what is its position in the pipeline? What does it trust from upstream agents? What guarantee does it provide to downstream ones? Agent-to-agent trust is currently ad hoc — it must be designed explicitly

* **Observability** — can every step this agent takes be inspected, replayed, and diagnosed? Observability is not a developer convenience; it is the aviation black box. It exists not for real-time use but for post-incident accountability and learning

* **Infrastructure assumptions** — what happens when a tool is unavailable, an API rate-limits, or a model call times out? The agent's behaviour under infrastructure failure must be defined, not discovered in production

---

## Layer 8: Improvement

*How does this agent get better over time?*

* **Pattern extraction** — when this agent succeeds, what pattern contributed? When it fails, what pattern failed? Both outcomes should feed a structured, queryable pattern library — not a post-mortem document, but a living knowledge base that agents consult before beginning work

* **Knowledge compounds** — every task the agent completes makes the system smarter, if the learning is captured. Early patterns have low confidence because they have limited evidence. As they are applied and validated, confidence grows. Patterns that consistently underperform are retired

* **Performance measurement** — what metrics define this agent's performance? Not just output quality, but token efficiency, step count, rework rate, uncertainty rate, and lifecycle cost. Anomalies in any metric are diagnostic signals, not acceptable noise

* **Retrospective discipline** — performance does not improve automatically. It requires structured retrospectives that extract patterns and update the knowledge base. An agent system treated as a deployment rather than a continuous improvement cycle will plateau and degrade

* **Specification quality as a metric** — how often do tasks built on this agent's outputs require rework? High rework rates are not output failures; they are specification failures upstream. The framework should trace rework back to its root cause: ambiguous acceptance criteria, missing discovery, skipped validation

---

## The Framework as a Set of Questions

Every element above collapses into a question that must be answered before an agent is deployed. The unanswered questions are the gaps:

| Layer | The design question |
| :---- | :---- |
| Purpose | Why does this agent exist, and what human need does it serve? |
| Identity | What is this agent's role, orientation, and capability boundary? |
| Specification | What does done look like, and can it be independently verified? |
| Context | What is the minimum information this agent needs, and when? |
| Trust | Who verifies this work, and how is that separation enforced? |
| Safety | What are the fail-safe defaults, and where are the human gates? |
| Ecosystem | What surrounds this agent, and how does it interact with humans and other agents? |
| Improvement | How do outcomes feed back into making the system smarter? |

An agent design that answers all eight questions is structurally sound. An agent design that answers seven has one guaranteed failure mode — and it will surface exactly where the unanswered question lives.  
