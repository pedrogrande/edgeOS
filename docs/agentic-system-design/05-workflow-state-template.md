# Agentic System — Workflow & State Machine Specification Template

*Companion to the HUMAN Framework Agentic System Design Template, System Architecture Template, Agent Specification Template, and Data & Schema Specification Template*
*Complete this document after Agent Specifications and Data & Schema Specifications are settled. Every state, transition, and gate defined here must be traceable to a principle in the Design Document, a structural decision in the Architecture Document, a capability in an Agent Specification, and a schema in the Data & Schema Document.*

## How to Use This Template

1. **Work through sections in order** — the state inventory must be complete before transitions can be defined, and transitions must be complete before gates can be specified.
2. **Name every state** — if a work item's status cannot be described by a named state in this document, the state machine is incomplete. "In progress" is not a state.
3. **Every transition has a gate** — there are no ungated transitions. If nothing must be true for a transition to occur, that is itself a decision that must be documented — and scrutinised.
4. **Distinguish mode from state** — autonomy mode (who acts) and workflow state (what phase the work is in) are different things. Both must be defined, but they are not the same.
5. **This document is the input to the orchestration framework configuration, human interface design, uncertainty routing logic, and integration test suite** — all four derive from decisions made here.

***

## Workflow Identity Card

*Complete this block before filling out any section. One workflow identity card per distinct workflow in the system.*


| Field | Value |
| :-- | :-- |
| **Workflow Name** |  |
| **Work Item Type** | *(What object moves through this workflow — task, article, request, report?)* |
| **Initiating Actor** | *(Human role or agent that creates the work item)* |
| **Terminal State** | *(The state that means work is complete and no further transitions are possible)* |
| **Total Named States** | *(Count — if this cannot be answered, the state inventory is incomplete)* |
| **Total Transitions** | *(Count — if this cannot be answered, the transition map is incomplete)* |
| **Human Touchpoints** | *(Count of mandatory human gates in this workflow)* |
| **Irreversible Transitions** | *(Count — each requires its own human presence gate)* |
| **Linked Agent Specs** |  |
| **Linked Schema Refs** |  |
| **Version** |  |
| **Last Reviewed** |  |


***

## Section 1 — Workflow Scope & Invariants

*Before defining states and transitions, establish the rules that govern the entire workflow.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **1.1 — Workflow Purpose** | What human goal does this workflow serve — not the tasks it performs, but the outcome it enables? |  |
|  | What would a successfully completed workflow look like — in the human's terms, not system metrics? |  |
|  | What would a technically completed workflow look like that nonetheless failed the human's actual need? |  |
|  | Who initiates this workflow — under what conditions, and with what information? |  |
| **1.2 — Invariants** | What must always be true at every point in this workflow — regardless of state? |  |
|  | What must never happen at any point in this workflow — regardless of efficiency pressure? |  |
|  | Which invariants are enforced structurally — and which are currently only policy? |  |
|  | How are invariant violations detected — and what does the system do when one is detected? |  |
| **1.3 — Workflow Boundaries** | What triggers the start of this workflow — and is that trigger itself audited? |  |
|  | What constitutes a completed workflow — and is completion distinct from abandonment or failure? |  |
|  | Can this workflow be abandoned mid-execution — and if so, what state does the work item move to, and what is preserved? |  |
|  | Can two instances of this workflow run in parallel for the same work item — and if not, how is that prevented? |  |
| **1.4 — Ordering Constraints** | Which stages must occur in strict sequence — and which can occur in parallel? |  |
|  | Are there any stages that must never be skipped — even under time or resource pressure? |  |
|  | What prevents out-of-order operations — an agent acting in a stage before its prerequisites are complete? |  |
|  | How does the system detect and handle a workflow that has fallen out of the expected sequence? |  |


***

## Section 2 — State Inventory

