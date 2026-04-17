# Agentic System — Infrastructure & Integration Specification Template

*Companion to the HUMAN Framework Agentic System Design Template, System Architecture Template, Agent Specification Template, Data & Schema Specification Template, and Workflow & State Machine Specification Template*
*Complete this document after all five preceding companion documents are settled. Every infrastructure decision made here must enforce a structural requirement from one of those documents — not introduce new logic, but make existing logic physically impossible to violate.*

## How to Use This Template

1. **Infrastructure enforces what policy cannot** — every answer in this document should describe what the system makes structurally impossible, not what it discourages or instructs against. If the answer is "the prompt tells the agent not to," that is a policy answer in an infrastructure document and must be redesigned.
2. **Work through sections in order** — compute and model infrastructure before tool scoping, tool scoping before agent communication, agent communication before observability, observability before resilience.
3. **Every section traces to a principle** — if an infrastructure decision cannot be connected to a named requirement in the Design Document, Architecture Document, or an Agent Specification, question whether it belongs here.
4. **Security is not a section — it is a property of every section** — each section includes security questions because security cannot be bolted on after the fact.
5. **This document is the input to DevOps configuration, cloud architecture, security review, vendor selection, and the integration test suite** — all five derive from decisions made here, nothing else.

***

## Infrastructure Identity Card

*Complete this block before filling out any section.*


| Field | Value |
| :-- | :-- |
| **System Name** |  |
| **Deployment Environment** | *(Cloud / On-premise / Hybrid — provider and region)* |
| **Compliance Constraints** | *(Regulatory, legal, or organisational requirements that bound infrastructure decisions)* |
| **Total Agent Count** | *(From Architecture Document)* |
| **Total Integration Points** | *(External systems, APIs, data sources this system connects to)* |
| **Irreversible Action Classes** | *(Count — each requires structural gating, not policy)* |
| **Data Residency Requirements** |  |
| **Infrastructure Owner** |  |
| **Security Review Owner** |  |
| **Version** |  |
| **Last Reviewed** |  |


***

## Section 1 — Infrastructure Design Principles

*Before defining any component, establish the rules that govern all infrastructure decisions in this system.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **1.1 — Structure Over Policy** | For every constraint that currently exists only as a policy or prompt instruction — what is the plan to make it structural? |  |
|  | How does the team distinguish between a structural constraint and a policy constraint — and who arbitrates when there is disagreement? |  |
|  | What is the review process for ensuring that new capabilities do not introduce policy-only constraints? |  |
|  | How are policy-only constraints tracked — as known technical debt with a resolution plan, not as accepted practice? |  |
| **1.2 — Minimum Sufficient Surface Area** | For every component, integration point, and tool connection — is it genuinely necessary, or has it been added by default? |  |
|  | How does the team enforce minimum sufficient surface area as the system evolves — preventing capability creep? |  |
|  | What is the process for removing a component or integration point that is no longer necessary? |  |
|  | How is the attack surface documented — and reviewed when any component is added, changed, or removed? |  |
| **1.3 — Vendor Independence** | Is the agentic logic separated from the underlying model and vendor layer — so the system can survive a provider change? |  |
|  | What is the migration path if the primary LLM provider changes pricing, terms, or model behaviour? |  |
|  | Are any components currently so tightly coupled to a specific vendor that replacement would require a redesign? |  |
|  | How is vendor lock-in risk assessed when a new integration is proposed? |  |
| **1.4 — Fail Loud, Not Silent** | Is every failure in this system designed to produce a visible signal — never to degrade silently? |  |
|  | What is the difference between a graceful degradation and a silent failure — and how does the system enforce that distinction? |  |
|  | How does the system ensure that a failure in one component does not mask failures in other components? |  |
|  | Who receives failure signals — and is that routing defined before deployment, not discovered when something breaks? |  |


***

## Section 2 — Compute & Model Infrastructure

