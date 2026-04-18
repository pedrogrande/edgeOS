# Agentic System — Agent Specification Template

*Companion to the HUMAN Framework Agentic System Design Template and System Architecture Template*
*Complete one copy of this document for every agent in the system. Every answer must be traceable to the System Architecture Document and, through it, to the Design Document.*

## How to Use This Template

1. **Complete one document per agent** — specifications are never shared between agents, even if two agents seem similar.
2. **Start with Purpose and Identity** — do not write acceptance criteria before the agent's role and cognitive orientation are settled.
3. **Distinguish capability from policy** — where a question asks what the agent can or cannot do, the answer must describe infrastructure-level constraints, not prompt instructions.
4. **Every blank is a risk** — an unanswered question in this document is a known failure mode being knowingly deferred to production.
5. **This document is the input to the agent's system prompt, tool configuration, context card, and test suite** — all four derive from answers here, nothing else.

***

## Agent Identity Card

*Complete this summary block before filling out any section below. If you cannot complete it, the agent is not ready to be specified.*


| Field | Value |
| :-- | :-- |
| **Agent Name** |  |
| **Role Archetype** | *(Executor / Reviewer / Orchestrator / Synthesiser / Articulation Agent / Exploration Agent)* |
| **Cognitive Orientation** | *(Critical / Optimistic / Creative / Factual / Procedural / Synthesising)* |
| **Autonomy Mode (default)** | *(Agent-autonomous / Agent-recommended / Human-led)* |
| **Primary Output Type** |  |
| **Executor or Verifier?** | *(Never both for the same output)* |
| **Structurally Separate Verifier** | *(Name the agent or human role that verifies this agent's output)* |
| **Underlying Model** |  |
| **Version** |  |
| **Last Reviewed** |  |


***

## Layer 1 — Purpose

*Why does this agent exist? Every subsequent design decision is tested against these answers.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **1.1 — Human Need** | What specific human need does this agent serve — not the task it performs, but the underlying need? |  |
|  | What would the human have to do themselves if this agent did not exist? |  |
|  | What does the human gain in capability, understanding, or perspective from this agent's work — beyond the output itself? |  |
|  | What would a technically correct output from this agent look like that nonetheless failed the human's actual need? |  |
| **1.2 — Amplification Intent** | What human capability should grow as a result of this agent's work over time? |  |
|  | What must this agent never do — because doing it would create dependency rather than growth? |  |
|  | How will you detect whether this agent is amplifying the human or substituting for them? |  |
| **1.3 — Complementarity Boundary** | What does this agent do that a human cannot do as well at scale — and should therefore do? |  |
|  | What must remain human — regardless of this agent's capability — and why? |  |
|  | If efficiency and human enrichment conflict, which wins — and how is that enforced? |  |
| **1.4 — Success Definition** | What does a successful output from this agent look like — in the human's terms, not system metrics? |  |
|  | What does failure look like — including the failure mode where the output is technically correct but purposively wrong? |  |
|  | Who evaluates whether this agent is succeeding — and how often? |  |


***

## Layer 2 — Identity

*What is this agent — its role, orientation, and fixed properties.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **2.1 — Role Archetype** | What is the agent's role archetype — and what does that archetype structurally prevent it from doing? |  |
|  | If the archetype is Executor: what does it produce, and what must it never evaluate or verify? |  |
|  | If the archetype is Reviewer: what does it verify against, and what must it never produce or modify? |  |
|  | If the archetype is Orchestrator: what does it route or coordinate, and what decisions does it make versus delegate? |  |
|  | If the archetype is Articulation or Exploration Agent: when is it deployed, and what prevents its output from being treated as a decision rather than a prompt? |  |
| **2.2 — Cognitive Orientation** | What is this agent's cognitive orientation — and why is that orientation appropriate for its role? |  |
|  | What kinds of outputs does this orientation produce that a different orientation would not? |  |
|  | What blind spots does this orientation introduce — and how are those compensated for elsewhere in the system? |  |
|  | Is this orientation fixed — or does it shift depending on task type? If it shifts, how is the shift governed? |  |
| **2.3 — Theory of Mind** | Does this agent operate in a multi-agent pipeline where it receives output from another agent? |  |
|  | What upstream epistemic context does it receive — not just outputs, but confidence levels, assumptions made, and alternatives discarded? |  |
|  | How does this agent communicate its own uncertainty, confidence, and reasoning to downstream agents or humans? |  |
|  | How does this agent calibrate how much to trust upstream input — and is that calibration tracked over time? |  |
| **2.4 — Model Selection** | Which underlying model is selected for this agent — and why is it appropriate for this role? |  |
|  | What temperature and sampling parameters are set — and what reasoning justifies those values for this agent's task type? |  |
|  | How will model drift be detected if the provider silently updates the underlying model? |  |
|  | Is fine-tuning applied — and if so, on what data and for what quality improvement? |  |


***

## Layer 3 — Specification

*What does done look like — defined before work begins, not after.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **3.1 — Output Definition** | What exactly does this agent produce — in terms of format, structure, and content? |  |
|  | What is the proof template for this agent's output — the structured evidence document that constitutes completion? |  |
|  | What specific evidence must the proof template contain — not assertions, but traceable evidence mapped to criteria? |  |
|  | Who receives the output — and what do they do with it next? |  |
| **3.2 — Acceptance Criteria** | What are the pre-defined acceptance criteria for this agent's output — defined before work begins? |  |
|  | Is each criterion independently verifiable — can a verifier determine pass or fail without asking the agent? |  |
|  | Which criteria are binary pass/fail — and which require a confidence tier or graduated assessment? |  |
|  | Who defined the acceptance criteria — and is that definition itself versioned and auditable? |  |
| **3.3 — Explore Before Execute** | Before acceptance criteria are written for a given task, is there an exploration phase where the problem framing is questioned? |  |
|  | What alternative approaches were considered before committing to the current output format and criteria? |  |
|  | Are discarded alternatives recorded — so there is evidence that the current approach was chosen, not defaulted into? |  |
|  | What is the lightest-weight version of this agent's output that tests core assumptions before full execution? |  |
| **3.4 — Problem Before Solution** | Is the problem this agent is solving clearly defined and validated before the agent begins work? |  |
|  | How is the problem statement communicated to the agent at task initiation — and is it specific enough to constrain output? |  |
|  | What would solving the wrong problem look like for this agent — and how would that be detected? |  |


***

## Layer 4 — Context

*What does this agent know — and when does it know it.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **4.1 — Context Card** | What information is in this agent's context card at task start — the fixed, always-present context? |  |
|  | Is this the minimum sufficient context — or has anything been included out of habit or caution? |  |
|  | For every item in the context card: what fails if it is removed? |  |
|  | How is the context card maintained and versioned — and who is responsible for keeping it current? |  |
| **4.2 — On-Demand Knowledge** | What information does this agent retrieve from the knowledge base during a task — rather than receiving upfront? |  |
|  | What query interface does the agent use to retrieve on-demand knowledge — and is retrieval itself logged? |  |
|  | How does the agent know when to query rather than proceed on existing context? |  |
|  | How is retrieved knowledge validated before the agent acts on it — particularly if the knowledge base could be stale or poisoned? |  |
| **4.3 — Forbidden Reads** | What is this agent explicitly forbidden to read — and how is that enforced? |  |
|  | Are there documents, databases, or outputs from other agents that this agent must never load — even if they are technically accessible? |  |
|  | How does the system detect if a forbidden read occurs — accidentally or through prompt injection? |  |
| **4.4 — Lifecycle State Awareness** | Does this agent need to know what phase of the workflow it is operating in — exploration, specification, execution, verification? |  |
|  | How is lifecycle state communicated to the agent at task initiation? |  |
|  | What actions are structurally prevented at each lifecycle state — so the agent cannot act out of order? |  |
| **4.5 — Progressive Loading** | Is any part of this agent's context loaded progressively — on demand via skills — rather than at startup? |  |
|  | What skills or instruction packages can be loaded by this agent during a task — and what triggers their loading? |  |
|  | How does progressive loading interact with the agent's context budget — and is there a limit? |  |


***

## Layer 5 — Trust

*How does this agent's output become trustworthy.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **5.1 — Verification Structure** | Who or what verifies this agent's output — and are they structurally prevented from being the same agent that produced it? |  |
|  | Does the verifier receive only the output and the proof template — or also the agent's reasoning chain? |  |
|  | What specific evidence in the proof document does the verifier check against each acceptance criterion? |  |
|  | What does the verifier produce as their output — a pass/fail record, a structured failure report, or a belief revision proposal? |  |
| **5.2 — Proof Document** | What is the exact structure of the proof document this agent produces? |  |
|  | How does the proof document map evidence to criteria — field by field, not as a general assertion? |  |
|  | Where is the proof document stored — and is it linked immutably to the specific output version it certifies? |  |
|  | Can this agent's output be accepted, forwarded, or acted upon without a complete proof document? How is this prevented? |  |
| **5.3 — Belief Revision Protocol** | When a verifier disagrees with this agent's output, is there a structured mechanism for the verifier to propose a specific revision with justification? |  |
|  | Can this agent respond to or defer a proposed revision — with that exchange recorded in the audit trail? |  |
|  | How does the belief revision process improve the pipeline's reasoning over time — not just verify individual outputs? |  |
| **5.4 — Audit Trail** | What does a complete audit entry look like for one action taken by this agent — what fields does it contain? |  |
|  | Is every tool call by this agent logged — including failed calls, rejected calls, and uncertainty raises? |  |
|  | Is the audit entry written by the tool itself — not by the agent, which could suppress or modify it? |  |
|  | How long is this agent's audit trail retained — and what triggers archival? |  |


***

## Layer 6 — Safety

*What happens when things go wrong — designed in advance, not discovered in production.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **6.1 — Uncertainty Conditions** | What specific conditions must cause this agent to halt execution and surface uncertainty immediately? |  |
|  | When uncertainty is surfaced, what state does the work item move to — and who is notified? |  |
|  | How is surfacing uncertainty treated in this system — as correct behaviour, not as agent failure? |  |
|  | What information must the agent include when surfacing uncertainty — condition encountered, why it is unresolvable, relevant context? |  |
| **6.2 — Fail-Safe Defaults** | When this agent encounters an unknown condition, loses state, or cannot complete its task — what does it default to? |  |
|  | Is the default always "stop and signal" — or are there conditions where proceeding with reduced confidence is permitted? |  |
|  | How does the agent notify the human when a fail-safe is triggered — and what information do they receive? |  |
|  | Are fail-safe events logged distinctly from normal operation events in the audit trail? |  |
| **6.3 — Reversibility Classification** | For every action this agent can take, is it classified as read-only, reversible, or irreversible? |  |
|  | How is the reversibility classification enforced — at the infrastructure level, not by prompt instruction? |  |
|  | Which of this agent's actions are irreversible — and are those gated behind human presence structurally? |  |
|  | How is a new action class classified when it is added to this agent's capability set? |  |
| **6.4 — Prompt Injection Defence** | What external content does this agent read — documents, tool outputs, retrieved data, other agents' outputs? |  |
|  | For each content type: how does the agent's trust model differentiate between authoritative instructions and potentially malicious embedded content? |  |
|  | What structural defences prevent injected instructions in retrieved content from overriding this agent's directive? |  |
|  | How are prompt injection attempts detected and logged — so they surface as signals rather than silent failures? |  |
| **6.5 — Capability-Alignment Independence** | What mechanisms test that this agent is aligned with the principal's intent — not just capable of producing correct outputs? |  |
|  | Under what conditions might this agent produce technically correct outputs while working against the intent behind the task? |  |
|  | How is the agent's alignment monitored over time — not just evaluated at deployment? |  |


***

## Layer 7 — Ecosystem

*What surrounds this agent — tools, humans, other agents, and infrastructure.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **7.1 — Tool Inventory** | What is the complete list of tools this agent holds? |  |
|  | For each tool: what specific task does it enable — and what would fail if it were removed? |  |
|  | For each tool: is it read-only, write, or executable — and is its reversibility classification defined? |  |
|  | What is the attack surface introduced by each tool — and how is it mitigated? |  |
| **7.2 — Forbidden Tools** | What tools and capabilities must this agent never hold — regardless of task demands? |  |
|  | For each forbidden tool: how is the prohibition enforced at the infrastructure level? |  |
|  | Which prohibitions are currently enforced only by policy — and what is the plan to make them structural? |  |
|  | How would an accidental grant of a forbidden tool be detected and remediated? |  |
| **7.3 — Human-in-the-Loop Placement** | At what points in this agent's workflow does a human appear — and what are they genuinely deciding? |  |
|  | Is the human placed at irreversible decision thresholds — not just at task completion for rubber-stamp approval? |  |
|  | What context does the human receive when a handoff occurs — enough for a genuine judgment, not just approve/reject? |  |
|  | How does the system prevent approval fatigue for human touchpoints associated with this agent? |  |
| **7.4 — Multi-Agent Position** | Where does this agent sit in the pipeline — what comes upstream, what comes downstream? |  |
|  | What does this agent trust from upstream — and what does it verify independently? |  |
|  | What guarantee does this agent provide to downstream agents about the quality and confidence of its output? |  |
|  | How does this agent's position affect its failure mode — and what happens downstream if this agent fails? |  |
| **7.5 — Infrastructure Assumptions** | What does this agent assume about infrastructure reliability — and what happens when those assumptions are violated? |  |
|  | How does this agent behave when a tool is unavailable, an API rate-limits, or a model call times out? |  |
|  | Are retry logic, circuit breakers, and graceful degradation paths defined for this agent? |  |
|  | What is the maximum acceptable latency for this agent's output — and what happens if it is exceeded? |  |


***

## Layer 8 — Improvement

*How does this agent get better over time.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **8.1 — Performance Metrics** | What metrics define this agent's performance — beyond output quality? |  |
|  | Which efficiency metrics are tracked per task: token count, latency, step count, rework rate, uncertainty rate? |  |
|  | What are the baseline values for each metric — and what constitutes an anomaly requiring investigation? |  |
|  | How are anomalies in efficiency metrics surfaced — to whom, and on what timescale? |  |
| **8.2 — Pattern Contribution** | When this agent succeeds, what pattern contributed — and how is that recorded in the pattern library? |  |
|  | When this agent fails or triggers rework, what pattern failed — and how is that recorded? |  |
|  | How does this agent consult the pattern library before beginning work — and is that consultation itself logged? |  |
|  | How are patterns with consistently poor outcomes retired — and who is responsible for that decision? |  |
| **8.3 — Specification Quality Feedback** | When rework is required on this agent's output, is the root cause traced — to specification ambiguity, missing exploration, skipped validation, or execution failure? |  |
|  | How does specification quality improve over time — based on rework patterns? |  |
|  | Who reviews specification quality for this agent — and on what cadence? |  |
| **8.4 — Retrospective Discipline** | How does this agent's performance get reviewed — in a structured retrospective, not just when something breaks? |  |
|  | What retrospective outputs are produced — and do they feed back into the pattern library and context card? |  |
|  | How often is this agent's specification reviewed and updated — and what triggers an out-of-cycle review? |  |


***

## Layer 9 — Human Enrichment

*Does every interaction leave the human more capable — this layer is the second axis of excellence.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **9.1 — Perspective Multiplication** | Before the human commits to a direction, does this agent surface multiple cognitive orientations or options — not just the most likely answer? |  |
|  | How does this agent present options in a way that expands rather than collapses the human's thinking? |  |
|  | What design patterns prevent this agent from presenting pre-digested conclusions rather than a richer option space? |  |
| **9.2 — Cognitive Mirroring** | Does this agent surface its own framing, reasoning, and assumptions — so the human can interrogate them rather than inherit them? |  |
|  | How is the agent's reasoning made visible to the human — at what level of detail, and at what moment? |  |
|  | How does the human build on the agent's reasoning rather than simply accepting it? |  |
| **9.3 — Scaffolding \& Withdrawal** | At what level of human capability does this agent currently operate — and what is it doing for the human that the human cannot yet do alone? |  |
|  | How does this agent deliberately withdraw support as the human's capability grows? |  |
|  | What would "making itself less necessary for this task" look like concretely for this agent? |  |
|  | Are there tasks where scaffolding is never appropriate for this agent — where human capability must be preserved regardless? |  |
| **9.4 — Tacit Knowledge Activation** | Does this agent create productive friction that externalises what the human already knows but hasn't yet articulated? |  |
|  | What prompts, questions, or structured outputs does this agent produce that activate the human's own knowledge — rather than supplying knowledge the human lacks? |  |
|  | How does this agent distinguish between tasks where it should supply knowledge and tasks where it should surface the human's existing knowledge? |  |
| **9.5 — Enrichment Measurement** | How will you know, after six months, whether interactions with this agent have left humans more capable — not just better served? |  |
|  | What proxy signals indicate that enrichment is occurring — and what signals indicate dependency formation? |  |
|  | Who reviews enrichment signals — and what authority do they have to recalibrate the agent's scaffolding approach? |  |


***

## Agent Readiness Checklist

*This checklist is completed by the agent designer before the specification is handed to the implementation team. Every item must be resolved.*


| Check | Question | Status |
| :-- | :-- | :-- |
| **Purpose** | Can this agent's existence be justified by a specific, named human need — not just a task? |  |
| **Role Archetype** | Is the role archetype defined — and does it structurally prevent this agent from being both executor and verifier? |  |
| **Cognitive Orientation** | Is the cognitive orientation defined — and is it appropriate for the role? |  |
| **No Self-Judgment** | Is the structurally separate verifier named — and is the separation enforced by architecture? |  |
| **Tool Inventory** | Is the tool inventory complete — including explicitly forbidden tools? |  |
| **Acceptance Criteria** | Are acceptance criteria defined before work begins — and is each criterion independently verifiable? |  |
| **Proof Template** | Is the proof template defined — with specific evidence fields, not general assertions? |  |
| **Uncertainty Conditions** | Are specific uncertainty conditions defined — with named halt states and escalation paths? |  |
| **Autonomy Mode** | Is the autonomy mode defined per action class — before deployment, not at runtime? |  |
| **Context Card** | Is the context card minimum sufficient — with every item justified by a specific failure if removed? |  |
| **Fail-Safe Defaults** | Is the fail-safe default defined — and is it always "stop and signal"? |  |
| **Reversibility** | Is every action classified as read-only, reversible, or irreversible — with irreversible actions gated behind human presence? |  |
| **Prompt Injection Defence** | Is the trust model for external content defined — structurally, not by prompt instruction? |  |
| **Performance Metrics** | Are performance metrics and anomaly thresholds defined? |  |
| **Enrichment** | Are enrichment signals defined — so human capability growth can be measured alongside output quality? |  |
| **Master Test** | Can every output be verified, attributed, and audited — AND does every interaction leave the human more capable, more aware, and more connected? |  |
