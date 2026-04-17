# Agentic System Architecture Template

*Companion to the HUMAN Framework Agentic System Design Template*
*Complete the Design Template before beginning this document. Every section here should be traceable to a principle answer in that document.*

## How to Use This Template

1. **Work through sections in order** — each section builds on the last. Agent specifications cannot be completed before the system topology is settled.
2. **Trace every answer back to the design document** — if an architectural decision cannot be connected to a principle, question whether it belongs in the system.
3. **Distinguish structure from policy** — where a question asks how something is enforced, the answer must be architectural (infrastructure, schema, configuration) not a policy statement or prompt instruction.
4. **Leave nothing open** — an unanswered question is a future failure mode. Use the right column to record decisions, open questions, and the name of who is responsible for resolving them.
5. **This document is an input to six downstream specs** — Agent Specifications, Data & Schema, Workflow & State Machine, Infrastructure & Integration, and Test & Acceptance all depend on decisions made here.

***

## Section 1 — System Scope & Boundaries

*Before designing what exists inside the system, define exactly where the system ends.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **1.1 — System Purpose Statement** | In one sentence, what does this system do — and for whom? |  |
|  | What human workflow does this system support — and what parts of that workflow are explicitly outside scope? |  |
|  | What would a correct, complete output from this system look like? |  |
|  | What would a technically correct but purposively failed output look like? |  |
| **1.2 — Human Actors** | Who are all the humans in this system — by role, not by name? |  |
|  | Which humans are users (interact with the system directly)? |  |
|  | Which humans are affected parties (impacted by outputs but not direct users)? |  |
|  | Which humans are reviewers or gatekeepers (receive outputs for approval or publication)? |  |
|  | Which humans are system stewards (responsible for maintaining and evolving the system)? |  |
| **1.3 — System Boundaries** | What is the first action the system takes in a workflow? What triggers it? |  |
|  | What is the last action the system takes? What does it produce? |  |
|  | What external systems, services, or data sources does this system connect to? |  |
|  | What external systems must it never connect to — and how is that enforced structurally? |  |
|  | What happens at the boundary when an external system is unavailable? |  |
| **1.4 — Scope Constraints** | What classes of task are explicitly out of scope for every agent in this system? |  |
|  | What decisions must never be automated — regardless of confidence or efficiency? |  |
|  | Are there regulatory, legal, or ethical constraints that bound the system's scope? |  |
|  | Who has the authority to change the system's scope — and is that change itself auditable? |  |


***

## Section 2 — Agent Inventory

*Define every agent that exists in the system before specifying any of them in detail.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **2.1 — Agent Roster** | Agent title? |  |
|  | What is the agent's role archetype — Executor, Reviewer, Orchestrator, Synthesiser, Articulation Agent, or Exploration Agent? |  |
|  | Does the agent hold more than one archetype? If so, does that create a self-judgment risk (T5)? |  |
|  | Are there tasks in the workflow that currently have no assigned agent — and should they? |  |
| **2.2 — Role Archetype Definitions** | For each Executor agent: what does it produce, and what does it never evaluate or verify? |  |
|  | For each Reviewer agent: what does it verify against, and what does it never produce or modify? |  |
|  | For each Orchestrator agent: what does it coordinate, and what decisions does it make vs. route? |  |
|  | For each Synthesiser agent: what inputs does it integrate, and how is its output verified? |  |
|  | For each Articulation Agent: what implicit or rough input does it clarify, and for whom? |  |
|  | For each Exploration Agent: when is it deployed, and how is its output prevented from prematurely narrowing the option space? |  |
| **2.3 — Cognitive Orientations** | What cognitive orientation does each agent hold — critical, optimistic, creative, factual, procedural, or synthesising? |  |
|  | Are any two agents in the same workflow stage assigned the same orientation? If so, is that deliberate — or a design gap? |  |
|  | Which workflow stages require cognitive diversity by design — multiple agents with different orientations before a decision is made? |  |
|  | How is cognitive diversity preserved as the system scales — and prevented from converging toward homogeneity? |  |
| **2.4 — Theory of Mind** | Which agents operate in multi-agent pipelines where they must model what upstream agents believe, assumed, and are uncertain about? |  |
|  | How does each agent in a pipeline receive upstream epistemic context — not just outputs, but confidence levels, assumptions, and discarded alternatives? |  |
|  | How does each agent signal its own uncertainty and reasoning to downstream agents? |  |


