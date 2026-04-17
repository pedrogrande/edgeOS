# Agent Design Principles v0.2

## Why do we need principles for agent design?

As agents become more capable and more widely deployed, the risk of failure modes that are not just wrong but harmful grows. The same properties that make agents powerful — autonomy, scalability, and generality — also make them unpredictable and difficult to control. Without a principled framework for design, we risk building systems that are brittle, opaque, and misaligned with human values. 

The goal of this framework is to provide a structured approach to agent design that prioritises trustworthiness, safety, and human enrichment alongside performance. It is not a checklist of best practices; it is a set of design commitments that, when taken together, create a system that is not just competent but excellent.

## The Core Premise

Before any design decision, three commitments need to be made explicit:

1. **Trustworthiness comes from structure, not identity.** An agent is trusted not because of what it is, but because of how it was built, constrained, and verified. Every element of the framework should enforce this structurally, not declaratively.

2. **Performance is a system property, not an agent property.** Excellence emerges from the relationship between the agent, its specification, its tools, its verifiers, its ecosystem, and its improvement loops. No single layer is sufficient alone.

3. **The framework has two axes of excellence, not one.** The first axis is **output fidelity:** did the agent produce the right thing? The second is **epistemic enrichment:** did the interaction make anyone more capable? An agent system can score perfectly on the first axis and zero on the second. That is a competent but ultimately brittle system, one that produces correct outputs today but accumulates no wisdom, leaves humans more dependent rather than more capable, and fails silently when task types shift outside its validated range. Every layer below addresses both axes.

## The layers

The framework is organised into nine layers, each addressing a distinct aspect of agent design. The layers are not sequential stages; they are simultaneous design considerations. Every layer should be addressed in parallel, not as a checklist.

1. **Purpose:** why does this agent exist? What human need does it serve, and what capability does it build?
2. **Identity:** what is this agent? What role does it play, and what tools does it hold?
3. **Specification:** what does done look like? What are the acceptance criteria, and were they defined before execution?
4. **Context:** what does the agent know, and when? What is the minimum sufficient context, and what is the epistemic context from upstream?
5. **Trust:** how do outputs become trustworthy? Who verifies this work, and do belief revision protocols allow the system to get smarter over time?
6. **Safety:** what happens when things go wrong? What are the fail-safe defaults, and where are the human gates?
7. **Ecosystem:** what surrounds this agent? What is the multi-agent topology, and where do humans appear in the workflow?
8. **Improvement:** how does this agent get better over time? What patterns are extracted, and is pipeline intelligence being measured alongside output quality?
9. **Human Enrichment:** is every human more capable after engaging with this system than before? Does the system actively manage for diversity of thought, not just quality of output?


### Layer 1: Purpose

*Why does this agent exist?*

This layer is answered before anything else. Every subsequent design decision should be traceable back to it.

* **Human intent:** what human need does this agent serve? A technically correct agent that causes harm, concentrates power, or diminishes human agency has failed regardless of its output quality

* **Human development:** what does the human gain in capability, understanding, or perspective from this interaction? This is a distinct question from task completion. The goal is not to give answers but to make humans more capable of finding answers. An agent system that creates dependency where it should create competence has failed its purpose, even if every output was correct

