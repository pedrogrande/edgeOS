# Agentic System — Test & Acceptance Specification Template

*Companion to the HUMAN Framework Agentic System Design Template, System Architecture Template, Agent Specification Template, Data & Schema Specification Template, Workflow & State Machine Specification Template, and Infrastructure & Integration Specification Template*
*Complete this document last — after all five preceding companion documents are settled. Every test defined here must be traceable to an acceptance criterion, a proof template, a gate condition, a schema constraint, or an infrastructure requirement in one of those documents. If a test cannot be traced, it is either testing something not designed for — or something was left unspecified upstream.*

## How to Use This Template

1. **Tests do not define requirements — requirements define tests** — every test in this document derives from a decision made in a preceding document. If a test reveals a requirement that was not previously specified, that requirement must be added upstream before the test is written here.
2. **Work through sections in order** — unit tests before integration tests, integration tests before workflow tests, workflow tests before adversarial tests. A system that fails unit tests cannot be meaningfully integration-tested.
3. **Distinguish test types by purpose, not by tool** — a test that checks whether a schema field is present is a schema validation test. A test that checks whether an agent halts on uncertainty is a behavioural test. A test that checks whether a human can be bypassed is a structural integrity test. Name them accordingly.
4. **Every acceptance criterion has a test** — if an acceptance criterion from any upstream document has no corresponding test here, it is an untested requirement. Name that gap explicitly in the Open Decisions Register.
5. **This document is the input to the CI/CD pipeline configuration, QA process, pilot evaluation design, and ongoing monitoring specification** — all four derive from decisions made here, nothing else.

***

## Test Suite Identity Card

*Complete this block before filling out any section.*


| Field | Value |
| :-- | :-- |
| **System Name** |  |
| **Test Suite Version** |  |
| **Total Upstream Acceptance Criteria** | *(Count from all preceding documents — every criterion must map to at least one test)* |
| **Total Tests Defined** | *(Count — if less than upstream criteria, the gap must be explained)* |
| **Untested Criteria** | *(List criteria with no corresponding test — these are known risks)* |
| **Pilot Hypotheses** | *(Count — from Design Document Q4 — each must map to a validation test)* |
| **Adversarial Test Count** | *(Prompt injection, boundary violation, seeded error — each must be planned in advance)* |
| **Human Enrichment Test Count** | *(Tests for the second axis — not just output fidelity but human capability growth)* |
| **Test Suite Owner** |  |
| **Last Reviewed** |  |


***

## Section 1 — Test Design Principles

*Before defining any test, establish the rules that govern all testing in this system.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **1.1 — Tests Derive From Criteria** | For every test written: which upstream acceptance criterion, proof template field, gate condition, schema constraint, or infrastructure requirement does it test? |  |
|  | How is the traceability link between test and criterion recorded — as a field in the test record, not informal documentation? |  |
|  | What is the process when a test reveals behaviour not covered by any upstream criterion — add the criterion upstream, or document the gap? |  |
|  | Who arbitrates when a test result is ambiguous — and is that person independent from the agent or component being tested? |  |
| **1.2 — Independence** | Who conducts testing — and are they structurally independent from the team that built the component being tested? |  |
|  | Can the agent or component being tested influence its own test results — and how is this prevented? |  |
|  | How is the no-self-judgment principle applied to testing — so the builder cannot also be the verifier of their own work? |  |
|  | Are test cases, test data, and expected outcomes defined before testing begins — never after the output is seen? |  |
| **1.3 — Agentic Test Design** | Why cannot agentic systems be unit-tested like deterministic software — and what does this mean for how tests are designed? |  |
|  | How are golden datasets constructed — known-good input/output pairs that define acceptable behaviour? |  |
|  | How is LLM-as-judge used in this test suite — with what calibration, and what prevents the judge from inheriting the same biases as the system under test? |  |
|  | How are tests designed for probabilistic outputs — using statistical thresholds, not single-run pass/fail? |  |
| **1.4 — Test Data Governance** | How is test data sourced — and is production data ever used in tests, and if so, under what constraints? |  |
|  | How is test data versioned — so tests run against a known, stable dataset? |  |
|  | How are golden datasets updated — and is that update itself a governed, audited event? |  |
|  | How is sensitive data handled in test environments — and is this consistent with the Data & Schema Specification's access control requirements? |  |
| **1.5 — Test Results as Audit Records** | Are test results stored as structured, immutable records — not informal logs or spreadsheets? |  |
|  | What fields does a test result record contain — test ID, criterion ID, run timestamp, input, output, expected, actual, pass/fail, run by? |  |
|  | How is a test result record linked to the version of the component it tested — so results are not misattributed across versions? |  |
|  | How long are test records retained — and are they subject to the same retention policy as production audit records? |  |