***

## Section 3 — Capability & Tool Inventory

*For every agent, define what is structurally possible — and structurally impossible.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **3.1 — Tool Inventory per Agent** | For each agent, what is the complete list of tools it holds? |  |
|  | For each tool, is it read-only, write, or executable? |  |
|  | Are tools defined as atomic units of capability — or are they bundled in ways that grant broader access than needed? |  |
|  | Is every tool in the inventory genuinely necessary — or have any been added by default? |  |
| **3.2 — Forbidden Capabilities** | For each agent, what tools and capabilities are structurally impossible for it to hold? |  |
|  | How is each forbidden capability enforced — at the infrastructure level, or only by policy/prompt? |  |
|  | Are there any capabilities currently enforced only by policy that should be made structural? What is the plan to change them? |  |
|  | What would happen if a forbidden capability were accidentally granted? How would this be detected? |  |
| **3.3 — Authority Assignment** | How is authority granted to each agent — and by whom? |  |
|  | Can authority be escalated at runtime? If yes, under what conditions, and is that escalation itself logged? |  |
|  | Is authority capability-based (the agent either holds the tool or it doesn't) — or is any authority declared at runtime? |  |
|  | How do you verify at any point in time that each agent is operating within its declared authority? |  |
| **3.4 — Minimum Sufficient Toolset** | For each agent, could it perform its role with fewer tools than currently assigned? |  |
|  | For every tool assigned, what is the specific task it enables — and what would fail if it were removed? |  |
|  | How does the system prevent tool scope creep as new capabilities become available? |  |


***

## Section 4 — Structural Separation (No Self-Judgment)

*Map every executor to its structurally independent verifier.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **4.1 — Executor-Verifier Map** | For every agent that produces an output, who is the structurally separate verifier? |  |
|  | Is the separation between executor and verifier enforced by architecture — or only by convention? |  |
|  | Are there any stages in the workflow where a single agent currently both produces and verifies output? How will this be resolved? |  |
|  | Does the no self-judgment principle apply to human actors as well as agents — and how is it enforced for humans? |  |
| **4.2 — Verifier Independence** | Does the verifier have access to the executor's reasoning chain — or only to its output? |  |
|  | What is the verifier's access scope: proof template and output only, or broader context? |  |
|  | What prevents the verifier from being influenced by the executor's intent, even indirectly? |  |
|  | How is verifier independence maintained under time pressure or resource constraints? |  |
| **4.3 — Verification Failure Paths** | When a verifier rejects an output, what specifically happens — to the output, to the workflow, to the human? |  |
|  | Is a rejected output quarantined — or returned to the executor for silent revision? |  |
|  | What structured failure record does the verifier produce — and how specific must it be? |  |
|  | How many verification failures are permitted before the workflow escalates to human review? |  |
| **4.4 — Verifier Availability** | What happens when a verifier is unavailable? Does work hold, degrade, or reroute? |  |
|  | Is there a fallback verifier — and if so, does the fallback maintain the same structural independence? |  |
|  | How long can verification be queued before a human is notified? |  |


***

## Section 5 — Data Flows & Communication Topology

*Define what passes between agents — not just outputs, but reasoning traces and epistemic context.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **5.1 — System Topology** | Draw the complete topology: which agents communicate with which, and in which direction? |  |
|  | Are there any bidirectional connections — and if so, is there a risk of circular dependency or feedback loops? |  |
|  | Which connections are synchronous (agent waits for response) and which are asynchronous (agent continues and receives response later)? |  |
|  | Are there any connections between agents that should be structurally prevented? How? |  |
| **5.2 — What Passes Between Agents** | For each connection, what exactly is passed — output only, or also reasoning trace, confidence level, assumptions made, alternatives discarded? |  |
|  | How does a downstream agent know how much weight to place on an upstream agent's output? |  |
|  | Are upstream epistemic states — what the agent believed, assumed, and was uncertain about — passed to downstream agents? |  |
|  | What is the format of inter-agent handoffs — structured schema, or free-form text? |  |
| **5.3 — Human Touchpoints** | At which exact points in the workflow does a human receive output, make a decision, or trigger an action? |  |
|  | For each human touchpoint: what information does the human receive — and is it sufficient to make a genuine judgment (not just approve or reject)? |  |
|  | Which human touchpoints are mandatory gates — and which are optional checkpoints? |  |
|  | How does the system prevent approval fatigue — humans approving without genuinely reviewing? |  |
| **5.4 — Inter-Agent Trust Calibration** | How does each agent decide how much to trust output from upstream agents? |  |
|  | Is inter-agent trust tracked over time — so an agent with a poor accuracy record is weighted lower? |  |
|  | What happens when an agent disagrees with upstream output — can it flag this, and where does the flag route? |  |
|  | Is there a structured mechanism for one agent to propose a revision to another agent's output — with justification and an auditable record? |  |


***

## Section 6 — Workflow States & Transitions

*Define every state a work item can be in, and every gate between states.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **6.1 — State Inventory** | What is the complete list of states a work item can be in — from creation to completion? |  |
|  | Are all intermediate states named and defined — or do some transitions happen invisibly? |  |
|  | What states represent holds or failures — and are they distinct from active processing states? |  |
|  | What is the terminal state — and how is it defined so the system knows work is complete? |  |
| **6.2 — Transition Gates** | For each state transition, what must be true for the transition to be permitted? |  |
|  | Which transitions are triggered by agent outputs, which by human actions, and which by verifier passes? |  |
|  | Which transitions are irreversible — and do those require a human explicit trigger? |  |
|  | What prevents a transition from occurring if its gate condition is not met? Is this structural or policy-based? |  |
| **6.3 — Autonomy Mode Mapping** | For each action class in the workflow, which autonomy mode applies: Agent-autonomous, Agent-recommended, or Human-led? |  |
|  | Are autonomy mode assignments defined before deployment — or left to runtime judgment? |  |
|  | What conditions trigger an escalation from a lower to a higher autonomy mode? |  |
|  | How are out-of-bounds actions — an agent acting in a mode it was not assigned — detected, recorded, and escalated? |  |
| **6.4 — Uncertainty & Halt Conditions** | What specific conditions must cause any agent to halt execution and surface uncertainty? |  |
|  | When an agent halts, what state does the work item move to — and who is notified? |  |
|  | How long can a work item remain in an uncertainty-hold state before escalation? |  |
|  | How are recurring uncertainty patterns identified and addressed upstream? |  |


***

## Section 7 — Audit, Logging & Observability

*Define how every action is witnessed — and how the system is diagnosed when something goes wrong.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **7.1 — Audit Log Structure** | What fields does every audit log entry contain — at minimum? |  |
|  | Who or what writes audit entries — the calling agent, or the tool itself? |  |
|  | Are log entries immutable once written — and how is this enforced at the storage layer, not just by policy? |  |
|  | How long are logs retained, and what triggers archival vs. deletion? |  |
| **7.2 — Log Coverage** | Are all agent actions logged — or only a subset? If a subset, what is excluded and why? |  |
|  | Are human actions within the system logged with the same attribution and timestamp as agent actions? |  |
|  | Are failed actions — rejected tool calls, failed verifications, surfaced uncertainties — logged as distinctly as successful ones? |  |
|  | Is privacy protected through access control on the log — not through selective logging? |  |
| **7.3 — Access Control** | Who has access to the full audit log — and under what conditions? |  |
|  | What tiers of log access exist — and what does each tier permit? |  |
|  | How is access to sensitive log fields (e.g., personal contact information) restricted without omitting those events from the log? |  |
|  | What happens when a third party requests access to the log — legally or otherwise? |  |
| **7.4 — Observability & Diagnostics** | Given any disputed output, can the system reconstruct every action that contributed to it? |  |
|  | Can the audit log be replayed — to reproduce what happened step by step? |  |
|  | What performance and efficiency metrics are captured per tool call — token count, latency, energy? |  |
|  | How are anomalies in efficiency metrics detected and surfaced? |  |


***

## Section 8 — Proof & Verification Infrastructure

*Define how outputs become trustworthy — structurally, not declaratively.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **8.1 — Proof Document Architecture** | What proof document accompanies each major output type in this system? |  |
|  | How does each proof document map evidence to criteria — not just assert compliance? |  |
|  | Where are proof documents stored — and are they versioned and linked immutably to the output they certify? |  |
|  | Who can read, write, challenge, and archive each proof document type? |  |
| **8.2 — Verification Criteria** | Are verification criteria defined before work begins — or after? |  |
|  | Who defines the criteria — and is that definition itself auditable? |  |
|  | Can criteria be modified after work begins? If yes, under what conditions, and what happens to in-progress work? |  |
|  | How does a verifier confirm that an output meets criteria — what specific evidence is required? |  |
| **8.3 — Output Integrity** | How is a certified output linked to its proof document in a way that detects any post-certification modification? |  |
|  | What happens when a hash mismatch or integrity failure is detected? |  |
|  | Can an output be submitted or acted upon without a valid, linked proof document? How is this prevented structurally? |  |
|  | How are proof documents and outputs archived together — so future auditors have both? |  |
| **8.4 — Distributable Verification** | Does any verification step currently require a single named verifier — and what is the risk this creates? |  |
|  | Which verification steps could be handled by a qualified pool rather than a single actor? |  |
|  | What qualifies an actor (human or agent) to participate in the verifier pool for each output type? |  |
|  | How is consensus defined when multiple verifiers are used — and what happens when they disagree? |  |


***

## Section 9 — Resilience & Failure Design

*Define how the system behaves when components fail — before it happens in production.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **9.1 — Single Points of Failure** | What are all the single points of failure in this system? |  |
|  | For each: what is the impact if it fails — on the workflow, on trust, on the human? |  |
|  | How is each mitigated structurally — not by hoping it doesn't fail? |  |
|  | Which single points of failure remain unmitigated in this version — and what is the plan to address them? |  |
| **9.2 — Failure Mode Inventory** | What failure modes have been explicitly designed for? |  |
|  | What failure modes are known but not yet designed for — and what is the risk of leaving them unaddressed? |  |
|  | For each designed failure mode: what is the system's response — hold, reroute, escalate, degrade gracefully? |  |
|  | Is "proceed and guess" ever a permitted response to a failure condition? If so, under what constraints? |  |
| **9.3 — Fail-Safe Defaults** | What is the default state when any agent encounters an unknown condition or loses state? |  |
|  | Is the default always "stop and signal" — or are there conditions where proceeding is permitted? |  |
|  | How does the system notify the human when a fail-safe is triggered — and what information do they receive? |  |
|  | How are fail-safe events distinguished in the audit log from normal operation events? |  |
| **9.4 — Reversibility Classification** | For every action class, is it classified as read-only, reversible, or irreversible — before execution? |  |
|  | How is the reversibility classification enforced at the infrastructure level? |  |
|  | Are irreversible actions structurally gated behind human presence — not bypassable under any condition? |  |
|  | How is a new action class classified when it is added to the system? Who makes that classification, and is it audited? |  |


***

## Section 10 — Knowledge & Learning Infrastructure

*Define how the system gets smarter — structurally, not incidentally.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **10.1 — Pattern Library** | Where does the pattern library live — and how do agents query it at task initiation? |  |
|  | What is the minimum structure of a pattern entry — what fields does it contain? |  |
|  | How is a pattern's confidence score calculated — and what is the minimum evidence threshold before a pattern is encoded? |  |
|  | How are outdated or contradicted patterns flagged, demoted, or retired? |  |
| **10.2 — Knowledge Compounding** | How does every completed task contribute to the pattern library — automatically, or manually? |  |
|  | Who validates a new pattern before it influences future agent behaviour? |  |
|  | How are patterns from one domain made available to agents in adjacent domains? |  |
|  | How does the system prevent incorrect patterns from compounding harm as they accumulate confidence? |  |
| **10.3 — Context Architecture** | What information is in each agent's context card at task start — and is it the minimum sufficient? |  |
|  | What information is available in the knowledge base for agents to query on demand — but not loaded by default? |  |
|  | What is each agent explicitly forbidden to read — and how is that enforced? |  |
|  | How is context card quality measured — is excessive or insufficient context detectable from efficiency metrics? |  |
| **10.4 — Retrospective Discipline** | How does the system improve from each completed task — structurally, not through informal post-mortems? |  |
|  | Who is responsible for reviewing retrospective outputs and updating the pattern library? |  |
|  | How often does the system's performance baseline get reviewed — and what triggers an out-of-cycle review? |  |
|  | Is performance improvement tracked as a system metric — or assumed to happen automatically? |  |


***

## Section 11 — Technology Stack Decisions

*These are architectural decisions that must be resolved before any downstream specification document can be written.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **11.1 — Underlying Models** | Which underlying model is selected for each agent — and is this a deliberate design decision, not a default? |  |
|  | What temperature and sampling parameters are set per agent — and why are those values appropriate for that agent's role? |  |
|  | How will model drift be detected if a provider silently updates the underlying model? |  |
|  | Is the agentic logic separated from the underlying model and vendor — to prevent lock-in? |  |
| **11.2 — Orchestration Framework** | What framework coordinates agent sequencing, state management, retries, and parallel execution? |  |
|  | How does the orchestration layer handle agent failures mid-workflow without losing state? |  |
|  | How are pipeline health metrics — information diversity, unnecessary path ratio, downstream capability gain — measured by the orchestration layer? |  |
|  | Is the orchestration framework itself observable — can every routing decision be logged and replayed? |  |
| **11.3 — Storage & Persistence** | What storage mechanism enforces append-only audit logs — and how is immutability guaranteed at the database layer? |  |
|  | How is the proof document stored and version-controlled — and how is the hash-link to the certified output implemented? |  |
|  | How is the pattern library stored — and what query interface do agents use to retrieve patterns by domain and confidence? |  |
|  | What is the backup and recovery strategy — and how is data integrity verified on retrieval from backup? |  |
| **11.4 — Tool Scoping & API Security** | How is each agent's tool access restricted at the infrastructure level — not by prompt instruction? |  |
|  | How are API connections scoped per agent — so a tool an agent doesn't hold is a missing connection, not a denied request? |  |
|  | How is prompt injection — malicious instructions embedded in documents, emails, or tool outputs — defended against structurally? |  |
|  | How is the attack surface of each new tool integration assessed before it is granted to an agent? |  |


***

## Section 12 — Open Decisions Register

*Every architectural question left open is a future failure mode. Record all unresolved decisions here before handing off to downstream document authors.*


| Decision | Description | Owner | Target Resolution Date | Impact if Unresolved |
| :-- | :-- | :-- | :-- | :-- |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |


***

## Architecture Readiness Checklist

*Before this document is handed to downstream specification authors, every item must be resolved.*


| Check | Question | Status |
| :-- | :-- | :-- |
| **Scope** | Is the system boundary defined precisely enough that a developer can determine whether a given feature is in or out of scope? |  |
| **Agent Inventory** | Is every agent in the system named, role-typed, and assigned a cognitive orientation? |  |
| **No Self-Judgment** | Is every executor mapped to a structurally separate verifier? |  |
| **Tool Inventory** | Is every agent's tool inventory complete — including forbidden capabilities? |  |
| **Authority** | Is all authority capability-based and assigned before deployment — with no runtime escalation path? |  |
| **Data Flows** | Is the complete topology documented — including what epistemic context passes between agents? |  |
| **Human Touchpoints** | Is every human decision point named, and is the information given to the human sufficient for genuine judgment? |  |
| **State Machine** | Is every workflow state named, and every transition gate defined — including what happens when the gate fails? |  |
| **Audit Coverage** | Is every action — agent and human — logged, attributed, and immutable? |  |
| **Proof Infrastructure** | Is every major output type accompanied by a proof document — with defined structure, storage, and integrity mechanism? |  |
| **Failure Modes** | Is every known failure mode designed for — with an explicit system response? |  |
| **Technology Stack** | Are all model selection, orchestration, storage, and tool scoping decisions resolved? |  |
| **Open Decisions** | Is every unresolved decision recorded in the Open Decisions Register with an owner and date? |  |


***

The twelve sections map directly onto the six downstream specification documents — agent specs draw from Sections 2, 3, and 4; data and schema specs from Sections 7 and 8; workflow specs from Section 6; infrastructure specs from Sections 9 and 11; and the test specifications from Sections 4, 8, and 9. Section 12 exists specifically to prevent incomplete decisions from being silently inherited by those documents.