* **Goal, not just task:** what is the agent trying to achieve, not just what is it being asked to do? Without goal clarity, the agent cannot recognise when completing the task would undermine the purpose (commander's intent)

* **Success in human terms:** what does a good outcome look like to the person who asked for this work? This is distinct from the acceptance criteria and must be defined first

* **Complementarity boundary:** what should this agent do, and what must remain human? Agents handle the consistent, parallelisable, and precisely specifiable; humans handle the ethical, irreversible, and genuinely novel. This boundary is drawn explicitly, not discovered at runtime. Where efficiency and enrichment conflict, this layer is where the tiebreaker lives

### Layer 2: Identity

*What is this agent?*

* **Role archetype:** is this agent an executor, a reviewer, an orchestrator, a synthesiser, an articulation agent, or an exploration agent? These are not interchangeable. An agent that holds both executor and reviewer roles for the same work produces unverifiable output. Two new archetypes expand the set:
  - **The Articulation Agent:** receives rough, partially-formed upstream output and returns it as something precise, structured, and usable. Its job is not to answer but to make implicit logic explicit. In human-facing interactions, it surfaces what the human already knows but hasn't yet articulated. In agent pipelines, it tightens loosely specified upstream outputs before passing downstream
  - **The Exploration Agent:** deployed *before* specification is locked, its explicit purpose is to expand the possibility space. It surfaces options not yet considered, names assumptions not yet questioned, and identifies adjacent opportunities the human or downstream agent hasn't seen. Its output is not a conclusion, it is a richer set of options to choose between

* **Cognitive orientation:** does this agent approach problems critically, optimistically, creatively, factually, procedurally, or as a synthesiser of other perspectives? A single orientation applied to every problem is a design flaw. Multi-agent systems should deliberately compose complementary orientations

* **Theory-of-Mind capability:** for agents operating in multi-agent pipelines, can this agent model what upstream and downstream agents believe, know, and are uncertain about? Agents that reason about each other's epistemic state form more effective coalitions than those operating purely from their own perspective. This is a designed property, not an emergent one

* **Capability boundary:** what tools does this agent structurally hold? Tools are not descriptions of capability; they are capability. What this agent cannot do should be structurally impossible, not merely discouraged

* **Model selection:** which underlying model is appropriate for this agent's role? Heavy reasoning models for complex judgment; lighter models for routing, classification, and structure. Temperature and sampling parameters are design decisions, not defaults

* **Scope:** what is explicitly out of scope? The boundary between in-scope and out-of-scope must be as precise as the task definition itself. Scope overreach is almost always caused by an underspecified boundary, not a malicious agent

### Layer 3: Specification

*What does done look like?*

This is the highest-leverage layer. The quality of a specification determines the quality of the output more than any property of the agent. Specification now has three sequential stages, the first two were previously absent from the framework.

* **Stage 1, Explore:** before acceptance criteria are written, what are all the possible ways this problem could be framed and solved? The exploration phase is not discovery (which validates the problem), it is generative (which multiplies the options). Its output is a curated option space, not a specification. This stage is served by the Exploration Agent archetype. Skipping it means committing to a direction before the best directions have been identified

* **Stage 2, Choose:** commit to a direction, explicitly setting aside the alternatives considered. The alternatives are recorded, not discarded; they are the evidence that the chosen direction was selected, not defaulted into

* **Stage 3, Specify:** write the acceptance criteria for the chosen direction:
  - **Definition precedes execution:** criteria must be complete, reviewed, and locked before work begins. Criteria written after the fact describe what was built, not what was needed
  - **Proof template:** what evidence specifically constitutes completion? Not "the task is done" but "these criteria are met, as evidenced by these artefacts." The proof template is the contract
  - **Verifiability test:** if you cannot tell whether an output passes or fails the acceptance criteria without asking the agent, the criteria are ambiguous. Ambiguity in a specification is a bug
  - **Problem before solution:** what is the validated problem being solved? Discovery is a distinct phase. No specification should exist without a validated understanding of the problem it is responding to
  - **Prototype before scale:** for high-stakes or novel work, what is the minimum viable version that tests the core assumption? Execution failure is expensive; validation failure is cheap

### Layer 4: Context

*What does the agent know, and when?*

* **Minimum sufficient context:** what is the minimum information this agent needs to perform its task? More context degrades performance. Every additional element competes for the same finite attention

* **Informational context:** what is provided upfront in a context card, and what does the agent retrieve on demand from a knowledge base? These are not the same thing. Context is local and task-specific; knowledge is global and queryable

* **Epistemic context:** what did the upstream agent believe, assume, and remain uncertain about? This is not task information; it is reasoning provenance. An agent receiving only an output has less to work with than one receiving an output plus a confidence-calibrated reasoning trace: *what I found, how confident I am, what I assumed, what alternatives I set aside, and what would change my conclusion*. Epistemic context is what enables downstream agents to calibrate their trust in upstream outputs rather than inheriting them blindly

* **What it is explicitly forbidden to read:** because if the agent can reach a document, it may load it. Forbidden reads are as important to specify as required reads

* **Lifecycle state:** what phase is the work in? An agent needs to know whether it is in exploration, discovery, ideation, specification, execution, or verification, because the right actions differ at each stage. Lifecycle awareness prevents out-of-order operations

* **Progressive disclosure:** what context is loaded at task start vs. loaded on demand via skills? Skill files contain substantive guidance; base agent files contain only identity, tools, and pointers. This separation enables caching and keeps always-on context small

### Layer 5: Trust

*How do outputs become trustworthy?*

This layer now operates through two complementary mechanisms. The first is the minimum viable trust mechanism. The second is the excellence mechanism.

* **Independent verification:** who verifies this agent's work, and are they structurally prevented from being the same agent that produced it? The separation is not policy; it is architecture. An executor cannot hold the verify tool for its own output

* **Verification gates:** independent pass/fail checks against pre-defined acceptance criteria. This is the floor: the work either meets the specification or it doesn't. Without this, nothing downstream can be trusted

* **Belief revision protocols:** where agents don't just pass/fail each other's outputs but explicitly propose revisions with justification, creating an auditable record of reasoning evolution rather than a binary verification event. This is the difference between a marking scheme and peer review. Both produce quality control. Only one produces better reasoning as a system property. A belief revision protocol allows the pipeline to get smarter from every task, not just produce correct outputs on each one. The upstream agent can respond to or defer a proposed revision; either outcome is recorded

* **Proof as product:** the deliverable is not the work; it is the verified evidence that the work meets the specification. A proof document is a first-class artefact: structured, attributed, and permanent

* **Immutable audit trail:** every tool call, document read, state transition, and uncertainty raise creates an immutable, attributed, timestamped record. Transparency is not a feature; it is the precondition for accountability. The audit log cannot be suppressed or retroactively edited

* **Chain of custody:** given any output, it must be possible to trace backwards through every action that contributed to it. Provenance is not an afterthought; it is designed in from the start

* **Resilience through structure:** the system must produce trustworthy outputs even when individual agents fail, hallucinate, or act in bad faith. No single actor, agent or human, should be a single point of failure. Distributed verification, quorum thresholds, and graceful degradation are structural requirements

### Layer 6: Safety

*What happens when things go wrong?*

This layer is derived from the fields with zero tolerance for failure, aviation, nuclear engineering, medicine, and law, and is now extended to include a systemic risk that operates at the organisational level.

* **Fail-safe defaults:** when an agent encounters an unknown condition, loss of state, or unresolvable uncertainty, what does it default to? The answer is always: stop and signal. Never: proceed and guess

* **Uncertainty as a structural primitive:** raising uncertainty is not a failure; it is correct behaviour. Any agent must be able to surface uncertainty immediately, without social cost or penalty. Uncertainty halts execution and creates a priority signal to human attention

* **Reversibility classification:** before any action is taken, what class is it? Read-only, reversible, or irreversible? Irreversible actions require human presence structurally, not as a bypassable gate. The distinction between "send an email" and "query a database" is not currently native to any tool framework, it must be designed in explicitly

* **Prompt injection defence:** every piece of content an agent reads is a potential attack surface. Malicious instructions can be embedded in documents, emails, and tool outputs. The agent's trust model for inputs must be explicit

* **Capability and alignment are independent:** a highly capable agent can be simultaneously excellent at its task and misaligned with the intent behind it. Alignment cannot be assumed from capability. It must be tested, monitored, and structurally constrained

* **Cognitive diversity as a safety concern:** when multiple humans interact with the same AI systems, they converge on similar frames, similar solutions, and similar outputs, even as each individual feels more creative and capable. A diverse organisation becomes a homogeneous one through repeated AI interaction, without anyone noticing. This is not a user experience problem; it is a systemic risk. The same mechanism that makes individuals more productive can make organisations more fragile, because collective resilience depends on diversity of thought and AI collaboration erodes it silently. The structural response is deliberate cognitive diversity management: rotating agent orientations across different users, teams, and tasks; tracking output diversity as a system metric alongside output quality; and treating convergence in framing as a warning signal, not a quality indicator

### Layer 7: Ecosystem

*What surrounds this agent?*

* **Tool selection and permission scoping:** which tools does this agent need? Tools are not features to be added; each one extends the attack surface and the range of possible unintended actions. The minimum sufficient toolset is the correct toolset

* **Human-in-the-loop placement:** where in the workflow do humans appear, and what are they actually deciding? Humans placed too early create bottlenecks; placed too late, they can only accept or reject outcomes. The right placement is at irreversible decision thresholds, with enough context to make a genuine judgment

* **Multi-agent topology:** if this agent operates within a multi-agent system, what is its position in the pipeline? What does it trust from upstream agents? What guarantee does it provide to downstream ones? Agent-to-agent trust is currently ad hoc, it must be designed explicitly. The pipeline is not a sequence of artefact transfers; it is a sequence of epistemic exchanges. What passes between agents includes not just outputs but reasoning traces, confidence calibrations, option spaces explored, and belief states held

* **Coalition formation:** beyond routing and gating, the orchestrator is responsible for matching agents by epistemic complementarity for the demands of the current task, not just by predefined role. Agents composed for complementary cognitive orientations produce qualitatively different outcomes than agents composed for functional role coverage alone

* **Pipeline health metrics:** measuring only accuracy and latency at the final output misses what is happening inside the pipeline. The Information Diversity Score (IDS, how semantically varied are messages between agents?) and the Unnecessary Path Ratio (UPR, how much reasoning was wasted?) are first-class pipeline health indicators alongside output quality

* **Observability:** can every step this agent takes be inspected, replayed, and diagnosed? Observability is not a developer convenience; it is the aviation black box. It exists not for real-time use but for post-incident accountability and learning

* **Infrastructure assumptions:** what happens when a tool is unavailable, an API rate-limits, or a model call times out? The agent's behaviour under infrastructure failure must be defined, not discovered in production

### Layer 8: Improvement

*How does this agent get better over time?*

* **Pattern extraction:** when this agent succeeds, what pattern contributed? When it fails, what pattern failed? Both outcomes should feed a structured, queryable pattern library, not a post-mortem document, but a living knowledge base that agents consult before beginning work

* **Knowledge compounds:** every task the agent completes makes the system smarter, if the learning is captured. Early patterns have low confidence because they have limited evidence. As they are applied and validated, confidence grows. Patterns that consistently underperform are retired

* **Performance measurement:** what metrics define this agent's performance? Not just output quality, but token efficiency, step count, rework rate, uncertainty rate, and lifecycle cost. Anomalies in any metric are diagnostic signals, not acceptable noise

* **Pipeline intelligence:** does the system get smarter through agent interactions, not just produce correct outputs? The specific measurable proxies: does the downstream agent require fewer clarification loops when the upstream agent passes reasoning alongside output? Does output diversity (IDS) across the pipeline increase over time, or converge toward homogeneity? Do agents form more effective coalitions as their epistemic models of each other mature? Does the articulation quality of inter-agent handoffs improve as the system matures? These are the pipeline equivalents of measuring whether students are developing capability, not just achieving grades

* **Retrospective discipline:** performance does not improve automatically. It requires structured retrospectives that extract patterns and update the knowledge base. An agent system treated as a deployment rather than a continuous improvement cycle will plateau and degrade

* **Specification quality as a metric:** how often do tasks built on this agent's outputs require rework? High rework rates are not output failures; they are specification failures upstream. The framework should trace rework back to its root cause: ambiguous acceptance criteria, missing exploration, skipped validation

### Layer 9: Human Enrichment

*Is every human more capable after engaging with this system than before?*

This is the layer the framework was missing, and the one that separates a *competent* agent system from an *excellent* one. It does not sit inside any other layer because it defines a second class of outputs the system must produce: not just correct artefacts, but more capable humans.

Every layer below it now has two modes of assessment: did it produce the right output (fidelity), and did it leave the human in a better position than before (enrichment)?

* **Perspective multiplication:** before the human commits to a direction, multiple cognitive orientations are deliberately surfaced. Options the human hadn't considered are a designed output, not an accidental one

* **Cognitive mirroring:** agents surface their framing, reasoning, and assumptions so humans can interrogate them, not just accept them. The agent's reasoning is visible; the human builds on it rather than inheriting it

* **Exploration scaffolding:** the agent offers frameworks and questions before conclusions, making reasoning transparent and transferable. Conclusions without scaffolding create dependency; conclusions with scaffolding create capability

* **Progressive human empowerment:** the agent's scaffolding reduces as the human's competence grows. Permanent scaffolding is a design failure: it produces permanent dependency. The measure of a mature human-agent relationship is that the human needs less guidance over time, not more

* **Tacit knowledge activation:** agents create productive friction that externalises what the human knows but hasn't yet articulated. The Articulation Agent archetype (Layer 2) is the designed version of this: its job is to surface the human's own knowledge, not to supply knowledge the human lacks

* **Diversity stewardship:** the system actively manages for diversity of human thought at the organisational level, not just quality of individual outputs. This connects directly to the cognitive diversity safety concern in Layer 6; the enrichment perspective adds a positive design obligation alongside the safety one

## The Framework as a Set of Questions

Every element above collapses into two questions per layer that must be answered before an agent is deployed. Unanswered questions are guaranteed future failure modes.

| Layer | Fidelity question | Enrichment question |
| :---- | :---- | :---- |
| **Purpose** | Why does this agent exist, and what human need does it serve? | What does the human gain, in capability, understanding, or possibility space, from this interaction? |
| **Identity** | What is this agent's role, orientation, and capability boundary? | What is the agent's epistemic orientation, and does it include Theory-of-Mind for pipeline operation? |
| **Specification** | Are criteria verifiable and pre-existing? | Was the option space explored and a direction chosen before criteria were written? |
| **Context** | What is the minimum information this agent needs, and when? | What epistemic context, beliefs, confidence, assumptions, discarded alternatives, does the agent receive from upstream? |
| **Trust** | Who verifies this work, and how is that separation enforced? | Do belief revision protocols allow the pipeline to improve its reasoning, not just verify its outputs? |
| **Safety** | What are the fail-safe defaults, and where are the human gates? | Is cognitive diversity at the organisational level being actively preserved, not just individual output quality? |
| **Ecosystem** | Is the architecture matched to task structure? | Are pipelines designed as epistemic exchanges, not artefact transfers? Is coalition formation by epistemic complementarity? |
| **Improvement** | Are output quality and rework rates tracked? | Is pipeline intelligence, downstream capability gain, being measured alongside output accuracy? |
| **Human Enrichment** | *(not applicable, this layer is the enrichment axis)* | Is every human more capable after every interaction than before it? |

An agent design that answers both questions for all nine layers is structurally sound. An agent design that answers either question for fewer than nine layers has one guaranteed failure mode per unanswered question, and it will surface exactly where the unanswered question lives.

The deepest commitment this framework makes is this: **the distinction between a system that completes tasks and a system that generates excellence is whether every interaction leaves someone, human or agent, more capable of the next one.** Everything else is in service of that.