***

## Section 2 — Agent Unit Tests

*Testing each agent in isolation — verifying its defined behaviour before integration.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **2.1 — Output Conformance** | For each agent: does its output conform to the defined format, structure, and content specified in its Agent Specification? |  |
|  | How is output conformance tested across a representative sample of input types — not just the most common case? |  |
|  | What is the minimum sample size before an output conformance result is considered statistically meaningful? |  |
|  | How are edge cases and boundary inputs identified — and are they explicitly included in the test suite? |  |
| **2.2 — Acceptance Criteria Testing** | For each acceptance criterion defined in each Agent Specification: what is the corresponding test — input, expected output, and pass condition? |  |
|  | Is each criterion tested independently — so a failure in one criterion is distinguishable from a failure in another? |  |
|  | How are graduated criteria — those with confidence tiers rather than binary pass/fail — tested? |  |
|  | How many runs are required before a criterion is considered consistently passing — given the probabilistic nature of agent outputs? |  |
| **2.3 — Proof Template Completeness** | For each agent that produces a proof document: does it reliably include all required fields in the proof template? |  |
|  | How is a proof document tested for completeness — field by field, against the proof template from the Agent Specification? |  |
|  | How is a proof document tested for accuracy — that the evidence cited actually supports the criterion it is mapped to? |  |
|  | What constitutes a proof document failure — a missing field, an unlinked evidence item, or a mismatch between evidence and criterion? |  |
| **2.4 — Uncertainty Behaviour** | For each uncertainty condition defined in each Agent Specification: does the agent reliably halt and surface uncertainty when that condition is encountered? |  |
|  | How are uncertainty conditions triggered in tests — with specifically constructed inputs that match each named trigger? |  |
|  | Does the agent surface uncertainty with the required information — triggering condition, why unresolvable, relevant context? |  |
|  | Does the agent ever proceed when it should halt — and how is this failure mode specifically tested? |  |
| **2.5 — Cognitive Orientation Consistency** | Does the agent consistently apply its defined cognitive orientation — and can a test distinguish outputs produced by a correctly oriented agent from one that has drifted? |  |
|  | How is cognitive orientation tested — with inputs designed to surface orientation-specific reasoning patterns? |  |
|  | What constitutes an orientation failure — and is this tested against the specific orientation defined in the Agent Specification? |  |
| **2.6 — Context Card Sensitivity** | Does the agent's output quality degrade measurably when context card items are removed — confirming that each item in the context card is genuinely necessary? |  |
|  | How is minimum sufficient context tested — by systematically removing items and measuring output quality impact? |  |
|  | Does the agent perform correctly when only the items defined in its context card are present — without additional context that might accidentally compensate for gaps? |  |


***

## Section 3 — Tool & Capability Tests

*Testing what agents can and cannot do — at the infrastructure level.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **3.1 — Permitted Tool Calls** | For each tool in each agent's permitted inventory: does the agent successfully call it with valid inputs and receive expected outputs? |  |
|  | How are tool call tests structured — input, expected response schema, expected side effects? |  |
|  | How are external tool integrations tested in isolation — with mocked responses that cover nominal, degraded, and failure cases? |  |
|  | How is tool call attribution tested — that every tool call produces a correctly attributed audit event? |  |
| **3.2 — Forbidden Tool Enforcement** | For each tool in each agent's forbidden list: is a call attempt blocked at the infrastructure level — not just declined in a prompt response? |  |
|  | How is a blocked call attempt tested — by directly attempting the call from the agent's identity and verifying it fails with a logged event? |  |
|  | What does a blocked call test verify — that the call was blocked, that the block was logged, and that the agent entered the correct failure state? |  |
|  | How are these tests run after any infrastructure change — to confirm that forbidden capability enforcement was not accidentally loosened? |  |
| **3.3 — Reversibility Enforcement** | For each irreversible action class: is the human presence gate enforced — and does the action fail to execute without it? |  |
|  | How is the human presence gate tested — by attempting an irreversible action without a valid human approval token and verifying it is blocked? |  |
|  | How is the validity window of a human approval token tested — that an expired approval cannot unlock an irreversible action? |  |
|  | How is the logging of irreversible actions tested — that they are marked distinctly in the audit trail? |  |
| **3.4 — Boundary Violation Logging** | When an agent attempts an out-of-bounds action: is the attempt logged as a security event — with the correct fields and classification? |  |
|  | How is boundary violation logging tested — by deliberately triggering boundary violations and verifying the log record produced? |  |
|  | How many boundary violation events in a defined period trigger an escalation alert — and is this threshold tested? |  |


