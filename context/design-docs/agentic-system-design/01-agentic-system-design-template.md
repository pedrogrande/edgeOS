# Agentic System Design Template

This template guides designers through the HUMAN Framework for agentic systems — moving from *why* the system exists, through *how trust is built*, to *how humans and agents work together*, to *how growth happens*, to *how quality is ensured*.

## How to Use This Template

1. **Work through the clusters in order** — each cluster builds on the last. Do not jump ahead to agent design before completing Purpose.
2. **Answer the primary question first**, then use the supporting questions to pressure-test and deepen your response.
3. **Use the right-hand column to record your responses.**
4. **Apply the Master Test at every stage** — both questions must be answered "yes" before proceeding.
5. **Revisit and revise** as the system is validated and deployed.

***

## Cluster 1 — Purpose

*Why the framework exists. These principles are the governing intent against which all other decisions are tested.*


| Principle | Your Responses |
| :-- | :-- |
| **H1 — Human Flourishing Is the Measure** | |
| What does genuine human flourishing look like for the people this system serves? |  |
| How will you measure whether the system is serving human dignity and growth — not just task completion? |  |
| What outcomes would indicate the system is causing harm, even if outputs are technically correct? |  |
| Who are the humans in scope — users, operators, affected third parties? |  |
| What does "success" look like for each of them — in their own words, not yours? |  |
| **H2 — Amplification, Not Dependency** | |
| Which capabilities do you want humans to grow through using this system? |  |
| Which features risk creating reliance rather than growth? How will you detect this? |  |
| How will you know, six months in, whether the human is more capable or more dependent? |  |
| What would you deliberately *not* automate in order to preserve human skill development? |  |
| How does the system's design change as the human's capability grows? |  |
| **H3 — Dignity Is the Constraint** | |
| What decisions or actions must remain with the human — regardless of efficiency gains? |  |
| Where could optimisation or automation diminish the human's sense of agency or worth? |  |
| When principles conflict, how is dignity prioritised structurally — not just stated in a policy? |  |
| What would a user feel if they observed every action this system takes on their behalf? |  |
| Are there any populations for whom this system could cause disproportionate harm? |  |
| **H4 — Connection Over Isolation** | |
| How does this system strengthen human-to-human relationships, not replace them? |  |
| Which tasks inherently involve human relationships that agents must not absorb? |  |
| How will you detect if users are substituting agent interactions for human ones? |  |
| What mechanisms actively route humans back to each other rather than to the agent? |  |
| Does the system leave users better connected to people, ideas, and community after each interaction? |  |


***

## Cluster 2 — Trust Architecture

*How the framework earns and maintains trust structurally, not declaratively.*


| Principle | Your Responses |
| :-- | :-- |
| **T1 — Verification Precedes Trust** | |
| What are the pre-defined criteria that every output must be verified against before being treated as complete? |  |
| Who or what performs verification — and are they structurally independent from the executor? |  |
| What happens to an output that fails verification? Is the failure pathway clearly defined? |  |
| Are verification criteria defined *before* the task begins, not after? |  |
| Which outputs carry the highest risk if unverified? Are those verified most rigorously? |  |
| **T2 — Proof Is the Product** | |
| What structured evidence document will accompany each major output? |  |
| How does that document map evidence to criteria — not just assert compliance? |  |
| Who can read, audit, and challenge the proof document? |  |
| What format does the proof document take, and where is it stored? |  |
| How is the proof document linked immutably to the output it certifies? |  |
| **T3 — Authority Is Structural** | |
| What capabilities does each agent actually hold — and what is structurally impossible for it to do? |  |
| How is authority granted — and by whom? Can it be escalated at runtime? |  |
| What prevents an agent from claiming authority it was not granted? |  |
| Are authority boundaries enforced by architecture, or only by policy? |  |
| How do you audit whether agents operated within their structural authority? |  |
| **T4 — All Actions Witnessed** | |
| What logging and audit infrastructure will record every action with attribution and timestamp? |  |
| How is privacy protected — through access control, never through selective logging? |  |
| Who has access to the audit log — and under what conditions? |  |
| How long are logs retained, and are they immutable once written? |  |
| What would the audit log reveal about a disputed action or outcome? |  |
| **T5 — No Self-Judgment** | |
| For every executor role, who is the structurally separate verifier? |  |
| Are there any stages where a single actor currently both executes and verifies? How will you resolve this? |  |
| Does this separation apply to human actors as well as agents? |  |
| How is the verifier's independence maintained under time pressure or resource constraints? |  |
| What happens when the verifier is unavailable? Is there a defined fallback? |  |
| **T6 — Resilience Through Structure** | |
| What are the single points of failure in this system — and how are they mitigated structurally? |  |
| If any one agent fails, errors, or acts in bad faith, what is the impact on systemic trust? |  |
| How does the system continue to produce trustworthy outputs when components degrade? |  |
| What failure modes have you explicitly designed for? Which are still unaddressed? |  |
| How is resilience tested before the system is deployed at scale? |  |
| **T7 — Distributable Verification** | |
| Does verification require a central trusted party — and if so, how is that risk managed? |  |
| How could quorum-based or distributed verification be applied to reduce bottlenecks? |  |
| What qualifies a verifier to participate in the pool? |  |
| How is consensus reached, and what happens when verifiers disagree? |  |
| How does distributable verification apply at the scale you are designing for? |  |