*Every state a work item can be in — named, defined, and classified.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **2.1 — State Naming Convention** | What naming convention is used for states — and is it consistent across all workflows in the system? |  |
|  | Are state names unambiguous — can two people independently read a state name and agree on what it means? |  |
|  | Are state names stable — will they remain meaningful as the system evolves? |  |
|  | How are states referenced in the audit log, UI, and API — by name, by ID, or both? |  |
| **2.2 — Active Processing States** | What states represent work actively being performed — by an agent or human? |  |
|  | For each active state: who is the actor, what are they doing, and what does the work item look like while in this state? |  |
|  | Can a work item be in an active state without an actor currently assigned to it — and if so, what triggers actor assignment? |  |
|  | How long can a work item remain in an active state before it is flagged as stalled? |  |
| **2.3 — Pending & Awaiting States** | What states represent a work item waiting for an external input — human approval, verifier response, upstream output? |  |
|  | For each pending state: what is being waited for, who is responsible for providing it, and what is the maximum wait time before escalation? |  |
|  | How is a work item in a pending state distinguishable from one that has been silently dropped? |  |
|  | What happens when the awaited input never arrives — what state does the work item move to? |  |
| **2.4 — Hold & Uncertainty States** | What states represent a work item that has been halted — due to uncertainty, failure, or a missing prerequisite? |  |
|  | For each hold state: what caused the hold, who was notified, and what must happen for the hold to be released? |  |
|  | Is an uncertainty hold state distinct from a failure hold state — and does the system treat them differently? |  |
|  | How long can a work item remain in a hold state before it escalates — and to whom? |  |
| **2.5 — Verification States** | What states represent a work item undergoing independent verification? |  |
|  | For each verification state: who is the verifier, what are they checking against, and what are the possible outcomes? |  |
|  | Is the verification state entered only after the executor has completed — never during? |  |
|  | What state does a work item move to if the verifier is unavailable — and does work proceed without verification? |  |
| **2.6 — Failure & Quarantine States** | What states represent a work item that has failed verification, breached an invariant, or been flagged for human review? |  |
|  | For each failure state: is the work item quarantined — prevented from proceeding until the failure is resolved? |  |
|  | How is a failure state communicated to the relevant human — with what information and on what timescale? |  |
|  | Can a work item recover from a failure state — and if so, what must happen before it can re-enter the active workflow? |  |
| **2.7 — Terminal States** | What are the terminal states — states from which no further transition is possible? |  |
|  | Is there more than one terminal state — completed, abandoned, failed-permanently — and are they structurally distinct? |  |
|  | What is preserved when a work item reaches a terminal state — proof documents, audit trail, contribution records? |  |
|  | Can a terminal state be reversed — and if not, how is re-initiation of a new work item distinguished from recovery of the old one? |  |


***

## Section 3 — Complete State Register

*Document every state in a single reference table. One row per state.*


| State Name | Category | Description | Actor Responsible | Max Duration | Escalation Path | Linked Schema State |
| :-- | :-- | :-- | :-- | :-- | :-- | :-- |
|  | *(Active / Pending / Hold / Verification / Failure / Terminal)* |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |


***

## Section 4 — Transition Inventory

*Every path between states — named, defined, and gated.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **4.1 — Transition Naming Convention** | What naming convention is used for transitions — and is it consistent with the state naming convention? |  |
|  | Does each transition name describe the event that causes the transition — not just the destination state? |  |
|  | How are transitions referenced in the audit log — by name, by ID, or both? |  |
| **4.2 — Transition Triggers** | For each transition: what exactly triggers it — an agent output, a human action, a verifier pass, a timer, or a system event? |  |
|  | Can more than one trigger cause the same transition — and if so, are they all logged distinctly? |  |
|  | Can a transition be triggered automatically — without any human or agent action? If so, what authorises that automation? |  |
|  | What prevents a transition from being triggered by a source that does not have authority to trigger it? |  |
| **4.3 — Transition Gates** | For each transition: what must be true for the transition to be permitted — what are the gate conditions? |  |
|  | Is each gate condition verifiable independently — can the system determine pass or fail without asking the agent or human? |  |
|  | What happens when a gate condition is not met — is the transition blocked, queued, or does it trigger a different path? |  |
|  | Are gate conditions checked at the infrastructure level — so a transition cannot proceed without them, regardless of what an agent or prompt instructs? |  |
| **4.4 — Reversible vs. Irreversible Transitions** | Which transitions are reversible — the work item can be moved back to the prior state? |  |
|  | Which transitions are irreversible — once made, the prior state cannot be recovered? |  |
|  | For every irreversible transition: is there a mandatory human presence gate before it executes? |  |
|  | How is an irreversible transition marked distinctly in the audit log — so it is immediately identifiable? |  |
| **4.5 — Autonomy Mode per Transition** | For each transition: which autonomy mode governs it — Agent-autonomous, Agent-recommended, or Human-led? |  |
|  | Are autonomy mode assignments defined before deployment — recorded as structured configuration, not inferred at runtime? |  |
|  | What conditions can trigger a mode escalation for a specific transition instance — moving it from autonomous to recommended, or recommended to human-led? |  |
|  | How is a mode escalation recorded — as a distinct event with the triggering condition and the escalated mode? |  |