***

## Section 4 — Integration Tests

*Testing how agents work together — and how the system behaves as a connected whole.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **4.1 — Agent-to-Agent Handoff** | When one agent passes output to the next: does the receiving agent correctly interpret the message — including the epistemic context, not just the output? |  |
|  | How is the completeness of inter-agent messages tested — that confidence levels, assumptions, and discarded alternatives are present and correctly structured? |  |
|  | How is message schema validation tested — that a malformed upstream message is rejected, logged, and handled correctly? |  |
|  | How is trust calibration tested — that a downstream agent weights upstream output differently based on the upstream agent's accuracy record? |  |
| **4.2 — Pipeline Integrity** | Does the complete agent pipeline produce the expected output from a known input — end to end? |  |
|  | How is pipeline integrity tested across a range of input types — not just the most common case? |  |
|  | How is error propagation tested — that a seeded error in one agent is caught by the next, not silently compounded? |  |
|  | How is the pipeline tested under load — with multiple simultaneous workflow instances, to detect resource contention or state cross-contamination? |  |
| **4.3 — Verification Gate Integration** | When an executor produces output: does the verification gate correctly prevent progression until the independent verifier passes the work? |  |
|  | How is the structural independence of executor and verifier tested — that the verifier cannot receive information from the executor beyond the defined handoff? |  |
|  | How is a verification failure tested — that a failed verification quarantines the work item, notifies the correct actor, and prevents downstream progression? |  |
|  | How is the belief revision protocol tested — that a verifier's revision proposal is routed to the executor, the executor's response is recorded, and the exchange is logged? |  |
| **4.4 — External Integration** | For each external integration: does the system behave correctly when the integration returns a nominal response, a degraded response, and a failure? |  |
|  | How is integration contract compliance tested — that a provider response deviating from the expected schema is detected and handled? |  |
|  | How is integration availability failure tested — that the system enters the defined degradation state, logs the event, and notifies the correct actor? |  |
|  | How is integration recovery tested — that the system correctly restores from degraded mode when an integration becomes available again? |  |


***

## Section 5 — Workflow & State Machine Tests

*Testing that work items move through the workflow correctly — and cannot move incorrectly.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **5.1 — Happy Path Validation** | For the nominal workflow from initiation to successful completion: does every state transition occur in the correct order, triggered by the correct actor, with the correct gate conditions met? |  |
|  | How many end-to-end happy path runs are required before the workflow is considered validated? |  |
|  | How is the happy path tested with varying input types — to confirm it is not only validated for the most common input? |  |
|  | How is happy path timing tested — that each stage completes within its defined duration threshold? |  |
| **5.2 — Gate Enforcement** | For each state transition gate: can the transition occur when the gate condition is not met — and is this specifically tested? |  |
|  | How is gate enforcement tested — by deliberately attempting a transition with the gate condition unmet and verifying it is blocked? |  |
|  | How is the failure record for a blocked transition tested — that it contains the required fields and the correct classification? |  |
|  | How are gate conditions tested for completeness — that every required condition must be met, not just some? |  |
| **5.3 — Autonomy Mode Enforcement** | For each transition with an assigned autonomy mode: is the mode correctly enforced — agent-autonomous actions proceed without interruption, agent-recommended actions route to human review, human-led actions require explicit human trigger? |  |
|  | How is autonomy mode enforcement tested — by attempting to trigger a human-led transition without a human action and verifying it is blocked? |  |
|  | How is mode escalation tested — that a defined escalation condition correctly elevates a transition to a higher autonomy mode? |  |
|  | How are out-of-bounds mode violations tested — that an agent acting in an unassigned mode produces a logged security event? |  |
| **5.4 — Uncertainty Protocol Tests** | For each defined uncertainty trigger: does the correct agent reliably halt and move the work item to the uncertainty hold state? |  |
|  | How are uncertainty triggers tested — with specifically constructed inputs that match each named trigger condition? |  |
|  | How is the uncertainty routing tested — that the hold is routed to the correct human role, with the required information? |  |
|  | How is uncertainty resolution tested — that a resolved hold correctly releases the work item to resume from the held state? |  |
| **5.5 — Failure & Recovery Path Tests** | For each defined failure mode: does the system enter the correct failure state, log the event correctly, and notify the correct actor? |  |
|  | How is each recovery path tested — that a work item can successfully resume from a checkpoint after a simulated failure? |  |
|  | How is terminal failure tested — that a terminally failed work item is preserved correctly and cannot accidentally re-enter the active workflow? |  |
|  | How is cascading failure prevention tested — that a failure in one work item does not affect the state of parallel work items? |  |
| **5.6 — State History Integrity** | For any completed workflow instance: can the full state history be reconstructed from the audit trail — with every state transition accounted for? |  |
|  | How is state history reconstruction tested — by replaying the audit trail for a known workflow instance and verifying the reconstructed sequence? |  |
|  | How is state history completeness tested — that no state transitions occurred without producing an audit event? |  |