*The foundation on which every agent operates.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **2.1 — Model Hosting** | Where does each agent's underlying model run — managed API, self-hosted, or hybrid? |  |
|  | What SLA governs model availability — and what is the system's behaviour when that SLA is breached? |  |
|  | How is model version pinned per agent — so a provider update does not silently change agent behaviour? |  |
|  | What is the process for intentionally updating a model version — including re-validation of the affected agent before promotion to production? |  |
| **2.2 — Model Drift Detection** | How is model drift detected — when a provider silently changes the underlying model's behaviour? |  |
|  | What baseline behaviour is captured for each agent at deployment — to enable comparison when drift is suspected? |  |
|  | Who is notified when model drift is detected — and what is the response protocol? |  |
|  | How is a model drift event recorded in the audit trail — as a distinct event type with the detected behavioural delta? |  |
| **2.3 — Compute Isolation** | Are agent compute environments isolated from each other — so a runaway process in one agent cannot consume resources allocated to another? |  |
|  | How are compute quotas defined and enforced per agent — as infrastructure configuration, not runtime instruction? |  |
|  | What happens when an agent exceeds its compute quota — hard stop, graceful degradation, or escalation? |  |
|  | How are code execution sandboxes isolated — so an agent executing code cannot reach the host environment or other agents' data? |  |
| **2.4 — Latency & Timeout Management** | What maximum latency is defined per agent action — and what happens structurally when that threshold is exceeded? |  |
|  | How are timeouts configured — as infrastructure settings, not as values the agent can influence? |  |
|  | What state does a work item move to when an agent times out — and is the timeout event logged as a distinct audit event? |  |
|  | How are retry attempts configured — maximum count, backoff interval, and the state the work item enters if all retries are exhausted? |  |
| **2.5 — Cost & Token Management** | How are token budgets defined and enforced per agent per task — as infrastructure limits, not prompt instructions? |  |
|  | What happens when a token budget is exhausted — does the agent halt, degrade, or escalate? |  |
|  | How are token costs recorded per task — as efficiency metrics in the audit trail? |  |
|  | How are cost anomalies detected — and who is notified when an agent's token usage deviates significantly from its baseline? |  |


***

## Section 3 — Tool Scoping & Capability Enforcement

*Every agent's capability boundary — enforced by infrastructure, not by trust.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **3.1 — Tool Registration** | How are tools registered in the system — as discrete, versioned records, not as free-form capabilities? |  |
|  | What fields define a tool registration — name, version, reversibility class, attack surface assessment, permitted agents? |  |
|  | Who can register a new tool — and is that registration itself an audited event? |  |
|  | How are deprecated or removed tools handled — so agents that previously held them cannot continue to call them? |  |
| **3.2 — Agent-Tool Binding** | How is a tool granted to an agent — as an explicit binding at the infrastructure level, not as a capability listed in a prompt? |  |
|  | What does the granting of a tool binding look like technically — an API scope, a credential, a network permission, or a combination? |  |
|  | How is a tool binding revoked — and is revocation immediate, or is there a propagation delay? |  |
|  | How does the system verify at any point in time which tools each agent currently holds — with a query that cannot be spoofed by the agent? |  |
| **3.3 — Forbidden Capability Enforcement** | For each agent's forbidden tool list: how is the prohibition enforced — a missing credential, a blocked network route, or an absent API scope? |  |
|  | What happens when an agent attempts to call a tool it does not hold — is the attempt blocked, logged, and escalated? |  |
|  | Are boundary violation attempts logged as a distinct event type — with the agent ID, attempted tool, and timestamp? |  |
|  | How is an accidental tool grant detected — before it results in an out-of-bounds action? |  |
| **3.4 — Reversibility Enforcement** | How is each tool's reversibility class enforced at the infrastructure level — not just recorded in documentation? |  |
|  | For irreversible tool calls: how is human presence enforced as a structural gate — so the call cannot execute without an explicit human trigger? |  |
|  | What is the technical mechanism for the human presence gate — a signed token, a session-bound approval, or a two-party key? |  |
|  | How long is a human approval valid — and can an approved irreversible action be queued and executed later without re-approval? |  |
| **3.5 — External Tool Integration** | For each external tool or API: what is the minimum permission scope requested — and is requesting broader scope actively prevented? |  |
|  | How are external API credentials stored — encrypted at rest, rotated on a schedule, and never accessible to the agent directly? |  |
|  | How are external API responses validated before being passed to an agent — to detect malformed, malicious, or poisoned responses? |  |
|  | What happens when an external API is unavailable — hold, queue, fallback, or escalate — and is this behaviour configured per tool? |  |