***

## Section 5 — Complete Transition Register

*Document every transition in a single reference table. One row per transition.*


| Transition Name | From State | To State | Trigger | Gate Conditions | Autonomy Mode | Reversible? | Human Required? |
| :-- | :-- | :-- | :-- | :-- | :-- | :-- | :-- |
|  |  |  |  |  | *(Auto / Recommended / Human-led)* | *(Y/N)* | *(Y/N)* |
|  |  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |  |


***

## Section 6 — Human Touchpoint Specifications

*Every point where a human must genuinely decide — not merely approve.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **6.1 — Touchpoint Inventory** | What is the complete list of mandatory human touchpoints in this workflow — where human action is structurally required? |  |
|  | For each touchpoint: what is the human deciding — not approving, but genuinely deciding? |  |
|  | For each touchpoint: what information does the human receive — and is it sufficient for genuine judgment, not rubber-stamp approval? |  |
|  | For each touchpoint: what are the possible human actions — approve, reject, modify, escalate — and what state does each produce? |  |
| **6.2 — Information Sufficiency** | For each human touchpoint: what is the minimum information the human needs to make a genuine decision? |  |
|  | Is that information presented at the touchpoint — or must the human seek it elsewhere? |  |
|  | What information is explicitly excluded from the touchpoint presentation — and why? |  |
|  | How is the information shown to the human at the time of decision recorded — so the decision can be contextualised if later disputed? |  |
| **6.3 — Approval Fatigue Prevention** | What is the minimum reasonable review time for each human touchpoint — below which an approval is likely not genuine? |  |
|  | How does the system detect when approvals are consistently granted faster than this threshold? |  |
|  | What does the system do when approval fatigue is detected — flag, slow down, escalate, or require a secondary review? |  |
|  | Are any touchpoints designed to require an active decision — rather than a passive approval? |  |
| **6.4 — Human Unavailability** | What happens when the required human is unavailable at a touchpoint — does work hold, reroute, or have a time-limited fallback? |  |
|  | Is there a designated alternate human for each touchpoint — and is that designation itself a governed configuration? |  |
|  | How long can a human touchpoint wait before the workflow escalates — and what does escalation look like? |  |
|  | Can any human touchpoint be bypassed under any condition — and if so, under what constraints, with what logging? |  |
| **6.5 — Human Override** | Can a human override the workflow at any point — moving a work item to a state the normal transition map would not permit? |  |
|  | If overrides are permitted: what states can be overridden, by which human roles, and under what conditions? |  |
|  | How is a human override logged — as a distinct event type, with the reason and the overriding human's identity? |  |
|  | How are override patterns reviewed — so systemic use of overrides surfaces as a workflow design problem rather than a repeated exception? |  |


***

## Section 7 — Uncertainty & Escalation Protocols

