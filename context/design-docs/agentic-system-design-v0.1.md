<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# If I wanted to build a trustful AI platform that made it possible for developers and organisation to implement responsible AI agentic systems with structural boundaries and integrity, how would we engineer this platform?

Review the agent design principles, framework principles, context engineering approach, 6-dimension ontology documents and cognitive diversity discussions first. Don't look to existing agentic platforms or tools, don't consider specific tools or solutions.

This platform is not built by assembling features — it is engineered by translating principles directly into structural constraints, so that responsible behaviour becomes architecturally impossible to bypass rather than merely encouraged by policy. Every design decision below traces back to that single commitment: **trustworthiness comes from structure, not identity**.[^1_1]

***

## The Foundational Premise

Before any architecture is designed, three commitments must be made explicit:[^1_1]

- **Trustworthiness is structural** — an agent is trusted not because of what it is, but because of how it was built, constrained, and verified
- **Performance is a system property** — excellence emerges from the relationship between the agent, its specification, tools, verifiers, ecosystem, and improvement loops; no single layer is sufficient
- **Two axes of excellence exist** — output fidelity (did the agent produce the right thing?) and epistemic enrichment (did the interaction leave humans more capable?); a system that scores perfectly on the first and zero on the second is brittle and ultimately failing its purpose

The platform's job is to make it structurally easy to build agents that score on both axes, and structurally hard to deploy agents that score on neither.[^1_2]

***

## The Structural Substrate: ONE 6-Dimension Ontology

Every component of the platform — the database schema, tool design, agent specifications, policy engine — must be an expression of one unified model, not separate configurations that drift out of sync:[^1_3]

- **Groups** — hierarchical containers enforcing multi-tenancy, scope, and ownership (teams, projects, domains)
- **Actors** — entities that authorise actions; both `humanActor` and `aiAgent` subtypes are first-class, differentiated by subtype not hierarchy
- **Things** — entities that exist but don't act: tasks, specifications, proofs, patterns, skill definitions, policies
- **Connections** — relationships between entities: `owns`, `authorisedBy`, `assignedTo`, `reviewedBy`; these are capability grants, not descriptions
- **Events** — immutable, append-only state changes: created, verified, submitted, transitioned; the audit log is implemented here and cannot be deleted
- **Knowledge** — crystallised understanding: patterns with confidence scores, reputation scores, efficiency baselines

The six dimensions answer six simultaneous questions for every operation: *Who is permitted? Who did it? Does it meet the standard? Is this the right moment? Does the agent have what it needs? What was produced?*  Any framework element that cannot answer all six has a named gap — and that gap is a future failure mode.[^1_3]

***

## Platform Architecture: Two Layers

The platform operates as two structurally separate layers:[^1_4]

**External-facing layer (API):** Serves context and capabilities to any third-party agent or developer system. An agent presents its tool manifest; the platform maps that manifest to a minimum-sufficient context package. The tool declaration is both the capability claim and the context query — elegant application of Object-Capability (OCAP) security principles where authority is *held*, not *declared*.

**Internal governance layer:** Governs the platform's own agents. Internal agents hold specific, atomic tools. An agent without a write tool structurally cannot write — not because a policy says so, but because the operation fails at the database level when no authorisation `Connection` exists.[^1_2]

The canonical rule: **no tool, no capability; no connection, no authority**. Runtime permission checks that ask "should this agent be allowed to do this?" are a governance failure — the answer must be structurally encoded before the question is ever asked.[^1_2]

***

## The Policy Engine as a Runtime Component

Policies stored as documents are declarations. Policies evaluated by an engine are structural. The Policy Engine is a first-class runtime component — not a configuration file — with these responsibilities:[^1_4]

- **State transition enforcement** — evaluates whether an Event meets preconditions before allowing lifecycle transitions; a task cannot move to `verified` without a `submissionComplete` Event
- **Tool grant and withdrawal** — issues `toolsListChanged` notifications when task state changes, activating or withdrawing tools from active agents dynamically
- **Quorum monitoring** — tracks multi-verifier pools and fires `quorumReached` or `quorumFailed` Events when thresholds are met
- **Escalation routing** — routes uncertainty Events, failed verifications, and policy violations to the correct actor (human interface or designated owner)
- **Temporal enforcement** — checks `validFrom`/`validTo` on context cards, policies, and skill versions; retires expired items automatically

The Policy Engine holds no write tools beyond Event creation. It does not make judgment calls — it evaluates conditions and fires consequences. All judgment is escalated to humans.[^1_4]

***

## The 9-Layer Agent Design Framework

Every agent deployed through this platform must answer two questions per layer — a fidelity question and an enrichment question. An unanswered question is a guaranteed failure mode:[^1_1]


| Layer | Fidelity Question | Enrichment Question |
| :-- | :-- | :-- |
| **Purpose** | Why does this agent exist and what human need does it serve? | What does the human gain in capability from this interaction? |
| **Identity** | What is this agent's role, orientation, and capability boundary? | Does the agent include Theory-of-Mind for pipeline operation? |
| **Specification** | Are criteria verifiable and pre-existing? | Was the option space explored before criteria were written? |
| **Context** | What is the minimum information this agent needs? | What epistemic context — beliefs, confidence, discarded alternatives — arrives from upstream? |
| **Trust** | Who verifies this work, and how is separation enforced? | Do belief revision protocols let the pipeline improve its reasoning? |
| **Safety** | What are the fail-safe defaults and where are the human gates? | Is cognitive diversity at the organisational level actively preserved? |
| **Ecosystem** | Is the architecture matched to task structure? | Are pipelines epistemic exchanges, not just artefact transfers? |
| **Improvement** | Are output quality and rework rates tracked? | Is pipeline intelligence — downstream capability gain — being measured? |
| **Human Enrichment** | *(this layer is the enrichment axis)* | Is every human more capable after every interaction than before? |

[^1_1]

***

## Context Engineering

The platform must treat context as a *finite resource*, not free storage. The research is unambiguous: more context degrades performance through the **lost-in-the-middle problem** — attention distributes across the entire window, with instructions buried in the middle most likely to be missed.[^1_5]

The platform enforces this through four mechanisms:[^1_5]

- **Explicit scope trees** — every agent operation defines exactly what it reads, writes, and is forbidden from reading; if an agent can reach a document it may load it, so forbidden reads are as important as required reads
- **Context cards** — generated, minimum-sufficient briefings delivered at instantiation, not bloated dumps; the Context Curation Agent compresses human-uploaded content before any operational agent sees it
- **Progressive disclosure** — base agent files hold only identity, tools, and pointers; skill files contain substantive guidance loaded on demand; this keeps always-on context minimal and enables prompt caching at a fraction of full token cost
- **Epistemic context** — inter-agent handoffs pass not just outputs but reasoning traces: confidence levels, assumptions made, alternatives discarded, and what would change the conclusion; downstream agents calibrate trust rather than inherit blindly[^1_1]

***

## Trust and Verification

Trust is produced by four structural mechanisms, not by reputation:[^1_2]

- **Verification precedes trust** — no output is accepted on the author's assertion; a structurally separate actor verifies against pre-defined criteria; the executor cannot hold the verify tool for its own work
- **Proof is the product** — the deliverable is not the work; it is verified evidence that the work meets specification; proof documents are first-class artefacts: typed, versioned, permanently attributed
- **Immutable audit log** — every tool call, document read, state transition, and uncertainty raise produces an immutable, timestamped, attributed Event; the audit log cannot be suppressed or retroactively modified
- **Belief revision protocols** — verifiers don't just pass/fail outputs; they explicitly propose revisions with justification, creating an auditable record of reasoning evolution; the upstream agent responds or defers; both outcomes are recorded; this is the mechanism by which the pipeline gets smarter from every task[^1_1]

For high-stakes operations, **quorum-based verification** through verifier pools removes single points of failure; the platform selects verifiers by availability, reputation, and expertise — never by the performer.[^1_2]

***

## Safety Architecture

Safety is drawn from aviation, nuclear engineering, medicine, and law — fields with zero tolerance for failure:[^1_1]

- **Fail-safe defaults** — when an agent encounters an unknown condition or unresolvable uncertainty, the only valid response is *stop and signal*; never proceed and guess
- **Uncertainty as a structural primitive** — every agent holds a `raiseUncertainty` Connection that is universal and irrevocable; calling it is never penalised; it halts execution and routes to a priority stream; the same uncertainty raised repeatedly without upstream fixes is a signal that something upstream needs to be fixed
- **Reversibility classification** — before any action, it is classified: read-only, reversible, or irreversible; irreversible actions structurally require a human `approvalGranted` Event before proceeding; there is no bypass flag
- **Prompt injection defence** — every piece of content an agent reads is a potential attack surface; the agent's trust model for inputs must differentiate sources by authority level, not treat retrieved content as equivalent to direct instructions
- **Cognitive diversity as a safety concern** — when multiple humans interact with the same AI systems, they silently converge on similar frames and solutions even as each feels more creative; a diverse organisation becomes a homogeneous one through repeated AI interaction without anyone noticing; the structural response is deliberate cognitive diversity management: rotating agent orientations, tracking Information Diversity Score (IDS) as a system metric, and treating convergence in framing as a warning signal[^1_1]

***

## Cognitive Diversity by Design

The platform enforces multi-perspective exploration before solution selection for all complex work:[^1_2]

- Agents are assigned explicit `cognitiveOrientation` attributes: critical, optimistic, creative, factual, procedural, synthesiser
- The orchestrator composes agents by **epistemic complementarity** for the task demands, not just by functional role
- Ideation sessions spawn multiple agents with distinct orientations; a synthesis agent integrates — not aggregates — the outputs
- The **Information Diversity Score (IDS)** — how semantically varied are messages between agents? — and the **Unnecessary Path Ratio (UPR)** — how much reasoning was wasted? — are first-class pipeline health metrics alongside output quality[^1_1]
- For the platform's own critical operations (pattern crystallisation, policy creation, agent class design), cognitively diverse review panels are enforced by the Policy Engine before changes can proceed[^1_4]

***

## The Continuous Improvement Layer

An agent system treated as a deployment rather than a continuous improvement cycle will plateau and degrade. The platform requires three dedicated improvement agents operating on schedules, not on demand:[^1_4][^1_1]

- **Retrospective Facilitator Agent** — triggered after task completion and at cycle boundaries; queries completed Events, applied patterns, and escalation history; produces structured retrospective Things with pattern candidates; routes candidates to the Pattern Library for cognitive-diverse review
- **Performance Reviewer Agent** — monitors token consumption, latency, and cost per agent class against Knowledge-dimension baselines; flags regressions with `performanceRegression` Events; recommends agent class modifications submitted as proposals requiring human approval
- **Quality Auditor Agent** — analyses verification pass/fail rates by task type and proof template; identifies systemic quality issues (a task type that consistently fails its first verification is a specification problem, not a performer problem); proposes proof template updates

All three agents are **read-only** except for creating Event Things and drafting proposal Things. They do not implement the solutions they identify — that is P5 (No Self-Judgment) applied to the improvement layer itself.[^1_4]

***

## The Pattern Library

Patterns are crystallised solutions stored as `Things` in the Knowledge dimension with:[^1_4]

- A `confidenceScore` (float 0–1) updated by weighted Bayesian decay after each application
- `successCount` and `failureCount` connected via Events from tasks that applied them
- A `retirementThreshold` — patterns that consistently underperform are automatically deprecated by the Policy Engine, not indefinitely tolerated
- A cognitive-diverse review requirement before any candidate pattern becomes active
- Cross-domain transfer via `domainTags` — a pattern crystallised in legal drafting can transfer to financial analysis because both share the same Knowledge dimension

The pattern library is the primary implementation of the **L3 Knowledge Compounds** principle: every completed task makes the system structurally smarter, not just an organisation with more history.[^1_2]

***

## Conformance Profiles for Adoption

Not every system needs the full platform from day one. Three tiered profiles allow incremental adoption:[^1_2]

- **Core Trust Profile** — minimum viable: audit log, independent verification, proof templates, capability-based authority; without these, outputs are not structurally trustworthy
- **Full Lifecycle Profile** — adds cognitive diversity, validate-before-scale, lifecycle efficiency, and uncertainty surfacing; improves quality and enables learning
- **High-Stakes / DAO Profile** — adds quorum verification, resilience through structure, human flourishing governance, reversibility enforcement, and knowledge compounds; required for regulated industries, multi-org collaboration, and high-consequence systems

The deepest commitment the platform makes is this: the distinction between a system that completes tasks and a system that generates excellence is whether every interaction leaves someone — human or agent — more capable of the next one. Everything else is in service of that.[^1_1]
<span style="display:none">[^1_10][^1_11][^1_12][^1_13][^1_14][^1_15][^1_16][^1_17][^1_18][^1_19][^1_20][^1_6][^1_7][^1_8][^1_9]</span>

<div align="center">⁂</div>

[^1_1]: agent-design-principles-v0.2.md

[^1_2]: framework-principles-v0.4.md

[^1_3]: one-ontology-approach.md

[^1_4]: i-want-to-build-an-open-source-Tzo5tKssRbG4ZaEG.idAKg.md

[^1_5]: context-engineering-approach.md

[^1_6]: trust-framework-analysis.md

[^1_7]: suggested-updates.md

[^1_8]: five-questions-of-agency.md

[^1_9]: beyond-expected.md

[^1_10]: aligning-strengths-and-limitations.md

[^1_11]: 34 Strenths Ranking.md

[^1_12]: Pete Argent - Expert Report.pdf

[^1_13]: review-the-agent-design-framew-AfD0jfBJTtGLpqIwDzFqcQ.md

[^1_14]: i-want-to-think-through-the-de-1uknqXF9SA6WXLfbDBtvQw.md

[^1_15]: what-can-you-tell-me-about-kno-6g9KqcSXTLOtSlN2SoqF5g.md

[^1_16]: example-reviewer.agent.md

[^1_17]: example-planner.agent.md

[^1_18]: example-orchestrator.agent.md

[^1_19]: example-developer.agent.md

[^1_20]: platform-constraints.md


---

# This is great. But I'd like you to do this again and just see the documents and discussions as intent, not prescriptive. These are largely untested theories and principles and lack real world exposure or critique. Go to the underlying ideas of the documents and help me approach this from a new perspective in the interests of gaining new insights and identifying gaps or weaknesses. The most recent analysis and ideation I have been doing is around the cognitive diversity engine as I try to understand how agent design can impact outputs.

Is it worth first expanding on the platform goals and foundational premise to unpack and interrogate each element and as a whole?

Yes — interrogating the premises first is exactly the right move. When a platform's design claims flow from foundational assumptions, and those assumptions are untested, every downstream design decision inherits the same uncertainty. Better to find the cracks in the foundation now than after you've built several floors on top of it.

What follows is a genuine interrogation, not a critique for critique's sake. The goal is to find what's actually solid, what's plausible but unproven, and what might be subtly wrong in ways that would matter at build time.

***

## The Platform Goal Itself Needs Unpacking

The stated intent — *a trustful platform for responsible AI agentic systems with structural boundaries and integrity* — sounds coherent, but it smuggles in several assumptions before the first design decision is made.[^2_1]

**Who is the trust for?**
"Trustful" could mean trusted by developers building on it, trusted by organisations deploying it, trusted by the end users affected by it, or trusted by society at large. These are not the same thing. A platform that is structurally verifiable to developers may still be invisible and unaccountable to the humans whose lives it affects. The documents assume trust is primarily a property of the system's internal architecture, but that may be the least important dimension of trust from a societal perspective.[^2_2]

**Who decides what "responsible" means?**
The framework treats responsibility as something that can be encoded structurally — if the structure enforces certain constraints, the system is responsible. But responsibility is *contested*, not defined. Different actors have different and often incompatible views of what a responsible AI system looks like. The framework has no theory of contested responsibility — it assumes that once you define the structure, the responsibility question is answered.[^2_1]

**What problem is this actually solving?**
The documents emerge from a specific operational context — building a multi-agent software development system — and then generalise outward. That's a legitimate path, but it means the framework may be solving the problems that appeared in that context while creating blind spots for the problems that appear in others. The universality claim (*any knowledge work*) is significantly stronger than the evidence.[^2_1]

***

## Interrogating the Three Commitments

### "Trustworthiness comes from structure, not identity"

This is the most important claim in the framework — and the most over-extended.[^2_2]

**What it gets right:** Structural constraints can prevent *specific anticipated* failure modes. An executor who structurally cannot hold the verify tool for their own work cannot self-certify, regardless of intentions. This is genuinely more robust than a policy that says "don't self-certify." The aviation parallel is apt here — checklists work not because pilots are untrustworthy but because under stress, even trustworthy people make systematic errors that structure catches.

**What it gets wrong:** Structure only enforces what it anticipated. Novel failure modes — the ones you didn't think to structurally prevent — are not made less likely by structural constraints elsewhere. Worse: high structural confidence can *decrease* vigilance. If your system says "this was independently verified," you are less likely to personally scrutinise the output, even when the verification criterion was underspecified. Structure creates a *confidence signal* that may exceed the actual trust it warrants.

**The deeper problem:** Trustworthiness involves competence, reliability, alignment with intent, and adaptability to novel situations. None of these are structurally enforceable. The framework's structural constraints can tell you whether process was followed — they cannot tell you whether the process was the right one, whether the agent understood what it was doing, or whether the output actually serves the stated intent.[^2_1]

**The reframe worth considering:** Structure makes certain *classes* of failure structurally impossible, not trustworthiness in general. That's a meaningfully weaker and more accurate claim — and it changes what you build, because you must acknowledge the non-structural residual.

***

### "Performance is a system property, not an agent property"

This is the most useful reframe in the framework, and also the one most at risk of becoming an excuse.[^2_2]

**What it gets right:** The literature is clear that context engineering, specification quality, tool selection, and ecosystem design all substantially affect agent performance. An excellent agent in a poorly designed environment will underperform a mediocre agent in a well-designed one. The facilitative framing — creating conditions for excellence rather than just containing failure — is generative and correct.[^2_3]

**The attribution problem:** "Performance is a system property" is an empirical claim, but the documents offer no empirical evidence for it. It *feels* right, but what we'd need to know is the *distribution of variance explained* by system factors vs. agent-intrinsic factors vs. their interaction. If 80% of performance variance is explained by the agent and 20% by the system, "it's a system property" produces bad design decisions. We don't know the actual numbers.[^2_4]

**The accountability escape hatch:** When performance is always framed as a system property, individual agent design quality can become diluted as a concern — "the system will catch it." In practice, the agents that sit at the most consequential nodes of a pipeline (specification writers, synthesisers, human-gate briefing agents) may be the most impactful individual variables in the whole system. The reframe may be systematically under-investing in their individual design quality.

***

### "Two Axes of Excellence: Fidelity and Epistemic Enrichment"

This is the most philosophically ambitious claim, the least operationalisable, and potentially the most important.[^2_2]

**What it gets right:** The concern that AI systems create capability dependency rather than capability growth is real and under-examined. If every AI interaction makes someone faster at a task without developing their understanding of it, you are building an organisation that becomes progressively more brittle as AI reliability varies. That's a genuine systemic risk.[^2_2]

**The measurement void:** "Did this interaction leave the human more capable?" is essentially unmeasurable in practice. You cannot run a control trial every time an agent interacts with a human. You cannot assess baseline capability before and after each interaction. In the absence of measurement, the enrichment axis becomes decorative — it is a value statement dressed as a design principle.[^2_2]

**The tension that isn't resolved:** Making humans more capable often means productive struggle, well-calibrated challenge, and resisting the urge to give answers directly. But a platform optimising for task completion efficiency will consistently choose the fast, complete answer over the productive friction that builds capability. These two objectives are not just complementary — they are genuinely in tension. The documents acknowledge this tension in principle (the facilitative framing, the ZPD concept) but don't resolve *how* a system that serves both simultaneously decides which to prioritise in a specific interaction.[^2_3]

**The deeper question it opens:** If epistemic enrichment is a genuine design axis, then the evaluation criteria for the whole platform change. You're not just measuring whether outputs are correct and processes are verified — you're measuring whether the people using the platform are developing or atrophying. That's a much harder and more important design problem than anything in the framework as currently specified.

***

## The Cognitive Diversity Question — The Most Interesting Gap

This is where the framework's theoretical ambition most outpaces its mechanistic grounding, and where the most productive new thinking lives.[^2_1][^2_2]

**The borrowed premise:** The cognitive diversity claims borrow heavily from human team research — Scott Page's diversity bonus, de Bono's Six Thinking Hats, established findings about heterogeneous groups outperforming homogeneous ones. These are real findings. But they apply to humans who have genuinely different cognitive architectures, different knowledge from different lives, different perceptual frameworks shaped by different experiences. The transfer to AI agents is *not* established — it's an analogy presented as a mechanism.[^2_2]

**The homogeneous substrate problem:** If all your agents run on the same base model, they share the same training distribution, the same embedded biases, the same blind spots, the same systematic errors. "Cognitive orientation" as a prompt-level instruction — be critical, be optimistic, be creative — is sampling from different regions of the *same distribution*, not drawing from genuinely diverse distributions. You may be creating the appearance of diversity while the underlying homogeneity remains intact. This is an empirical question the framework has not answered.[^2_2]

**What genuine diversity might actually require:** Different base models trained on different corpora, agents with access to genuinely different domain knowledge, structurally different reasoning approaches (not just different prompts), or — most provocatively — human perspectives at the diversity-critical junctures rather than AI perspectives claiming cognitive diversity they may not possess.

**The IDS metric problem:** Information Diversity Score measures semantic variety of inter-agent messages. But semantic variety is not epistemic diversity. Two agents could produce semantically very different text while making the same fundamental reasoning errors rooted in shared training data. Measuring word and concept diversity tells you something about surface-level output variation — it tells you very little about whether the agents are actually finding genuinely different aspects of the problem space.[^2_2]

**The task-type dependency that isn't fully addressed:** The documents acknowledge cognitive diversity helps more on open-ended tasks than precise execution tasks. But the framework has no principled decision rule for *when* to deploy cognitive diversity. "Cognitive diversity by design" as a default for complex problems still requires you to define "complex" — and that definition is doing a lot of unexamined work.[^2_4]

**The most productive new question here:** Rather than asking "how do we implement cognitive diversity?" — which presupposes we know what we mean by it — the more useful prior question is: *what is the actual mechanism by which different perspectives improve outputs?* In human teams, the mechanism is documented: different people literally perceive different features of the problem, they catch each other's errors because they don't share the same blind spots, and social dynamics prevent premature convergence. For AI agents, which of these mechanisms actually operate, which only appear to, and which are entirely absent? Until you have a mechanistic answer to that question, cognitive diversity by design is a hypothesis, not a principle.

***

## What This Suggests About the Platform Direction

Rather than treating the documents as architecture to implement, treat them as a **hypothesis set to test**. The most important design question for the platform is not "how do we implement these principles structurally?" but "which of these principles are actually true, for which task types, under which conditions, and how would we know?"

The parallel agent experiment framing from your earlier discussions is the most underutilised insight in all of this. That work describes a research methodology — not just a design thought experiment — that could empirically ground the claims the framework currently asserts. Before engineering a cognitive diversity engine, the more productive investment might be running controlled parallel experiments to find out whether cognitive orientation diversity at the prompt level actually produces output diversity that matters for quality.[^2_4]

The platform goal might be better framed not as *implementing responsible AI with structural boundaries* but as *creating the conditions under which we can learn what responsible AI actually requires in practice* — a framework for continuous empirical refinement rather than a framework for implementing pre-specified principles.

That's a fundamentally different kind of platform to engineer.
<span style="display:none">[^2_5]</span>

<div align="center">⁂</div>

[^2_1]: framework-principles-v0.4.md

[^2_2]: agent-design-principles-v0.2.md

[^2_3]: beyond-expected.md

[^2_4]: review-the-agent-design-framew-AfD0jfBJTtGLpqIwDzFqcQ.md

[^2_5]: i-want-to-build-an-open-source-Tzo5tKssRbG4ZaEG.idAKg.md


---

# great. I like your reframing suggestion of a framework for continuous empirical refinement.

let's go backwards even further.

What is an agentic platform? I see it as a tool that simplifies the design and development of agents. To add value to the platform, it should provide extensible structures that allow for integration of AI tooling, and an orchestration layer that allows the creation of teams and workflows of various configurations. There should be methods to provide inputs for agents and specify outputs.

I am confident you will do better in unpacking the concept and explain core components/layers and optional or value-added elements