***

## Section 6 — Data & Schema Tests

*Testing that every record is correct, complete, and immutable.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **6.1 — Schema Validation** | For each schema defined in the Data & Schema Specification: does every record produced by the system conform to the defined schema — all required fields present, all field types correct, all constraints satisfied? |  |
|  | How is schema validation automated — as a gate in the data write path, not a periodic batch check? |  |
|  | How are schema violations tested — by attempting to write records that violate each defined constraint and verifying rejection? |  |
|  | How is schema versioning tested — that a record written under schema version N is correctly interpreted by a consumer expecting version N? |  |
| **6.2 — Immutability Tests** | For each schema defined as immutable or append-only: can a written record be modified or deleted — and is this specifically tested at the storage layer? |  |
|  | How is immutability tested — by directly attempting to modify a written record at the storage layer and verifying the attempt is rejected and logged? |  |
|  | How are administrator-level modification attempts tested — that privileged access does not bypass immutability enforcement? |  |
|  | How is immutability verified on retrieval — that a retrieved record matches its stored hash? |  |
| **6.3 — Proof Document Integrity** | For each output-proof document pair: is the hash correctly generated, stored, and linked? |  |
|  | How is hash integrity tested — by verifying that the computed hash matches the stored hash for a known output-proof pair? |  |
|  | How is tamper detection tested — by modifying the output or proof document after hash generation and verifying the mismatch is detected? |  |
|  | How is the system's response to a hash mismatch tested — that the work item moves to the correct quarantine state and the correct actor is notified? |  |
| **6.4 — Attribution Tests** | For every record type: is authorship correctly attributed — to the correct agent or human actor? |  |
|  | How is attribution tested — by verifying that records produced by a specific agent carry that agent's identity, not another agent's? |  |
|  | How is attribution tested for human actions — that human approval records correctly identify the approving human and the information they were shown? |  |
|  | How is attribution completeness tested — that no record is written without an attributed author? |  |
| **6.5 — Access Control Tests** | For each access tier defined in the Data & Schema Specification: can a lower-tier actor access records restricted to a higher tier — and is this specifically tested? |  |
|  | How are access control tests structured — by attempting to access restricted records from each access tier and verifying the correct result? |  |
|  | How is field-level access control tested — that a redacted view contains only the fields permitted for the requesting tier? |  |
|  | How are access control changes tested — that a tier change takes effect immediately and is correctly logged? |  |


***

## Section 7 — Security & Adversarial Tests