***

## Cluster 3 — Human-Agent Complementarity

*Who does what — and how the boundary is governed, not assumed.*


| Principle | Your Responses |
| :-- | :-- |
| **C1 — Deliberate Role Allocation** | |
| For each workflow stage, which tasks are assigned to agents and which to humans — and why? |  |
| Which tasks require ethical judgment, irreversible decisions, novel situations, or values alignment? |  |
| Where are agents used for consistency, scale, speed, and recall — and is this appropriate? |  |
| Are any human tasks currently being assigned to agents by default rather than by deliberate design? |  |
| How will role allocations be reviewed as the system matures and human capabilities evolve? |  |
| **C2 — Governed Autonomy** | |
| For every action class, which mode applies: Agent-autonomous, Agent-recommended, or Human-led? |  |
| Are these mode assignments made before deployment — not left to runtime judgement? |  |
| What conditions trigger an upgrade from autonomous to recommended, or recommended to human-led? |  |
| How are out-of-bounds actions detected, recorded, and escalated? |  |
| Who has the authority to change mode assignments — and is that change itself auditable? |  |
| **C3 — Uncertainty Surfaces Immediately** | |
| What conditions should cause any actor to halt work and surface uncertainty? |  |
| How does the system route surfaced uncertainty to the appropriate decision-maker? |  |
| Is surfacing uncertainty treated as correct behaviour — or does the system culture penalise it? |  |
| What is the expected response time when uncertainty is surfaced? |  |
| How are unresolved uncertainties logged and reviewed over time? |  |
| **C4 — Structural Ethics** | |
| Which ethical constraints are enforced by architecture — structurally impossible to violate? |  |
| Which constraints are currently only policy-based — and what is the plan to make them structural? |  |
| Under what pressure conditions might declarative ethics fail — and how does structure hold then? |  |
| How do you test that structural constraints hold in adversarial or edge-case conditions? |  |
| Who is responsible for maintaining and updating structural ethical constraints as the system evolves? |  |


***

## Cluster 4 — Growth and Learning

*How humans develop, and how the system improves alongside them.*


