# Agentic System Architecture Template
*Version 2.0 — March 2026*
*Companion to the HUMAN Framework Agentic System Design Template*
*Complete the Design Template — including Section 6 (Agent Inventory), Section 7 (Phasing Register), and the Workflow Topology diagram — before beginning this document. Every section here must be traceable to a principle answer in that document.*

---

## How to Use This Template

1. **Work through sections in order** — each section builds on the last. Agent specifications cannot be completed before the system topology is settled; tool inventories cannot be completed before agent specifications are settled.
2. **Trace every answer back to the design document** — if an architectural decision cannot be connected to a principle, question whether it belongs in the system.
3. **Distinguish structure from policy** — where a question asks how something is enforced, the answer must be architectural (infrastructure, schema, configuration) not a policy statement or prompt instruction.
4. **Leave nothing open** — an unanswered question is a future failure mode. Use the response column to record decisions, open questions, and the name of who is responsible for resolving them.
5. **This document is an input to five downstream specs** — Agent Specifications, Data & Schema, Workflow & State Machine, Infrastructure & Integration, and Test & Acceptance all depend on decisions made here.

---

## Section 1 — System Scope & Boundaries

*Before designing what exists inside the system, define exactly where the system ends.*

| Component | Guiding Questions | Your Responses |
|---|---|---|
| **1.1 — System Purpose Statement** | In one sentence, what does this system do — and for whom? | |
| | What human workflow does this system support — and what parts of that workflow are explicitly outside scope? | |
| | What would a correct, complete output from this system look like? | |
| | What would a technically correct but purposively failed output look like? | |
| **1.2 — Human Actors** | Who are all the humans in this system — by role, not by name? | |
| | Which humans are users (interact with the system directly)? | |
| | Which humans are affected parties (impacted by outputs but not direct users)? | |
| | Which humans are reviewers or gatekeepers (receive outputs for approval or publication)? | |
| | Which humans are system stewards (responsible for maintaining and evolving the system)? | |
| **1.3 — System Boundaries** | What is the first action the system takes in a workflow? What triggers it? | |
| | What is the last action the system takes? What does it produce? | |
| | What external systems, services, or data sources does this system connect to? | |
| | What external systems must it never connect to — and how is that enforced structurally? | |
| | What happens at the boundary when an external system is unavailable? | |
| **1.4 — Scope Constraints** | What classes of task are explicitly out of scope for every agent in this system? | |
| | What decisions must never be automated — regardless of confidence or efficiency? | |
| | Are there regulatory, legal, or ethical constraints that bound the system's scope? | |
| | Who has the authority to change the system's scope — and is that change itself auditable? | |

---

## Section 2 — Agent Inventory

*Define every agent that exists in the system before specifying any of them in detail.*

### Pre-Condition: Workflow Topology Confirmation

Before completing Section 2, confirm that the Workflow Topology diagram from the Design Template (Section 6.3) is attached and reviewed. The topology diagram is the map; Section 2 specifies what lives on that map. If the topology reveals any workflow function with no named agent, that gap must be resolved before proceeding.

**[ ] Workflow Topology confirmed and attached**

*If the topology reveals a coordination, orchestration, or synthesis function with no named agent, add that agent to the roster before continuing. Apply the A1 Single-Responsibility test to every agent in the roster before specifying any of them.*