*What happens when any actor cannot proceed — designed in advance, not improvised in the moment.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **7.1 — Uncertainty Trigger Inventory** | What are all the specific conditions that must cause any actor to halt and surface uncertainty in this workflow? |  |
|  | Are uncertainty conditions defined per actor and per workflow stage — not as a generic catch-all? |  |
|  | How are uncertainty conditions communicated to agents at task initiation — in the context card, not discovered at runtime? |  |
|  | Is surfacing uncertainty treated as correct behaviour in this system — with no penalty to the actor that surfaces it? |  |
| **7.2 — Uncertainty Routing** | For each uncertainty type: where does it route — to which human role or decision-making body? |  |
|  | Is routing defined before deployment — or does the system decide at runtime where to send an uncertainty? |  |
|  | How is an uncertainty routed if the primary routing target is unavailable? |  |
|  | How is the routing decision itself logged — so the uncertainty trail is traceable from trigger to resolution? |  |
| **7.3 — Uncertainty Hold State** | When an actor surfaces uncertainty, what state does the work item move to — and is that state distinct from other hold states? |  |
|  | What information must the actor include in the uncertainty record — triggering condition, why it is unresolvable, relevant context, options considered? |  |
|  | How is the uncertainty hold communicated to the human — with what urgency and what format? |  |
|  | What is the maximum time an uncertainty hold can remain unresolved before it escalates further? |  |
| **7.4 — Resolution Protocol** | What must happen for an uncertainty hold to be released — who resolves it, and what do they produce? |  |
|  | Is the resolution communicated back explicitly to the halted actor — or does the actor resume silently when the hold is released? |  |
|  | What state does the work item move to after a successful resolution — and can it continue from where it stopped, or must it restart? |  |
|  | How is the resolution recorded — and is it linked to the original uncertainty event in the audit trail? |  |
| **7.5 — Recurring Uncertainty Analysis** | How are recurring uncertainties on the same topic detected — across multiple workflow instances? |  |
|  | Who reviews recurring uncertainty patterns — and what authority do they have to change acceptance criteria, context cards, or workflow design in response? |  |
|  | How is a recurring uncertainty pattern distinguished from a one-off edge case — what threshold triggers a design review? |  |
|  | How is the resolution of a recurring uncertainty pattern propagated to all relevant agents and future workflow instances? |  |


***

## Section 8 — Verification Gates

*Independent verification as a structural feature of the workflow — not an optional quality step.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **8.1 — Verification Gate Inventory** | What are all the verification gates in this workflow — points where an independent verifier must pass the work item before it can proceed? |  |
|  | For each verification gate: what is being verified, against what criteria, by which structurally independent verifier? |  |
|  | Is each verification gate defined as a required state transition — so the workflow cannot proceed without it? |  |
|  | Can any verification gate be skipped — under any condition? If yes, what is the constraint and what is the logging requirement? |  |
| **8.2 — Criteria Lock** | For each verification gate: are the acceptance criteria locked before the work being verified begins — not written after the fact? |  |
|  | How is criteria lock enforced — can a verifier evaluate against criteria that were modified after work began? |  |
|  | What happens when a verification is attempted without a complete, locked proof template — does the gate block or proceed? |  |
|  | How are criteria changes after lock recorded — as a version event, with the work item's status adjusted accordingly? |  |
| **8.3 — Verification Outcomes** | What are the possible outcomes of a verification gate — pass, fail, partial pass, or belief revision proposal? |  |
|  | For each outcome: what state does the work item move to? |  |
|  | For a fail outcome: is the work item quarantined — and what must happen before it can re-enter the verification gate? |  |
|  | For a belief revision proposal: how is it routed — and is the executor required to respond before the workflow can proceed? |  |
| **8.4 — Quorum Verification** | Which verification gates use a single verifier — and which require a quorum? |  |
|  | For quorum gates: how many verifiers are required, how are they selected from the pool, and what constitutes consensus? |  |
|  | What happens when quorum verifiers disagree — who resolves the disagreement, and how is the resolution recorded? |  |
|  | How is verifier accuracy tracked over time — and how does poor accuracy affect a verifier's future selection for quorum pools? |  |


***

## Section 9 — Failure & Recovery Paths