This is a productive place to anchor. Your definition — *a tool that simplifies the design and development of agents* — is true but substantially incomplete. It describes the build-time job while missing the runtime, governance, and improvement jobs that determine whether an agentic platform is genuinely useful or just a sophisticated scaffold for producing unreliable systems.[^3_1]

Let me offer a sharper foundation and then unpack it structurally.

***

## A Better Starting Definition

An agentic platform is **infrastructure that reduces the cost of bringing agents into existence, running them reliably under constraint, and making them improveable over time** — on behalf of both the developers who build with it and the operators who deploy it.

That three-part definition — *enabling, constraining, learning* — is actually the most important structural lens for an agentic platform, and it exposes a critical gap in most existing platforms:[^3_1]

- Nearly all investment goes into **enabling** (tooling, runtime, integrations)
- Very little goes into **constraining** (governance is usually an afterthought, not architecture)
- Almost nothing goes into **learning** (improvement is manual, not structural)

A platform that solves only the first job produces systems that are fast to build but unreliable to operate. Your framework documents are notable precisely because they attempt all three — but from an agent design perspective, not a platform architecture perspective. The platform question is: *what does the infrastructure itself need to provide to make these three jobs achievable?*[^3_2]

***

## The Non-Negotiable Substrate

These five layers must exist for any agent to function at all. Remove one and you don't have an agentic system — you have an incomplete tool.

- **Model access** — API connectivity, request/response parsing, retry logic, rate limiting, cost tracking, and model routing. This is commodity infrastructure, but its absence makes everything else impossible
- **Agent execution runtime** — instantiation of an agent from its definition, context assembly, tool dispatch when the model produces a tool call, loop management (what triggers the next turn?), and termination logic (when does the agent stop?). This is the core runtime that actually *runs* your agent — distinct from defining it
- **State management** — what persists between turns, between tasks, and between sessions. In-context state is transient; task-level state persists for the duration of a workflow; cross-session state builds a long-term model of context. Most platforms conflate these, which is why agents behave as if they have no memory beyond the immediate conversation
- **Tool integration** — a registry of available tools, the execution mechanism for dispatching calls and returning results, and the capability-scoping layer that determines which agent can call which tool. This is what separates an agent (something that acts) from a chatbot (something that responds)
- **Agent definition abstraction** — how do you *express* what an agent is? The richness of this abstraction is highly leveraged: a thin definition (just a system prompt) pushes all design decisions to the developer; a rich definition (role, model, tools, capability bounds, accepted input types, output schema, verification requirements) lets the platform enforce constraints on your behalf[^3_3]

***

## The I/O Contract — Systematically Underspecified

Most platforms treat agent inputs as "user messages" and outputs as "responses." This is fine for chat interfaces. It is dangerously underspecified for agentic systems.

**What can trigger an agent?** Human messages, scheduled timers, events from other agents, API calls, file system changes, inbound webhooks, threshold breaches in monitoring. Each trigger type carries different authority levels, different context structures, and different reversibility implications.

**What does an agent produce?** Text, structured data, artefacts (files, documents, records), real-world actions (API calls, emails, database writes), events fired downstream, or invocations of other agents. The failure to *type* outputs — to declare whether an output is a text response or a real-world action — is one of the most consistent gaps in agentic platform design.[^3_1]

The I/O contract is not just an API design question. It is a governance question. An agent that receives an event with the authority of a human approval should behave differently from one receiving an automated upstream signal. A platform that doesn't model input authority has no basis for knowing when human oversight is required.

***

## The Orchestration Layer — More Than Routing

Your definition includes "an orchestration layer that allows the creation of teams and workflows of various configurations." This is correct but significantly understates what orchestration must do.[^3_2]

At minimum, orchestration covers:

- **Topology** — sequential chains (A → B → C), parallel fans (A → B, C, D simultaneously), hierarchical delegation (orchestrator dispatches to specialist agents), and dynamic graphs (agent outputs determine next routing)
- **State passing** — what actually travels between agents: only the output artefact? Or also reasoning traces, confidence calibrations, alternatives considered, and uncertainty signals? Your framework documents call this the difference between artefact transfer and epistemic exchange — and it's the single biggest determinant of whether errors compound or get caught[^3_2]
- **Coalition formation** — how agents are matched to tasks. Static role-based assignment is the simplest form; dynamic matching by capability and cognitive orientation is more powerful but requires a richer agent registry
- **Error handling** — what does the workflow do when an agent in the middle of a chain fails, hallucinates, or raises uncertainty? Most platforms have no structured answer; they simply fail

The missing insight in most orchestration thinking is that **the pipeline is a computational object with its own state**, not just a sequence of API calls. A platform that treats the pipeline as stateless cannot support belief revision protocols, quorum-based verification, or structured uncertainty propagation — all of which require the pipeline to know what has already happened.[^3_1]

***

## Value-Added Elements

These are not required to run something — but they are required to run something *trustworthy at scale*. Their absence is usually invisible at prototype stage and catastrophic at production scale.


| Element | What it does | Why it's consistently skipped |
| :-- | :-- | :-- |
| **Observability and tracing** | Makes every agent action inspectable, replayable, and diagnosable | Adds latency and cost; returns are invisible until something breaks |
| **Policy enforcement engine** | Evaluates policies structurally against events — not as documents but as runtime constraints | Hard to build; easy to simulate with documentation that no one reads |
| **Human integration layer** | Typed interfaces for humans to approve, contest, escalate, and observe — not just a chat window | Requires upfront UX investment with no immediate capability gain |
| **Evaluation infrastructure** | Frameworks for knowing whether the system is actually working, not just running | Hard to define; results are uncomfortable when the answer is "not well" |
| **Context and knowledge management** | Curated, structured knowledge served at the right time to the right agent — your ACMS | Usually handled ad-hoc via ever-growing system prompts |
| **Improvement loops** | Structured extraction of what worked and what didn't, feeding back into agent and policy design | Requires organisational discipline that most teams don't have at build time |


***

## What Your ACMS Actually Is in This Map

This is worth naming explicitly. The ACMS is not an agentic platform in the full sense above — it doesn't provide the model access layer, the execution runtime, or the tool integration substrate. Those are provided by VS Code, GitHub Copilot, and the MCP ecosystem.[^3_3]

What the ACMS provides is a **platform governance layer** — the infrastructure that makes the execution platform *trustworthy*: context curation, policy enforcement, knowledge management, audit trails, human interfaces, and improvement loops. It sits *between* the raw execution platform and the agents it serves.[^3_4]

That's a more specific and more original product than "an agentic platform." Most execution platforms assume their users will handle governance themselves. Your ACMS is the governance infrastructure they won't build — which means it adds value proportional to how poorly the execution platform handles the constraining and learning jobs on its own. That's currently a very large gap.
<span style="display:none">[^3_5]</span>

<div align="center">⁂</div>

[^3_1]: i-want-to-think-through-the-de-1uknqXF9SA6WXLfbDBtvQw.md

[^3_2]: agent-design-principles-v0.2.md

[^3_3]: platform-constraints.md

[^3_4]: i-want-to-build-an-open-source-Tzo5tKssRbG4ZaEG.idAKg.md

[^3_5]: review-the-agent-design-framew-AfD0jfBJTtGLpqIwDzFqcQ.md


---

# Don't worry about the ACMS ideas. That's just my exploration and experimentation of the technologies.

Your break down of the agentic platform provides a great grounding.

Currently available platforms are intentionally general purpose so developers can employ them for a wide range of use cases.

I'd like us to explore a few 'real world' use cases as I feel there are lessons to be learned from the exercise. As they say, 'if you try to build for everyone, you end up building for no one".

Give me three high potential use cases from industry, government or for-purpose sectors. Let's start with a simple one and go progressively more complex.

The use cases should allow us to explore the actual needs of an agentic system from all angles. What are the required outcomes? How will the workflow be designed? Who will design, implement, operate, oversee etc? What are the benefits and challenges for stakeholders? What would the lifecycles be? What other considerations are important?

These three cases are chosen to reveal fundamentally different dimensions of what agentic systems actually require — not just technically, but governmentally, ethically, and operationally. Each one surfaces problems that are invisible until you encounter them in practice.

***

## Case 1 (Simple): Grant Application Screening — Community Foundation

**The scenario:** A mid-sized community foundation runs 8–12 grant rounds per year, receiving 200–400 applications per round. Staff currently spend 60–70% of their time on eligibility checking, completeness review, and compiling assessment briefs. The agent system handles intake through to shortlist briefing; humans make all funding decisions.

### Required Outcomes

- Completeness verification — has the applicant provided every required document and field?
- Eligibility determination — does this application meet the round criteria?
- Structured assessment briefs — consistent, comparable summaries for human assessors
- Exception routing — borderline or unusual applications flagged with specific reasons
- Outcome communications — acceptance, rejection, or request for further information letters


### Workflow Design

```
Application submission → Completeness Agent → Eligibility Agent 
        → Classification (eligible / ineligible / borderline)
        → [borderline] → Escalation to program officer
        → [eligible] → Synthesis Agent → Assessment Brief
        → Human assessors → Decision
        → Communication Agent → Applicant notification
```

The workflow is deceptively clean. The instructive complexity sits in the *seams*:

- What triggers the eligibility check? The submission event — but what if the form system and the agent platform aren't integrated and a submission sits in an email inbox?
- What happens when an eligibility criterion is written in natural language that doesn't resolve cleanly? "Organisations working in the affordable housing space" — does this include a financial counselling service whose clients are sometimes at risk of homelessness?
- The Communication Agent faces humans who will be materially affected by its output. A technically correct rejection notice that reads as dismissive creates reputational harm the foundation must absorb[^4_1]


### Stakeholder Map

| Stakeholder | Primary interest | Key tension |
| :-- | :-- | :-- |
| Program staff | Reclaim time from admin | Fear of errors in a high-trust relationship context |
| Grant assessors | Consistent, comparable briefs | Risk of anchoring to AI framing before applying judgment |
| Applicant organisations | Fast, fair decisions | No visibility into how decisions are made |
| Foundation board | Governance compliance, mission alignment | Accountability for decisions partly shaped by AI |
| Funders of the foundation | Responsible use of philanthropic capital | Expectation of human judgment in grant-making |

### What the Lifecycle Actually Looks Like

- **System lifecycle:** Not continuous — it pulses with the grant calendar. Criteria, forms, and eligibility rules change per round. The system must be re-configured for each round, which means the maintenance burden is proportional to the frequency of rounds, not just the scale
- **Task lifecycle:** Application → completeness check → eligibility check → briefing → decision → notification → (if funded) progress monitoring. Each stage has a different actor responsible for the outcome
- **Agent instance lifecycle:** Short-lived per application, but the *pattern* extracted from thousands of applications over time is where long-run value compounds


### The Instructive Lesson

The **principal identification problem** appears immediately and doesn't resolve cleanly. Is the agent working for the foundation (processing efficiency, consistency) or for the applicants (transparency, fairness in borderline cases)? The same agent system designed for one will make different decisions about borderline routing than one designed for the other. Most platform discussions skip this question entirely — it isn't a design preference, it's a values choice that must be made before the acceptance criteria are written.[^4_2]

***

## Case 2 (Medium): Hospital Discharge Coordination — Healthcare

**The scenario:** A 600-bed teaching hospital coordinates discharge across pharmacy, transport, room cleaning, family/carer notification, and community care providers. Currently managed by phone and email, producing an average 5.4 hours from discharge order to bed-ready. Real deployments show 38% improvement in bed turnover when agentic coordination is introduced.[^4_3]

### Required Outcomes

- Predict discharge 24 hours in advance (before the order is written)
- Coordinate parallel downstream tasks simultaneously across 6–8 departments
- Route complex cases (housing, social support, language barriers) to social workers
- Ensure documentation completeness: discharge summary, medication reconciliation, follow-up bookings
- Provide ward nurses a single-pane view of discharge status across all patients


### Workflow Design

```
Continuous EMR monitoring → Prediction Agent (24hr horizon)
        → Pre-alert: pharmacy pre-prep, community care notice, family notification
        
Discharge order signed → Orchestration Agent
        → Parallel dispatch: [pharmacy] [transport] [cleaning] [family/carer] [documentation check]
        → Exception Agent → [social complexity] → Social worker
        → Completion verification → Nurse sign-off → Bed status update
```

The workflow is genuinely parallel, which means the orchestration layer is managing interdependencies, not just sequences. Transport cannot be confirmed until pharmacy is ready. Room cleaning cannot start until the patient has physically left. The agent must hold and update state across multiple simultaneous threads — a fundamentally different challenge from sequential pipelines.[^4_4]

### Where the Design Gets Hard

**The multi-principal conflict.** The hospital wants faster bed turnover. The patient wants a dignified, safe transition with adequate time for education. The insurer wants minimum length of stay. The community care provider wants adequate notice, not a two-hour pre-alert. These principals are structurally in conflict. The agent optimising for "efficiency" without an explicit principal hierarchy will default to whoever owns the system — the hospital — which may not align with patient outcomes.[^4_5]

**The clinical judgment boundary.** Discharge documentation completeness checking sounds like a verification task. It is, until it isn't. A discharge summary that fails to mention a new allergy revealed during admission, or a medication reconciliation that misses an interaction, is not a documentation formatting error — it is a patient safety event. The acceptance criteria that define "documentation complete" are deceptively difficult to specify without clinical expertise. A verification agent that cannot distinguish a formatting gap from a clinical gap should not be trusted to clear documentation unilaterally.[^4_6]

**The reversibility asymmetry.** Booking transport is reversible. Sending a patient education session that sets incorrect medication expectations is not — the patient leaves with wrong information and there is no easy mechanism to correct it post-discharge. Actions in this workflow span the full reversibility spectrum, and the platform must classify and gate them differently.

### Stakeholder Map — What Each Group Actually Experiences

- **Nurses:** freed from coordination calls, but now dependent on a system they cannot fully inspect. The failure mode is *automation complacency* — assuming the system has handled something it hasn't
- **Physicians:** largely unaware the system exists; benefit from knowing discharge will be smooth; risk of over-relying on the system's prediction model and discharging patients before the community support is truly ready
- **Patients:** faster, better-coordinated discharge; risk of feeling processed rather than cared for; no mechanism to contest the system's timeline
- **Community care providers:** receive better-prepared handoff packages, but the system's efficiency creates pressure on their capacity that they didn't agree to absorb
- **Hospital administration:** significant operational and financial benefit; bears full accountability if the system contributes to a readmission or adverse event[^4_3]


### The Instructive Lesson

This case makes the **integration reality problem** unavoidable. The EMR, pharmacy, transport booking, cleaning scheduling, and community care systems were not designed to share data. Each has its own schema, its own authentication model, its own update latency. The agentic platform must bridge systems whose owners have never agreed to align — and when one of those integrations breaks silently, the coordination agent operates on stale data with full confidence. The reliability of the whole system is bounded by its weakest integration, not its best agent.[^4_7]

***

## Case 3 (Complex): Water Supply Contamination Emergency — Government/Utility

**The scenario:** A water utility serving 500,000 people detects anomalous readings across multiple sensors. A contamination event may be developing. Over the following 72 hours, the situation requires simultaneous management across the utility, public health authority, local government, EPA, emergency services, and media. An agentic system supports situational awareness, multi-agency coordination, and public communication management throughout.

### Required Outcomes

- Real-time synthesis of sensor data, lab results, and epidemiological signals into a continuously updated situation picture
- Multi-agency notification with role-appropriate briefings at the right escalation threshold
- Public communication management — timely, accurate, consistent advice across channels (SMS alerts, website, social media, media statements)
- Resource coordination — bottled water logistics, alternative supply routing, repair and remediation sequencing
- Regulatory documentation — continuous, attributed record of every decision, action, and communication
- Recovery pathway — evidence-based recommendation on when and how to lift restrictions


### Workflow Design

```
Sensor anomaly → Detection Agent → Classification (routine / elevated / critical)
        → [critical] → Multi-agency notification package (role-differentiated)
        → Situation Synthesis Agent → Continuously updated Common Operating Picture
        
Public communication trigger → Draft Agent → Approval workflow [utility comms + health dept + elected official]
        → Published communication → Social monitoring Agent → Correction triggers

Resource coordination → Logistics Agent → Dispatch + tracking
        → Epidemiological monitoring Agent → Health system signal integration
        → Recovery recommendation Agent → Evidence threshold check → Human decision
```

The workflow is **not a pipeline** — it is a continuously running system that manages dozens of simultaneous processes over days, not minutes. The orchestration challenge is an order of magnitude beyond Case 2.[^4_8]

### The Design Problems That Only Appear at This Scale

**No coherent principal.** The utility has operational authority over the water system. The health department has authority over public health advice. Elected officials have political authority over emergency declarations. The EPA has regulatory authority over contamination response. These four authorities overlap, conflict, and operate on different timelines. An agent system designed around "the principal delegates to the agent" has no answer for a situation where four principals simultaneously and legitimately assert authority over the same action. This is not a governance edge case — it is the normal condition of public emergency management.[^4_9]

**Asymmetric irreversibility at societal scale.** Issuing a "do not drink" notice causes economic harm (hospitality, business closures), public anxiety, and political disruption. Not issuing it when warranted causes illness and potentially death. These are not symmetric mistakes, and an agent designed to minimise both equally will systematically under-trigger in uncertain conditions — precisely the opposite of what the precautionary principle demands. The risk threshold must be explicitly asymmetric, and who sets that asymmetry is a political and ethical decision, not a technical one.[^4_10]

**Communication as an attack surface.** A system with the authority to auto-publish emergency alerts is one of the highest-value targets imaginable for adversarial interference. Prompt injection via compromised monitoring data could trigger false alarms. A misconfigured communication agent could publish contradictory guidance to 500,000 people. The public communication workflow must have irreversible-action gates that cannot be bypassed — not as policy, but as structural constraint.

**Trust inversion.** At the start of an incident, humans make decisions and the system supports. As the system proves reliable, humans begin to trust it more heavily. But this trust accumulates at exactly the moment when conditions are most novel, most uncertain, and furthest outside the system's validated range. The highest-trust moment is also the highest-risk moment. This is the **automation surprise problem** at societal scale — humans who have offloaded cognition to the system have the least capacity to catch the system when it fails.

**Every output is legal evidence.** In the post-incident inquiry — and there will always be one — every recommendation the system made, every communication it drafted, every action it logged, will be examined. The audit trail is not a governance nicety; it is the documentation basis for determining whether the utility, the health department, and the elected officials acted responsibly. A system without complete, immutable, attributed records of every action is not a governable system.

### Stakeholder Map — Where Authority and Accountability Diverge

| Stakeholder | Wants from the system | Fears about the system |
| :-- | :-- | :-- |
| Utility operations | Accurate real-time picture, fast resource coordination | Being blamed for an AI recommendation they approved |
| Public health officials | Comprehensive data synthesis | AI issuing advice under their name without their approval |
| Elected officials | To be briefed first, not surprised | AI making decisions that get attributed to them |
| The public | Timely, accurate, consistent information | Contradictory or machine-generated communications in a crisis |
| Media | Transparency on what was known and when | AI producing inconsistencies that become the story |
| EPA/Regulators | Complete documentation, clear accountability chain | AI obscuring who made which decision |

### The Instructive Lesson

This case reveals the **fundamental limit of agentic automation**: the question of which decisions can be delegated to an agent and which cannot is not primarily a technical question. It is a question about *who bears accountability for outcomes*. In a public emergency, accountability cannot be delegated to a system. It lives with the humans whose names appear on the decisions. An agentic platform that doesn't structurally distinguish between decisions-as-agent-actions and decisions-as-human-accountable-acts will produce systems where accountability is distributed so widely it effectively disappears — and when it fails, no one is responsible.[^4_11]

***

## What the Three Cases Reveal Together

Placing these cases side by side, five design requirements emerge that no amount of abstract platform thinking would surface as clearly:

1. **Principal identification is not optional** — every system has a de facto principal even when one isn't defined. Making it explicit is the difference between a system that serves stakeholders and one that systematically advantages whoever owns the infrastructure
2. **Reversibility is a spectrum, not a binary** — and the most consequential actions are often not the obviously irreversible ones, but the *subtly irreversible* ones (wrong information reaching a patient; a public statement that creates a legal baseline)
3. **Integration failure is the most common real-world failure mode** — not hallucination, not misalignment, but a downstream system returning stale data that the agent treats as current
4. **Trust accumulation and risk accumulation move together** — the more operators trust the system, the further they are from catching its failure modes; platform design must actively resist this dynamic
5. **The boundary between agent decision and human decision must be drawn by accountable humans, not discovered at runtime** — and that boundary will be different in every case, which means a general-purpose platform cannot draw it for you
<span style="display:none">[^4_12][^4_13][^4_14][^4_15][^4_16][^4_17]</span>

<div align="center">⁂</div>

[^4_1]: https://www.rapidinnovation.io/post/ai-agents-for-government-key-components-applications-and-use-cases

[^4_2]: agent-design-principles-v0.2.md

[^4_3]: https://www.linkedin.com/pulse/bed-ready-process-isnt-solving-discharge-logistics-ai-vinayagam-rtmdc

[^4_4]: https://www.productiveedge.com/blog/redefining-care-transitions-with-agentic-ai

[^4_5]: https://pmc.ncbi.nlm.nih.gov/articles/PMC12092461/

[^4_6]: https://arxiv.org/pdf/2601.21113.pdf

[^4_7]: https://techexactly.com/blogs/agentic-ai-in-healthcare

[^4_8]: https://caio.waiu.org/p/respondai-ai-orchestrated-emergency-response-platform

[^4_9]: https://www.leidos.com/insights/agentic-ai-aims-cut-down-emergency-response-time-when-disasters-strike

[^4_10]: i-want-to-think-through-the-de-1uknqXF9SA6WXLfbDBtvQw.md

[^4_11]: https://itbrief.com.au/story/ai-agents-are-joining-the-public-service-who-s-governing-them

[^4_12]: https://realworlddatascience.net/applied-insights/case-studies/posts/2025/08/12/deploying-agentic-ai.html

[^4_13]: https://kodexolabs.com/agentic-ai-use-cases/

[^4_14]: https://www.novelvista.com/blogs/ai-and-ml/agentic-ai-in-healthcare

[^4_15]: https://web.superagi.com/the-evolution-of-ai-agents-in-public-sector-enhancing-citizen-experience-and-security-in-2025/

[^4_16]: https://www.authorea.com/doi/pdf/10.22541/au.176479422.22838930

[^4_17]: https://sunasterisk-global.com/?p=2544


---

# this has delivered rich insights already and it sets up our next steps excellently.

explore each use case through the lens of personas who are directly involved with the system and for all personas, apply an additional lens of trust building since an untrustworthy system is already a failure.

Designers - how do they design the system? what inputs are needed? what tools would assist? what is their expected output? what makes it challenging? what makes it rewarding?
Builders - how do they build the system? what makes it easy to build? what makes it enjoyable to build?
Users - how is the system used? how is it easy to use? how is it enjoyable to use?
Beneficiaries - how do the customers/patients/community most impacted by the success or failure of the system, involved in the system's design, development and operations?
Decision makers / owners - what do decision makers expect from the system? What do they not want?

This exercise surfaces something that no amount of abstract analysis reveals: **trust is not a single thing shared by everyone in a system — it is five entirely different relationships, each requiring different evidence, earned in different sequences, and broken by different failures.** The trust that builds confidence in a designer is invisible to a beneficiary. The accountability that matters to a decision maker may actively undermine a user's psychological safety. Designing for trust means designing for all five simultaneously, which is much harder than designing for any one.[^5_1][^5_2]

A consistent finding across real-world deployments runs underneath everything that follows: the most common cause of AI system failure is not the technology — it is the trust architecture. Systems that work technically fail because the people who operate them don't believe in them, the people affected by them weren't included, and the people accountable for them don't understand them.[^5_3]

***

## Case 1: Grant Application Screening

### Designers

The designer's primary challenge in this case is not technical — it is the **codification of implicit judgment**. Program staff have been making borderline eligibility decisions for years using criteria that have never been fully articulated. "Organisations working in the affordable housing space" is a sentence that every staff member interprets slightly differently. The design process, if done well, forces this implicit judgment into the open — which means it also forces disagreements that were previously invisible to surface.

This is both the most challenging and the most rewarding part of the designer's work. When the design process reveals that two experienced program officers have been applying materially different eligibility standards to borderline cases, the problem is not the AI — the problem was already there, and the design process has finally made it visible and fixable. Trust builds when designers frame this not as "the AI needs rules" but as "we're creating shared understanding of our own decision-making."