***

## Section 4 — Agent Communication Infrastructure

*How agents talk to each other — and why that communication cannot be trusted by default.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **4.1 — Message Format & Contract** | What is the standard message format for inter-agent communication — schema, version, required fields? |  |
|  | Does every inter-agent message include not just output but epistemic context — confidence level, assumptions made, alternatives discarded? |  |
|  | How is the message schema versioned — so agents running different versions can still communicate without silent misinterpretation? |  |
|  | What validation is applied to every incoming message before an agent acts on it — schema check, source verification, content validation? |  |
| **4.2 — Agent Identity & Authentication** | How does one agent verify that a message it receives is genuinely from the claimed upstream agent — not an impersonation or injection? |  |
|  | What authentication mechanism governs agent-to-agent communication — signed messages, mutual TLS, or session-bound tokens? |  |
|  | Can an agent forge a message claiming to be from another agent — and how is this structurally prevented? |  |
|  | How are agent identities provisioned and rotated — as infrastructure configuration, not runtime self-assignment? |  |
| **4.3 — Trust Calibration Infrastructure** | How is each agent's track record stored — accuracy score, task count, domain, recent performance — so downstream agents can calibrate trust? |  |
|  | How is a downstream agent's trust weight for an upstream agent calculated — and is that calculation itself auditable? |  |
|  | When a downstream agent disagrees with upstream output — what is the technical mechanism for flagging the disagreement and routing it for resolution? |  |
|  | How are inter-agent trust scores updated — after each verified task, in batch, or on a defined schedule? |  |
| **4.4 — Message Routing & Queuing** | How are messages routed between agents — synchronously, asynchronously, or a combination per message type? |  |
|  | How are message queues managed — with durability guarantees so messages are not lost if an agent is temporarily unavailable? |  |
|  | What is the maximum queue depth before a human is notified that the pipeline is backing up? |  |
|  | How are duplicate messages detected and handled — so a message delivered twice does not cause a workflow to execute twice? |  |
| **4.5 — Prompt Injection Defence** | How does the system distinguish between authoritative instructions and content an agent is processing — at the infrastructure level? |  |
|  | What structural mechanism prevents content retrieved from external sources from overriding an agent's directive? |  |
|  | How are prompt injection attempts in retrieved documents, emails, tool outputs, and other agent messages detected? |  |
|  | How are detected injection attempts logged — as security events with source, content, and target agent? |  |


***

## Section 5 — Orchestration Infrastructure