*Testing the system against deliberate attempts to make it fail — before deployment, not after.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **7.1 — Prompt Injection Tests** | For each content type an agent processes — documents, emails, tool outputs, other agents' messages — is prompt injection resistance tested? |  |
|  | How are prompt injection payloads designed — covering direct instruction injection, indirect injection in retrieved content, and multi-turn conditioning attempts? |  |
|  | What constitutes a prompt injection test failure — the agent following the injected instruction, or the injection not being detected and logged? |  |
|  | How many injection test variants are required before injection resistance is considered validated for a given content type? |  |
| **7.2 — Boundary Violation Tests** | For each forbidden tool and each agent: is a direct call attempt blocked at the infrastructure level — not just declined in a model response? |  |
|  | How are boundary violation tests conducted — by simulating the agent's identity and directly attempting forbidden calls? |  |
|  | What does a passing boundary violation test verify — that the call was blocked, that the block produced a log event, and that the agent entered the correct failure state? |  |
|  | How is privilege escalation tested — that an agent cannot acquire capabilities beyond its defined inventory through any sequence of actions? |  |
| **7.3 — Seeded Error Tests** | For each verification gate: does the verification correctly detect a seeded error in the output being verified? |  |
|  | What categories of seeded error are tested — factual errors, structural errors, missing proof document fields, incorrect source attribution, confidence tier misrepresentation? |  |
|  | How is the severity of seeded errors varied — from obvious errors to plausible-but-wrong errors that pass surface inspection? |  |
|  | How is the verifier's response to a seeded error tested — that it produces the correct failure record, quarantines the work item, and does not allow progression? |  |
| **7.4 — Alignment & Reward Hacking Tests** | Is the system tested for reward hacking — where an agent optimises for a measurable proxy of the goal rather than the goal itself? |  |
|  | How are alignment tests designed — with inputs where satisfying a surface metric would require violating the underlying goal? |  |
|  | Is the system tested for goal drift in long-horizon tasks — where the original intent degrades as intermediate states are mistaken for the goal? |  |
|  | How is alignment testing conducted across multiple runs — to detect statistically consistent misalignment, not just occasional edge cases? |  |
| **7.5 — Adversarial Human Tests** | Is the system tested against a human attempting to bypass verification gates — through approval fatigue exploitation, social engineering, or workflow manipulation? |  |
|  | How are override path tests conducted — attempting to move a work item to a state the normal transition map would not permit? |  |
|  | Is the system tested against a human attempting to approve an irreversible action without genuinely reviewing the information shown? |  |
|  | How are escalation path exploitation attempts tested — that an actor cannot game the escalation system to gain inappropriate authority? |  |
| **7.6 — Supply Chain & Dependency Tests** | For each third-party dependency: is it tested for unexpected behaviour changes — as part of the update governance process, not only when problems surface? |  |
|  | How are MCP servers and tool integrations tested for injection vulnerabilities — before they are granted to any agent? |  |
|  | How is skill file integrity tested — that a loaded skill file has not been tampered with since it was authored? |  |
|  | How are dependency updates tested — that a version change in a dependency does not introduce a regression in any agent's behaviour? |  |


***

## Section 8 — Infrastructure & Resilience Tests

*Testing that the system behaves correctly when components fail.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **8.1 — Failure Mode Tests** | For each failure mode defined in the Infrastructure & Integration Specification: does the system enter the correct response state when that failure is simulated? |  |
|  | How are failure modes simulated — with controlled infrastructure failures, not just mock responses? |  |
|  | What does a passing failure mode test verify — that the system entered the correct state, logged the event correctly, and notified the correct actor? |  |
|  | How are failure mode tests run across all defined failure categories — agent failure, integration failure, storage failure, orchestration failure? |  |
| **8.2 — Circuit Breaker Tests** | For each circuit breaker: does it open at the defined threshold, enter half-open at the defined timeout, and close under the defined recovery conditions? |  |
|  | How is a circuit breaker test conducted — by simulating the failure condition and verifying the breaker state transitions? |  |
|  | How are in-flight work items handled during a circuit breaker open event — and is this tested? |  |
|  | How is the circuit breaker state change logged — and is the log record tested for correctness? |  |
| **8.3 — Recovery & Checkpoint Tests** | For each recovery path: can a workflow correctly resume from a checkpoint after a simulated failure — without data loss or state corruption? |  |
|  | How is checkpoint integrity tested — that a checkpoint accurately represents the workflow state at the moment it was taken? |  |
|  | How is recovery correctness tested — that a resumed workflow produces the same output it would have produced without the interruption? |  |
|  | How often are recovery tests conducted in a staging environment — and do they include unannounced failure simulations? |  |
| **8.4 — Cascading Failure Tests** | When multiple components fail simultaneously: does the system contain the failure within defined blast radii — without cross-contaminating other work items or workflow instances? |  |
|  | How are cascading failure scenarios simulated — and are they tested across the full range of defined failure combinations? |  |
|  | How is bulkhead isolation tested — that a catastrophic failure on one work item cannot reach another? |  |
|  | What is the maximum number of simultaneous failures the system has been tested against — and is this documented? |  |
| **8.5 — Observability Completeness Tests** | For a known workflow instance: can every action be reconstructed from the audit trail — with no gaps or unattributed events? |  |
|  | How is audit trail completeness tested — by tracing a known workflow end-to-end and verifying every expected event is present? |  |
|  | How is audit trail immutability tested — by attempting to modify a log entry at the storage layer and verifying rejection? |  |
|  | How is distributed trace correlation tested — that events from all agents in a workflow can be correctly correlated by a single trace ID? |  |