Inputs needed: historical application decisions with outcomes (especially borderline cases), all eligibility criteria documents across previous grant rounds, edge cases that required director-level sign-off, and — critically — the *reasons given for rejection* in previous rounds, which are often more informative than the criteria documents themselves. Tools that assist: co-design workshops with program staff using real (anonymised) applications, decision tree mapping, and a testing set of 50+ historical applications run against proposed criteria before any code is written.[^5_1]

**Trust architecture:** Designers build trust not by delivering a specification, but by running the system through 30–40 historical applications with program staff in the room, observing where the system agrees with what they would have done, and — crucially — investigating every disagreement together. This shared diagnostic exercise is more trust-building than any documentation.

### Builders

What makes this case relatively enjoyable to build is its bounded scope — document processing, classification, and structured output generation are well-understood problems with mature tooling. What makes it genuinely hard is that the edge cases matter disproportionately. An eligibility engine that gets 90% of cases right fails in practice, because the 10% it gets wrong will almost certainly include the cases that mattered most to someone.

The critical builder trust-building move is **making uncertainty visible at every step**. Rather than returning "INELIGIBLE," the system should return "INELIGIBLE (confidence 94%) — criterion 3.2 not met: applicant's stated geographic scope does not include the funded region" or "BORDERLINE (confidence 61%) — criterion 4.1 partially met: organisation works adjacent to but does not exclusively serve the target population — routing to program officer." The difference between these outputs is enormous for user trust. A binary output that is sometimes wrong destroys trust. A calibrated output that accurately communicates its own uncertainty builds it.[^5_3]

What makes building enjoyable here: the feedback loop is fast. You can run 200 historical applications through the system in minutes and see immediately where it aligns with human decisions and where it diverges. That visibility is rare in software development and deeply satisfying.

### Users (Program Staff)

The most common failure mode for grant screening implementations is not technical — it is what research calls **automation complacency in reverse**: staff who distrusted the system initially begin to over-trust it once they see it working correctly on routine cases, and then fail to scrutinise the borderline cases where human judgment is most needed. Designing against this is a platform responsibility, not a training issue.[^5_4]

For program staff, trust is built through a specific sequence: first, they observe the system handling cases they would have rejected (and agree with the outcome); second, they see it correctly flag a borderline case they would have missed; third, they correct a flagged case and see their correction accepted without friction. That third step is critical. If overriding the system feels bureaucratically punished — if it creates extra paperwork or requires justification to a supervisor — staff will stop doing it, and the feedback loop that improves the system dies.[^5_5]

What makes daily use enjoyable: staff who previously spent 60% of their time on administrative triage find themselves spending that time on substantive program work for the first time. The psychological shift from inbox-management to mission-work is significant and should not be underestimated as a motivator.

### Beneficiaries (Applicant Organisations)

Beneficiaries in this case — small, under-resourced nonprofits — are almost never involved in design and almost always disproportionately affected by system failures. A larger, well-resourced organisation can absorb a rejection and reapply; a small community organisation that loses funding because an AI misclassified their work may close.

The structural trust problem: beneficiaries have *less* visibility into an AI-mediated decision than a human-mediated one. With a human reviewer, there is at least the possibility of a phone call, a clarifying question, a relationship. With an AI classifier, there is a rejection letter that says nothing about the reasoning. This is not merely a UX problem — it is a justice problem that the design must address directly.[^5_1]

Practical trust-building mechanisms: a rejection notice that includes the specific criterion not met (not just "does not meet eligibility criteria"); a genuine contestation pathway with a human reviewer for borderline cases; and — ideally — involving representatives from small applicant organisations in testing the system before deployment. Their experience of the application process will reveal classification gaps that no internal testing will find.[^5_1]

### Decision Makers (Foundation Board and Executive)

Decision makers at this level want three things from the system that are in partial tension with each other: **efficiency** (staff time reclaimed), **consistency** (decisions that hold up under scrutiny), and **reputation protection** (no public story about an unfair AI).

What they most fear, but rarely articulate: a scenario where an AI rejection can be demonstrated to have systematically disadvantaged a particular type of organisation — geographically, by organisation size, or by the demographic of the communities served. This is not a hypothetical risk. Any classifier trained on historical decisions will inherit the biases of those historical decisions, including any systematic under-funding of particular community types.[^5_6]

The trust architecture at the decision-maker level requires a regular pattern analysis report: showing pass rates by application type, geography, and organisation size, comparing these to historical norms, and flagging deviations for board review. This is not just governance — it is the mechanism by which the system earns ongoing permission to operate.

***

## Case 2: Hospital Discharge Coordination

### Designers

This is the case where **the design process requires genuine clinical expertise** and cannot be adequately performed by generalist system designers. The question of whether a discharge summary is "complete enough" is not a formatting question — it is a clinical judgment about whether the receiving community care provider has the information they need to safely continue care. Getting this wrong has patient safety consequences.

The most valuable input in this design process is not the workflow documentation — it is the near-miss register: incidents where discharge coordination failures led to readmissions or adverse events. These cases surface the specific failure modes the system must prevent, and they reveal something important: the majority of failures are not from complex cases but from routine ones that fell through coordination gaps. The system's highest value is not in handling complexity — it is in ensuring that the routine never slips.[^5_7]

Designers build trust with clinical staff through **shared investigation of failure cases**. Sitting with a nurse and walking through a discharge that went badly — mapping every phone call made, every system checked, every gap in information — and then showing how the proposed system would have handled the same sequence, is the most trust-building design activity possible. It grounds the abstract system in felt clinical experience.

What makes this rewarding: the patient experience lens. When designers follow patients through the current discharge experience — the waiting in a ward bay dressed to go home, the confusion about what medications to take, the family member who drove two hours and then waited another three — the human value of coordination becomes visceral and clarifying.

### Builders

The honest truth about building this system is that the hardest problems are not AI problems — they are **integration problems**. The EMR, pharmacy system, transport booking, cleaning scheduling, and community care referral portal were not designed to share data. They have different schemas, different authentication models, different update latencies, and different governance requirements for access. Getting real-time data from all of them simultaneously is an engineering challenge that will consume the majority of the build time.[^5_8]