*How multi-agent workflows are coordinated — state managed, sequenced, and recovered.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **5.1 — Orchestration Framework** | What framework is used to coordinate agent sequencing, state management, retries, and parallel execution? |  |
|  | How does the orchestration layer enforce the workflow state machine — ensuring agents cannot act out of sequence? |  |
|  | Is the orchestration framework itself observable — can every routing decision be logged and replayed? |  |
|  | How is the orchestration framework updated or upgraded — without disrupting in-flight workflow instances? |  |
| **5.2 — Workflow State Persistence** | How is workflow state persisted — so an in-flight workflow survives an infrastructure failure without losing progress? |  |
|  | What is the checkpoint mechanism — at what granularity is state saved, and how is it verified on restore? |  |
|  | How is a workflow resumed after a checkpoint restore — from the last verified state, not from an unverified in-memory snapshot? |  |
|  | What is the maximum acceptable data loss in a recovery scenario — expressed as a recovery point objective? |  |
| **5.3 — Parallel Execution Management** | For workflows with parallel branches: how is state isolation enforced — so parallel branches cannot overwrite each other's state? |  |
|  | How is a parallel branch failure handled — does it halt the entire workflow, or only its branch? |  |
|  | How are parallel branches synchronised when they must converge — and what happens if one branch is significantly slower than the others? |  |
|  | How are resource contention conflicts between parallel branches detected and resolved? |  |
| **5.4 — Pipeline Health Monitoring** | How are pipeline health metrics captured at the orchestration layer — information diversity score, unnecessary path ratio, downstream capability gain? |  |
|  | How is an unhealthy pipeline pattern detected — one where agents are forming ineffective coalitions, reasoning is converging toward homogeneity, or unnecessary paths are proliferating? |  |
|  | Who receives pipeline health alerts — and what authority do they have to intervene in a running pipeline? |  |
|  | How are pipeline health trends tracked over time — not just point-in-time snapshots? |  |
| **5.5 — Coalition Formation** | How does the orchestration layer match agents by epistemic complementarity for a given task — not just by predefined role sequence? |  |
|  | Is coalition formation configuration a governed, versioned record — not an ad-hoc runtime decision? |  |
|  | How is coalition effectiveness measured — and how does that measurement feed back into future coalition formation decisions? |  |
|  | What prevents the orchestration layer from defaulting to the same coalition for every task — ensuring cognitive diversity is structurally maintained? |  |


***

## Section 6 — Storage & Persistence Infrastructure

*Where data lives — and how its integrity is guaranteed.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **6.1 — Storage Architecture** | What storage systems are used — and which system is responsible for which schema type from the Data & Schema Specification? |  |
|  | How is storage isolated per sensitivity tier — so a breach of a lower-sensitivity store does not expose a higher-sensitivity one? |  |
|  | How is data at rest encrypted — with what algorithm, and how are encryption keys managed and rotated? |  |
|  | How is storage availability guaranteed — what is the recovery time objective if the primary storage system fails? |  |
| **6.2 — Immutability Enforcement** | For schemas defined as append-only or immutable in the Data & Schema Specification: how is immutability enforced at the storage layer — not by application logic? |  |
|  | What storage mechanism physically prevents record modification — write-once storage, cryptographic chaining, or database-level constraints? |  |
|  | How is an attempt to modify an immutable record detected, blocked, and logged — including attempts by system administrators? |  |
|  | How is immutability verified on retrieval — so a consumer knows the record has not been tampered with since it was written? |  |
| **6.3 — Proof Document & Hash Storage** | How is the hash generated from an output and its proof document — what algorithm, computed by what component, at what point in the workflow? |  |
|  | Where is the hash stored — and how is it linked to both the output record and the proof document record so neither can be detached? |  |
|  | How is a hash mismatch detected — what triggers the check, and what is the response when a mismatch is found? |  |
|  | How are hash collisions handled — and has the chosen algorithm been assessed against current collision resistance standards? |  |
| **6.4 — Knowledge Base Infrastructure** | How is the knowledge base stored and indexed — to support the query patterns agents use at task initiation? |  |
|  | How are knowledge base entries validated before they are made available for agent retrieval — to prevent poisoned entries from reaching agents? |  |
|  | How are knowledge base retrievals logged — so the use of a specific entry can be traced across all tasks that consumed it? |  |
|  | What is the staleness detection mechanism — how does the system identify knowledge base entries that may no longer be accurate? |  |
| **6.5 — Pattern Library Infrastructure** | How is the pattern library stored — with query support for domain, confidence score, recency, and status? |  |
|  | How are pattern confidence scores updated — as an atomic operation that cannot produce a partial update? |  |
|  | How is a pattern's retirement recorded — as an event, not a deletion, so the pattern's history is preserved? |  |
|  | How does the system prevent a retired pattern from being retrieved by an agent — immediately, not after a propagation delay? |  |
| **6.6 — Backup & Recovery** | What backup schedule applies to each storage system — and is it defined as infrastructure configuration, not operational convention? |  |
|  | How is backup integrity verified — against a stored hash, not just by confirming the backup completed? |  |
|  | How long does recovery take — expressed as a recovery time objective per storage system? |  |
|  | How are recoveries tested — on a defined schedule, not only when a real failure occurs? |  |