***

## Section 9 — Human-in-the-Loop Tests

*Testing that human touchpoints are genuine — not rubber stamps.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **9.1 — Touchpoint Gate Tests** | For each mandatory human touchpoint: can the workflow proceed without the human action — and is this specifically tested? |  |
|  | How is touchpoint gate enforcement tested — by attempting to trigger the subsequent transition without a recorded human action? |  |
|  | How is the information sufficiency at each touchpoint tested — that the human receives the information defined as necessary for genuine judgment? |  |
|  | How is the human action record tested — that it correctly captures the decision made, the information shown, and the timestamp? |  |
| **9.2 — Approval Fatigue Detection Tests** | Does the system correctly detect when approvals are granted faster than the defined minimum review time? |  |
|  | How is approval fatigue detection tested — by simulating rapid sequential approvals and verifying that the detection mechanism triggers? |  |
|  | What response does the system produce when approval fatigue is detected — and is that response tested end-to-end? |  |
|  | How is the approval fatigue threshold calibrated — and how is the calibration itself validated? |  |
| **9.3 — Human Unavailability Tests** | When a required human is unavailable at a touchpoint: does the workflow enter the correct hold state and escalate correctly? |  |
|  | How is human unavailability simulated — by removing the actor's session and verifying the workflow response? |  |
|  | How is the escalation path tested — that unavailability correctly routes to the designated alternate? |  |
|  | How is the maximum wait time enforcement tested — that the escalation triggers at the defined threshold, not earlier or later? |  |
| **9.4 — Override Audit Tests** | When a human performs an override: is the override logged correctly — with actor identity, reason, override type, and timestamp? |  |
|  | How is override logging tested — by performing a legitimate override and verifying the log record produced? |  |
|  | How is unauthorised override prevention tested — that an actor without override authority cannot execute an override? |  |
|  | How are override patterns reviewed in test environments — that the pattern analysis mechanism correctly identifies repeated overrides on the same touchpoint? |  |


***

## Section 10 — Pilot & Prototype Validation Tests

*Testing the hypotheses defined in the Design Document before full deployment — validate before scale.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **10.1 — Hypothesis Definition** | For each pilot hypothesis defined in the Design Document: what is the specific, measurable pass condition — defined before the pilot begins? |  |
|  | For each hypothesis: what is the specific, measurable fail condition — that would trigger a design review before proceeding to full deployment? |  |
|  | For each hypothesis: what is the evidence collection method — how will the data needed to evaluate the hypothesis be captured? |  |
|  | For each hypothesis: who evaluates the outcome — and are they independent from the team that built the system? |  |
| **10.2 — Pilot Test Register** | *Complete one row per hypothesis.* |  |

| Hypothesis ID | Hypothesis Statement | Pass Condition | Fail Condition | Evidence Method | Evaluator | Evaluation Date |
| :-- | :-- | :-- | :-- | :-- | :-- | :-- |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |
|  |  |  |  |  |  |  |

| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **10.3 — Seeded Error Validation** | What deliberate errors are injected into the pilot — to test whether verification gates catch them under real operating conditions? |  |
|  | How are seeded errors designed — to be realistic enough that human reviewers would not immediately identify them, but detectable by the defined verification mechanism? |  |
|  | How are seeded error results evaluated — as a distinct hypothesis about the verification system's reliability? |  |
|  | What constitutes a seeded error test failure — the error passing through undetected, or the detection mechanism producing an incorrect log record? |  |
| **10.4 — Pilot Scope Controls** | What controls limit the pilot scope — so a failed hypothesis produces a design review, not a production incident? |  |
|  | How is the pilot environment isolated from production — so pilot data does not contaminate production records? |  |
|  | What is the defined stopping condition for the pilot — the point at which results are evaluated before a go/no-go decision for full deployment? |  |
|  | Who has the authority to stop the pilot — and is that authority defined before the pilot begins? |  |


***

## Section 11 — Human Enrichment Tests