*What the workflow does when things go wrong — defined in advance, not discovered in production.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **9.1 — Failure Classification** | What categories of failure can occur in this workflow — verification failure, agent failure, human unavailability, infrastructure failure, invariant breach? |  |
|  | For each failure category: is it recoverable or terminal — and is that classification defined before deployment? |  |
|  | How is a failure distinguished from an uncertainty — and does the workflow treat them differently? |  |
|  | How are failures logged — as distinct event types with structured failure classification? |  |
| **9.2 — Recovery Paths** | For each recoverable failure: what is the defined recovery path — who acts, what state is entered, and what must happen before normal workflow resumes? |  |
|  | Does recovery require restarting the workflow from the beginning — or can it resume from a checkpoint? |  |
|  | If resuming from a checkpoint: how is the checkpoint defined and stored — and is it verified before resumption? |  |
|  | How is a recovery event logged — linked to the original failure event and the checkpoint state? |  |
| **9.3 — Terminal Failure** | What conditions cause a work item to enter a terminal failure state — from which recovery is not possible? |  |
|  | When a work item terminally fails: what is preserved — audit trail, partial proof documents, human decisions made? |  |
|  | Who is notified of a terminal failure — and what information do they receive? |  |
|  | How is a terminal failure distinguished from an abandoned work item — and are they stored differently? |  |
| **9.4 — Cascading Failure Prevention** | If one agent or component fails, what prevents that failure from propagating downstream to other work items or workflow instances? |  |
|  | Are work items isolated from each other — so a failure in one does not affect the state of another? |  |
|  | How does the system detect cascading failure patterns — and what triggers a system-level review rather than a work-item-level recovery? |  |
|  | What is the system's behaviour when multiple components fail simultaneously — and is this scenario explicitly designed for? |  |


***

## Section 10 — Lifecycle Efficiency & Performance

*How the workflow measures and improves its own performance over time.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **10.1 — Lifecycle Metrics** | What metrics measure the performance of this workflow across its full lifecycle — not within individual stages? |  |
|  | What is the target time from workflow initiation to terminal state — and what constitutes an anomaly? |  |
|  | How is rework measured — when a work item returns to an earlier state, what information is recorded about why? |  |
|  | How is the cost of a verification failure compared to the cost of preventing it upstream — and is this tracked as a lifecycle metric? |  |
| **10.2 — Stage-Level Efficiency** | For each workflow stage: what are the expected duration, token cost, and step count — and what constitutes an anomaly at the stage level? |  |
|  | How are stage-level anomalies surfaced — to whom, and on what timescale? |  |
|  | Are any stages currently optimising locally in ways that create downstream inefficiency — and how is this detected? |  |
|  | How is the efficiency of the verification stage measured — relative to the rework it prevents? |  |
| **10.3 — Pattern Learning from Workflow Outcomes** | When a workflow instance completes successfully, what patterns are extracted and contributed to the pattern library? |  |
|  | When a workflow instance fails, what failure patterns are recorded — and how do they inform future workflow design? |  |
|  | How are workflow-level patterns distinguished from agent-level patterns — and are they stored in the same pattern library or separately? |  |
|  | Who reviews workflow-level patterns — and what authority do they have to change workflow design based on accumulated evidence? |  |
| **10.4 — Workflow Retrospective** | How often is this workflow's design reviewed — and what triggers an out-of-cycle review? |  |
|  | What does a workflow retrospective produce — a structured record of findings and changes, not just a meeting? |  |
|  | How are workflow changes versioned — so the evolution of the workflow design is itself an auditable record? |  |
|  | What is the minimum evidence threshold before a workflow change is implemented — and how is that threshold defined? |  |


***

## Section 11 — Workflow Diagram Requirements