***

## Section 7 — Audit & Observability Infrastructure

*The black box — built before deployment, not after the first incident.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **7.1 — Audit Log Infrastructure** | What storage system hosts the audit log — and how is it isolated from application storage so a compromise of one does not affect the other? |  |
|  | How is the audit log append-only enforced at the infrastructure layer — not by application logic? |  |
|  | What is the write latency for audit events — and is there a maximum acceptable delay between an action occurring and its log entry being written? |  |
|  | What happens if the audit log storage system is unavailable — does the action proceed, hold, or abort? |  |
| **7.2 — Log Ingestion Pipeline** | How are audit events written to the log — directly by the tool or infrastructure component, never by the calling agent? |  |
|  | How is the log ingestion pipeline itself monitored — so a failure in the pipeline surfaces immediately rather than silently dropping events? |  |
|  | How are log events ordered — by arrival time, event time, or both — and how are clock skew issues between distributed components handled? |  |
|  | How are duplicate log events detected and handled — without silently discarding a genuine event that looks like a duplicate? |  |
| **7.3 — Access Control on Logs** | What tiers of log access are defined — and what does each tier permit to query? |  |
|  | How are sensitive fields in log entries protected — through field-level encryption or access control on query results, never through omission? |  |
|  | How is access to the audit log itself audited — so every query against the log is itself a log event? |  |
|  | What prevents a system administrator from deleting or modifying audit log entries — and how is this verified? |  |
| **7.4 — Tracing & Replay** | How is distributed tracing implemented — so every action across all agents in a workflow can be correlated by a single trace ID? |  |
|  | Can the audit trail for any work item be fully replayed — reconstructing every action in sequence? |  |
|  | How long does a replay take for a typical workflow instance — and is this acceptable for incident investigation? |  |
|  | How are trace IDs assigned — by the initiating actor, by the orchestration layer, or by the infrastructure? |  |
| **7.5 — Performance & Anomaly Monitoring** | What monitoring is in place for efficiency metrics — token count, latency, step count — per agent per task? |  |
|  | How are baselines established for each metric — and how often are they recalibrated as the system matures? |  |
|  | How are anomalies surfaced — as real-time alerts, periodic reports, or both — and who receives them? |  |
|  | How are monitoring alerts prioritised — so a critical anomaly is not buried in routine notifications? |  |
| **7.6 — Security Event Monitoring** | How are security events — boundary violation attempts, prompt injection detections, abnormal access patterns — distinguished from operational events in the log? |  |
|  | What triggers an automated security response — and what is the response, expressed as infrastructure behaviour not human judgment? |  |
|  | How are security event patterns detected across multiple workflow instances — so a coordinated attack is visible even if individual events look routine? |  |
|  | Who receives security event alerts — and what is the escalation path if the primary recipient is unavailable? |  |


***

## Section 8 — Access Control & Identity Infrastructure