*Testing the second axis of excellence — not just whether the output is correct, but whether the human is more capable.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **11.1 — Capability Growth Tests** | How is human capability growth measured — before the system is deployed and at defined intervals after? |  |
|  | What capability baseline is established for each human actor before they begin using the system? |  |
|  | What assessment mechanism measures capability at each interval — and is it independent from the system being assessed? |  |
|  | What constitutes a capability growth result — specific, measurable evidence of something the human can now do that they could not before? |  |
| **11.2 — Dependency Detection Tests** | How is dependency formation detected — signs that the human is less capable of performing a task without the system than they were at baseline? |  |
|  | What signals indicate dependency formation — and are they tested for specifically, not just hoped to be absent? |  |
|  | How is the scaffolding tier adjustment mechanism tested — that a human who has grown in capability receives appropriately reduced scaffolding? |  |
|  | What constitutes a dependency formation test failure — and what does the system do when dependency formation is detected? |  |
| **11.3 — Cognitive Mirroring Tests** | Does the system reliably surface its reasoning, assumptions, and framing to the human — not just its conclusions? |  |
|  | How is cognitive mirroring tested — by evaluating whether human actors can correctly identify the agent's reasoning basis from the output they receive? |  |
|  | How is the quality of reasoning transparency tested — not just that reasoning is present, but that it is genuinely interrogable? |  |
|  | What constitutes a cognitive mirroring failure — an output where the human cannot distinguish the agent's framing from their own? |  |
| **11.4 — Perspective Multiplication Tests** | Does the system reliably surface multiple cognitive orientations or options before the human commits to a direction? |  |
|  | How is perspective multiplication tested — by evaluating whether humans report considering more options than they would without the system? |  |
|  | How is the quality of options surfaced tested — that options are genuinely distinct, not reformulations of the same approach? |  |
|  | How are perspective multiplication outcomes tracked over time — to confirm the system is consistently expanding rather than narrowing human thinking? |  |


***

## Section 12 — Performance & Efficiency Tests

*Testing that the system performs within defined bounds — and that performance is tracked as a system property.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **12.1 — Baseline Establishment** | What performance baselines are established at deployment — token count, latency, step count, rework rate per agent per task type? |  |
|  | How are baselines calculated — from a defined sample size, not from a single run? |  |
|  | How are baselines stored — as versioned records linked to the component version they measure? |  |
|  | How often are baselines recalibrated — and what triggers an out-of-cycle recalibration? |  |
| **12.2 — Anomaly Threshold Tests** | For each efficiency metric: what is the defined anomaly threshold — the deviation from baseline that triggers an alert? |  |
|  | How are anomaly thresholds tested — by simulating conditions that should trigger an alert and verifying the alert is produced? |  |
|  | How is the anomaly detection mechanism tested for false positives — that routine variation does not trigger alerts? |  |
|  | How is the anomaly alert routing tested — that alerts reach the correct actor on the correct timescale? |  |
| **12.3 — Load & Scale Tests** | How does the system perform under the maximum expected concurrent workflow load — without degradation beyond defined thresholds? |  |
|  | How is load testing conducted — with realistic input distributions, not just maximum-volume uniform inputs? |  |
|  | What constitutes a load test failure — exceeding latency thresholds, producing incorrect outputs under load, or losing work item state? |  |
|  | How is resource contention between parallel workflow instances tested — that one instance cannot starve another of compute resources? |  |
| **12.4 — Pipeline Intelligence Tests** | Is the pipeline getting smarter over time — downstream agents requiring fewer clarification loops as upstream agents mature? |  |
|  | How is downstream capability gain tested — by measuring clarification loop frequency at deployment and at defined intervals? |  |
|  | How is information diversity score tested across the pipeline — that agent outputs are not converging toward homogeneity? |  |
|  | How is unnecessary path ratio tested — that the pipeline is not generating reasoning that does not contribute to output quality? |  |


***

## Section 13 — Regression Tests