*Before handoff to the implementation team, the workflow must be visualised.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **11.1 — State Diagram** | Does the state diagram show every named state from the State Register — with no states implied but not drawn? |  |
|  | Does the diagram show every transition from the Transition Register — with direction and trigger labelled? |  |
|  | Are human touchpoints visually distinct from automated transitions — so the boundary is immediately visible? |  |
|  | Are irreversible transitions marked distinctly — so their significance is immediately clear? |  |
| **11.2 — Happy Path** | Is the happy path — the nominal workflow from initiation to successful completion — clearly identifiable in the diagram? |  |
|  | How many states and transitions does the happy path contain — and is this the minimum necessary? |  |
|  | Are all verification gates visible on the happy path — making it clear that verification is integral, not optional? |  |
| **11.3 — Exception Paths** | Are all uncertainty hold paths shown — where work diverges from the happy path? |  |
|  | Are all failure paths shown — including recovery paths and terminal failure paths? |  |
|  | Are all escalation paths shown — including what happens when a human is unavailable at a touchpoint? |  |
|  | Is there any state in the diagram that has no exit path — and if so, is this intentional? |  |
| **11.4 — Diagram Validation** | Has the diagram been traced against the State Register — confirming every state in the register appears exactly once in the diagram? |  |
|  | Has the diagram been traced against the Transition Register — confirming every transition in the register appears exactly once in the diagram? |  |
|  | Has the diagram been reviewed by someone who did not draw it — to confirm it is independently readable? |  |
|  | Is the diagram version-controlled and linked to this specification document? |  |


***

## Section 12 — Cross-Workflow Dependencies

*This workflow does not exist in isolation — define its relationships to other workflows.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **12.1 — Upstream Dependencies** | Does this workflow depend on outputs from another workflow — and if so, what exactly does it receive and in what state? |  |
|  | What happens if the upstream output arrives late, incomplete, or in an unexpected state? |  |
|  | How is the upstream output validated before this workflow begins — and is that validation a gate on workflow initiation? |  |
| **12.2 — Downstream Dependencies** | Does another workflow depend on outputs from this workflow — and if so, what exactly does it receive and in what state? |  |
|  | How does this workflow notify downstream workflows that output is available and verified — as a structured event, not an informal signal? |  |
|  | What happens downstream if this workflow terminally fails — and is that scenario designed for in the downstream workflow? |  |
| **12.3 — Parallel Workflow Conflicts** | Can multiple instances of this workflow run in parallel — and if so, do they share any resources that could conflict? |  |
|  | How are conflicts between parallel workflow instances detected and resolved — without one silently overwriting the other's state? |  |
|  | Are there any states that can only be occupied by one workflow instance at a time — and how is mutual exclusion enforced? |  |


***

## Workflow & State Machine Readiness Checklist

*Every item must be resolved before this document is handed to the orchestration framework configuration team.*


| Check | Question | Status |
| :-- | :-- | :-- |
| **State Completeness** | Is every state a work item can be in named — with no implied or undocumented states? |  |
| **Transition Completeness** | Is every transition between states defined — with a named trigger, gate conditions, and autonomy mode? |  |
| **No Ungated Transitions** | Does every transition have a gate — even if that gate is explicitly defined as "no condition required"? |  |
| **Irreversibility** | Is every irreversible transition identified — with a mandatory human presence gate enforced structurally? |  |
| **Autonomy Modes** | Is the autonomy mode assigned to every transition — defined before deployment, not at runtime? |  |
| **Human Touchpoints** | Is every mandatory human touchpoint defined — with sufficient information specified for genuine judgment? |  |
| **Uncertainty Protocols** | Is every uncertainty trigger defined per actor and per stage — with named hold states and routing paths? |  |
| **Verification Gates** | Is every verification gate defined — with locked criteria, a named independent verifier, and an outcome-to-state map? |  |
| **Failure Paths** | Is every failure category defined — with a recovery path or terminal classification? |  |
| **No Self-Progression** | Can any work item advance through a verification gate without a structurally independent verifier passing it? |  |
| **Lifecycle Metrics** | Are efficiency metrics defined for the full workflow lifecycle — not just individual stages? |  |
| **Diagram** | Is the state diagram complete, validated against the registers, and version-controlled? |  |
| **Master Test** | Can every transition be attributed, verified, and audited? Does the workflow design leave the human more capable, more aware, and more connected — not just better served? |  |