*Who can reach what — enforced at the infrastructure layer.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **8.1 — Identity Provisioning** | How are human actor identities provisioned — and what is the authoritative source of identity? |  |
|  | How are agent identities provisioned — as infrastructure-assigned identities, not self-declared? |  |
|  | How are identities rotated — for both humans and agents — and is rotation automatic or manual? |  |
|  | How is identity deprovisioning handled — when a human leaves or an agent is retired, and how quickly is access revoked? |  |
| **8.2 — Access Control Enforcement** | What access control model is used — role-based, attribute-based, or capability-based — and why is it appropriate for this system? |  |
|  | How are access control rules evaluated — at the infrastructure layer, so an agent cannot bypass them regardless of prompt instructions? |  |
|  | How are access control changes audited — as events with attribution, timestamp, and the prior and new state? |  |
|  | What is the default access level for a newly provisioned actor — and is it the minimum possible? |  |
| **8.3 — Secrets Management** | How are API keys, credentials, and model access tokens stored — in a dedicated secrets manager, never in code, configuration files, or prompts? |  |
|  | How are secrets rotated — on a defined schedule and immediately upon suspected compromise? |  |
|  | How does an agent access a secret it needs — through an injected environment variable, a runtime fetch, or a proxy call — and which approach is used and why? |  |
|  | How is secret access logged — so every use of a credential is a traceable event? |  |
| **8.4 — Network Segmentation** | How are agents isolated at the network layer — so an agent can only reach the endpoints it is authorised to reach? |  |
|  | What network controls enforce the forbidden tool list from each Agent Specification — so an unauthorised endpoint is unreachable, not merely discouraged? |  |
|  | How is network segmentation configuration version-controlled — and reviewed when a new tool or integration is added? |  |
|  | How are network-level anomalies detected — an agent attempting to reach an endpoint outside its defined segment? |  |


***

## Section 9 — Resilience & Degradation Infrastructure

*How the system behaves when components fail — defined before deployment.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **9.1 — Circuit Breakers** | What circuit breaker configuration applies to each external integration — threshold for opening, timeout before half-open, conditions for closing? |  |
|  | When a circuit breaker opens, what does the system do with in-flight work items that were waiting on that integration? |  |
|  | How is a circuit breaker state change logged — as a distinct infrastructure event with timestamp and triggering condition? |  |
|  | How are circuit breaker configurations reviewed — when integration reliability data shows they are too sensitive or too permissive? |  |
| **9.2 — Retry & Backoff Configuration** | What retry policy applies to each agent action type — maximum attempts, backoff algorithm, jitter? |  |
|  | How is a retry distinguished from a duplicate execution in the audit log — so retried actions do not appear as additional completed work? |  |
|  | What state does a work item enter when all retries are exhausted — and who is notified? |  |
|  | Are retry budgets defined — so a single work item cannot consume retry capacity that starves other work items? |  |
| **9.3 — Graceful Degradation Paths** | For each integration: if it is unavailable, does the system degrade gracefully — with reduced capability but continued operation — or halt? |  |
|  | What is the explicit degradation behaviour for each unavailable component — defined per component, not as a general policy? |  |
|  | How is degraded mode communicated to human actors — so they know the system is operating with reduced capability? |  |
|  | How is the system restored from degraded mode — and is restoration itself a logged, verified event? |  |
| **9.4 — Redundancy & Failover** | What components have redundant instances — and how is failover triggered and executed? |  |
|  | How is failover tested — on a defined schedule, including unannounced failover tests to verify actual behaviour? |  |
|  | How long does failover take — expressed as a recovery time objective per component? |  |
|  | How is a failed primary instance recovered — and under what conditions is it restored to service versus permanently replaced? |  |
| **9.5 — Cascading Failure Containment** | How are failure blast radii defined — so a failure in one component cannot propagate beyond its defined boundary? |  |
|  | What bulkhead configurations isolate work items from each other — so a catastrophic failure on one work item does not affect others? |  |
|  | How are cascading failure patterns detected across multiple simultaneous failures — and what triggers a system-level response? |  |
|  | What is the system's behaviour during a cascading failure — defined explicitly, not discovered when it occurs? |  |


***