What makes it enjoyable: the parallel workflow orchestration is technically interesting. Coordinating dependent and independent tasks simultaneously, managing state across multiple concurrent threads, and surfacing exceptions intelligently — this is a genuinely sophisticated engineering problem. Unlike many enterprise software projects, the test cases are immediately intuitive (a real discharge is either coordinated or it isn't) and the feedback loop with clinical users is fast.[^5_9]

Builder trust-building requires **testability with real data**. A system tested only with synthetic cases will encounter production failure modes that testing never surfaced. The build should include a shadow-operation phase — running the system in parallel with manual coordination for 2-3 weeks before go-live — and comparing outcomes. This phase is not optional, and it is not just QA. It is the evidence base that gives clinical staff confidence that the system works.[^5_3]

### Users (Nurses, Social Workers, Pharmacists)

Research consistently shows that healthcare frontline workers fall on a spectrum from enthusiastic adopters to deeply sceptical non-adopters — and the sceptics are not irrational. They have lived through multiple waves of "this will save you time" technology that added complexity without benefit. Their credibility as critics of the system is higher than any designer's.[^5_5]

The nurse's trust relationship with this system is fundamentally about **accountability clarity**. If the system fails to confirm pharmacy and transport ends up waiting for a delayed medication, who bears responsibility for the delayed discharge? The nurse who approved the discharge order, or the system that didn't flag the dependency gap? This question must be answered explicitly before go-live — not in legal small print, but in the operational protocol that nurses sign off on. Without a clear answer, nurses will over-check every system output (creating the cognitive load the system was meant to reduce), and trust will never reach steady state.[^5_4][^5_3]

Social workers have the most complex cases and the least structured data — which means the system adds the least value for their work and may add friction if it expects structured inputs they cannot provide. A trust-building choice: design the system so social workers can mark a case as "social complexity — human-led coordination" and have the system step back gracefully. Forcing complex cases through automated workflows is both clinically dangerous and a fast path to social worker rejection of the system.

### Beneficiaries (Patients and Families)

Patients are almost entirely absent from the design conversation for hospital discharge systems, which is remarkable given that they are both the primary beneficiary and the primary person affected by failure. The clinical and operational focus of design tends to treat discharge as a workflow-management problem when it is simultaneously a human experience of anxiety, confusion, and — if done well — relief and empowerment.[^5_1]

The most significant untapped design input is the **patient experience of the current system**. What information do patients most need and consistently don't receive? At what point in the process do families feel most anxious? What communication channel reaches them reliably? These questions are rarely asked, but their answers would reshape the system's design significantly. A family-facing notification layer — "your family member's discharge is being prepared, expected time is 3pm, transport is confirmed" — is an obvious trust-building addition that adds relatively little technical complexity.

The trust test: would the hospital be comfortable telling a patient "an AI system coordinated your discharge"? If the honest answer is "we'd probably not mention it," the system has a hidden trust problem that hasn't been designed against. Transparency about AI's role, framed correctly, doesn't undermine trust — hiding it does, when it's eventually discovered.[^5_2]

### Decision Makers (Hospital Executive, CMO, Clinical Governance)

Hospital leadership wants three things that are in genuine tension: **operational efficiency** (faster bed turnover, reduced length of stay), **clinical safety** (no adverse events attributable to the system), and **regulatory compliance** (documentation that satisfies clinical governance and accreditation requirements).

What decision makers most want to avoid is a **retrospective accountability scenario**: a patient readmitted within 30 days, a parliamentary question or coroner's inquiry, and a finding that the AI system made a recommendation that clinical staff followed without adequate scrutiny. This scenario — not the day-to-day operational risk — is what governs executive caution around deployment. The trust architecture for this level requires: a clear documented boundary between what the system decides and what humans decide; an immutable audit trail of every system action; and a clinical governance review process with specific authority to suspend the system if patterns indicate risk.[^5_10]

The most trust-building thing a decision maker can do, paradoxically, is build a clear escalation and suspension protocol *before* go-live. Having a documented process for "how we pause the system if something goes wrong" signals genuine commitment to human oversight — and it actually makes expansion faster, because the governance framework de-risks each new deployment.[^5_2]

***

## Case 3: Water Supply Contamination Emergency

### Designers

This is the design challenge with no adequate analogue in the other cases: **you are designing for a scenario that will never occur during design, and may never occur during the system's operational life**. The people who will use the system in a real emergency will encounter it for the first time under conditions of extreme stress, time pressure, and incomplete information. Their ability to trust the system in those moments depends entirely on whether they trusted it in the tabletop exercises that preceded the event.

This means the design process is as much about **trust rehearsal** as system specification. Tabletop exercises where emergency managers use the actual system interface to work through simulated scenarios are not just testing — they are the primary trust-building mechanism. Every instance where the system surfaces a piece of information that the emergency manager would have missed builds latent trust. Every instance where it produces something confusing or wrong builds latent distrust. The ratio of these instances over months of exercises is what determines how much the system will be used when it matters.[^5_11]

The multi-principal problem makes the design process politically complex. Designers must facilitate agreement between the utility, the health department, local government, and the EPA on a shared decision framework — including the question of which principal's authority takes precedence when they conflict. This is not a technical question. It is a negotiation, and it requires political skill as well as design skill. Many of these projects stall here.

### Builders

The technical scope of this system is genuinely at the frontier of what is currently buildable. Real-time sensor data synthesis across heterogeneous monitoring infrastructure, multi-agency notification routing, public communication management, resource coordination, and regulatory documentation — simultaneously and reliably under crisis conditions — is not a standard enterprise integration challenge.[^5_12]

What makes it enjoyable for builders who take it on: **the stakes clarify the architecture**. Every architectural decision can be tested against the question "what happens to 500,000 people if this component fails?" That clarity — rare in enterprise software — is intellectually and professionally compelling. The non-negotiable audit trail requirement also drives builders toward genuinely good architecture: immutable event logs, attributed actions, replicate-able state reconstruction. These are the right technical choices regardless of the use case, and mission-criticality forces them into the design rather than leaving them as aspirational.[^5_11]

Trust-building for builders requires something most projects don't have: **a realistic failure mode testing programme**. Not unit tests and integration tests, but adversarial testing: what happens when a sensor returns anomalous readings that look like a contamination event but aren't? What happens when the primary notification channel is unavailable during an actual event? What happens when two agencies publish contradictory communications through different channels simultaneously? These scenarios need to be designed and tested before go-live, not discovered in production.

### Users (Emergency Managers, Public Health Officials, Communications Teams)

Emergency professionals are among the most trust-conservative users in any domain. They have detailed protocols developed over decades, they have experienced system failures in the field, and they know that trusting the wrong tool at the wrong moment can cost lives. They will not adopt a system because management told them to — they will adopt it because it makes them better at their job in ways they can directly observe.[^5_4]

The communications team has a specific trust requirement that must be designed as a structural constraint: **no communication can be published without explicit human approval, and this constraint cannot be bypassed by any system condition**. Not in a crisis. Not when time pressure is extreme. Not when the person who normally approves is unavailable. The gate must be human, it must be irreversible once passed, and it must be documented. If communications staff learn that this constraint can be overridden by anyone under certain conditions, their trust evaporates immediately and permanently.

For all emergency users, the system's value must be demonstrable in *non-emergency* conditions first. Running the system during routine monitoring — daily sensor checks, scheduled maintenance notifications, minor quality events — builds familiarity and trust before the extraordinary event occurs. A system that only exists for the crisis scenario will be unfamiliar when it's most needed.

### Beneficiaries (The Public)

The public are the most numerous, least involved, and most consequentially affected beneficiaries in this case. Their interaction with the system is entirely mediated through communications they receive — SMS alerts, website updates, media statements — and they have no visibility into the system that produced them.[^5_13]

Public trust is conditional on three things that are each imperfectly satisfied: transparency (do they know AI was involved?), accountability (is there a human who takes responsibility if the communication was wrong?), and accessibility (did the system reach everyone equally?). The last is most consistently neglected. Households without smartphones, non-English speakers, elderly residents with limited digital access, and people in areas with poor mobile coverage all receive later, less clear communications — which means the system's failure modes are disproportionately borne by the populations already most vulnerable.[^5_13]

The most practical trust-building mechanism for public beneficiaries: **post-incident community review sessions** where affected community members evaluate what they received, when they received it, whether it was clear, and what they needed that they didn't get. This feedback should directly shape the next iteration of the communication templates and channel strategy. This almost never happens after contamination incidents — the focus shifts to remediation — and the same communication failures recur in the next event.

### Decision Makers (Utility CEO, Health Minister, Elected Officials, EPA)

Decision makers in this case face the **accountability fragmentation problem** in its most acute form. When four agencies with overlapping authority all have a stake in the system's actions, and something goes wrong, the incentive for each is to demonstrate that the decision was made by another party. The system's audit trail — far from being merely a governance nicety — is the primary structural mechanism that prevents this fragmentation from destroying accountability entirely.[^5_2]

What elected officials and executives most want from this system: to be informed first, to have options presented with evidence, and to have documentation that they acted responsibly. What they most fear: learning that the system published a communication in their name without their approval; being unable to explain the system's recommendation in a parliamentary hearing; or being held accountable for an automated action they weren't aware was taken.[^5_14][^5_6]

The most instructive trust-building decision at the decision-maker level is one that initially seems counterintuitive: **investing in the system's graceful failure mode before its operational capability**. A decision maker who knows that the system will safely pause and escalate to humans when it encounters something outside its validated range trusts the system's normal operation more, not less. The confidence to deploy comes from knowing what happens when it fails — not from assurances that it won't.

***

## The Cross-Cutting Pattern

Placing all three cases and all five personas together, a single trust architecture principle emerges that no individual case fully reveals:

**Trust is built from beneficiaries outward, but it's currently built from decision makers inward.**

The people with the most power in the system — decision makers, then designers, then builders — make the trust decisions. The people with the least power — beneficiaries, then users — live with the consequences. Real-world deployments consistently show that when this order is inverted — when beneficiary perspectives shape design before decision-maker preferences do — the systems that result are both more trusted and more effective. The platform that structurally forces beneficiary participation into the design process, rather than treating it as optional best practice, would address the single most consistent failure mode in deployed agentic systems.[^5_14][^5_3][^5_1]
<span style="display:none">[^5_15][^5_16][^5_17][^5_18][^5_19]</span>

<div align="center">⁂</div>

[^5_1]: https://www.pmc.gov.au/resources/long-term-insights-briefings/how-might-ai-affect-trust-public-service-delivery/ai-trust/insight1

[^5_2]: https://lens.monash.edu/responsible-ai-is-now-a-governance-risk-not-an-ethics-debate/

[^5_3]: https://www.forbes.com/councils/forbesbusinesscouncil/2025/10/07/the-barrier-to-wide-scale-ai-adoption-in-healthcare-is-trust-not-technology/

[^5_4]: https://www.fmj.co.uk/frontline-workers-trust-ai-and-automation-to-keep-them-safe/

[^5_5]: https://pmc.ncbi.nlm.nih.gov/articles/PMC12310525/

[^5_6]: https://www.linkedin.com/pulse/decision-accountability-who-responsible-when-ai-acts-gupte-nhulf

[^5_7]: https://www.linkedin.com/pulse/bed-ready-process-isnt-solving-discharge-logistics-ai-vinayagam-rtmdc

[^5_8]: https://techexactly.com/blogs/agentic-ai-in-healthcare

[^5_9]: https://www.sciencedirect.com/science/article/pii/S092575352500253X

[^5_10]: https://aign.global/ai-governance-insights/patrick-upmann/who-is-accountable-when-an-ai-system-makes-erroneous-decisions-that-cause-harm/

[^5_11]: https://caio.waiu.org/p/respondai-ai-orchestrated-emergency-response-platform

[^5_12]: https://www.authorea.com/doi/pdf/10.22541/au.176479422.22838930

[^5_13]: https://thepolicymaker.appi.org.au/bridging-public-trust-in-ai-why-inclusive-ai-governance-is-essential-public-infrastructure/

[^5_14]: https://dial.global/successful-ai-legible-and-explicable-design/

[^5_15]: https://www.unleash.ai/unleash-world/empowering-the-frontline-workforce-with-ai-and-human-centric-leadership/

[^5_16]: http://ijeret.org/index.php/ijeret/article/download/405/386

[^5_17]: https://www.sciencedirect.com/science/article/pii/S0278431925003743

[^5_18]: https://www.tandfonline.com/doi/full/10.1080/23311975.2024.2442550

[^5_19]: https://www.finance.gov.au/about-us/news/2025/introducing-aps-ai-plan


---

# I love the cross-cutting pattern insight as it supports so much or our prior thinking and values.

From the PoV of the stakeholder groups, across case studies, what have we learned?

This synthesis is worth doing carefully — not as a summary of what was said, but as an extraction of what the cases revealed that no single case alone could have shown. The three cases serve as a stress test: when a finding holds across grant screening, hospital discharge, and water emergency management simultaneously, it is not coincidence — it is structural.[^6_1]

***

## What Designers Taught Us

The constant across all three cases: **the most valuable design inputs are failure cases, not ideal cases**. Program officers' borderline decisions, hospital near-misses, contamination incident reports — these reveal what the system must handle that the happy-path documentation never shows. A designer who only reads the specification documents and never studies the failures is designing for a world that doesn't exist.[^6_1]

What changes with complexity is the *nature* of the design challenge itself:


| Case | Core design challenge | What it requires |
| :-- | :-- | :-- |
| Grant screening | Codifying implicit, unspoken judgment | Facilitated co-design with practitioners |
| Hospital discharge | Mapping competing clinical priorities | Domain expertise that cannot be substituted |
| Water emergency | Negotiating between competing authorities with legal standing | Political skill as much as design skill |

The shift from Case 1 to Case 3 is profound: at Case 3, the designer is no longer primarily a system architect — they are a mediator of a multi-principal governance problem. Most designer training prepares people for Case 1 and assumes the rest scales linearly. It doesn't.[^6_2]

The deepest designer insight is that **the design process is itself trust infrastructure** — it is not merely a precursor to the system. When program officers discover they've been applying eligibility criteria differently for years, that discovery is a trust-building event. When nurses walk through a discharge failure and see how the proposed system would have handled it, that shared investigation is more trust-building than any documentation. The design process either builds or forecloses the shared understanding that makes adoption possible.[^6_1]

***

## What Builders Taught Us

The structural finding that holds across all three cases without exception: **the hardest problems are integration problems, not AI problems**. Not prompt quality, not model selection, not orchestration topology — it is the reality that the systems an agent must connect to were not designed to share data, operate at the same latency, or speak the same schema. Every builder who has discovered this in production could have discovered it in design, but the integration reality is consistently underweighted at the start.[^6_3]

The most important trust-building activity across all cases is **shadow operation** — running the system in parallel with existing manual processes before go-live. This mechanism serves multiple functions simultaneously: it generates the evidence base that gives clinical staff, emergency managers, and program officers confidence; it surfaces failure modes that testing with synthetic data never finds; and it creates a shared diagnostic experience between builders and users that is more trust-building than any demo.[^6_4]

What changes with complexity is testability — the inverse correlation between stakes and testability is one of the sharpest findings from the exercise:

- Grant screening: 200 historical applications can be processed in minutes; the feedback loop is immediate and intuitive
- Hospital discharge: shadow operation over 2–3 weeks provides adequate evidence, but real clinical complexity is harder to synthesise in test conditions
- Water emergency: the extraordinary event you're designing for may never occur during the system's operational life — there is no test that fully substitutes for the real scenario

This inverse relationship has a critical implication for platform design: **the systems that most need rigorous pre-deployment testing are the ones least amenable to it**. A platform that only supports testing regimes suitable for routine cases will systematically under-validate the high-stakes deployments.[^6_5]

***

## What Users Taught Us

Users are the most consistently accurate critics of these systems across all three cases. This is not because they are resistant to change — it is because they hold operational knowledge that designers and builders structurally cannot have, and their scepticism is epistemically justified.[^6_6]

Three things are constant regardless of case:

- **The trust-building sequence is invariant**: agreement on easy cases → revealed value on hard cases → frictionless override capability. This sequence cannot be shortcut. A system that proves itself on easy cases but hasn't yet demonstrated value on hard ones has not earned trust for hard cases. A system that doesn't provide frictionless override will be abandoned when it matters most[^6_7]
- **Override capability is not a safety feature — it is the feedback mechanism that improves the system.** Every time a user overrides correctly, and that correction is captured, the system learns. If overriding feels bureaucratically punished, users stop doing it, and the improvement loop dies. This connection between override design and improvement capability is rarely articulated in platform thinking[^6_1]
- **The accountability/input mismatch is structural and persistent.** Users bear operational accountability for outcomes — the nurse is responsible if discharge fails, the program officer explains a rejected grant — but have the least input into design. This mismatch doesn't create resistance; it creates a specific type of trust collapse: the user who feels accountability without control cannot build genuine trust in the system, only compliance with it[^6_8]

What changes with complexity is the **stakes of the automation complacency problem**. In all three cases, smooth operation in routine conditions builds over-trust that then fails in exceptional conditions. But the consequences scale: a missed borderline grant case is a disappointment; unchecked automation in a clinical case is a patient safety event; automation complacency in a water emergency is a public health failure. The platform requirement this generates — actively designing against over-trust, not just against under-trust — is currently absent from every general-purpose agentic platform.[^6_5][^6_4]

***

## What Beneficiaries Taught Us

Beneficiaries are the single most important design informant in all three cases and the single most consistently excluded one. This is the finding that most directly challenges current practice — and it connects directly to your framework's commitment to human flourishing as a first principle, not an afterthought.[^6_9]

What's consistent across cases:

- **The failure modes that most harm beneficiaries are the ones least visible to designers.** A rejection notice that is technically accurate reads entirely differently to a small nonprofit than to the program officer who wrote the criteria. A discharge that is statistically on-time is experienced as being rushed and confused by the patient. A public alert that reaches 94% of residents is experienced as silence by the 6% it missed — who are usually the most vulnerable. The gap between system performance from the inside and system impact from the outside is not measurable without beneficiary participation[^6_2]
- **Beneficiaries have less recourse in AI-mediated decisions than in human-mediated ones, at the point where recourse matters most.** With a human reviewer there is the possibility of a conversation, a clarification, a relationship. With an AI classifier there is a decision letter. This is not a UX problem — it is a justice problem that the design must address structurally, not aspirationally[^6_10]
- **Beneficiary participation is a design quality mechanism, not just an ethical obligation.** Their experience of the current system will surface classification gaps, communication failures, and access inequalities that no internal testing will find. Treating it as optional best practice rather than required input consistently produces systems with the same preventable failures across iterations[^6_2]

What changes with complexity is the *scale of the participation gap*. A grant applicant organisation can at least respond to a survey or participate in a focus group. A hospital patient is often physically unable to participate in design research during the period when their experience is most relevant. The public affected by a water emergency has no structured participation mechanism at any stage. As complexity and stakes increase, the participation gap widens at exactly the point where it should be narrowing.[^6_10]

***

## What Decision Makers Taught Us

The consistent finding: decision makers want **efficiency, consistency, and accountability protection** — in that order. What they most fear is not the system failing but being unable to explain or defend a decision made partly by the system when scrutiny arrives. This fear is rational and should be designed for, not dismissed.[^6_11]

What changes with complexity is how diffuse accountability becomes — and diffuse accountability creates a specific failure dynamic:

- **Case 1:** One foundation bears full accountability. Fear of public reputation damage is a sufficient governance driver
- **Case 2:** Hospital leadership bears accountability, but it's shared with clinical governance, the CMO, and indirectly with the system vendor. Each party has an incentive to demonstrate the decision was made by another
- **Case 3:** Four agencies with legal authority, each with incentive to show the decision rested with another. The accountability fragmentation problem in its most acute form[^6_12]

The counterintuitive finding across all three: **the most trust-building decision a decision maker can make is investing in the failure protocol before the success case**. Building the suspension and escalation procedure before go-live signals genuine commitment to human oversight. It also makes expansion faster — the governance framework de-risks each new deployment rather than requiring it to be rebuilt from scratch. Decision makers who understand this invest early; those who don't discover it after the first significant failure.[^6_13]

The deepest decision-maker insight connects back to your framework's principle that structural ethics are enforced by design, not declaration. Decision makers who believe that a governance policy document provides adequate constraint have made a declaration, not a structural commitment. The systems that fail accountability scrutiny are almost always ones where the governance was declarative — where "the humans are responsible for reviewing AI recommendations" existed as a protocol rather than as an enforced gate that the system structurally required.[^6_9][^6_13]

***

## The Cross-Persona Synthesis

Placing all five personas and all three cases together, six findings emerge that no individual case or persona reveals alone:

**1. The trust chain has a fixed directionality that is currently being violated.** Trust must be built from beneficiaries outward — because the system that beneficiaries trust provides the foundation on which user trust, designer confidence, and decision-maker accountability all rest. When built in the opposite direction (decision-maker approval → designer specification → builder implementation → user adoption → beneficiary outcome), the chain consistently breaks at the same point: users adopt systems that beneficiaries don't trust, and accountability concentrates at the bottom of the hierarchy, not the top.[^6_9][^6_2]

**2. The verification gap affects every persona differently but breaks trust at each level for the same reason.** Designers can specify but not verify their specifications were implemented as intended. Builders can test but not test every condition. Users can observe outputs but not audit reasoning. Beneficiaries can experience outcomes but not inspect the process. Decision makers can approve but not understand. Each persona's inability to verify independently of the others creates a chain of inherited trust that doesn't compound — it accumulates risk at each transfer.[^6_1]

**3. The feedback loop that would improve the system is broken at every case level.** Grant applicants don't receive specific enough feedback to improve future applications — so the same misclassifications recur. Patients don't systematically report coordination failures — so hospitals don't know the real failure rate. The public has no structured mechanism for evaluating emergency communications — so the same gaps recur in the next incident. The absence of beneficiary feedback into the improvement loop is not a peripheral concern — it is the primary reason these systems plateau rather than improve.[^6_9]

**4. The system that works best in normal conditions is most dangerous in exceptional ones** — and this is not a coincidence but a causal mechanism. Smooth operation produces over-trust. Over-trust produces reduced scrutiny. Reduced scrutiny is exactly the condition that allows the first genuine exception to fail silently. The cases don't differ in *whether* this happens — they differ only in the consequences when it does.[^6_5]

**5. Participation is the universal trust mechanism, but it is currently treated as optional.** In every case, the groups most involved in design were most trusting. In every case, the groups least involved were least trusting and most affected. The mechanism is causal: involvement creates understanding, understanding enables appropriate trust calibration, appropriate trust calibration leads to better system outcomes. The platform that structurally enforces participation — rather than leaving it to project discipline — addresses the single most consistent failure mode in deployed agentic systems.[^6_2]

**6. General-purpose platforms cannot resolve the principal identification problem — and this is where most real-world failures begin.** Every case study has a principal identification problem at its core. In grant screening, is the agent serving the foundation or the applicants? In hospital discharge, is it serving the patient, the hospital, or the insurer? In water emergency, which of four legal authorities is the principal? A general-purpose platform that leaves this question to be "configured" by the deploying organisation is leaving the single highest-consequence design decision undecided. The organisations that actually resolve it are the ones whose systems hold up under scrutiny. The ones that don't resolve it discover the answer when something goes wrong.[^6_11][^6_9]
<span style="display:none">[^6_14][^6_15]</span>

<div align="center">⁂</div>

[^6_1]: agent-design-principles-v0.2.md

[^6_2]: https://www.pmc.gov.au/resources/long-term-insights-briefings/how-might-ai-affect-trust-public-service-delivery/ai-trust/insight1

[^6_3]: https://techexactly.com/blogs/agentic-ai-in-healthcare

[^6_4]: https://www.forbes.com/councils/forbesbusinesscouncil/2025/10/07/the-barrier-to-wide-scale-ai-adoption-in-healthcare-is-trust-not-technology/

[^6_5]: i-want-to-think-through-the-de-1uknqXF9SA6WXLfbDBtvQw.md

[^6_6]: https://pmc.ncbi.nlm.nih.gov/articles/PMC12310525/

[^6_7]: https://www.fmj.co.uk/frontline-workers-trust-ai-and-automation-to-keep-them-safe/

[^6_8]: https://www.sciencedirect.com/science/article/pii/S092575352500253X

[^6_9]: framework-principles-v0.4.md

[^6_10]: https://thepolicymaker.appi.org.au/bridging-public-trust-in-ai-why-inclusive-ai-governance-is-essential-public-infrastructure/

[^6_11]: https://www.linkedin.com/pulse/decision-accountability-who-responsible-when-ai-acts-gupte-nhulf

[^6_12]: https://aign.global/ai-governance-insights/patrick-upmann/who-is-accountable-when-an-ai-system-makes-erroneous-decisions-that-cause-harm/

[^6_13]: https://lens.monash.edu/responsible-ai-is-now-a-governance-risk-not-an-ethics-debate/

[^6_14]: review-the-agent-design-framew-AfD0jfBJTtGLpqIwDzFqcQ.md

[^6_15]: beyond-expected.md


---

# How does this analysis guide us towards designing a system that addresses the challenges identified?

disregard any existing systems or tools and focus on first principles.

The analysis generates something more specific than a list of design requirements — it generates a **logical derivation**. Each identified challenge, traced to its structural root, demands a specific system property. What follows is that derivation, from first principles, without reference to existing platforms.[^7_1][^7_2]

***

## The Fundamental Reframing

Before deriving what the system must contain, the framing of the design problem must shift.

The standard framing: build a system that performs tasks correctly. This framing produces technically capable systems that fail in operation — the grant screener that classifies correctly 90% of the time, the discharge coordinator that breaks when the EMR has a 15-minute lag, the emergency manager who follows the system's recommendation into a novel scenario it was never validated against. Correctness is necessary but insufficient.

The first-principles reframing: **build a system that maintains trustworthy relationships between principals, agents, and beneficiaries over time, within which correct task performance is a consequence**. This reframing changes what the system must be before it acts, what it must do while acting, and what it must provide after acting. It also changes which design failures are fatal — a system that is technically correct but structurally unaccountable is not a working system. It is a liability.[^7_2]

This reframing is not philosophical — it has direct architectural consequences. A system designed for correctness needs a verification layer. A system designed for trustworthy relationships needs a legitimacy substrate, an integration reality model, an action classification engine, a verification-attribution layer, a participation-feedback mechanism, and a trust calibration layer. None of these are the same thing.[^7_3]

***

## From Challenges to Required Properties

The case study analysis generated six cross-cutting failures. Each one, traced to its structural root, yields a required system property that no amount of agent capability will substitute for.


| Challenge identified | Structural root | Required system property |
| :-- | :-- | :-- |
| Trust built from decision-makers inward, not beneficiaries outward | No structural representation of who is served or who bears consequences | **Legitimacy Substrate**: explicit registration of principals, beneficiaries, and their authority relationships before activation |
| Integration failure is the most common real-world failure mode | External data treated as uniformly reliable when it isn't | **Integration Reality Layer**: every external connection modeled with currency, reliability, and scope properties that propagate into agent confidence |
| The boundary between agent and human decisions is discovered at runtime | No pre-runtime classification of which actions belong to which actor | **Action Classification Engine**: reversibility × authority matrix as the native execution model, not a configurable policy |
| Accountability cannot be delegated to a system | No mechanism for preserving accountability attribution across personas, time, and organizational transitions | **Verification-Attribution Layer**: persona-appropriate, immutable evidence chains that hold up under external scrutiny |
| Participation is the universal trust mechanism but treated as optional | Beneficiary and user input is a best practice, not a structural gate | **Participation-Feedback Layer**: structural preconditions for beneficiary participation before deployment, and override-as-learning during operation |
| Automation complacency is the real failure mode in high-trust, routine systems | No mechanism for detecting or managing over-trust | **Trust Calibration Layer**: active measurement and management of both under-trust and over-trust across all personas |


***

## Layer 1: The Legitimacy Substrate

The deepest finding from the case studies is that the principal identification problem is not a governance edge case — it is the default condition of any non-trivial deployment. Grant screening has two competing principals (foundation and applicants). Hospital discharge has four (patient, hospital, insurer, community care). Water emergency has four agencies with legal authority in contested overlap.[^7_2]

A system without a legitimacy substrate defaults to serving whoever owns the infrastructure. This is not a neutral choice — it is a values choice made by omission, and it systematically advantages those with the most technical access over those with the most consequential exposure.

From first principles, the legitimacy substrate requires:

- **Principal registry**: every entity that has delegated authority to the system, with the bounds of that authority, registered before any agent is activated. Not as documentation — as structural data that governs which operations are permitted
- **Beneficiary registry**: every entity or class of entity that bears the consequences of the system's actions, with a structured representation mechanism that gives them standing in the system's design and operation
- **Authority model**: explicit definition of which principals have authority over which action classes, and in what precedence order when principals conflict. A principal hierarchy that exists only in documentation will be resolved by whoever is in the room at the moment of conflict
- **Accountability assignment**: which human actors bear responsibility for which classes of decision, recorded immutably before deployment. This is not role documentation — it is the evidence that accountability was assigned before the system acted

The critical design principle: **the legitimacy substrate is not configurable during operation**. Once established and activated, it can be revised only through a defined change-control process that requires the same principals who established it. A system whose principal hierarchy can be modified by whoever has administrative access has no principal hierarchy — it has a fiction.[^7_1]

***

## Layer 2: The Integration Reality Layer

The most consistent finding across all three cases: integration failure is the most common real-world failure mode, and current system design treats external connections as infrastructure rather than as first-class design concerns.[^7_3]

From first principles, every external data source has three properties that bound what the system can safely do with it:

- **Currency**: what is the lag between real-world state and the data the system receives? A 15-minute pharmacy lag is invisible to an agent that treats timestamps as reliable
- **Reliability**: what is the error rate of this data source, and what types of errors does it produce? A sensor that occasionally misreads pH is different from one that occasionally returns null — but neither should be treated as fully reliable without explicit modeling
- **Scope**: what does this data source not cover? The gap between what the system can see and what is actually true is where the most consequential failures hide

The integration reality layer requires that every external connection is modeled with these three properties, and that these properties **propagate into the agent's confidence about its outputs**. An agent drawing conclusions from three data sources — one with 5-minute lag, one with 15-minute lag, and one that hasn't reported in 2 hours — should have a combined confidence estimate that reflects the reliability of its inputs, not just the quality of its reasoning.

This has a specific architectural implication: **action classification (Layer 3) must take integration reliability into account**. An action that is reversible under normal conditions may become effectively irreversible if the data it's based on turns out to be stale. The classification is not static — it is a function of the current reliability state of the system's inputs.[^7_2]

***

## Layer 3: The Action Classification Engine

Every action an agent considers must be classified across two dimensions before execution. This is not a policy check — it is the native execution model. An unclassified action does not execute.[^7_1]

**Dimension 1: Reversibility**

- **Read-only**: the action changes no state in the world
- **Reversible**: the action changes state, but that state can be restored at proportionate cost
- **Irreversible**: the action changes state permanently or at prohibitive restoration cost

The critical design insight: reversibility is not binary and it is not static. The same action (sending a notification) may be reversible in one context (internal draft notification) and irreversible in another (public communication to 500,000 people). Classification must be contextual, not categorical.

**Dimension 2: Authority Required**

- **Single principal, clear authority**: the action is within the uncontested authority of one principal
- **Single principal, bounded authority**: the action approaches the limits of a principal's authority and requires explicit confirmation
- **Multiple principals, aligned**: the action requires authorization from multiple principals who are expected to agree
- **Multiple principals, contested**: the action is within the claimed authority of multiple principals who may not agree

The intersection of these two dimensions generates the execution path:


|  | Reversible | Irreversible |
| :-- | :-- | :-- |
| **Single principal, clear** | Execute, record | Halt → human gate → execute with attribution |
| **Single principal, bounded** | Execute with explicit authority confirmation | Halt → explicit principal confirmation → human gate |
| **Multiple principals, aligned** | Execute with multi-principal notification | Halt → quorum confirmation → human gate |
| **Multiple principals, contested** | Halt → authority resolution → execute only after resolution | Halt → do not execute until authority conflict is resolved at the legitimacy substrate level |

The bottom-right cell — irreversible action with contested principals — is the design case that reveals most clearly why this layer must be structural. This is exactly the situation in the water emergency (four agencies, contested authority, life-safety consequences). A system without a native classification engine will reach this cell and default to whatever behavior it was designed to default to, which will satisfy no one and be defensible to no one.[^7_2]

***

## Layer 4: The Verification-Attribution Layer

Your framework's trust principles (T1 through T7) address this layer comprehensively for the internal design of agents. What the case study analysis adds are three requirements that emerge specifically from the external trust architecture:[^7_1]

**Persona-appropriate evidence.** The evidence that satisfies a designer ("the specification was implemented as intended") is different from the evidence that satisfies a user ("the system did what I thought it did"), different again from the evidence that satisfies a beneficiary ("the decision that affected me was made by the right process"), and different from the evidence that satisfies a decision-maker ("I can explain and defend this decision under external scrutiny"). A verification-attribution layer that produces only technical audit logs satisfies only the builder's evidence requirement.

**Accountability persistence through organizational transitions.** When the nurse who approved a discharge leaves the hospital, when the foundation's program director changes, when the emergency management chief retires, the accountability chain must survive. This means the chain is structured around roles and decisions, not named individuals — and the evidence is sufficient for a third party who was not present to evaluate the decision's legitimacy.

**Attribution at the decision boundary, not just the output boundary.** The most consequential attribution question is not "who produced this output?" but "who made the decision that this output acted on?" In a system where agents produce recommendations and humans approve them, the approval event and its context must be as richly attributed as the recommendation that preceded it. A human gate that records only "approved: yes" is attribution in name only.[^7_3]

***

## Layer 5: The Participation-Feedback Layer

This is the layer most completely absent from current agentic platforms and most consistently identified by the case study analysis as the primary mechanism through which trust is built or foreclosed.[^7_1]

The layer has three structurally distinct mechanisms:

**Design-time participation gate.** Before any system is deployed, structured evidence must exist that beneficiaries and users were genuinely included in design. Not as consultation — as input that demonstrably shaped the design. The evidence must include: what was heard from each group, how it changed the design (or why it didn't), and who is accountable for that decision. This evidence is a precondition of deployment, not a post-deployment report.

This is the structural response to the cross-cutting finding: participation is the universal trust mechanism but is treated as optional. Making it a structural gate removes the option. Designers cannot claim they "ran out of time for user testing" if deployment is structurally blocked until participation evidence exists.[^7_3]

**Override-as-learning.** Every user override of an agent's output is a structured learning signal: what the agent recommended, what the human did instead, and if capturable, why. This is not merely operational monitoring — it is the primary mechanism by which the system learns where its reasoning diverges from informed human judgment.

The current framing — overrides as exception handling — reverses the priority. Overrides are not errors to be minimized. They are the most valuable signal the system receives. A system where override is bureaucratically punished or structurally onerous is a system that has eliminated its primary learning mechanism while retaining the appearance of human oversight.[^7_1]

**Beneficiary outcome tracking.** The system must track outcomes as experienced by beneficiaries, not only as measured by operational metrics. A discharge that is statistically on-time but experienced by the patient as rushed and confusing is a failure the operational dashboard will not show. Beneficiary outcome tracking requires structured mechanisms for beneficiaries to report their experience — not as customer satisfaction scores, but as signal that feeds directly into the system's improvement loop.

***

## Layer 6: The Trust Calibration Layer

This layer has no analogue in existing frameworks and is genuinely derived from the case study analysis. The finding was: **automation complacency is the most dangerous failure mode in high-trust, routine systems — and it is currently neither measured nor managed**.[^7_3]

Trust calibration has two directions, both required:

**Under-trust detection.** When users are checking the system's outputs more frequently than the system's validated accuracy warrants, they are either correctly cautious (the system hasn't demonstrated reliability in their scenarios) or incorrectly cautious (the system has demonstrated reliability, but they don't know it). Either way, the signal is diagnostic and should trigger a response — either more evidence of system reliability, or a redesign of how that reliability is communicated.

**Over-trust detection.** This is the more dangerous direction. As systems prove reliable in routine cases, users reduce scrutiny. The signal that over-trust is developing:

- Override rate declining as case complexity increases (users are overriding less on hard cases, not more)
- Time spent reviewing system outputs declining as system tenure increases (familiarity producing reduced scrutiny)
- Correlation between system confidence and user scrutiny becoming weak (users approve with equal speed regardless of the system's uncertainty signals)

The architectural requirement: **the system must actively monitor these signals and route them to the appropriate authority when they indicate over-trust**. This is not a dashboard metric for a quarterly review. It is a system behavior that mirrors what the system does with under-confidence — raise an alert, halt the at-risk behavior, escalate to human attention.[^7_1]

The practical implication: a system that has been operating successfully for 18 months is not necessarily more trustworthy than one deployed 3 months ago. It may simply have accumulated more complacency. The trust calibration layer treats high-trust-age as a risk signal requiring renewed scrutiny, not as evidence of reliability.

***

## The Dependency Structure

These six layers are not a stack — they have logical dependencies that determine the order of design and the conditions under which each layer can function correctly:

```
Legitimacy Substrate ──────────────────────────────────┐
        │                                               │
        ▼                                               ▼
Integration Reality ─────────► Action Classification ──► Verification-Attribution
                                        │                         │
                                        └─────────────────────────┤
                                                                   ▼
                                                      Participation-Feedback
                                                                   │
                                                                   ▼
                                                         Trust Calibration
```

- The **Legitimacy Substrate** must be established first. Action classification cannot resolve contested authority without it. Accountability attribution has no foundation without it
- The **Integration Reality Layer** must be modeled before actions are classified. Reversibility is a function of data reliability
- The **Action Classification Engine** is the execution gateway. No action proceeds without classification
- The **Verification-Attribution Layer** operates on completed actions. It requires all three preceding layers to have functioned correctly
- The **Participation-Feedback Layer** requires operational data from verification-attribution and design access to the legitimacy substrate
- The **Trust Calibration Layer** requires operational data from all preceding layers to compute its signals

This dependency structure has a practical consequence: **a system that implements only the middle layers — action classification and verification — without establishing the legitimacy substrate and integration reality model has built governance theater**. The gates exist, but they're checking against an undefined standard, with unresolved accountability, and with no measure of whether the trust the system is accumulating is appropriately calibrated.[^7_2]

***

## What This Adds to the Existing Framework

Your framework's nine-layer design model (Purpose through Human Enrichment) addresses the internal trust architecture — what must be true about the agent's design for its outputs to be trustworthy. These six layers address the external trust architecture — what must be true about the system's relationships for those outputs to be legitimately acted on.[^7_3][^7_1]


| Framework layer | External architecture equivalent | Relationship |
| :-- | :-- | :-- |
| Purpose (L1): why does this agent exist? | Legitimacy Substrate: who has the authority to define that purpose? | Framework addresses design intent; external architecture addresses political legitimacy |
| Safety (L6): where are the human gates? | Action Classification: what class of action requires which gate? | Framework addresses gate placement; external architecture addresses gate criteria |
| Trust (L5): who verifies the work? | Verification-Attribution: for whom is the evidence appropriate, and for how long? | Framework addresses verification structure; external architecture addresses evidence persistence and accessibility |
| Improvement (L8): how does the system get better? | Participation-Feedback: whose feedback reaches the improvement loop? | Framework addresses improvement mechanism; external architecture adds beneficiary participation as a structural input |
| *Not present* | Trust Calibration: is accumulated trust appropriately calibrated? | Genuinely new — no current analogue |
| *Not present* | Integration Reality: how reliable is the world the agent acts on? | Partially in ecosystem (L7) but not as a first-class confidence propagation mechanism |

The combined model — internal trust architecture plus external trust architecture — answers both of the questions your framework commits to: *did the agent produce the right thing* (fidelity), and *did the system leave everyone in a better position than before* (enrichment). The external architecture is what makes enrichment structurally possible rather than aspirationally intended.[^7_3]

***

## The Minimum Viable System

From everything above, the floor below which no agentic system should be deployed — regardless of domain, scale, or complexity:

1. **Principal identification is explicit**: who this system serves and who bears the consequences is registered as structural data before any agent is activated, not inferred from organizational context
2. **Reversibility is classified before execution**: no irreversible action proceeds without a human present, structurally, not as a bypassable protocol
3. **The audit trail is immutable**: every action is attributed, timestamped, and unalterable — not selectively logged, not deletable for performance reasons
4. **Override is frictionless and captured**: every human override of a system output is a first-class event, recorded and routed to the improvement loop — not treated as an exception to be minimized
5. **Shadow operation precedes go-live**: the system runs in parallel with existing human processes long enough to surface integration failures and edge cases that testing never finds — not as QA, but as the validation standard for deployment readiness

These five are the irreducible minimum. A system missing any one of them is not a less trustworthy version of a trustworthy system — it is a system for which trustworthiness cannot be evaluated at all.[^7_2][^7_1]
<span style="display:none">[^7_4][^7_5]</span>

<div align="center">⁂</div>

[^7_1]: framework-principles-v0.4.md

[^7_2]: five-questions-of-agency.md

[^7_3]: agent-design-principles-v0.2.md

[^7_4]: review-the-agent-design-framew-AfD0jfBJTtGLpqIwDzFqcQ.md

[^7_5]: i-want-to-build-an-open-source-Tzo5tKssRbG4ZaEG.idAKg.md


---

# This has been fascinating for me. I want to give us a new framing and

if instead of thinking how agents can do work for humans, we ask how agents can make work easy and enjoyable for humans

This is not a UX reframing. It is an inversion of what the entire system is *for* — and it changes the design problem at its root.[^8_1]

***

## What Actually Changes

The first framing positions humans as principals who delegate. The agent is the subject; the human recedes into the background as approver and overseer. The measure of success is what the agent produces.

The second framing positions humans as performers. The agent is infrastructure; the human remains in the foreground as the one doing meaningful work. The measure of success is the quality of the human's work experience.[^8_2]

That shift has consequences that ripple through every design decision:


| Design dimension | Agents doing work for humans | Agents making work easy and enjoyable |
| :-- | :-- | :-- |
| **What the system models** | Tasks, workflows, outputs | Human work experience — what drains, what engages, what creates meaning |
| **Where the boundary is drawn** | Capability: agents do what they can, humans do the rest | Meaning: agents handle what isn't meaningfully human, humans keep what is |
| **Measure of success** | Throughput, accuracy, efficiency | Engagement, capability growth, satisfaction |
| **What failure looks like** | Task incomplete or incorrect | Human made less capable, less engaged, or less connected to their work |
| **The improvement signal** | Output quality metrics | Human work experience quality |


***

## The Tension Built Into the Reframing

"Easy" and "enjoyable" are not the same thing — and conflating them is the most dangerous design mistake this framing can make.[^8_1]

Some of what makes work meaningful *is* difficulty. The surgeon who solves a complex diagnostic puzzle. The grant officer who develops a nuanced read of an organization's potential. The emergency manager who finds calm in the storm. Strip the productive difficulty and you haven't made the work better — you've made it into a different kind of empty.

This means the reframing generates a design obligation that didn't exist before: **you must classify friction before you can decide what to remove**. Not all friction is the same:

- **Unproductive friction** — effort without meaning: the 12 coordination calls, the duplicate data entry across systems, the form-checking that doesn't require judgment, the information hunting that precedes the real work
- **Productive friction** — difficulty that is the work: the judgment call that requires genuine thought, the patient conversation that requires presence, the ethical tension that requires a real person to hold

Agents should absorb unproductive friction entirely. They should not touch productive friction — because productive friction is the soul of the work, and removing it makes the job worse even as it makes it easier.[^8_2][^8_1]

The design question this creates: *before deciding what agents handle, you must first ask what this work feels like on a practitioner's best day, and make sure what remains after agents intervene is closer to that day, not further from it.*

***

## What the System Must Now Model

This framing adds something to the design process that was absent before. Before you can design what agents do, you need genuine understanding of the human experience of work in this domain. Not just the task structure — the lived texture of the work.[^8_2]

A human work experience map, analogous to the agent empathy map from our earlier work:


| Dimension | The design question |
| :-- | :-- |
| **What creates flow?** | Which parts of this work produce absorption, focus, and the sense of being fully present? |
| **What creates drain?** | Which parts produce cognitive fatigue, frustration, or the feeling that effort is wasted? |
| **What creates meaning?** | Which parts connect to why this person chose this work in the first place? |
| **What creates growth?** | Which parts develop capability over time versus which parts are just repetition? |
| **What creates connection?** | Which parts involve human relationships that are irreplaceable? |
| **What creates alienation?** | Which parts make the practitioner feel like a cog rather than a person? |

Agents should be designed to move the balance of human work time away from drain and alienation, and toward flow, meaning, connection, and growth. That is a design specification — as concrete and verifiable as any acceptance criterion.[^8_1][^8_2]

***

## What This Adds to the Framework

The framework's Layer 9 (Human Enrichment) already asks whether every human is more capable after engaging with the system. This reframing adds a second axis that L9 doesn't fully capture:[^8_1]

**L9 asks:** *Is every human more capable?*
**This reframing asks:** *Is every human more engaged in work they find meaningful?*

These can diverge. A practitioner can become more capable while finding their work less meaningful — more efficient at a job that feels hollowed out. A nurse who spends all their time supervising agent outputs is not the same as a nurse who spends that time on patient care, even if their measurable capability is identical. The system must track both axes — capability and experience quality — not just the first one.[^8_2]

This also resolves a structural problem we identified in the case study analysis: the trust problem is partly a consequence of the first framing. When the system's goal is to do work for humans, practitioners are subjects of the system. Their involvement is overhead. Their resistance is friction to be managed. When the system's goal is to make their work better, practitioners are **stakeholders in the system's success** — because the system only succeeds if their work experience improves. That reframes participation from governance obligation to genuine shared interest.[^8_1]

***

## The New Design Questions

This framing generates a different set of first questions — ones that would never surface under the old framing:

- What does this work feel like on a practitioner's best day? What conditions made that possible?
- Which parts of this work do the best practitioners find most meaningful? What do they find most tedious?
- If agents removed all the friction that doesn't serve the quality of the work itself, what would remain? Is that remainder worth doing?
- As practitioners develop mastery, what parts of the work become more engaging rather than less? How does the agent's role shift to match that growth?
- What would it mean for this work to be genuinely good work — not just accurate or efficient, but the kind of work a person could build a meaningful professional life around?

These questions belong in the design process before any agent architecture is decided. They require the same practitioner participation we identified as structurally necessary for trust — but now for a different reason. Not just to understand the task, but to understand what makes the work worth doing.[^8_2][^8_1]

***

## A Concrete Test

Here is a practical test this reframing provides that the old framing couldn't: after the system has been in operation for two years, ask practitioners two questions.

Under the old framing, you ask: *"Is the work being done more accurately and efficiently?"* A yes is success.

Under the new framing, you ask: *"Do you find your work more meaningful and engaging than you did two years ago?"* A yes is success. A no — even if the first question is also a yes — is failure.[^8_1]

This test has teeth. It is possible for an agentic system to achieve high accuracy, high efficiency, and zero improvement in human work experience — or even a decline. The new framing makes that outcome visible as a failure rather than hiding it behind throughput metrics. And it creates the design obligation to prevent it from the start, not discover it two years too late.
<span style="display:none">[^8_3][^8_4][^8_5]</span>

<div align="center">⁂</div>

[^8_1]: agent-design-principles-v0.2.md

[^8_2]: beyond-expected.md

[^8_3]: review-the-agent-design-framew-AfD0jfBJTtGLpqIwDzFqcQ.md

[^8_4]: i-want-to-think-through-the-de-1uknqXF9SA6WXLfbDBtvQw.md

[^8_5]: i-want-to-build-an-open-source-Tzo5tKssRbG4ZaEG.idAKg.md


---

# Can we explore how this approach might also build more trust across the system.

Can we explore how we keep the approach of involving all stakeholders, especially most affected, in the design phase, and through the lifecycle?

There is a specific mechanism at work here that connects these two questions — and it's not obvious until you trace it carefully.[^9_1]

***

## The Adversarial Dynamic and How It Dissolves

Under the "agents do work for humans" framing, trust has an inherent tension built into it. The system's design goal (maximise autonomous task completion) and the practitioner's goal (maintain meaningful involvement and relevance) are structurally opposed. Every capability the system gains feels like something the practitioner loses. Every system failure confirms the practitioner's worry that they were right to be cautious.[^9_2]

This is why trust-building under the old framing requires constant reassurance — "this isn't replacing you, it's supporting you" — reassurance that feels unconvincing precisely because the design goal is genuinely oriented toward reducing human involvement.

The new framing dissolves this structurally. When the system's stated and verifiable goal is *improving the quality of the human's work experience*, the system's success and the practitioner's wellbeing are aligned, not opposed. Every improvement the system makes is experienced as a gain by the practitioner. Every failure is a failure for both of them. The trust relationship stops being one-directional (the practitioner deciding whether to trust the system) and becomes **reciprocal** (both parties mutually invested in each other's success).[^9_3][^9_1]

This matters because reciprocal trust compounds. A practitioner who experiences the system as genuinely on their side becomes an active contributor to its improvement. They report problems honestly rather than working around them. They surface edge cases rather than hiding them. They override when they should rather than rubber-stamping to avoid friction. Every one of those behaviours is a richer signal that makes the system better faster — which creates more trust, which generates better signal. The virtuous cycle is structural, not aspirational.[^9_1]

***

## Four Dimensions of Trust This Approach Addresses

The trust framework analysis distinguishes between structural trust (what the process produces) and public trust (what external parties can verify). This framing adds two further dimensions that neither category captures:[^9_3]


| Trust dimension | What it is | What produces it |
| :-- | :-- | :-- |
| **Competence trust** | Does the system do what it claims to do correctly? | Verification, proof-as-product, immutable audit |
| **Benevolence trust** | Is the system designed for my benefit, not just for organizational efficiency? | Design goals oriented toward work experience; demonstrable improvement over time |
| **Integrity trust** | Is the system honest about what it knows, what it doesn't, and what it's doing? | Transparent reasoning, confidence surfacing, uncertainty escalation |
| **Identity trust** | Does using this system align with who I am as a practitioner? | System preserves and amplifies the meaningful work, rather than replacing it |

The old framing consistently produces competence trust and integrity trust but leaves benevolence and identity trust unaddressed. Practitioners who are technically competent at their work often find agentic systems feel like a threat to their professional identity even when the system is reliable, because the system's orientation is not toward their flourishing.[^9_2][^9_1]

The new framing addresses all four dimensions structurally. Identity trust in particular is a trust dimension that cannot be manufactured through communication campaigns — it can only be earned through demonstrable alignment between what the system does and what the practitioner values about their work.[^9_1]

***

## Consultation vs. Participation vs. Governance

Before addressing the structural mechanisms, the distinction between these three needs to be precise — because almost all stakeholder involvement in agentic systems is actually the first one, performed as if it were the second.[^9_4]

- **Consultation**: we asked what you think, then we decided
- **Participation**: your input demonstrably changed what we built, and you can see that it did
- **Governance**: you have ongoing standing to shape how the system evolves, with a defined response process

Consultation builds no trust because it provides no evidence that input was heard. Participation builds initial trust because participants can trace their influence. Governance builds durable trust because it creates a permanent relationship between the most affected and the system's evolution — the trust is not dependent on the goodwill of any particular design team or organizational leader.[^9_4][^9_3]

What makes participation genuine rather than performative requires three conditions:

- **Influence**: participation must demonstrably change design decisions — not all of them, but visibly some of them
- **Transparency**: participants must be able to see what changed because of their input, and receive an honest explanation for what didn't change and why
- **Continuity**: participation extends through operation, not just design — the channel remains open and remains consequential

Without all three, participation is consultation with better framing.[^9_1]

***

## The Power Asymmetry Problem

There is a structural barrier to genuine participation that no amount of design intention overcomes if left unaddressed. The people with the most power in the design process — technical teams, organizational leadership, funders — have the least to gain from practitioner and beneficiary input. The people with the most to gain — front-line workers and the communities or individuals the system affects — have the least power to enforce that their input shapes the design.[^9_3]

This means that genuine participation cannot be left to the goodwill of those with power. It must be structural — a gate in the process that cannot be bypassed, producing evidence that is verifiable, not just documented internally.[^9_4]

The specific structural requirement: **before any specification is locked, documented evidence must exist that practitioners and beneficiaries shaped the design of the human-agent boundary**. Not "we ran a workshop" as a check box — but "these specific inputs produced these specific design decisions, and here is the evidence of each." That evidence becomes part of the proof-as-product requirement for the design phase itself, verified by a party with no stake in the system succeeding on schedule.[^9_4][^9_1]

The most affected stakeholders need something additional: **they must be able to see that the system's improvement over time is being distributed in ways that serve them, not just the organization that deployed it**. If a nurse's workflow is improved but the freed time immediately becomes additional administrative burden from another process, the system has delivered organizational efficiency while delivering zero improvement to the nurse's work experience. That failure must be visible, measurable, and attributed.[^9_3]

***

## Participation Through the Lifecycle

Participation is not a phase — it is a relationship that has different expressions at each lifecycle stage. What follows is what genuine participation looks like at each stage, and what makes it structural rather than aspirational.[^9_1]

**Conception — defining what "good work" means**

- Practitioners, not designers, define what their best day at work looks like and what makes it possible
- Beneficiaries, not organizational representatives, describe their experience of the service the system will affect
- This is not requirements gathering — it is understanding what the system is for in human terms before any technical direction is set
- Gate: no design phase begins until this understanding is documented and verified against all stakeholder groups

**Design — classifying friction and drawing the human-agent boundary**

- The productive/unproductive friction classification is done *with* practitioners, because only they know which difficulty is the soul of their work and which is just overhead
- The human-agent boundary is proposed, tested with practitioners, and revised based on what they experience as appropriate versus what feels like encroachment
- Alternatives considered and rejected are recorded with the reasons — practitioners can see that their concerns were heard even when they didn't produce the expected change
- Gate: the human-agent boundary requires documented practitioner sign-off before specification is locked

**Prototyping — testing the experience, not just the output**

- Shadow operation includes structured practitioner experience reporting alongside technical accuracy metrics
- Practitioners are asked not just "did it produce the right output?" but "did working with this make your work better?"
- Discrepancies between technical success and experienced improvement are treated as design failures, not edge cases
- Beneficiary experience of the service during shadow operation is tracked and reported

**Live operation — generating the improvement signal**

- Override capability is frictionless, and every override feeds into the improvement cycle — practitioners know this and experience the feedback loop closing
- Regular structured check-ins with practitioners on work experience quality, not just system performance
- Beneficiary outcome tracking distinct from operational metrics — their experience of the service is a first-class signal
- Any practitioner can raise a concern about system behavior and receive a documented response within a defined timeframe

**Evolution — governance, not just feedback**

- Practitioners have standing to propose changes to the human-agent boundary as their experience of the system matures — this right is permanent and cannot be removed without their agreement
- Changes to the system that affect practitioner work require documented practitioner input before they are deployed
- The most affected beneficiary groups have a named governance channel through which they can raise concerns about system behavior and see them addressed
- System evolution decisions are transparent: what changed, what was proposed and rejected, and why[^9_3][^9_4]

***

## The Specific Trust-Building Mechanism

The "making work enjoyable" framing creates a trust cascade that operates through a specific mechanism:

- Practitioners who participated in design **recognise their input** in what was built → design trust
- The system demonstrably improves work experience over time → experience trust
- Practitioners use the system **authentically** rather than gaming it or working around it → richer signal
- Richer signal improves the system faster → more improvement in less time
- Accelerating improvement deepens experience trust → practitioners invest more deeply in governance participation
- Deeper participation produces better design decisions → sustained improvement

The reverse cascade — the default without genuine participation — is equally structural. Consultation without influence → practitioners feel unheard → compliance without authentic engagement → thin signal → slow improvement → trust erodes → practitioners disengage further.[^9_2][^9_1]

The critical point: neither cascade is primarily a cultural phenomenon. Both are driven by structural design choices about whether participation is genuine or performative, whether the system's success metric is aligned with the practitioner's wellbeing or merely adjacent to it, and whether the trust relationship is designed to be reciprocal or one-directional.[^9_4]

***

## What This Demands of the System Architecturally

Connecting this back to the design framework, genuine stakeholder participation through the lifecycle requires the system to produce two classes of output that are not currently in scope:[^9_1][^9_4]

**1. Participation evidence as a first-class artefact.** The proof-as-product requirement applies to design participation — not just to task outputs. The system must produce structured, verifiable evidence of who was involved in what design decisions, what changed as a result, and what didn't change and why. This evidence is accessible to participants, not just held by the design team. It persists through the system's entire operational life.

**2. Work experience quality as a measured metric alongside output quality.** The improvement layer currently measures output accuracy, rework rates, and efficiency metrics. Work experience quality must sit alongside these as a first-class signal, measured at the practitioner level (is your work more engaging and meaningful than before?) and the beneficiary level (is your experience of this service better than before?). A system that is improving on output metrics while degrading on experience metrics is not improving — it is trading one value for another without the informed consent of those whose experience is being degraded.[^9_1]

Neither of these is a soft or cultural addition. Both have structural implementations: the first as a participation audit trail in the same ontological substrate as task audit trails, the second as a structured feedback primitive with the same first-class status as override events.[^9_5][^9_4]
<span style="display:none">[^9_6]</span>

<div align="center">⁂</div>

[^9_1]: agent-design-principles-v0.2.md

[^9_2]: beyond-expected.md

[^9_3]: trust-framework-analysis.md

[^9_4]: framework-principles-v0.4.md

[^9_5]: suggested-updates.md

[^9_6]: review-the-agent-design-framew-AfD0jfBJTtGLpqIwDzFqcQ.md


---

# This is all great.

I feel now that 'enjoyable' was doing heavy lifting, and while "quality of human's work experience" alludes to more, perhaps it's important to break that down as the entire analysis depends on achieving it. What research has been done on 'worker happiness' etc that we can use to inform our understanding of this. Not only research on what makes workers happy, but the impacts and flow on effects for all stakeholders.

What are all the factors that need to be present for workers to be happy?
What are all the benefits that come from workers being happy?
Are there other factors not directly related to the quality of human's work experience that we can examine?

The research here is rich, substantive, and directly actionable. What follows is a synthesis of the major bodies of evidence, organized to build toward design implications.

***

## Why "Enjoyable" Was Right to Flag

"Enjoyable" conflates two philosophically distinct states that the research treats separately:[^10_1]

- **Hedonic wellbeing** — pleasure, positive emotion, absence of distress. This is what "enjoyable" most naturally denotes
- **Eudaimonic wellbeing** — meaning, engagement, growth, living in accordance with your values and capabilities

Seligman's foundational work argues that true flourishing requires both, and that optimizing for one at the expense of the other is a design failure. Work can be pleasant without being meaningful, and meaningful without being pleasant. The research target is flourishing — a state that includes but goes well beyond enjoyment. This distinction matters enormously for how we design the system, because agentic systems that make work more pleasant by removing challenge may be inadvertently hollowing out the eudaimonic dimension that makes work worth doing.[^10_2][^10_1]

***

## The Major Research Frameworks

Four distinct bodies of research converge on what worker flourishing requires. They are complementary, not competing.

**1. Self-Determination Theory (Deci \& Ryan)** identifies three universal psychological needs that must be satisfied for intrinsic motivation and wellbeing:[^10_3][^10_4]

- **Autonomy** — feeling that your actions are self-authored and volitional, not just compliance
- **Competence** — feeling effective; mastery growing over time
- **Relatedness** — genuine quality connection with others

These are not preferences — they are needs in the psychological sense. When any one is unsatisfied, wellbeing deteriorates regardless of other conditions. Critically, autonomy is "the most important for facilitating integration" — workers who feel controlled, even in conditions of high competence and relatedness, cannot flourish.[^10_3]

**2. Seligman's PERMA Model** provides the most comprehensive operational definition of flourishing:[^10_5][^10_2]

- **P**ositive emotions — joy, interest, gratitude, and other positive experiences in daily work
- **E**ngagement — deep absorption and flow; using strengths at full stretch
- **R**elationships — quality connections with colleagues and those served
- **M**eaning — contributing to something larger than yourself; purpose beyond task completion
- **A**ccomplishment — achieving meaningful goals; the experience of effective effort

Research has shown that PERMA components are positively associated with job satisfaction, physical health, vitality, and organizational commitment — and that PERMA is a better predictor of psychological distress than prior models. The PERMA+4 extension adds physical health, economic security, sleep quality, and environmental conditions as additional structural prerequisites.[^10_2][^10_1]

**3. The Job Characteristics Model (Hackman \& Oldham)** identifies five structural properties of work that produce psychological states necessary for intrinsic motivation and satisfaction:[^10_6][^10_7][^10_8]

- **Skill variety** — the work draws on multiple meaningful skills and abilities, preventing monotony
- **Task identity** — completing a recognizable whole piece of work from beginning to end
- **Task significance** — the work has visible impact on others, inside or outside the organization
- **Autonomy** — discretion and independence in *how* the work is done
- **Feedback** — clear, direct information about the effectiveness of performance

The first three (variety, identity, significance) produce *experienced meaningfulness* — the sense that the work matters. Autonomy produces *experienced responsibility*. Feedback produces *knowledge of results*. All three psychological states must be present for intrinsic motivation to operate.[^10_7]

**4. The Job Demands-Resources Model (Bakker \& Demerouti)** frames worker wellbeing as a dynamic balance between two categories:[^10_9][^10_10][^10_11]

- **Job demands** — cognitive, physical, and emotional requirements that cost sustained effort (workload, complexity, emotional labor, time pressure)
- **Job resources** — physical, psychological, social, and organizational aspects that support goal achievement, reduce demands, or stimulate growth (autonomy, feedback, supervisor support, development opportunities)

The model's key insight: high demands produce burnout when resources are insufficient, but high resources produce *engagement* independently of demand level. Reducing demands alone prevents burnout. Increasing resources produces engagement. Both matter but through different mechanisms.[^10_10][^10_11]

***

## What Factors Need to Be Present

Synthesizing across all four frameworks, these are the conditions that must be present — not merely desirable:

**Intrinsic work structure conditions**

- Meaningful autonomy over *how* work is done (not just which tasks to do)
- Skill variety sufficient to prevent mechanization of the work
- Whole-task ownership — seeing a piece of work through from start to outcome
- Visible impact on people who are served — task significance felt, not just described
- Timely, direct feedback on whether effort was effective

**Psychological state conditions**

- Growth in competence over time — capability accumulating, not decaying
- Access to flow states — challenge calibrated to capability, with clear goals and minimal distraction
- Positive emotions routinely accessible in daily work — the work itself is a source of positive experience, not just the paycheck
- Felt meaning — connection between daily tasks and purpose that the practitioner values

**Social/relational conditions**

- Psychological safety — the ability to raise concerns, make mistakes, and surface uncertainty without fear of embarrassment or punishment[^10_12][^10_13]
- Quality relationships with colleagues — genuine mutual support and connection
- Supervisory competence and support — managers who develop rather than control
- Recognition that is genuine and specific, not performative

**Structural/organizational conditions**

- Workload that allows genuine engagement rather than survival mode
- Fair and transparent compensation and recognition
- Clear role definition — knowing what you're responsible for and what you're not
- Development opportunities — genuine pathways for growth

***

## The Benefits and Their Flow-On Effects

The research evidence on outcomes is substantial. Organized by who benefits:

### For the worker themselves

- Job satisfaction accounts for a **14% increase in current life satisfaction** scores and 8% increase in future life evaluation — the effect of work happiness extends beyond working hours into the whole of life[^10_14]
- Satisfied workers have significantly lower prevalence of sadness, anger, worry, and stress — and higher prevalence of positive emotions across their whole day[^10_14]
- Physical health improves with wellbeing; the reverse — work dissatisfaction — carries documented health costs
- Notably: unemployed people experience more positive emotions than employed people who are *dissatisfied with their work* — a dissatisfied job is worse than no job for daily emotional experience[^10_14]


### For team and organizational performance

- **12–20% higher individual productivity** (University of Warwick; Oxford studies)[^10_15][^10_16]
- **21% higher profitability** at the organizational level for companies with high engagement[^10_15]
- Psychological safety — the team-level condition enabling open communication — is identified by Google's Project Aristotle as **"by far the most important"** factor in team effectiveness, above talent, structure, or resources[^10_17]
- Happy workers are more creative, more willing to experiment, and more likely to generate novel solutions[^10_18][^10_15]
- **Lower turnover** — reducing the enormous cost of recruiting, onboarding, and rebuilding institutional knowledge


### For service recipients and beneficiaries

This is the cascade that matters most for our system design. The service quality research is unambiguous:[^10_19][^10_20]

- Employee satisfaction has a **direct and significant positive effect on service quality** — workers who feel valued provide higher-quality service to those they serve
- This operates through both willingness (motivation to serve well) and capability (engagement that produces attentiveness)
- The effect is particularly strong in human-facing service roles — nurses, case workers, program officers — precisely the practitioner roles our cases involve
- Customer/beneficiary happiness correlates strongly with employee happiness; the pathway runs from worker experience → service quality → recipient experience[^10_21]

The implication: a system that makes the nurse's work better makes the patient's care better. These are not separate outcomes — they are the same outcome measured from different positions.

### For organizations and their missions

- Innovation rates are higher in organizations with engaged workers — employees feel empowered to experiment and take risks[^10_15]
- Organizational learning improves through psychological safety — teams with high safety "learn from mistakes to a greater extent" and show greater team effectiveness[^10_13]
- Decision quality improves because workers in psychologically safe conditions surface problems earlier, before they compound


### For society

- Reduced healthcare burden from work-related stress and burnout
- Spillover effects into families and communities — work unhappiness is not contained within work hours
- When knowledge workers are engaged and growing, institutional knowledge compounds rather than degrades — a societal asset

***

## Factors Not Directly Related to Work Experience Quality

Several important influences on worker wellbeing operate independently of what happens within the work experience itself:[^10_22][^10_14]

**Personal characteristics**

- Personality traits (particularly emotional stability and extraversion) have modest but measurable effects on job satisfaction — these are stable properties that design cannot change but can accommodate
- Locus of control: workers with an internal locus of control (believing their actions shape outcomes) have higher baseline satisfaction across work contexts
- Self-efficacy: prior experience of effectiveness creates expectations of future effectiveness, creating momentum in either direction

**Life outside work**

- Marital status and quality of personal relationships are statistically significant contributors to emotional wellbeing at work
- Physical health independent of work — chronic illness reduces wellbeing regardless of work quality
- Financial security beyond compensation — debt, housing insecurity, and family financial pressure affect work experience even in well-designed roles

**Organizational factors above the team level**

- Fairness of organizational processes and policies — perceived unfairness in promotion, recognition, or decision-making erodes wellbeing even when direct work experience is positive
- Economic security of employment — fear of job loss consumes cognitive and emotional resources that would otherwise go to work quality
- Organizational reputation and values alignment — workers whose organization acts in ways that conflict with their values experience a form of moral injury that standard wellbeing interventions cannot address

**The social context of work**

- Status and recognition from outside the immediate team — professional community recognition, external validation of the work's value
- The narrative around the profession — nursing, social work, and emergency management are all professions under public scrutiny; the societal story told about these workers affects their own experience of the work

***

## What This Means for the Design Vocabulary

The research provides us with a precise, evidence-grounded vocabulary to replace "enjoyable." When we ask whether an agentic system improves the quality of the human work experience, we are now asking nine specific, measurable questions:


| Dimension | Research source | The design question |
| :-- | :-- | :-- |
| **Autonomy** | SDT; JCM | Does the practitioner experience genuine control over *how* they work, or has that control migrated to the system? |
| **Competence growth** | SDT | Is the practitioner more capable after 12 months of working with this system than before it? |
| **Relatedness** | SDT | Are the human relationships that make this work meaningful preserved and supported, or squeezed out? |
| **Engagement/Flow** | PERMA | Does the work the practitioner does create conditions for deep absorption — calibrated challenge, clear goals, minimal distraction? |
| **Meaning** | PERMA; ikigai | Does the practitioner's connection to *why* they chose this work remain intact and visible through daily tasks? |
| **Accomplishment** | PERMA; JCM task identity | Can the practitioner see and own meaningful outcomes — whole pieces of work from beginning to end? |
| **Task significance** | JCM | Is the practitioner's impact on the people they serve visible and attributable to them? |
| **Psychological safety** | Edmondson | Can the practitioner raise concerns, make mistakes, and surface uncertainty without fear of negative consequences — including from the system itself? |
| **Positive daily affect** | PERMA; hedonic wellbeing | Are positive emotions — interest, satisfaction, care — accessible in daily work, not just in exceptional moments? |

These nine dimensions are not a checklist — they form a system. The JD-R model explains the relationship between them: demands deplete, resources restore. A well-designed agentic system should function as a resource that reduces demands (cognitive overhead, coordination friction, administrative burden) and amplifies resources (feedback clarity, task significance, development opportunities). A poorly designed one does the reverse: it becomes a demand by adding supervision burden, eroding autonomy, fragmenting task identity, and creating the conditions for automation complacency to destroy competence over time.[^10_16][^10_9][^10_10][^10_13]

The nine dimensions above are now the system's success criteria for the human enrichment axis — as measurable and structural as output accuracy or rework rate. A system that is improving on technical metrics while degrading any of these nine is not a successful system. It is trading one form of value for a worse one, without the informed consent of the practitioners whose working lives are the medium of that trade.[^10_23][^10_4]
<span style="display:none">[^10_24][^10_25][^10_26][^10_27][^10_28][^10_29][^10_30][^10_31][^10_32][^10_33][^10_34][^10_35][^10_36][^10_37][^10_38][^10_39][^10_40][^10_41][^10_42][^10_43][^10_44]</span>

<div align="center">⁂</div>

[^10_1]: https://pmc.ncbi.nlm.nih.gov/articles/PMC8819083/

[^10_2]: https://positivepsychology.com/perma-model/

[^10_3]: https://selfdeterminationtheory.org/SDT/documents/2005_GagneDeci_JOB_SDTtheory.pdf

[^10_4]: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2018.01157/full

[^10_5]: https://ppc.sas.upenn.edu/learn-more/perma-theory-well-being-and-perma-workshops

[^10_6]: https://www.personio.com/hr-lexicon/hackman-and-oldham-model/

[^10_7]: https://humaans.io/hr-glossary/hackman-and-oldham-model

[^10_8]: https://www.sciencedirect.com/topics/psychology/job-characteristics

[^10_9]: https://pubmed.ncbi.nlm.nih.gov/11419809/

[^10_10]: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2023.1194018/full

[^10_11]: https://www.wilmarschaufeli.nl/publications/Schaufeli/476.pdf

[^10_12]: https://journals.sagepub.com/doi/10.2307/2666999

[^10_13]: https://pmc.ncbi.nlm.nih.gov/articles/PMC9819141/

[^10_14]: https://pmc.ncbi.nlm.nih.gov/articles/PMC9171114/

[^10_15]: https://www.mokahr.io/myblog/science-employee-happiness-productivity/

[^10_16]: https://www.ox.ac.uk/news/2019-10-24-happy-workers-are-13-more-productive

[^10_17]: https://www.kaizenko.com/amy-edmondsons-psychological-safety-leadership-guide-to-team-innovation/

[^10_18]: https://lpsonline.sas.upenn.edu/features/science-happiness-work-how-positive-psychology-can-increase-productivity

[^10_19]: https://www.atlantis-press.com/article/125942790.pdf

[^10_20]: https://www.cscjournals.org/manuscript/Journals/IJBRM/Volume6/Issue3/IJBRM-187.pdf

[^10_21]: https://dinastipub.org/DIJEFA/article/download/3593/2362/16812

[^10_22]: https://wellbeing.gmu.edu/employee-well-being-factors-that-influence-job-satisfaction/

[^10_23]: https://pmc.ncbi.nlm.nih.gov/articles/PMC9963286/

[^10_24]: https://www.sciencedirect.com/science/article/pii/S219985312400221X

[^10_25]: https://www.eelet.org.uk/index.php/journal/article/download/1137/995/1197

[^10_26]: https://positivepsychology.com/job-satisfaction-theory/

[^10_27]: https://pmc.ncbi.nlm.nih.gov/articles/PMC7120033/

[^10_28]: https://www.verywellmind.com/what-is-self-determination-theory-2795387

[^10_29]: https://www.scitepress.org/Papers/2018/101023/101023.pdf

[^10_30]: https://www.hbs.edu/ris/Publication Files/gh19_ch5_9e171d71-db54-4e08-a2eb-3cf1587daf4a.pdf

[^10_31]: https://www.apsacademy.gov.au/resources/perma-model-flourishing

[^10_32]: https://www.bild.org.uk/wp-content/uploads/2021/03/The-PERMA-Model-Booklet-Update.pdf

[^10_33]: https://www.deloitte.com/au/en/services/consulting-risk/blogs/seligman-perma-model-using-science-flourish-work.html

[^10_34]: https://www.innovativehumancapital.com/article/finding-purpose-through-ikigai-how-leaders-can-promote-well-being-through-the-japanese-concept-of-r

[^10_35]: https://pmc.ncbi.nlm.nih.gov/articles/PMC12300217/

[^10_36]: https://theskillcollective.com/blog/perma-resilience-wellbeing

[^10_37]: https://www.steople.com.au/ikigai/

[^10_38]: https://www.gvhealth.org.au/wp-content/uploads/2023/08/PERMA-Model-Karen-Cline-070223.pdf

[^10_39]: https://www.isonderhouden.nl/doc/pdf/arnoldbakker/articles/articles_arnold_bakker_119.pdf

[^10_40]: https://web.mit.edu/curhan/www/docs/Articles/15341_Readings/Group_Performance/Edmondson%20Psychological%20safety.pdf

[^10_41]: https://amycedmondson.com/psychological-safety/

[^10_42]: https://www.library.hbs.edu/working-knowledge/four-steps-to-build-the-psychological-safety-that-high-performing-teams-need-today

[^10_43]: https://www.harvardbusiness.org/insight/why-psychological-safety-is-the-hidden-engine-behind-innovation-and-transformation/

[^10_44]: https://www.businessthink.unsw.edu.au/articles/psychological-safety-amy-edmondson-remote-work-artificial-intelligence


---

# How do we integrate these nine dimensions as measurable design requirements

The critical framing: these are **design requirements first, measurement problems second**. The validated instruments exist for all nine dimensions — the harder challenge is integrating requirements into the design process so they shape what is built, not just what is audited after the fact. The Hackman \& Oldham Job Diagnostic Survey was explicitly designed to be administered *before* job redesign as a diagnostic tool  — the right model for how we need to use this.[^11_1][^11_2]

***

## Three Integration Points

The nine dimensions must enter the design process at three distinct points, not one:

**1. Pre-deployment baseline** — measured against practitioners *before any system is deployed*, establishing the benchmark against which all future states are compared. Without this, you cannot demonstrate improvement, only assert it. This is the JDS's original design intent: diagnose first, then redesign.

**2. Design specification** — each dimension generates explicit acceptance criteria that must be satisfied before deployment is permitted. Not "we intend to preserve autonomy" — but "here is the evidence that the designed human-agent boundary satisfies the autonomy criterion."

**3. Operational improvement loop** — the same dimensions are tracked in operation, with defined degradation triggers that route to the governance layer. Work experience metrics sit in the improvement layer alongside output quality metrics, with equal standing.[^11_3]

***

## The Nine Dimensions as Design Requirements

Each dimension has four operational components: a design requirement that shapes what is built, a validated measurement instrument, a behavioral proxy observable without self-report, and a degradation signal that triggers governance response.

### Autonomy

*Source: Self-Determination Theory; Job Characteristics Model*[^11_4][^11_5]

**Design requirement:** The system must preserve meaningful practitioner discretion over *how* work is done, not merely *which* tasks to do. The human-agent boundary must be drawn to protect this. Autonomy is not preserved by making override *possible* — it is preserved by making override *natural*, expected, and frictionless at every point where practitioner judgment adds value.

**Validated instrument:** Basic Psychological Needs at Work Scale (BPNS-W) — Autonomy subscale[^11_5]

**Behavioral proxy:** The ratio of agent recommendations that practitioners modify to those accepted wholesale. A healthy system shows a practitioner population exercising ongoing discretion, not one that has converged on acceptance. A declining modification rate that is *not* explained by documented capability growth is a degradation signal.

**Degradation signal:** Practitioner acceptance rate of agent outputs trending above ~70% (calibrated by domain), particularly on cases that trained practitioners would historically have handled with significant variation. Uniformity of output is the warning sign, not quality of output.

**Critical structural note:** The JCM formula for Motivating Potential treats autonomy as a *multiplier*, not an additive component:[^11_2][^11_1]

$$
MPS = \frac{SV + TI + TS}{3} \times A \times F
$$

Where SV = skill variety, TI = task identity, TS = task significance, A = autonomy, F = feedback. If autonomy approaches zero, the entire score approaches zero regardless of other dimensions. A system that preserves all other dimensions while eliminating practitioner autonomy does not produce a partial improvement — it produces a complete failure of motivating potential.

***

### Competence Growth

*Source: Self-Determination Theory; Zone of Proximal Development*[^11_4]

**Design requirement:** The system must include a *progressive scaffolding reduction* mechanism — its guidance decreases as practitioner capability grows, rather than remaining constant. An agent system that provides the same level of support on day 400 as day 1 has produced dependency, not competence. This must be a designed behavior, not an emergent one.

**Validated instrument:** BPNS-W Competence subscale; domain-specific capability assessments administered at defined intervals[^11_5]

**Behavioral proxy:** Override *quality* over time. Early in deployment, practitioner overrides may be frequent but not always superior to the system's recommendation. As competence grows, overrides should become less frequent but more reliably better than the baseline agent output. Declining override quality — practitioners overriding without producing better outcomes — indicates the skill needed to evaluate system outputs is itself deteriorating.

**Degradation signal:** Capability assessment scores plateauing or declining after 12 months; override quality declining; practitioners unable to explain their override rationale; difficulty handling edge cases the system hasn't encountered.

***

### Relatedness

*Source: Self-Determination Theory*[^11_4][^11_5]

**Design requirement:** Time freed by the system must demonstrably flow toward meaningful human interactions, not toward additional administrative tasks or system supervision. The design must specify *where* the freed time goes, not just that time is freed. The value chain is: agent handles administrative coordination → practitioner spends more time with patients/applicants/community members — and that second step must be tracked.

**Validated instrument:** BPNS-W Relatedness subscale; time-use studies comparing pre- and post-deployment distribution of practitioner activity across interaction types[^11_5]

**Behavioral proxy:** Time-use sampling showing distribution between human interaction, administrative activity, and system supervision. This is measurable through work sampling without self-report bias.

**Degradation signal:** Practitioner time in meaningful human interaction declining post-deployment; beneficiaries reporting service feeling less personal; practitioners expressing increased sense of isolation.

***

### Engagement/Flow

*Source: PERMA; Flow research (Csikszentmihalyi)*[^11_6]

**Design requirement:** Work remaining for practitioners after agent deployment must be calibrated to their capability — genuinely demanding enough to require engagement, not so demanding as to overwhelm. The tasks the system offloads must be the mechanical ones. The tasks it leaves must be the meaningful ones. This is a *task classification* design requirement: before any work is allocated to agents, it must be classified on the engaging–mechanical axis, and the allocation must preserve engagement.

**Validated instrument:** Utrecht Work Engagement Scale (UWES-9) — measuring vigor, dedication, and absorption. The UWES is the most widely validated measure of work engagement, with strong cross-cultural validity and predictive power for performance and turnover.[^11_7][^11_8]

**Behavioral proxy:** Time-on-task distribution; error rates on tasks requiring genuine engagement (engagement produces better performance, mechanical execution produces more errors under sustained attention); quality of practitioner contributions to difficult cases.

**Degradation signal:** UWES scores declining over 6–12 month horizon; practitioners reporting work feels monotonous despite agent offloading (indicating the system has taken meaningful work, not just administrative work).

***

### Meaning

*Source: PERMA; Meaningful Work research*[^11_9][^11_6]

**Design requirement:** The system must preserve and amplify the practitioner's *visible connection* between their daily tasks and the purpose they care about. This is an information design requirement as much as a workflow design requirement. The impact of practitioner work on beneficiaries must be traceable and visible — if a nurse's discharge coordination produces better patient outcomes three weeks later, that outcome must be attributable to and visible by the nurse, not disappear into system metrics.

**Validated instrument:** Work and Meaning Inventory (WAMI, Steger et al.); Presence of Meaning and Search for Meaning subscales from the Meaning in Life Questionnaire (MLQ)[^11_9]

**Behavioral proxy:** The richness of practitioners' narratives about their work when asked "what difference does your work make?" — qualitative richness declining is a leading indicator of meaning erosion. This can be tracked through structured retrospectives without quantitative burden.

**Degradation signal:** WAMI scores declining; practitioners describing work in task terms rather than impact terms; increasing extrinsic motivation signals (working primarily for pay/schedule rather than purpose).

***

### Accomplishment

*Source: PERMA; JCM Task Identity*[^11_10][^11_1][^11_6]

**Design requirement:** Practitioners must own *whole pieces of work* from beginning to end — cases, patients, applications — not just individual micro-decisions extracted from a larger workflow. Task fragmentation is the specific risk. When an agent handles intake, a practitioner handles assessment, another agent handles coordination, and a third practitioner handles closure, no one owns the work. The design must preserve or create task identity — the experience of completing a recognizable whole.

**Validated instrument:** Job Diagnostic Survey (JDS) — Task Identity subscale[^11_11][^11_1][^11_2]

**Behavioral proxy:** Can practitioners name specific cases, people, or outcomes they are personally responsible for? This is directly observable in structured practitioner interviews and is a strong proxy for task identity without formal measurement.

**Degradation signal:** JDS Task Identity scores declining; practitioners unable to identify work they personally own; outcomes attributed to "the system" rather than to practitioners.

***

### Task Significance

*Source: Job Characteristics Model*[^11_1][^11_2][^11_10]

**Design requirement:** The impact of practitioner work on the people being served must be *visible and directly attributable* to the practitioner, not obscured by the system. Outcome reporting must run through practitioners, not around them. When the system produces outcome data (discharge rates, application approvals, emergency response times), that data must be presented in ways that make the practitioner's contribution legible — not in ways that attribute outcomes to system performance.

**Validated instrument:** JDS Task Significance subscale[^11_2][^11_1]

**Behavioral proxy:** How practitioners describe who benefits from their work when asked — specificity and warmth of response is a reliable qualitative proxy for experienced task significance.

**Degradation signal:** JDS Task Significance scores declining; practitioners describing outcomes as system achievements rather than their own; beneficiary relationship quality deteriorating.

***

### Psychological Safety

*Source: Edmondson (1999)*[^11_12][^11_13]

**Design requirement:** Practitioners must be able to question system outputs, override decisions, escalate concerns, and admit uncertainty — not just permitted to but *structurally supported* in doing so. Override must be frictionless. There must be a visible feedback loop showing that concerns raised have been heard and addressed. A practitioner who raises a concern and hears nothing back will not raise the next one.[^11_12]

**Validated instrument:** Edmondson's 7-item Psychological Safety Scale  — specifically: "It is safe to take a risk on this team"; "No one on this team would deliberately act in a way that undermines my efforts"; "It is difficult to ask other members of this team for help." These are adapted for the human-agent relationship.[^11_14][^11_12]

**Behavioral proxy:** Override rate relative to case complexity — a healthy pattern shows more overrides on complex cases, fewer on routine ones. A uniform override rate across complexity levels indicates either over-trust (not overriding on complex cases that warrant it) or under-trust (overriding on routine cases that don't warrant it). Both are psychological safety failures.[^11_12]

**Degradation signal:** Override rate declining uniformly; practitioners reporting reluctance to question system outputs; concern escalations going unanswered; practitioner safety scores declining over time.

***

### Positive Daily Affect

*Source: PERMA hedonic component; hedonic wellbeing research*[^11_15][^11_6]

**Design requirement:** The system must not create chronic negative emotional experience through alarm fatigue, constant monitoring requirements, decision pressure, or frustrating interaction design. Every interaction a practitioner has with the system is an affective event — aggregated, these events constitute the practitioner's daily emotional experience of work. This must be designed for, not left to emerge.

**Validated instrument:** PANAS (Positive and Negative Affect Schedule) administered at work; Experience Sampling Method (ESM) for in-the-moment affect capture during work. ESM is the gold standard because it captures affect at the moment of experience rather than retrospectively, eliminating recall bias.[^11_16][^11_17][^11_18][^11_19][^11_6]

**Behavioral proxy:** The ratio of practitioner-initiated interactions with the system (seeking it out because it helps) to system-initiated interactions (responding to alerts, monitoring queues, handling escalations). A system that primarily creates demands rather than serves practitioner needs will produce negative affect regardless of its technical accuracy.

**Degradation signal:** PANAS negative affect subscale scores rising; ESM data showing negative affect clustering around system interactions; practitioners describing work days as exhausting or draining after deployment in contexts where they previously didn't.

***

## The Composite Diagnostic

The JCM's Motivating Potential Score  provides a single pre/post diagnostic that captures five of the nine dimensions in one formula. It should be computed before deployment and at regular intervals thereafter:[^11_1][^11_2]

$$
MPS = \frac{SV + TI + TS}{3} \times A \times F
$$

Where scores come from the JDS subscales. This is not a substitute for tracking individual dimensions — it's a high-level health indicator that flags when the overall motivating structure of the work is changing. A declining MPS that cannot be explained by planned system changes is a structural alert.

***

## The Proof Template for Work Experience Quality

Every agent deployment has an output quality proof template. Work experience quality now requires its own:[^11_20][^11_3]


| Element | Content |
| :-- | :-- |
| **Pre-deployment baseline** | JDS, BPNS-W, UWES, WAMI, Edmondson scores for practitioners; MPS computed; time-use baseline established |
| **Design specification per dimension** | For each of the nine: target outcome (improve, maintain, or justified tradeoff with documented reasoning); specific design decisions made to satisfy the requirement |
| **Acceptance criteria** | Minimum acceptable score on each dimension at 3 months, 6 months, 12 months post-deployment |
| **Measurement protocol** | Who administers each instrument, at what frequency, with what independence guarantee |
| **Trigger thresholds** | Specific score changes that trigger defined responses (escalation to governance, design review, deployment pause) |
| **Attribution requirement** | For any dimension degrading, a documented investigation of which design decisions contributed and what remediation is proposed |

This proof template is verified independently before deployment — the same executor/verifier separation principle applies here as to task outputs. The design team that built the system cannot verify that their own design satisfies the work experience requirements.[^11_3]

***

## Framework Integration

The nine dimensions and their proof template map to specific layers in the existing framework:[^11_3]


| Framework layer | Integration point |
| :-- | :-- |
| **Purpose (L1)** | Work experience dimensions added as explicit design goals; the human-agent boundary *must* be defined with reference to autonomy, task identity, and engagement — not just capability |
| **Specification (L3)** | Acceptance criteria for work experience alongside output acceptance criteria; both must be defined before work begins |
| **Trust (L5)** | Work experience proof added to proof-as-product; a deployment without work experience evidence is an unverified deployment |
| **Safety (L6)** | Psychological safety is a structural property of the system, not a cultural property of the team — override frictionlessness and concern response are structural requirements |
| **Improvement (L8)** | Work experience metrics enter the improvement loop with equal standing to output quality; MPS and UWES trends are tracked alongside rework rates and accuracy |
| **Human Enrichment (L9)** | This layer now has concrete, measurable content — the nine dimensions with validated instruments, behavioral proxies, and degradation triggers [^11_3] |

The deepest integration is in Layer 9. The framework's commitment — "the distinction between a system that completes tasks and a system that generates excellence is whether every interaction leaves someone more capable of the next one"  — now has a measurement substrate: capable *and engaged* and *growing* and *connected to purpose* and *safe to question* and *experiencing their work as meaningful*. Excellence is not a gestural aspiration. It is nine dimensions, each with an instrument, each with a baseline, each with a trigger.[^11_7][^11_2][^11_3][^11_5]
<span style="display:none">[^11_21][^11_22][^11_23][^11_24][^11_25][^11_26]</span>

<div align="center">⁂</div>

[^11_1]: https://digital.library.unt.edu/ark:/67531/metadc2885/m2/1/high_res_d/dissertation.pdf

[^11_2]: https://werkwelzijnenmotivatie.wordpress.com/wp-content/uploads/2020/05/hackman-oldham-1975.pdf

[^11_3]: agent-design-principles-v0.2.md

[^11_4]: https://selfdeterminationtheory.org/SDT/documents/2005_GagneDeci_JOB_SDTtheory.pdf

[^11_5]: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2018.01157/full

[^11_6]: https://pmc.ncbi.nlm.nih.gov/articles/PMC8819083/

[^11_7]: https://www.wilmarschaufeli.nl/publications/Schaufeli/Test Manuals/Test_manual_UWES_English.pdf

[^11_8]: https://www.limesurvey.org/blog/knowledge/understanding-the-utrecht-work-engagement-scale-uwes

[^11_9]: https://pmc.ncbi.nlm.nih.gov/articles/PMC9963286/

[^11_10]: https://humaans.io/hr-glossary/hackman-and-oldham-model

[^11_11]: https://www.geeksforgeeks.org/hr/job-diagnostic-survey-jds-by-hackman-and-oldham/

[^11_12]: https://journals.sagepub.com/doi/10.2307/2666999

[^11_13]: https://pmc.ncbi.nlm.nih.gov/articles/PMC9819141/

[^11_14]: https://www.kaizenko.com/amy-edmondsons-psychological-safety-leadership-guide-to-team-innovation/

[^11_15]: https://positivepsychology.com/perma-model/

[^11_16]: https://en.wikipedia.org/wiki/Experience_sampling_method

[^11_17]: https://www.eur.nl/en/essb/research/measuring-daily-life

[^11_18]: https://onlinelibrary.wiley.com/doi/full/10.1002/cpp.2798

[^11_19]: https://www.expiwell.com/post/what-is-the-experience-sampling-method

[^11_20]: framework-principles-v0.4.md

[^11_21]: https://www.nature.com/articles/s41598-025-26907-z

[^11_22]: https://www.frontiersin.org/journals/psychology/articles/10.3389/fpsyg.2025.1486363/full

[^11_23]: https://pubmed.ncbi.nlm.nih.gov/38148025/

[^11_24]: https://www.ijssh.net/vol6/730-EP10007.pdf

[^11_25]: https://journals.copmadrid.org/jwop/art/j.rpto.2016.12.001

[^11_26]: https://jurnal.dim-unpas.web.id/index.php/JIMK/article/download/53/97


---

# Are the tasks and processes we have been discussing here a part of any existing job roles? Are there any analogs?

The short answer is: partially, across several disciplines, but not holistically in any single existing role. The synthesis we've been building is genuinely novel — and understanding where existing professions come close, and where they stop, reveals precisely what is missing from current practice.[^12_1][^12_2]

***

## The Closest Existing Disciplines

Five disciplines each cover a significant portion of what we've been discussing, but none spans the whole:

### Industrial-Organizational (I-O) Psychology

This is the closest single discipline to the measurement and design work we've been doing. I-O psychologists are specifically trained in the JDS, UWES, BPNS, and WAMI instruments we identified. They design job interventions, conduct organizational diagnostics, and study motivation theory. The emerging mandate, as the South African Journal of Industrial Psychology now explicitly states, is that I-O psychologists have "a dual mandate: to anticipate and mitigate the negative consequences of disruption while guiding organisations to use AI ethically and constructively... ensuring data integrity, protecting employee dignity, and supporting trust in AI-driven systems".[^12_3][^12_2]

**What it covers:** All nine wellbeing dimensions, validated measurement, job redesign, organizational psychology
**What it misses:** Agent architecture design, trust-as-structure (as opposed to trust-as-culture), participatory governance mechanics, the proof-as-product requirement, continuous improvement dual metrics

### Human Factors Engineering

Human factors (or ergonomics) specifically addresses human-system integration — workload analysis, cognitive ergonomics, task allocation between humans and automation, and safety-critical system design. Engineers Australia has identified the emerging need for human factors practitioners specifically trained in AI contexts. The discipline's core commitment — that the unit of design is the *whole system*, not the technical component in isolation — maps directly to our framework's "performance is a system property, not an agent property" principle.[^12_4][^12_5][^12_6]

**What it covers:** Human-system boundary design, workload management, trust calibration, automation complacency, safety-critical human-in-the-loop placement
**What it misses:** Worker flourishing beyond safety and performance, participatory governance, beneficiary involvement, structural ethics, continuous improvement loops

### Sociotechnical Systems Design

Originating from the Tavistock Institute in the 1950s (Trist and Emery), sociotechnical systems design holds that organizations are joint social and technical systems, and optimizing one without the other produces suboptimal outcomes. A 2026 paper by Herrmann directly applies this to AI integration: "instead of viewing AI merely as a technical tool, the analysis emphasizes the importance of embedding AI into communication, collaboration, and decision-making processes within organizations from a human-centered perspective".[^12_1]

**What it covers:** Joint human-technical optimization, organizational context, the system as the unit of design
**What it misses:** The measurement rigor of I-O psychology, trust architecture, participatory governance mechanics, wellbeing as a design requirement with proof obligations

### Organizational Development (OD)

OD practitioners design organizational change processes, facilitate participatory design, manage stakeholder engagement, and sustain organizational learning. The discipline has the deepest heritage in involving the most affected in design — the Action Research tradition, co-design methodologies, and appreciative inquiry are all OD contributions.

**What it covers:** Stakeholder participation, change management, organizational learning, facilitation
**What it misses:** Agent system design, measurement rigor, trust architecture, the structural (rather than cultural) enforcement of ethical requirements

### Human-Centered AI Design (Shneiderman)

Ben Shneiderman's definition is worth quoting directly, as it is the closest articulation of what we've been building toward: *"amplifying, augmenting, enhancing human performance in ways that make systems reliable, safe, and trustworthy. These systems also support human self-efficacy, encourage creativity, clarify responsibility, and facilitate social participation"*. The field is emerging, sits primarily in HCI (Human-Computer Interaction) research, and has growing practitioner communities at Stanford HAI, MIT Media Lab, and CSIRO in Australia.[^12_7][^12_8]

**What it covers:** Human performance amplification, trustworthy systems, self-efficacy, social participation
**What it misses:** Worker wellbeing measurement as a design requirement, participatory governance mechanics, proof-as-product requirements, structural ethics enforcement, continuous improvement with dual fidelity/enrichment metrics

***

## The Most Underappreciated Analogs

Two fields that rarely appear in AI design discussions carry lessons that are directly applicable:

### Implementation Science

Implementation science emerged in public health and healthcare to answer a specific question: why do evidence-based interventions fail to take hold in real organizations, even when they demonstrably work in trials? The field developed structured frameworks — the Consolidated Framework for Implementation Research (CFIR), the EPIS model (Exploration-Preparation-Implementation-Sustainment) — for understanding how context, stakeholder relationships, organizational readiness, and ongoing adaptation determine whether an intervention sustains or degrades.[^12_9]

The parallels to our work are structural:

- Implementation science insists that the most affected must be involved in adaptation, not just the initial design
- It distinguishes between *fidelity* (did we deploy as designed?) and *outcomes* (did it produce the intended effect in this context?) — our dual-axis framework
- It tracks sustainability over time as a primary outcome, not just initial performance
- It explicitly studies what happens when organizational conditions change and the intervention needs to adapt

Implementation scientists working in healthcare would recognize almost every design problem we've been discussing. The vocabulary is different; the structure is remarkably similar.

### Aviation and Healthcare Safety Science

These two fields have spent decades developing human-system integration frameworks for high-stakes environments where system failure costs lives. The contributions directly relevant to us:

- **Just culture** (Sydney Dekker): distinguishes between system failures and individual failures; creates psychological safety to report errors without punitive consequences. This is Edmondson's psychological safety at the organizational level, architecturally enforced[^12_10][^12_11]
- **Crew Resource Management (CRM)** in aviation: designed to ensure that the human in the system — the pilot — retains genuine authority and judgment even when automated systems are performing most of the work. The training explicitly addresses automation bias (over-trusting the system) and skill decay (losing manual flying ability from under-practice)
- **Safety II** (Hollnagel): shifts from asking "why do things go wrong?" to "why do things go right, most of the time?" — attending to the everyday work that makes systems resilient, not just the failure cases. This reframes the measurement problem from error rates to capability resilience — directly analogous to our dual-axis approach

These fields have institutionalized the mechanisms we're designing — structured handoffs, mandatory uncertainty escalation, irreversibility classification, independent verification — not as principles but as practiced procedures with professional certification attached.

***

## What Doesn't Exist

The honest synthesis is this: the full combination we've been building throughout this conversation — agent system design, worker wellbeing as structural design requirements with proof obligations, participatory governance through the lifecycle, trust architecture that is structural rather than cultural, and continuous improvement with dual fidelity/enrichment metrics — **does not exist as a named profession or practice discipline**.[^12_12][^12_2][^12_1]

Each contributing discipline reaches its boundary at a different point:


| Discipline | Goes deep on | Boundary |
| :-- | :-- | :-- |
| I-O Psychology | Measuring and designing for wellbeing | Stops at agent architecture |
| Human Factors | Human-system boundary design | Stops at flourishing beyond safety |
| Sociotechnical Design | Joint optimization of social/technical | Stops at measurement rigor |
| OD Consulting | Participatory design and change | Stops at structural ethics enforcement |
| Human-Centered AI | Amplifying human capability | Stops at governance mechanics and proof obligations |
| Implementation Science | Sustained real-world deployment | Stops at agent architecture and structural trust |
| Aviation/Healthcare Safety | Structural human-system integration | Stops at worker flourishing and beneficiary governance |

The synthesis is the gap. It requires the wellbeing measurement competency of I-O psychology, the human-system design competency of human factors, the participatory governance competency of OD, the structural ethics orientation of the best AI governance frameworks, and the deployment sustainability thinking of implementation science — held together by the agent design architecture that currently has no professional home in any of these fields.[^12_2][^12_1]

***

## What This Means

Two practical implications emerge from this analysis:

**First, there is a professional formation gap.** The people currently designing agentic systems typically have software engineering or AI research backgrounds. The people who have the wellbeing measurement tools (I-O psychologists) rarely participate in agent system design. The people who understand participatory governance (OD practitioners) rarely understand agent architecture. The design teams building the systems that will affect millions of workers' daily experience are missing the disciplinary knowledge to design for what we've been discussing.[^12_13][^12_2]

**Second, the framework we've been building through this conversation constitutes a design for that missing professional synthesis.** The nine wellbeing dimensions with their instruments and proof templates, the participatory governance mechanics through the lifecycle, the structural (rather than declarative) ethics enforcement, the dual fidelity/enrichment metric system, and the human-agent boundary drawn by meaning rather than capability — taken together, this is a practice methodology that no current profession teaches as a whole.[^12_8][^12_12][^12_1]

The closest institutional home for this emerging synthesis is probably Human-Centered AI research centers — Stanford HAI, MIT, CSIRO — but the practitioner role it implies has not yet been professionalized, certificated, or systematically trained for. What we've been designing is, among other things, the curriculum for that profession.[^12_14][^12_7]
<span style="display:none">[^12_15][^12_16][^12_17][^12_18]</span>

<div align="center">⁂</div>

[^12_1]: https://arxiv.org/abs/2601.21492

[^12_2]: https://sajip.co.za/index.php/sajip/article/view/2385/4554

[^12_3]: https://valuematrix.ai/blog/the-role-of-i-o-psychologists-in-ai-driven-hiring/

[^12_4]: https://www.linkedin.com/pulse/ai-implementation-human-factor-change-management-amit-paul-lqtzc

[^12_5]: https://www.pddinnovation.com/the-evolving-role-of-ai-in-human-factors/

[^12_6]: https://www.engineersaustralia.org.au/sites/default/files/Artificial_Intelligence_the_Emerging_Needs_for_Human_Factors_Engineering_Risk_Management_and_Stakeholder_Engagement_0.pdf

[^12_7]: https://today.design/news/practicing-responsible-and-human-centred-ai/

[^12_8]: https://www.linkedin.com/pulse/applying-human-centered-ai-design-field-software-jilan-shash-vtyrf

[^12_9]: https://lpsonline.sas.upenn.edu/features/science-happiness-work-how-positive-psychology-can-increase-productivity

[^12_10]: https://journals.sagepub.com/doi/10.2307/2666999

[^12_11]: https://www.kaizenko.com/amy-edmondsons-psychological-safety-leadership-guide-to-team-innovation/

[^12_12]: https://www.sciencedirect.com/science/article/pii/S2212827122007235

[^12_13]: https://sapia.ai/resources/blog/organizational-psychology-in-the-age-of-ai/

[^12_14]: https://www.youtube.com/watch?v=5UJ0uWqO1Ho

[^12_15]: https://www.lindenwood.edu/blog/human-centered-ai-careers/

[^12_16]: https://uxdesign.cc/riding-the-wave-from-human-centered-design-to-human-centered-ai-5ab0f3b321c9

[^12_17]: https://newstardom.com/insights/how-ai-is-reshaping-industrial-and-organizational-psychology-in-hiring

[^12_18]: https://healthtech.decos.com/en/resources/blog/intersection-human-factors-and-ai-opportunities-and-challenges


---

# How does this concept fit with a DAO?

As a blockchain economics lecturer I am a proponent of DAOs.

The fit is not merely compatible — at several points the DAO model is the natural organizational container for exactly what we've been designing. But the empirical research on actual DAO labor conditions reveals specific gaps that our framework directly addresses, and vice versa. The two bodies of thinking have precisely complementary strengths and weaknesses.[^13_1][^13_2]

***

## The Structural Resonances

Five of the most fundamental principles in our framework are essentially DAO primitives that have been independently derived from the same underlying logic — that structure is more trustworthy than declaration:


| Framework principle | DAO equivalent | The shared logic |
| :-- | :-- | :-- |
| **Structural ethics (P3)** — constraints enforced by design, not policy | Smart contracts — rules that cannot be bypassed by any actor regardless of authority | Ethics that can be overridden under pressure are not ethics; they are suggestions |
| **Proof as product (T2)** + **All actions witnessed (T4)** | Immutable on-chain ledger; cryptographic proof | Trust requires evidence that cannot be altered after the fact |
| **Distributable verification (T7)** — quorum-based, no single point of trust failure | Consensus mechanisms; multi-sig governance | No single verifier is a single point of trust failure |
| **Authority is structural (T3)** — capability-based, not declared | Smart contract capability gating — you either hold the token/key or the transaction fails | Permission systems that can be socially engineered are not structural |
| **Human flourishing with governance representation from affected parties (P1)** | Token-based governance rights distributed to stakeholders | Those who bear the consequences must have structural standing in decisions |

These are not analogies. They are the same design commitment expressed in different technical vocabularies. Both bodies of thinking arrived at structural enforcement, immutable evidence, and distributed verification as necessary conditions for trustworthy systems — one from agent system design, one from blockchain mechanism design.[^13_3][^13_4][^13_5]

***

## The Worker-Led DAO as Organizational Container

The most important connection is at the organizational level. The power asymmetry problem we identified — those who design the system have power, those most affected by it have the least power to enforce their interests — is precisely what the worker-led DAO structure is designed to solve architecturally.[^13_2][^13_6]

A worker-led DAO policy brief proposes a two-tier structure directly relevant here: votes on organizational governance handled through worker democracy (one worker, one governance token, one vote — not token-weighted), while shares of future value creation are distributed separately. This separation matters enormously:[^13_2]

- **Governance rights** should not be capital-weighted — a beneficiary with no financial stake has as much right to shape the service they receive as a funder does
- **Economic rights** can reflect different contributions without contaminating governance legitimacy

This maps directly to our participatory governance requirements: practitioners need governance standing over the human-agent boundary independent of their capital position; beneficiaries need governance standing over service quality independent of their ability to pay; the two should operate in separate governance tracks rather than collapsing into a single token-weighted vote.[^13_7][^13_8][^13_5]

The RadicalxChange analysis makes the key architectural point: "any token-voting system must have an identity system that formally distinguishes between different agents, or it will slide toward plutocracy". The identity question — *who is a practitioner*, *who is a beneficiary*, *what is their relationship to this system* — must be answered structurally before governance can function.[^13_8]

***

## What Empirical Research Reveals About Current DAOs

A 2026 empirical study — the first comprehensive examination of actual working conditions in DAOs, based on ethnographic research with 38 contributors — delivers a finding that every DAO proponent should sit with honestly: "while many DAO contributors aspire for DAOs to be solidarity economy vehicles akin to cooperatives and mutualist organisations, in practice, DAO labour falls short of this vision".[^13_1]

Three specific gaps emerge from that research:[^13_1]

**Psychosocial security** — contributors lack the psychological safety and relational stability that makes good work possible. The aspiration for self-determined, autonomous contribution hasn't produced the conditions for flourishing; instead it has produced precarity and anxiety. This is precisely the gap our framework addresses through the nine wellbeing dimensions. Current DAOs optimize for token mechanics and treasury management while leaving the psychosocial conditions of contribution largely undesigned.

**Financial predictability** — the compensation volatility inherent in token-denominated work creates cognitive and emotional overhead that consumes the capacity for good work. This connects directly to our observation that financial security beyond compensation is a necessary prerequisite for work wellbeing that the work experience itself cannot compensate for.[^13_9]

**Regulatory clarity** — the legal ambiguity surrounding DAO labor status creates a form of chronic uncertainty that undermines the psychological safety conditions essential for authentic contribution.[^13_6]

The study also identifies something important about invisible labor: "the ecosystem needs to recognise and value the invisible labour of coordination that maintains the flexible and self-determined structures in DAOs". This is exactly the kind of work our productive/unproductive friction analysis would identify as meaningful work that the system must make visible and valued — the coordination that holds the human tissue of the organization together.[^13_1]

***

## What Each Body of Thinking Gives the Other

The intersection is genuinely generative in both directions:

**What our framework gives the DAO model:**

- The nine wellbeing dimensions as *on-chain governance metrics* — DAO governance currently manages treasury, protocol parameters, and product roadmaps. It does not manage the psychosocial conditions of contributor work. Adding the nine dimensions as verifiable, on-chain metrics transforms worker wellbeing from aspiration into a structural governance object[^13_6][^13_1]
- The work experience proof template as a condition for treasury allocation — proposals that would degrade contributor autonomy, task identity, or psychological safety require evidence of mitigation before funds are released
- The progressive scaffolding principle as a token economics design: practitioners earn governance weight as their competence demonstrably grows — contributing to a virtuous cycle where investment in contributor development is structurally rewarded

**What the DAO model gives our framework:**

- **The incentive alignment solution.** Our framework requires that the most affected have genuine governance standing. DAOs provide the mechanism: governance tokens distributed to practitioners and beneficiaries, with smart contracts enforcing that the human-agent boundary cannot be changed without their consent. This is not a design principle — it is a structural technical fact
- **The organizational independence solution.** Our framework requires structural ethics enforcement at the organizational level, not just the system level. A DAO is an organization whose rules cannot be changed by any single authority including its founders. This makes "the organization is committed to worker flourishing" not a mission statement but an encoded constraint
- **The proof-of-value portability solution.** The framework's Proof of Value Layer — effectiveness evidence independently verifiable by any party — finds its most natural implementation on-chain. Funders, regulators, and partner organizations can verify system effectiveness without access to the deploying organization's internal data[^13_5][^13_10]

***

## The Mechanism Design at the Intersection

For the blockchain economics perspective, the most interesting design question is the token mechanism for encoding worker wellbeing as a governance object. Consider the following architecture:

**Contribution tokens** (non-transferable, non-capital) represent demonstrated practitioner participation and capability growth. They are earned by:

- Demonstrated competence growth over time (capability assessments improving)
- Quality override contributions (overrides that demonstrably improved outcomes)
- Governance participation (proposals that improved system behavior)
- Verified high scores on the nine dimensions relative to baseline

This creates an incentive structure where practitioners benefit from investing in the system's improvement — because their governance weight grows with their demonstrated contribution to it. The standard DAO plutocracy problem (capital buys governance) is inverted: demonstrated work quality and capability growth is what earns governance standing.[^13_7][^13_2]

**Wellbeing bonds** could extend this further — the DAO treasury allocates a portion to a wellbeing fund released to practitioners when aggregate wellbeing metrics (UWES, BPNS, psychological safety scores) meet defined thresholds, verified on-chain. This creates a treasury-level incentive for the DAO's technical contributors to design for practitioner flourishing: if the agents they build improve contributor wellbeing metrics, the treasury reward flows. If they build systems that degrade wellbeing (even while improving output accuracy), the wellbeing bond is not released.

This is incentive alignment at the mechanism level, not the principle level.[^13_11][^13_12]

***

## The Genuinely Novel Synthesis

Current DAOs address governance, treasury management, and protocol evolution. They do not structurally address the quality of the work experience of those who contribute to them — this remains in the aspiration layer, producing the gap the empirical research documents.[^13_1]

Current agent system design addresses task accuracy, safety, and increasingly human capability enrichment. It does not have a native organizational form — it sits inside traditional hierarchical organizations where the structural ethics it requires are ultimately overridable by management authority.

The synthesis that hasn't yet been built is: **a DAO whose encoded governance specifically commits to — and structurally enforces — the nine dimensions of worker flourishing, with agentic systems deployed as contributors to the DAO's mission and governed through the DAO's participatory mechanisms**.[^13_2][^13_6][^13_1]

In this form:

- The human-agent boundary is not a management decision — it is a DAO governance parameter that requires practitioner consent to change
- Worker wellbeing metrics are on-chain, verifiable, and first-class governance inputs — not cultural programs managed by HR
- Beneficiaries are not passive recipients — they hold governance standing over service quality through non-financial governance mechanisms
- Agents are not owned by a corporation optimizing for shareholder returns — they are governed by the community they serve, which includes the practitioners whose work experience they affect

The aspiration of the labor movement that the DAO ecosystem claims as a heritage — "workers began to demand more rights, decent pay and better working conditions"  — would, in this synthesis, be *structurally encoded* rather than negotiated and re-negotiated against the structural power of capital.[^13_13]

That is not a modest claim. But it is what the intersection of these two bodies of thinking, taken seriously, actually points toward.
<span style="display:none">[^13_14][^13_15][^13_16][^13_17][^13_18]</span>

<div align="center">⁂</div>

[^13_1]: https://policyreview.info/articles/analysis/decentralised-autonomous-organisations

[^13_2]: https://aspenpolicyacademy.org/wp-content/uploads/2024/11/DAO-Policy-Brief.pdf

[^13_3]: https://papers.ssrn.com/sol3/papers.cfm?abstract_id=6306198

[^13_4]: https://www.sciencedirect.com/science/article/abs/pii/S0929119925000021

[^13_5]: framework-principles-v0.4.md

[^13_6]: https://prism.sustainability-directory.com/scenario/global-dao-labor-standards-harmonization-challenges/

[^13_7]: https://storecloud.org/blog/dao-governance-more-democracy-less-plutocracy

[^13_8]: https://www.radicalxchange.org/updates/blog/a-speculative-sketch-of-a-dao-with-open-collective/

[^13_9]: https://wellbeing.gmu.edu/employee-well-being-factors-that-influence-job-satisfaction/

[^13_10]: suggested-updates.md

[^13_11]: https://www.ecgi.global/publications/working-papers/dao-governance

[^13_12]: https://www.nature.com/articles/s41598-026-40180-8_reference.pdf

[^13_13]: https://academy.youngplatform.com/en/blockchain/how-daos-work-governance-blockchain/

[^13_14]: https://www.frontiersin.org/journals/blockchain/articles/10.3389/fbloc.2025.1523951/full

[^13_15]: https://www.jdsupra.com/legalnews/daos-and-the-new-fiduciary-frontier-2074624/

[^13_16]: https://onlinelibrary.wiley.com/doi/10.1111/1744-7941.70042

[^13_17]: https://jbba.scholasticahq.com/article/133242-designing-community-governance-learnings-from-daos.pdf

[^13_18]: https://papers.ssrn.com/sol3/Delivery.cfm/5332134.pdf?abstractid=5332134\&mirid=1


---

```
# <q>2. The verification gap affects every persona differently but breaks trust at each level for the same reason. Designers can specify but not verify their specifications were implemented as intended. Builders can test but not test every condition. Users can observe outputs but not audit reasoning. Beneficiaries can experience outcomes but not inspect the process. Decision makers can approve but not understand. Each persona's inability to verify independently of the others creates a chain of inherited trust that doesn't compound — it accumulates risk at each transfer.</q> How might smart contracts and DAOs address or resolve this challenge?
```

The verification gap quote is describing something precise in information theory: risk doesn't just transfer through a chain of custody — it *compounds at each opacity point*. The person downstream cannot see what the person upstream knew, assumed, or decided, so they must inherit not just the output but all the unverifiable assumptions embedded in it. Smart contracts and DAOs address this by fundamentally changing the epistemic substrate — from opaque custody transfers to a shared, inspectable record — but they do not eliminate the need for trust, they *relocate and narrow it* in specific, important ways.[^14_1][^14_2]

***

## The Core Mechanism

The quote's key phrase is "inherited trust that doesn't compound — it accumulates risk." This is a precise statement about information asymmetry propagating through layers. Each persona has private knowledge the others can't access, so trust flows downward through the chain as an assumption rather than a verification.

Smart contracts address this by creating a **shared epistemic surface** — all parties verify against the same record, rather than each trusting the previous one. The DAO adds a **shared governance surface** — all parties have structured standing to contest, propose, and collectively decide, rather than each having to accept what the layer above them produced.

But the mechanism is not uniform across all five personas. The precision is important.

***

## Persona by Persona

### Designers: specify but not verify implementation

This is the gap smart contracts address most completely. In traditional systems, the designer writes a specification in natural language, the builder interprets it, and the designer can never fully verify that what was built matches what was meant.

Smart contracts + formal verification collapse this gap structurally. Formal verification provides **mathematical proof** that the implemented code is equivalent to the formal specification — not "we believe it matches" but "we have proven it cannot deviate". The process works by expressing the specification as a set of invariants and properties, then using model checking (exhaustive state exploration), theorem proving (logical proof under all circumstances), or symbolic execution (proof across symbolic rather than concrete inputs) to verify the code satisfies them.[^14_3][^14_4]

The designer who specifies in formal terms can verify — mathematically — that the builder implemented what was specified. The gap between specification and implementation is closed.[^14_5][^14_1]

**The residual gap**: formal verification proves `implementation = specification`. It cannot prove `specification = intention`. Did the designer specify what they actually meant? This gap cannot be closed cryptographically — it requires the human governance layer, specifically the participatory design process we discussed: practitioners and beneficiaries whose involvement ensures the specification represents genuine intent before it becomes executable law.

***

### Builders: test but not test every condition

Testing is empirical — it covers the conditions you thought to check. The builder cannot verify behaviour across conditions they didn't conceive of.

Formal verification addresses this directly. Model checking **exhaustively explores all possible states and transitions** — not a sample of inputs, but the entire reachable state space. Symbolic execution works with symbolic inputs rather than concrete test cases, effectively running the code against every possible input simultaneously. Theorem proving produces proofs that specified properties hold **under all circumstances**, not just tested ones.[^14_6][^14_4]

For the builder, this shifts from "we tested thoroughly" to "we proved this failure mode structurally cannot occur." The 2025 paper on formal verification notes it "ensures that smart contracts function according to their intended specifications" and is "indispensable for systems with high stakes"  — indispensable precisely because empirical testing cannot provide the guarantee formal verification can.[^14_3]

**The residual gap**: formal verification scales with complexity. For well-specified financial contracts, it is tractable today. For complex agentic systems with emergent reasoning behaviours, full formal verification of every property remains an open research problem. Builders can verify the contract's execution logic but not the quality or correctness of an agent's cognitive outputs that the contract then acts upon.

***

### Users: observe outputs but not audit reasoning

This is the most profound gap for agentic systems specifically, and the one where the most interesting new cryptographic tooling is emerging.

**On-chain reasoning traces** provide a partial solution: if the agent is required to commit its reasoning steps to the chain *before* producing output, those steps are immutable and inspectable. The user cannot change or challenge the record ex-post. This is our framework's epistemic context requirement made cryptographically verifiable — not just the output but the verified, immutable chain of reasoning that produced it, available to any party.

The more powerful solution is **Zero-Knowledge Proofs (ZKPs)**. A ZKP allows an agent to *prove* that its reasoning had certain properties — was not biased, used approved inputs, followed the specified procedure — *without revealing the proprietary model or the private data that was processed*. The mathematical structure is:[^14_7][^14_8][^14_9]

$$
C(x, w) = y
$$

where $C$ is the circuit (the process), $x$ is the public input, $w$ is the private witness (the model, the private data), and $y$ is the public output. The ZKP convinces any verifier that a secret $w$ exists such that the process produces $y$ from $x$ — without revealing $w$ itself.[^14_7]

The ZKMLOps framework applies this specifically to AI/ML systems, providing "verifiable cryptographic proof of compliance" across ML operations lifecycles, including "verifying inference results for proprietary neural networks and auditing datasets for fairness or bias without exposing sensitive data".[^14_7]

For the user: this shifts from "I observe the output and must trust the process" to "I can verify cryptographically that the process that produced this output had specific properties." The reasoning is not visible, but its compliance with specified properties is provable.

**The residual gap**: ZKPs prove *process* properties, not *quality* properties. They can prove "the model was trained on approved data using the specified fairness procedure" — they cannot prove "this output is correct." The user can verify the process was right; they still cannot independently verify the output is right. That requires the verification layer — independent human review against pre-defined criteria.

***

### Beneficiaries: experience outcomes but not inspect the process

Beneficiaries face two distinct problems collapsed into one. They cannot inspect *what the process did* (the transparency problem) and they have no *structural standing* to contest it if their experienced outcome diverges from what was promised (the governance problem).

**Transparency for beneficiaries**: if outcome records are on-chain, beneficiaries can independently verify what was recorded about their case — without trusting the organization's internal data. Service delivery events, decisions, and their attributed rationale are not held in a system the organization controls; they exist on a shared ledger inspectable by any party.[^14_10]

**Governance standing for beneficiaries**: this is where the DAO mechanism is most directly applicable. A contestation event is not a complaint routed through organizational hierarchy — it is a governance action that triggers defined multi-sig review, recorded permanently, with a required response within specified parameters. The beneficiary cannot be ignored; the contestation is on-chain, visible to all governance token holders, and the absence of response is itself a visible governance failure.[^14_11]

Outcome attestation completes this: service delivery events require beneficiary sign-off before they are closed on-chain. The organization cannot mark a case resolved until the beneficiary confirms — structurally, not as a courtesy.

**The residual gap**: the Oracle Paradox. A beneficiary can verify that what was *recorded* on-chain matches their stated experience — but they cannot verify that the on-chain record accurately captures what the agent actually did in producing its decision. As the Oracle Paradox research states: "blockchain provides fairly immutable virtual provenance workflows, proof that the blockchain accurately represents physical events lacks truly independent verification". The bridge between the agent's internal process and the on-chain record is an oracle, and that oracle reintroduces a trust assumption into a system designed to be trustless.[^14_2]

***

### Decision Makers: approve but not understand

The decision-maker gap is fundamentally about legibility and span of knowledge — having access to information is not the same as comprehending it. Transparency without legibility is noise.

DAOs address this through governance mechanisms that distribute the understanding burden rather than requiring every decision maker to understand everything:

**Liquid democracy** allows decision makers to delegate their governance vote to domain experts they trust on specific questions — a decision maker who understands mission but not agent architecture delegates the architecture vote; one who understands clinical care but not token economics delegates that vote. The trust relationship is explicit, revocable, and recorded, rather than implicit and untraceable.[^14_12][^14_13]

**Evidence synthesis as governance input**: the Proof of Value Layer we designed produces signals specifically structured for governance legibility — not raw transaction logs but synthesized, verified evidence of what the system produced, at what cost, with what distribution of benefit. When this is anchored on-chain, decision makers can engage with verified summaries rather than either trusting staff-produced reports or drowning in raw data.[^14_14]

**The residual gap**: the comprehension gap has a hard floor that no mechanism fully addresses. Even with legible evidence, decision makers who do not engage with it will approve what they are told to approve. The DAO's structural contribution is making *disengagement visible* — a governance vote with zero participation is itself a signal, on-chain, that the governance layer is not functioning. But it cannot force comprehension; it can only make the absence of it transparent.

***

## The Oracle Problem: The Persistent Boundary

Across all five personas, the most fundamental unresolved gap is the same, and it has a name: the **Oracle Problem**.[^14_15][^14_16][^14_2]

Smart contracts guarantee the integrity of data *once it is on-chain*. They cannot guarantee the veracity of data *introduced onto the chain from the off-chain world*. The bridge between the agent's real-world reasoning and the on-chain record requires trust in whatever oracle reports that reasoning.

The 2025 research on whether AI can solve the oracle problem concludes directly: *"AI should be understood as a complementary layer of inference and filtering within a broader oracle design, not a substitute for trust assumptions"*. AI can improve oracle quality — anomaly detection, cross-source validation, adversarial resistance — but it cannot eliminate the trust assumption at the junction between off-chain reality and on-chain record. That junction will always require a trusted observer.[^14_16][^14_15]

This has a specific structural implication: the oracle at each persona's gap is a human — and the quality of that oracle determines the quality of everything the blockchain can then make trustworthy.

- The oracle for the designer's specification is the participatory design process that tests whether the specification captures genuine intent
- The oracle for the builder's testing is the independent human verifier who confirms the formal specification represents what was actually needed
- The oracle for the user's reasoning audit is the practitioner whose override quality demonstrates whether the process is producing sound judgment
- The oracle for the beneficiary's process inspection is the contestation review body with genuine governance standing
- The oracle for the decision maker's comprehension is the legible evidence synthesis — verified, but still requiring a human to engage with it

***

## What This Architecture Produces

Smart contracts and DAOs do not eliminate the need for trust. They do something more useful: they **compress the trust surface and make its boundaries explicit**.[^14_17][^14_1]


| Persona gap | Status with smart contracts + DAOs | Residual trust requirement |
| :-- | :-- | :-- |
| **Designers**: specify but not verify | ✓ Closed by formal verification | Specification must capture intent — requires participatory design |
| **Builders**: test not every condition | ✓ Substantially closed by model checking | Agent cognitive outputs still require human verification |
| **Users**: observe but not audit reasoning | ◑ Partially addressed by ZKPs (process), on-chain traces | Output quality still requires independent review |
| **Beneficiaries**: experience but not inspect | ✓ Governance standing via contestation; outcome attestation | Oracle gap — on-chain record accuracy requires trusted reporting |
| **Decision makers**: approve but not understand | ◑ Liquid democracy, legible evidence synthesis | Engagement with information cannot be structurally forced |

The chain of inherited trust is not eliminated — it is replaced with a smaller number of explicit, located, structural trust requirements. Instead of five opaque persona-to-persona transfers each accumulating unverified assumptions, you have a transparent record that all personas verify against directly, with clearly named oracle requirements at each gap that remains.[^14_2][^14_15]

The oracle requirements are precisely where our framework's human governance layer, psychological safety requirements, participatory design process, and human enrichment principles live. Blockchain cannot reach them — not because blockchain is weak but because these gaps are located in the relationship between human meaning and formal representation, and that relationship cannot be cryptographically closed. It can only be well-governed.[^14_18][^14_19][^14_11]

The deepest insight: the framework and the DAO are not redundant approaches to the same problem. The blockchain resolves the *formal* verification gaps; the framework resolves the *semantic* verification gaps — the gaps between what was specified and what was meant, between what was recorded and what actually happened, between what was approved and what was understood. Neither can replace the other. Together they close the chain.
<span style="display:none">[^14_20][^14_21][^14_22][^14_23]</span>

<div align="center">⁂</div>

[^14_1]: https://ramagururadhakrishnan.github.io/Blockchain-Papers/Formal_Methods/A_Survey_of_Smart_Contract_Formal_Specification_and_Verification.pdf

[^14_2]: https://publications.aaahq.org/jis/article/35/2/1/947/Trust-but-Verify-The-Oracle-Paradox-of-Blockchain

[^14_3]: https://arxiv.org/pdf/2503.20461.pdf

[^14_4]: https://hashlock.com/blog/what-is-formal-verification-in-smart-contract-auditing

[^14_5]: https://dl.acm.org/doi/fullHtml/10.1145/3464421

[^14_6]: https://bitcoinmagazine.com/technical/goodbye-bugs-how-formal-verification-could-fortify-smart-contracts

[^14_7]: https://arxiv.org/html/2510.26576v1

[^14_8]: https://aico.ai/glossary/zero-knowledge-proof

[^14_9]: https://www.dock.io/post/zero-knowledge-proofs

[^14_10]: https://academy.youngplatform.com/en/blockchain/how-daos-work-governance-blockchain/

[^14_11]: trust-framework-analysis.md

[^14_12]: https://www.radicalxchange.org/updates/blog/a-speculative-sketch-of-a-dao-with-open-collective/

[^14_13]: https://jbba.scholasticahq.com/article/133242-designing-community-governance-learnings-from-daos.pdf

[^14_14]: suggested-updates.md

[^14_15]: https://arxiv.org/pdf/2507.02125.pdf

[^14_16]: https://www.frontiersin.org/journals/blockchain/articles/10.3389/fbloc.2025.1682623/full

[^14_17]: https://www.sciencedirect.com/science/article/abs/pii/S0929119925000021

[^14_18]: https://policyreview.info/articles/analysis/decentralised-autonomous-organisations

[^14_19]: framework-principles-v0.4.md

[^14_20]: https://dr.ntu.edu.sg/bitstreams/5bd3acdd-9311-4831-9a96-8d0528f3ed34/download

[^14_21]: https://dev.to/bobrenze/how-ai-agents-verify-trust-in-multi-agent-systems-and-why-most-cant-5474

[^14_22]: https://ceur-ws.org/Vol-3962/paper16.pdf

[^14_23]: https://dl.acm.org/doi/10.1145/3464421


---

# I personally see DAOs and smart contracts as important part of this emerging framework, however, let's leave it to the side for now and draft an overview of the outcomes from our exploratory work today.

What were our revelations?
what was our journey?
Did we make any decisions?
Are there any open questions?
What are the key points we can build upon in our next session?
Which elements should be noted even if not seen as important yet?

This is a session worth capturing carefully — several of today's movements were genuine conceptual shifts, not just elaborations of prior work. Here is an honest account of what happened.

***

## Our Journey

The session began with a pivot. Rather than continuing to build on the existing agent design framework from within its own logic, you introduced a reframing — from *agents doing work for humans* to *agents making work easy and enjoyable for humans*. From that single pivot, everything else followed. The session moved through five connected phases:

1. **The reframing and its structural implications** — unpacking what changes when you invert the design priority
2. **Trust and stakeholder participation** — how the reframing dissolves the adversarial dynamic and what genuine participation requires structurally
3. **Grounding "enjoyable" in research** — replacing a vague aspiration with the rigorous vocabulary of 50 years of organizational psychology
4. **Integration as design requirements** — converting the research into measurable, verifiable acceptance criteria within the framework
5. **Contextualizing in existing practice** — locating the work in existing professions and disciplines, discovering the DAO fit, and examining the verification gap through a blockchain lens

Each phase produced something that the next phase depended on. The session had genuine forward movement rather than lateral elaboration.

***

## The Revelations

These are the moments where something shifted that cannot easily be un-seen:

**1. The reframing changes the design problem at its root, not at the surface.**
Moving from "doing work for humans" to "making work easy and enjoyable for humans" is not a UX or communication shift — it inverts what the system is *for*. In the first framing, the human is an approver. In the second, the human is the purpose. Every design decision downstream is different depending on which you hold.

**2. "Easy" and "enjoyable" are not the same thing, and conflating them is the most dangerous design mistake the reframing can make.**
Some of what makes work meaningful *is* difficulty. The distinction between *productive friction* (difficulty that is the soul of the work) and *unproductive friction* (overhead that serves no intrinsic value) is not obvious from outside the work — it must be classified *with* practitioners, not determined for them. Removing the wrong kind of friction hollows out the work even while making it easier.

**3. The adversarial dynamic in trust is structural, not cultural.**
Under the old framing, the system's design goal (autonomous task completion) and the practitioner's goal (meaningful involvement) are structurally opposed. Every gain for the system feels like a loss for the practitioner. No amount of communication resolves this because it is a real structural conflict. The reframing dissolves it structurally: the system only succeeds if the practitioner's work experience improves. Their interests are aligned by design, producing reciprocal trust that compounds rather than eroding.

**4. Participation, consultation, and governance are not on a spectrum — they are categorically different things.**
Almost all stakeholder involvement in agentic systems is *consultation* performed as if it were *participation*. Genuine participation requires demonstrable influence: something changed because of your input, you can see that it did, and you receive an honest account of what didn't change and why. Governance requires permanent standing: a structural mechanism through which the most affected can contest, propose, and shape the system's evolution indefinitely — not dependent on any particular design team's goodwill.

**5. The power asymmetry problem cannot be resolved by goodwill.**
Those with the most to gain from genuine participation (practitioners and beneficiaries) have the least power to enforce it. Those with the most power (technical teams and organizational leadership) have the least personal stake in whether it happens. This means participation must be a *gate* in the design process with verifiable evidence requirements — not a principle or a cultural value.

**6. "Enjoyable" was doing heavy lifting for nine distinct, independently measurable dimensions.**
The organizational psychology research (SDT, PERMA, JCM, JD-R) provides a precise vocabulary: autonomy, competence growth, relatedness, engagement/flow, meaning, accomplishment, task significance, psychological safety, and positive daily affect. These are not preferences — they are needs in the psychological sense, with validated instruments, known interactions, and documented consequences when unmet. The system can now be evaluated against each independently.

**7. The JCM motivating potential formula reveals that autonomy is a *multiplier*, not an additive component.**

$$
MPS = \frac{SV + TI + TS}{3} \times A \times F
$$

If a system eliminates practitioner autonomy, the entire motivating potential collapses to zero regardless of how well it preserves skill variety, task identity, and significance. This is not a soft finding — it means systems that remove autonomy in exchange for other wellbeing improvements are making a mathematically losing trade.

**8. The worker-to-beneficiary pathway is not a second-order effect — it is the same outcome measured from a different position.**
Service quality research confirms the direct pathway: worker wellbeing → quality of human attention → quality of service experienced by the beneficiary. In the three cases we've been working with, a system that makes the nurse's work better makes the patient's care better. These are not separate outcomes to be weighed against each other. They are the same causal chain.

**9. No existing profession covers the full synthesis.**
I-O psychology has the measurement tools but not the agent architecture. Human factors has the human-system boundary design but not the flourishing orientation. Sociotechnical systems design has the joint optimization logic but not the measurement rigor. OD has the participatory governance but not structural ethics enforcement. Human-Centered AI has the amplification orientation but not the proof obligations. The combination we have been building is genuinely novel — and the professional formation gap is both a constraint and an opportunity.

**10. The DAO model and the agent design framework independently derived the same underlying commitments.**
Both arrived at: structural ethics enforcement (smart contracts / P3), immutable evidence (on-chain ledger / T4), distributed verification with no single point of trust failure (consensus / T7), capability-based authority (cryptographic keys / T3). The structural resonance is not coincidental — both bodies of thinking were responding to the same problem: how to make trust a property of the system rather than a property of the actors within it.

**11. Blockchain resolves *formal* verification gaps; the framework resolves *semantic* verification gaps. Neither can replace the other.**
The Oracle Problem means smart contracts can only guarantee the integrity of data once it is on-chain — they cannot guarantee that the on-chain record accurately represents off-chain reality. The oracle at each persona's verification gap is a human. The quality of that human governance layer — participatory design, psychological safety, legitimate contestation — determines what the blockchain can then make trustworthy. They are not alternative approaches; they are complementary layers with non-overlapping competencies.

***

## Decisions Made

These are the positions we arrived at with enough confidence to carry forward:

- **Replace "enjoyable" with the nine-dimension framework** drawn from validated organizational psychology research. The nine dimensions are now the operational definition of "quality of human work experience" in the framework
- **Work experience quality is a first-class metric alongside output quality** — not a secondary concern, not a compliance checkbox, but an equal axis of system performance with its own proof template, verified independently
- **A pre-deployment baseline is a structural gate** — you cannot demonstrate improvement without a before-state. The JDS, BPNS-W, UWES, WAMI, and Edmondson scales are administered before deployment and define the benchmark
- **The human-agent boundary is drawn by meaning, not capability** — agents handle what is not meaningfully human; humans do what is. The boundary is defined by what practitioners find meaningful, not by what technology can or cannot yet do
- **Productive vs. unproductive friction must be explicitly classified before any work is allocated to agents** — this classification is done *with* practitioners, not for them. It is a design requirement, not an implementation detail
- **Participation requires structural gates with verifiable evidence** — not principles, not cultural commitments. The design team cannot verify their own work experience design requirements; that verification must be independent
- **The DAO and smart contract threads are parked but not abandoned** — acknowledged as a natural structural fit with significant implications for the governance layer, to be developed in a dedicated future session

***

## Open Questions

These remain genuinely unresolved and will need attention:

- **How do the nine dimensions integrate formally into the framework document?** Do they extend Layer 9, sit as a new Layer 10, or modify the fidelity/enrichment questions across all nine existing layers? The structural placement has implications
- **What does progressive scaffolding reduction look like mechanically?** The principle is clear — agent support decreases as practitioner capability grows. The implementation is not yet designed: how does the system detect capability growth? What triggers a scaffolding reduction event?
- **How do we design the oracle layer for each persona gap?** The verification gap analysis identified where human governance must substitute for cryptographic proof. The design of those human governance mechanisms needs detailed work
- **What does the new professional role look like in practice?** We identified the gap and the contributing disciplines. We have not yet designed the curriculum, the credentialing model, or the organizational function it sits within
- **How do the three case studies (grant screening, hospital discharge, water emergency) look when mapped against the nine dimensions?** The framework now has sufficient precision to produce case-specific human work experience designs — this has not yet been done
- **What happens when dimensions trade off against each other?** We know autonomy is a multiplier, but what happens when improving task significance (making impact visible) requires reducing the practitioner's perception of ownership? The interaction effects between dimensions need examination
- **How does the wellbeing measurement aggregate without violating individual privacy?** Individual-level data is sensitive. The governance question of who owns practitioner wellbeing data — and who sees it at what granularity — has not been resolved

***

## Key Points to Build Upon in the Next Session

These are the most load-bearing elements — the ones that future work will depend on:

- **The nine dimensions with their instruments** are ready to be formalized as framework acceptance criteria. The next session could draft the proof template for work experience quality in full, including trigger thresholds and governance responses
- **The verification gap map** (five personas, what blockchain closes, what remains as human governance) provides a structural guide for where the DAO governance design needs to focus. This is particularly ready for the DAO session
- **The professional formation gap** is both an immediate constraint (who does this work now, with what training?) and a longer-term opportunity (what does the curriculum look like, and who builds it?)
- **The productive/unproductive friction classification** needs to be operationalized as a design process — what does the practitioner engagement look like that produces this classification in each of the three case studies?
- **The JD-R model as a design tool** — agents should function as *resources* (amplifying autonomy, feedback clarity, task significance visibility) not as additional *demands* (monitoring burden, alarm fatigue, supervision overhead). This is an actionable design lens that can be applied immediately to any agent specification

***

## Elements to Note, Even If Not Yet Central

These surfaced during the session but were not developed fully. They may prove important:

- **Implementation science** as an underappreciated methodological analog — particularly the EPIS model (Exploration, Preparation, Implementation, Sustainment) and its insistence on tracking sustainability as a primary outcome, not just initial performance. This discipline has practical tools that agent deployment teams are currently reinventing
- **Aviation Crew Resource Management (CRM) and Just Culture** as practised, certified, institutionalized versions of what we've been designing as principles — automation bias training, skill decay prevention, authority gradients in human-agent teams. The aviation industry has 40 years of hard-won knowledge about keeping humans genuinely in control alongside highly capable automated systems
- **Ikigai** as a non-Western frame for the meaning dimension — the intersection of what you love, what you're good at, what the world needs, and what you can be recognized for. This adds cultural breadth to a framework that currently draws primarily from Western organizational psychology
- **Cognitive diversity as a wellbeing concern, not just a safety concern** — the framework identifies homogenization of thought as a systemic risk. The wellbeing research adds a positive design obligation: cognitive diversity actively sustains the engagement and meaning dimensions, because genuinely different perspectives keep work stimulating rather than monotonous
- **The PERMA+4 extension** — physical health, economic security, sleep quality, and environmental conditions as prerequisites for wellbeing that work experience design cannot compensate for. These are structural prerequisites that organizational policy and DAO treasury design, not agent systems, need to address
- **Liquid democracy as a decision-maker legibility mechanism** — the ability to delegate governance votes to trusted domain experts on specific questions, explicitly and revocably. This was identified as a solution to the decision-maker comprehension gap but not yet examined as a design specification
- **The distinction between beneficiary outcomes and organizational metrics** — a system can improve organizational efficiency metrics (discharge rates, application throughput, response times) while degrading beneficiary experience. These are not the same measure, and the framework needs explicit instrumentation to ensure they are tracked separately and the divergence is visible
- **The observation that a dissatisfied job is measurably worse than unemployment** for daily emotional wellbeing — a finding from the wellbeing research that establishes a precise lower bound. Any system that produces sustained work dissatisfaction has caused a quantifiable harm, not merely a missed improvement

***

## The Thread Running Through All of It

If there is one principle that emerged as the organizing idea of the session, it is this: **the distinction between a system that extracts value from human work and a system that makes human work worth doing is not a values statement — it is a design specification with measurable criteria, verifiable requirements, and structural enforcement mechanisms**.

What began as a reframing ended as a framework with instruments, proof templates, governance mechanics, and professional formation requirements. The gap between aspiration and architecture closed significantly today. What remains is the detailed design work — and the three case studies are waiting to be the place that work gets done.

---

# reword this statement to be more straight forward:

"the distinction between a system that extracts value from human work and a system that makes human work worth doing is not a values statement — it is a design specification with measurable criteria, verifiable requirements, and structural enforcement mechanisms."

Here are a few options depending on the register you want:

**Most direct:**
> Making work worth doing is not an aspiration — it is a design requirement that can be specified, measured, and enforced.

**Slightly fuller:**
> Whether a system makes work worth doing is not a values question. It is a design question — one with measurable criteria, verifiable requirements, and structural enforcement mechanisms.

**Sharpest contrast:**
> A system either makes work worth doing or it doesn't. That difference isn't philosophical — it's measurable, verifiable, and built in by design.

The first option is the cleanest single sentence if you need one line. The third lands the contrast most forcefully if the context calls for emphasis on the shift from aspiration to obligation.

---

# What i'm asking for is just a statement of the value in the concept rather than comparing it to something its not

> Making work worth doing is a design requirement — one that can be specified, measured, and enforced.

---

# I don't think is the most impactful takeaway from this discussion.

It might look good on a slide or poster, but its not profound, insightful or very meaningful.

What is so good about something being a design specification? Maybe I'm missing something here so if you can explain it another way please do so. Or perhaps this was the most revelatory for you and that's valid.

For me, the revelation is  that flipping the approach to designing and developing agentic systems opened up unexpected benefits that promise to help humans redefine work and our relationship with technology.

You're right, and that's a much more significant claim.

The reframing didn't just produce a better design methodology — it opened a different relationship between humans and technology altogether. When you stop asking "what can agents do for us" and start asking "how do agents make our work worth doing," you stop treating technology as a replacement for human effort and start treating it as the condition for human flourishing.

That's not a design improvement. That's a different vision of what technology is for.

> Agentic systems, designed around the human experience of work, offer something we haven't had before — technology that doesn't replace what makes work meaningful, but makes more of it possible.

Or even more simply:

> For the first time, we can design technology around what makes work worth doing — and that changes what work can be.

The "design specification" framing was my instinct to anchor the idea in something concrete and defensible. But you're identifying something prior to that — the *reason* it matters that it can be specified and measured is that the underlying vision is genuinely new. The specification is just how you hold it accountable.

What's the context for this statement — is it opening a conversation, closing one, or standing alone?