| Component | Guiding Questions | Your Responses |
|---|---|---|
| **2.1 — Agent Roster** | Agent title? | |
| | What is the agent's role archetype — Executor, Reviewer, Orchestrator, Synthesiser, Articulation Agent, or Exploration Agent? | |
| | Does the agent hold more than one archetype? If so, apply the A1 test: could one function be separated into a coherent, independently deployable agent? If in doubt, separate. | |
| | Does every workflow function in the topology have a named agent? Are there any coordination, synthesis, or monitoring functions with no named agent? | |
| **2.2 — Role Archetype Definitions** | For each Executor agent: what does it produce, and what does it never evaluate or verify? | |
| | For each Reviewer agent: what does it verify against, and what does it never produce or modify? | |
| | For each Orchestrator agent: what does it coordinate, and what decisions does it make vs. route? | |
| | For each Synthesiser agent: what inputs does it integrate, and how is its output verified? | |
| | For each Articulation Agent: what implicit or rough input does it clarify, and for whom? | |
| | For each Exploration Agent: when is it deployed, and how is its output prevented from prematurely narrowing the option space? | |
| **2.3 — Cognitive Orientations** | What cognitive orientation does each agent hold — critical, optimistic, creative, factual, procedural, or synthesising? | |
| | Are any two agents in the same workflow stage assigned the same orientation? If so, is that deliberate — or a design gap? | |
| | Which workflow stages require cognitive diversity by design — multiple agents with different orientations before a decision is made? | |
| | How is cognitive diversity preserved as the system scales — and prevented from converging toward homogeneity? | |
| **2.4 — Theory of Mind** | Which agents operate in multi-agent pipelines where they must model what upstream agents believed, assumed, and were uncertain about? | |
| | How does each agent in a pipeline receive upstream epistemic context — not just outputs, but confidence levels, assumptions, and discarded alternatives? | |
| | How does each agent signal its own uncertainty and reasoning to downstream agents? | |
| **2.5 — Coupling Analysis** | For each agent: which agents does it depend on as inputs? | |
| | For each agent: which agents depend on its outputs? | |
| | If this agent fails, what is the propagation path? Which downstream stages are blocked? | |
| | Which agents are structural hubs — depended on by many others — and what are the mitigation plans for their failure? | |

---

## Section 3 — Capability & Tool Inventory

*For every agent, define what is structurally possible — and structurally impossible.*