| Principle | Your Responses |
| :-- | :-- |
| **G1 — Scaffold, Don't Substitute** | |
| At what point does the system do something *for* the human that the human cannot yet do alone? |  |
| How does the system deliberately withdraw support as the human's capability grows? |  |
| How will you detect that the scaffold is working — and that withdrawal is appropriate? |  |
| What would "making itself less necessary for this task" concretely look like in your system? |  |
| Are there tasks where scaffolding is never appropriate — where human capability must be preserved regardless? |  |
| **G2 — Learning Is Always Happening** | |
| What learning opportunities exist in each workflow stage — even transactional ones? |  |
| How does the system make the learning value of each interaction visible to the human? |  |
| What mechanisms consolidate understanding, surface new frames, or prompt reflection? |  |
| How is growth treated as a by-product of doing — not a separate "training" activity? |  |
| How do you measure whether learning is occurring over time? |  |
| **G3 — Make the Invisible Visible** | |
| What patterns, assumptions, and blind spots can the system surface that the human cannot see alone? |  |
| How does the system show the human their own growth over time? |  |
| How are self-awareness outputs delivered in a way that is empowering rather than surveilling? |  |
| Who owns the insights generated about the human — the platform or the human? |  |
| What would the human's self-awareness look like after six months of using this system? |  |
| **G4 — Contribution Has a Record** | |
| How are the human's decisions, judgments, and contributions captured and attributed to them? |  |
| Is the record portable — does the human own it and can they take it with them? |  |
| How is the record made immutable — protected from platform changes or deletions? |  |
| How does the record build the human's reputation and trust over time? |  |
| What does the human's contribution record look like after one month, six months, one year? |  |
| **G5 — Knowledge Compounds** | |
| What patterns from past outcomes are being crystallised and applied to future performance? |  |
| How does learning become structural — encoded in the system — rather than incidental? |  |
| Who contributes to the knowledge base — agents, humans, or both? |  |
| How is knowledge validated before it is encoded as a pattern? |  |
| How does the system prevent outdated or incorrect patterns from compounding harm? |  |


***

## Cluster 5 — Quality and Performance

*How the framework ensures excellent outcomes, not just trustworthy processes.*


| Principle | Your Responses |
| :-- | :-- |
| **Q1 — Expand, Never Collapse** | |
| How does each interaction increase the human's options, perspectives, and information? |  |
| Where does the system risk narrowing options or presenting pre-digested conclusions? |  |
| How do you test whether outputs are expanding or collapsing the human's thinking? |  |
| What design patterns actively present multiple possibilities rather than a single answer? |  |
| How do you guard against the system's own biases narrowing the option space? |  |
| **Q2 — Progressive Disclosure** | |
| How is complexity layered — delivered at the moment of relevance, in the amount needed now? |  |
| Where does the system currently over-deliver information in ways that overwhelm rather than serve? |  |
| How does the system know what level of detail is right for this human at this moment? |  |
| What mechanisms allow the human to request more depth without it being the default? |  |
| How is progressive disclosure designed differently for novice vs. expert users? |  |
| **Q3 — Cognitive Diversity by Design** | |
| What range of perspectives — human and AI — is brought to complex problems before solution selection? |  |
| How is cognitive diversity structured into the workflow — not left to chance? |  |
| Which problem types require mandatory multi-perspective review before proceeding? |  |
| How do you ensure AI orientations in the system are genuinely diverse — not homogeneous? |  |
| How is dissent or minority perspective captured and considered, not filtered out? |  |
| **Q4 — Validate Before Scale** | |
| What lightweight prototypes or pilots will validate core assumptions before full build? |  |
| What are the specific hypotheses being tested in the validation phase? |  |
| What would a validation failure look like — and what would you do in response? |  |
| How do you prevent pressure to scale prematurely overriding the validation gate? |  |
| What is the minimum evidence needed before proceeding to full execution? |  |
| **Q5 — Problem Precedes Solution** | |
| Has the problem been clearly defined and validated before any agent design begins? |  |
| How do you know the problem statement reflects the actual human need — not an assumed one? |  |
| What would solving the wrong problem perfectly look like in this context? |  |
| Who validated the problem definition — and were the actual humans affected involved? |  |
| How will you revisit the problem definition as the system reveals new information? |  |
| **Q6 — Lifecycle Efficiency** | |
| How is efficiency measured across the full lifecycle — not just within individual stages? |  |
| Where is early cognitive investment being treated as waste, when it actually prevents downstream rework? |  |
| What does the cost of a late-stage failure look like compared to the cost of early validation? |  |
| How does the system measure and report full-lifecycle outcomes — not just stage-level metrics? |  |
| Which stages currently optimise locally in ways that create inefficiency downstream? |  |


***

## The Master Test

*Apply at every design decision, feature review, and agent behaviour evaluation. Both must be yes. Either alone is insufficient.*


| Test | Question | Your Answer |
| :-- | :-- |
| **System Test** | |
| Can this be verified, attributed, and audited? |  |
| **Human Test** | |
| Does this leave the person more capable, more aware, and more connected than before? |  |
| If either answer is no — what must change before proceeding? |  |