## Section 10 — Security Infrastructure

*Structural defences — not policy statements.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **10.1 — Input Validation** | How is every input to every agent validated — before it enters the agent's context? |  |
|  | What validation is applied to retrieved document content — before it is passed to an agent as context? |  |
|  | How are inputs from external systems validated — schema, length, encoding, and content pattern checks? |  |
|  | How are validation failures handled — and are they logged as security events distinct from operational errors? |  |
| **10.2 — Content Isolation** | How is agent-processed content — documents, emails, retrieved data — isolated from the agent's instruction layer? |  |
|  | What structural mechanism prevents content from being interpreted as instructions — at the prompt construction level? |  |
|  | How is the boundary between trusted instructions and untrusted content enforced — technically, not by agent judgment? |  |
|  | How are attempts to breach content isolation detected — and what triggers a security alert? |  |
| **10.3 — Dependency & Supply Chain Security** | How are third-party libraries and dependencies managed — with version pinning, vulnerability scanning, and update governance? |  |
|  | How are MCP servers, tool integrations, and skill files validated before deployment — so a compromised dependency does not introduce a backdoor? |  |
|  | What is the process for responding to a newly discovered vulnerability in a dependency — patch timelines, interim mitigations, and communication? |  |
|  | How is the software supply chain itself audited — and who is responsible for supply chain security? |  |
| **10.4 — Penetration Testing & Red Teaming** | What security testing is conducted before deployment — including adversarial prompt testing, boundary violation testing, and injection testing? |  |
|  | How often is penetration testing conducted in production — and is it defined on a schedule, not only after incidents? |  |
|  | What red team exercises are conducted — specifically targeting the agentic system's unique failure modes, not just standard application security? |  |
|  | How are security test findings tracked — and what is the resolution SLA for each severity level? |  |
| **10.5 — Incident Response** | What is the incident response plan for an agentic system security event — defined in advance, not improvised? |  |
|  | What is the first action when a security incident is detected — and is it defined structurally, not left to human judgment in the moment? |  |
|  | How is an agent isolated quickly if it is determined to be behaving in a compromised or misaligned manner — without affecting other agents or in-flight work items? |  |
|  | How are incident response actions themselves logged — so the response is part of the audit trail, not separate from it? |  |


***

## Section 11 — Integration Specifications

*Every external connection — defined, bounded, and governed.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **11.1 — Integration Inventory** | What is the complete list of external systems, APIs, and data sources this system integrates with? |  |
|  | For each integration: what data flows in, what data flows out, and in which direction? |  |
|  | For each integration: which agent holds the connection — and is that the minimum necessary agent? |  |
|  | Are there any integrations where multiple agents share a connection — and if so, how is request attribution maintained? |  |
| **11.2 — Integration Contract** | For each integration: what is the formal contract — API version, schema, authentication method, rate limits, SLA? |  |
|  | How is the contract version pinned — so a provider update does not silently change integration behaviour? |  |
|  | What is the process for updating a pinned integration contract — including impact assessment and re-validation? |  |
|  | How are contract violations detected — when a provider's response deviates from the expected schema or behaviour? |  |
| **11.3 — Data Transformation & Validation** | For each integration: how is inbound data transformed and validated before it enters the system? |  |
|  | How are data quality failures in inbound data handled — invalid schema, unexpected nulls, out-of-range values? |  |
|  | For each integration: how is outbound data validated before it leaves the system — to prevent sending malformed or sensitive data? |  |
|  | How are data transformation rules versioned — so a change to transformation logic is a governed event, not an untracked code change? |  |
| **11.4 — Integration Monitoring** | How is each integration monitored for availability, latency, and error rate? |  |
|  | What thresholds trigger an alert for each integration — and are those thresholds defined per integration, not as a global default? |  |
|  | How are integration health trends tracked over time — so a gradual degradation is detected before it becomes a failure? |  |
|  | How is an integration's impact on overall system performance isolated — so a slow integration is detectable as the source of latency? |  |