| Component | Guiding Questions | Your Responses |
|---|---|---|
| **3.1 — Tool Inventory per Agent** | For each agent, what is the complete list of tools it holds? | |
| | For each tool, is it read-only, write, or executable? | |
| | Are tools defined as atomic units of capability — or are they bundled in ways that grant broader access than needed? | |
| | Is every tool in the inventory genuinely necessary — or have any been added by default? | |
| **3.2 — Forbidden Capabilities** | For each agent, what tools and capabilities are structurally impossible for it to hold? | |
| | How is each forbidden capability enforced — at the infrastructure level, or only by policy/prompt? | |
| | Are there any capabilities currently enforced only by policy that should be made structural? What is the plan and timeline to change them? | |
| | What would happen if a forbidden capability were accidentally granted? How would this be detected? | |
| **3.3 — Authority Assignment** | How is authority granted to each agent — and by whom? | |
| | Can authority be escalated at runtime? If yes, under what conditions, and is that escalation itself logged? | |
| | Is authority capability-based (the agent either holds the tool or it doesn't) — or is any authority declared at runtime? | |
| | How do you verify at any point in time that each agent is operating within its declared authority? | |
| **3.4 — Minimum Sufficient Toolset** | For each agent, could it perform its role with fewer tools than currently assigned? | |
| | For every tool assigned, what is the specific task it enables — and what would fail if it were removed? | |
| | How does the system prevent tool scope creep as new capabilities become available? | |

---

## Section 4 — Human-Agent Interaction Design

*Define every touchpoint between humans and the system.*

| Component | Guiding Questions | Your Responses |
|---|---|---|
| **4.1 — Interaction Points** | At which points does the system present output to a human? | |
| | At which points does the system require a human action (approval, selection, trigger) before proceeding? | |
| | At which points does the system surface uncertainty to a human? | |
| | Are there any points where the system acts without human awareness — and is that appropriate? | |
| **4.2 — Approval & Trigger Design** | For every human-gated step, what exactly must the human do — and is a passive confirmation sufficient, or is an active engagement required? | |
| | How does the system prevent rubber-stamping approvals under time pressure? | |
| | What is the minimum review window before an irreversible action can be triggered? | |
| **4.3 — Escalation Paths** | When an agent surfaces uncertainty, exactly how is the escalation delivered to the human? | |
| | What information does the human receive — enough to make a judgment, not just a notification? | |
| | What happens if the human does not respond within the SLA? | |
| **4.4 — Fallback & Manual Override** | For every agent-driven function, what is the manual fallback if the agent is unavailable? | |
| | Is the manual fallback documented and accessible to the human without agent assistance? | |
| | Does any fallback path reduce the trust guarantees of the system — and if so, how is the human informed? | |

---

## Section 5 — Data, State & Proof Architecture

*Define what is stored, where, and how it moves through the system.*

| Component | Guiding Questions | Your Responses |
|---|---|---|
| **5.1 — Data Objects** | What are the primary data objects in this system — by name and type? | |
| | For each object, who creates it, who can read it, who can modify it, and who can delete it? | |
| | Which objects are append-only (audit log, proof documents) — and how is that enforced? | |
| **5.2 — State Machine** | What are the discrete states a workflow instance can be in? | |
| | What events cause state transitions — and who or what triggers each event? | |
| | Are there states that cannot be exited without a specific human action? | |
| | What happens to a workflow instance that has been in a state longer than its SLA? | |
| **5.3 — Proof & Immutability** | How is each proof document linked immutably to the output it certifies? | |
| | What mechanism detects tampering with a proof document? | |
| | Where are proof documents stored — and is that storage independent of the operational system? | |
| **5.4 — Retention & Privacy** | How long is each data object retained — and what is the justification for that period? | |
| | How is sensitive data (source contacts, personal information) protected without selective logging? | |
| | What does data deletion look like — and what cannot be deleted even on user request? | |

---

## Section 6 — Audit, Monitoring & Boundary Enforcement

*Define how you know the system is behaving as designed — continuously, not just at incident time.*

| Component | Guiding Questions | Your Responses |
|---|---|---|
| **6.1 — Audit Log Design** | What fields does every log entry contain as minimum? | |
| | Are human actions logged identically to agent actions? | |
| | Is the log stored separately from the operational system — and who controls that storage? | |
| **6.2 — Boundary Monitoring** | How are tool calls monitored against declared authority in real time? | |
| | What triggers a boundary violation alert — and who receives it? | |
| | Are capability tokens audited at agent initialisation — and is that audit itself logged? | |
| **6.3 — Health & Drift Signals** | What signals indicate that an agent is operating near the edge of its intended scope? | |
| | What signals indicate that the human is becoming more dependent rather than more capable (H2)? | |
| | What signals indicate that cognitive diversity is degrading — agents converging toward homogeneous outputs? | |
| **6.4 — Review Cadence** | What automated reports run on what schedule — and who receives them? | |
| | What human-led reviews run on what schedule — and who conducts them? | |
| | What would trigger an unscheduled design review? | |

---

## Section 7 — Resilience & Failure Design

*Define system behaviour under degraded conditions.*

| Component | Guiding Questions | Your Responses |
|---|---|---|
| **7.1 — Failure Mode Inventory** | For every agent, what are the credible failure modes — not just unavailability, but overconfidence, hallucination, scope creep? | |
| | For every failure mode, what is the designed system response? | |
| | Are any failure modes currently undesigned? Record them in the Phasing Register. | |
| **7.2 — Cascading Failure Design** | If two or more agents fail simultaneously, what is the system's behaviour? | |
| | Which combinations of agent failures are catastrophic (produce false outputs or bypass verification) — and how are those prevented? | |
| | Is there any condition under which a verification step could be skipped due to infrastructure failure? If yes, how is this closed? | |
| **7.3 — Recovery Design** | What does recovery from each failure mode look like — including data integrity checks? | |
| | After a failure, how does the system confirm that trust guarantees are restored before recommencing? | |
| | Are recovery paths tested in the pilot (Q4) — not just normal operation? | |

---

## Section 8 — Phase 1 Scope Confirmation

*This section confirms what is in scope for Phase 1 deployment. It must be consistent with the Phasing Register in the Design Template.*

| Item | In Phase 1 | Notes |
|---|---|---|
| **Agents deployed in Phase 1** | List agents | |
| **Agents deferred to Phase 2+** | List agents | Cross-reference Phasing Register |
| **Capabilities deferred to Phase 2+** | List capabilities | Cross-reference Phasing Register |
| **Failure modes with undesigned responses in Phase 1** | List failure modes | Must include documented mitigation for each |
| **Policy-only constraints in Phase 1** | List constraints | Must include structural conversion plan with timeline |

---

## Document Sign-Off

Before this document proceeds to downstream specification:

| Gate | Confirmed By | Date |
|---|---|---|
| All sections complete — no open questions without a named owner | | |
| Workflow topology pre-condition confirmed (Section 2) | | |
| Every agent in the Design Template Section 6 roster is specified here | | |
| Every Phasing Register item is reflected in Section 8 | | |
| No inline deferrals — all open items are in Section 8 | | |
| System steward has reviewed Section 6 (Audit) and Section 7 (Resilience) | | |