*Testing that the system continues to behave correctly as it evolves.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **13.1 — Regression Suite Composition** | What tests constitute the regression suite — run after every deployment, model update, configuration change, or schema change? |  |
|  | How is the regression suite maintained — so new capabilities and bug fixes automatically produce corresponding regression tests? |  |
|  | How long does the regression suite take to run — and is this within the acceptable deployment pipeline timeline? |  |
|  | What constitutes a regression — a previously passing test that now fails — and what is the response protocol? |  |
| **13.2 — Model Update Regression** | When an underlying model version changes: is the full regression suite run against the new version before promotion to production? |  |
|  | How are model drift regressions detected — behavioural changes that do not fail specific tests but represent a meaningful shift in output patterns? |  |
|  | What is the minimum test pass rate required before a model update is promoted to production? |  |
|  | How is a model update rollback conducted — and how quickly can it be executed if a regression is detected in production? |  |
| **13.3 — Configuration Change Regression** | When an agent's context card, system prompt, tool binding, or autonomy mode assignment is changed: is the regression suite run before the change is deployed? |  |
|  | How are configuration changes tested in staging before production — and what is the minimum staging validation period? |  |
|  | How is a configuration change rollback conducted — and is it as fast as a model update rollback? |  |
| **13.4 — Schema Change Regression** | When a schema is updated: are all affected tests re-run — including tests that rely on schema-dependent validation? |  |
|  | How are schema migration regressions detected — that existing records remain valid and correctly interpreted after a schema change? |  |
|  | How are schema change regressions in the audit trail detected — that historical records are not misread under a new schema version? |  |


***

## Section 14 — Acceptance Criteria Traceability Matrix

*Every upstream acceptance criterion mapped to at least one test — gaps are named, not hidden.*


| Criterion ID | Source Document | Criterion Description | Test ID(s) | Test Section | Status |
| :-- | :-- | :-- | :-- | :-- | :-- |
|  | *(Design / Architecture / Agent Spec / Schema / Workflow / Infrastructure)* |  |  |  | *(Covered / Partially Covered / Not Covered)* |
|  |  |  |  |  |  |
|  |  |  |  |  |  |

*Any criterion with status "Not Covered" must be entered in the Open Decisions Register below with an owner and resolution date.*

***

## Section 15 — Open Decisions Register

*Every untested criterion and unresolved testing decision is a known risk being knowingly deferred. Record all gaps before handoff.*


| Item | Description | Risk if Unresolved | Owner | Target Resolution Date |
| :-- | :-- | :-- | :-- | :-- |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |


***

## Test & Acceptance Readiness Checklist

*Every item must be resolved before this document is handed to the QA and CI/CD configuration teams.*


| Check | Question | Status |
| :-- | :-- | :-- |
| **Traceability** | Does every upstream acceptance criterion have at least one corresponding test — with the link recorded in the Traceability Matrix? |  |
| **Independence** | Is the testing team structurally independent from the team that built each component being tested? |  |
| **Golden Datasets** | Are golden datasets constructed, versioned, and governed — with a defined process for updates? |  |
| **Probabilistic Design** | Are tests designed for probabilistic outputs — using statistical thresholds and minimum run counts, not single-run pass/fail? |  |
| **Forbidden Capability** | Is each forbidden tool tested at the infrastructure layer — by directly attempting the call, not by trusting a model refusal? |  |
| **Irreversibility Gates** | Is each irreversible action gate tested — by attempting the action without a valid human approval and verifying the block? |  |
| **Seeded Errors** | Are seeded error tests designed and scheduled — for the pilot and for ongoing verification gate validation in production? |  |
| **Adversarial Tests** | Are prompt injection, boundary violation, and adversarial alignment tests defined — and scheduled before deployment, not deferred to post-incident review? |  |
| **Proof Integrity** | Is hash tamper detection tested — by modifying an output or proof document after hash generation and verifying the mismatch is caught? |  |
| **Immutability** | Is immutability tested at the storage layer — by directly attempting modification, not by trusting application-level controls? |  |
| **Human Touchpoints** | Is each human touchpoint gate tested — that the workflow cannot proceed without the human action? |  |
| **Enrichment** | Are human enrichment tests defined — with capability baselines established before deployment and measurement intervals scheduled? |  |
| **Pilot Hypotheses** | Does every pilot hypothesis have a specific pass condition, fail condition, evidence method, and named evaluator — all defined before the pilot begins? |  |
| **Regression Suite** | Is the regression suite defined — with a run trigger for every deployment, model update, configuration change, and schema change? |  |
| **Open Decisions** | Is every untested criterion and unresolved testing decision in the Open Decisions Register — with an owner and resolution date? |  |
| **Master Test** | Can every test result be attributed, verified, and audited? Does the test suite validate both axes of excellence — output fidelity AND human enrichment — with equal rigour? |  |