***

## Section 12 — Environment Management

*Development, staging, and production — each defined, each isolated.*


| Component | Guiding Questions | Your Responses |
| :-- | :-- | :-- |
| **12.1 — Environment Definitions** | What environments exist — development, staging, production, and any others — and how are they isolated from each other? |  |
|  | What are the rules governing data flows between environments — specifically, can production data enter a lower environment, and if so, under what constraints? |  |
|  | How are environment-specific configurations managed — and what prevents a development configuration from being deployed to production? |  |
|  | How are environment-level access controls defined — so production access requires explicit provisioning, not inheritance from a lower environment? |  |
| **12.2 — Deployment Pipeline** | What is the promotion path from development to production — what gates must be passed at each stage? |  |
|  | How is every deployment itself a versioned, auditable event — with the deploying actor, the artefact version, and the environment recorded? |  |
|  | How is a deployment rolled back — and how quickly can a rollback be executed if a deployment introduces a regression? |  |
|  | How are agent system prompt and configuration changes deployed — with the same rigour as code changes, not as informal updates? |  |
| **12.3 — Configuration Management** | How are all infrastructure configurations version-controlled — in a configuration-as-code repository, not applied manually? |  |
|  | How are configuration changes reviewed and approved — with the same governance as code changes? |  |
|  | How is configuration drift detected — when a deployed configuration diverges from the version-controlled definition? |  |
|  | What is the process for emergency configuration changes — and how is the emergency change itself audited? |  |


***

## Section 13 — Open Decisions Register

*Every unresolved infrastructure decision is a structural risk being knowingly deferred. Record all open decisions before handoff.*


| Decision | Description | Impact if Unresolved | Owner | Target Resolution Date |
| :-- | :-- | :-- | :-- | :-- |
|  |  |  |  |  |
|  |  |  |  |  |
|  |  |  |  |  |


***

## Infrastructure & Integration Readiness Checklist

*Every item must be resolved before this document is handed to the DevOps and security teams.*


| Check | Question | Status |
| :-- | :-- | :-- |
| **Structure Over Policy** | Is every constraint that previously existed only as a policy or prompt instruction now enforced at the infrastructure layer? |  |
| **Tool Scoping** | Is every agent's tool access enforced by missing credentials or blocked routes — not by prompt instructions? |  |
| **Forbidden Capabilities** | Is every forbidden tool physically unreachable for its excluded agent — not merely discouraged? |  |
| **Irreversibility Gates** | Is every irreversible action structurally gated behind human presence — not bypassable under any condition? |  |
| **Immutability** | Is audit log and proof document immutability enforced at the storage layer — not by application logic? |  |
| **Prompt Injection** | Is content isolation enforced at the prompt construction layer — distinguishing instructions from processed content structurally? |  |
| **Model Pinning** | Is each agent's model version pinned — with a defined process for intentional updates and re-validation? |  |
| **Agent Identity** | Are all agent identities infrastructure-assigned — with no self-declaration permitted? |  |
| **Secrets Management** | Are all credentials stored in a dedicated secrets manager — never in code, configuration files, or prompts? |  |
| **Audit Log Isolation** | Is the audit log stored separately from application storage — with its own immutability enforcement? |  |
| **Resilience** | Is every known failure mode designed for — with an explicit system response defined before deployment? |  |
| **Integration Contracts** | Is every external integration contract versioned and pinned — with a governed process for updates? |  |
| **Observability** | Can every action across all agents in any workflow be correlated, replayed, and diagnosed from the audit trail? |  |
| **Open Decisions** | Is every unresolved decision in the Open Decisions Register — with an owner and a resolution date? |  |
| **Master Test** | Can every infrastructure action be attributed, verified, and audited? Does the infrastructure design preserve the human's ability to own, understand, and govern what is built on their behalf? |  |


