# Agentic System — Data & Schema Specification Template

*Companion to the HUMAN Framework Agentic System Design Template, System Architecture Template, and Agent Specification Template*
*Complete this document after the System Architecture Document and Agent Specifications are settled. Every schema defined here must be traceable to a principle in the Design Document and a structural requirement in the Architecture Document.*

## How to Use This Template

1. **Work through sections in order** — foundational schemas (entities, events) must be defined before derived schemas (proofs, patterns) can be specified.
2. **Define structure before content** — for every schema, define what fields exist and their constraints before deciding what values go in them.
3. **Mutability is a design decision, not a default** — every schema must explicitly state whether records can be updated, appended to, or only created. "It depends" is not an answer.
4. **Access is not the same as privacy** — nothing is omitted from the record to protect privacy. Access tiers control who sees what; the record itself is always complete.
5. **This document is the input to storage configuration, API contracts, audit infrastructure, and test fixtures** — all four derive from decisions made here.

***

## Schema Identity Card

*Complete one row per schema defined in this document. If a schema cannot be named and described in one line, it is not ready to be specified.*

| Schema Name | Type | Mutable? | Owner | Linked Principle |
| :---- | :---- | :---- | :---- | :---- |
|  | *(Entity / Event / Relationship / Knowledge)* | *(Append-only / Immutable / Versioned / Mutable)* |  |  |
|  |  |  |  |  |
|  |  |  |  |  |

***

## Section 1 — Schema Design Principles

*Before defining any individual schema, establish the rules that govern all schemas in this system.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **1.1 — Mutability Hierarchy** | What are the mutability classes used in this system — and what does each permit? |  |
|  | Which schemas are append-only — new records can be added but never modified or deleted? |  |
|  | Which schemas are immutable — once written, the record is permanent and unchangeable at any field? |  |
|  | Which schemas are versioned — a new version creates a new record, and all prior versions are retained? |  |
|  | Are there any schemas that permit in-place mutation — and if so, what justifies this, and how is the change history preserved? |  |
| **1.2 — Structural Trust** | How does the storage layer enforce immutability — not by application logic or policy, but at the database or infrastructure level? |  |
|  | What prevents a system administrator from deleting or modifying a record they should not be able to change? |  |
|  | How is schema integrity verified — can a downstream consumer trust that a record has not been tampered with since it was written? |  |
|  | What cryptographic or structural mechanism links related records so that tampering with one breaks the chain? |  |
| **1.3 — Ownership & Attribution** | For every record type, who is the attributed author — human, agent, or system? |  |
|  | How is authorship captured — as a field in the schema, not as metadata that can be detached? |  |
|  | What happens to attribution when a record is produced by an agent acting on behalf of a human — which is attributed? |  |
|  | How does a human claim ownership of their contribution record — and is that claim portable outside the platform? |  |
| **1.4 — Privacy by Access Control** | Is privacy implemented through access control on complete records — never through selective omission from the record? |  |
|  | What fields contain personally sensitive information — and what access tier governs each? |  |
|  | How is a redacted view of a record generated for a lower-access tier — without modifying the underlying record? |  |
|  | How are access control rules themselves stored and audited — so changes to access are visible? |  |
| **1.5 — Schema Versioning** | How are schema changes managed — so existing records remain valid when the schema evolves? |  |
|  | What is the migration strategy when a field is added, removed, or renamed? |  |
|  | How is the schema version recorded on every record — so a consumer knows which version of the schema produced a given record? |  |
|  | Who approves schema changes — and is that approval itself audited? |  |

***

## Section 2 — Actor Schemas

*Who acts in this system — human and agent.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **2.1 — Human Actor Schema** | What fields identify a human actor — at minimum? |  |
|  | What role assignments does a human actor hold — and are those assignments stored as a relationship, not as a field on the actor record? |  |
|  | What capability connections does a human actor hold — and how is the difference between a human-type and agent-type actor enforced at the schema level? |  |
|  | How is a human actor's contribution record linked to their identity — and can they export it independently of the platform? |  |
| **2.2 — Agent Actor Schema** | What fields identify an agent actor — at minimum? |  |
|  | How is role archetype, cognitive orientation, and autonomy mode stored on the agent record? |  |
|  | How is the agent's tool inventory represented — as a relationship to tool records, not as a list field that can be informally edited? |  |
|  | How is the agent's model version and configuration stored — so drift can be detected when the underlying model changes? |  |
|  | How is the agent's scaffolding tier stored — if the system adjusts its behaviour based on the human's growing capability? |  |
| **2.3 — Role & Capability Connections** | How are capabilities stored — as explicit relationship records between actor and tool, not as fields or policy rules? |  |
|  | What fields does a capability connection record contain — actor ID, tool ID, scope, granted by, granted at, expiry if applicable? |  |
|  | Can a capability connection be modified after creation — or is revocation a new record that supersedes the prior one? |  |
|  | How does the system query whether a given actor holds a given capability — and is that query itself logged? |  |
| **2.4 — Verifier Pool Schema** | How is a verifier pool defined — as a group record with membership connections? |  |
|  | What fields define a pool member's eligibility — credentials, accuracy score, domain, workload? |  |
|  | How is a verifier selected from the pool for a given task — and is the selection logged? |  |
|  | How is a verifier's accuracy record maintained over time — and what threshold triggers removal from the pool? |  |

***

## Section 3 — Task & Work Item Schemas

*What is being worked on — from initiation to completion.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **3.1 — Task Schema** | What fields does every task record contain — at minimum? |  |
|  | How is the task's current state stored — as a field that is updated, or as a sequence of state transition event records? |  |
|  | How is the task's lifecycle phase stored — exploration, specification, execution, verification — so agents know where in the sequence they are operating? |  |
|  | How is the task linked to the human who owns it — and is that link immutable after creation? |  |
|  | How is the task linked to the proof template that governs its output — and is this link required before the task can transition to execution? |  |
| **3.2 — Proof Template Schema** | What fields does a proof template record contain — criteria list, evidence requirements, version, author, creation timestamp? |  |
|  | Is the proof template created before the task begins — and is that ordering enforced structurally? |  |
|  | Can a proof template be modified after a task that references it has begun? If not, how is this prevented? |  |
|  | How is the proof template versioned — so a completed task's proof document is always evaluated against the version of the template in force when work began? |  |
| **3.3 — Proof Document Schema** | What fields does a proof document record contain — criterion ID, evidence item, evidence source, mapping rationale, status, verifier ID, verification timestamp? |  |
|  | How is the proof document linked to the specific output version it certifies — and is this link cryptographic so tampering is detectable? |  |
|  | Is the proof document append-only — so that each verification pass, revision, or challenge produces a new record rather than overwriting the prior one? |  |
|  | What is the schema for an incomplete proof document — one where evidence is missing for one or more criteria — and how does the system treat it differently from a complete one? |  |
| **3.4 — Prototype & Validation Schema** | How is a prototype record distinct from a task record — what fields are different? |  |
|  | What fields record the validation hypotheses — the specific claims being tested before full execution? |  |
|  | What fields record the validation outcome — pass/fail per hypothesis, evidence, and the decision made as a result? |  |
|  | How is the validated prototype linked to the full task that follows it — so the lineage is traceable? |  |

***

## Section 4 — Event & Audit Schemas

*Every action leaves a record — this section defines what that record contains.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **4.1 — Core Audit Event Schema** | What fields does every audit event record contain — at absolute minimum, regardless of event type? |  |
|  | Is the event record written by the tool or infrastructure — not by the calling agent, which could suppress or modify it? |  |
|  | Is the event record immutable once written — and how is this enforced at the storage layer? |  |
|  | How is the event record linked to the prior event in the chain — so the full sequence can be replayed? |  |
| **4.2 — Agent Action Events** | What additional fields does an agent action event contain beyond the core audit fields — tool name, input summary, output summary, token count, latency, energy estimate? |  |
|  | How are failed agent actions recorded — as a distinct event type with failure reason, not omitted? |  |
|  | How are boundary violation attempts recorded — when an agent attempts a tool call outside its declared authority? |  |
|  | How are uncertainty raise events recorded — as first-class events with the uncertainty description, triggering condition, and routing destination? |  |
| **4.3 — Human Action Events** | What fields does a human action event contain — to ensure human actions are attributed and timestamped with the same rigour as agent actions? |  |
|  | How are human approval events recorded — including what information the human was shown at the time of approval? |  |
|  | How are human rejection events recorded — including the reason provided and the resulting workflow state? |  |
|  | How are human override events recorded — when a human acts outside the expected workflow path? |  |
| **4.4 — State Transition Events** | What fields does a state transition event contain — prior state, new state, triggering actor, triggering condition, timestamp? |  |
|  | Are failed state transitions recorded — when a gate condition was not met and the transition was blocked? |  |
|  | How are irreversible state transitions marked distinctly — so they are immediately identifiable in audit queries? |  |
|  | How is the full state history of a work item reconstructed — from the sequence of state transition events? |  |
| **4.5 — Verification Events** | What fields does a verification event contain — verifier ID, task ID, proof document ID, criteria evaluated, pass/fail per criterion, timestamp? |  |
|  | How is a partial verification recorded — when some criteria pass and others fail? |  |
|  | How is a belief revision proposal recorded — when a verifier proposes a specific change to the output rather than a binary pass/fail? |  |
|  | How is the resolution of a belief revision proposal recorded — whether the executor accepts, defers, or contests it? |  |
| **4.6 — Efficiency & Performance Events** | What efficiency fields are recorded on every agent action event — token count, step count, latency, energy estimate? |  |
|  | How are efficiency baselines stored — so anomalies can be detected by comparison? |  |
|  | How are rework events recorded — linking the rework task back to the original task and the root cause classification? |  |
|  | How are pipeline health metrics recorded — information diversity score, unnecessary path ratio — across a multi-agent workflow? |  |

***

## Section 5 — Proof & Verification Infrastructure Schemas

*The proof document is the product — this section defines its data structure in full.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **5.1 — Claim Map Schema** | What is the exact structure of a claim map entry — claim text, source ID, verification status, confidence tier, verifier ID, timestamp? |  |
|  | How is the claim map linked to the specific output version it certifies — field by field, not as a general reference? |  |
|  | What is the schema for a claim map that is incomplete — one where claims exist without mapped sources? |  |
|  | How is a claim map rendered in both machine-readable and human-readable formats — and are both stored? |  |
| **5.2 — Source Manifest Schema** | What fields does a source manifest entry contain — source name, type, URL or reference, author, publication date, access date, credibility tier, conflict-of-interest flag? |  |
|  | How is a source manifest entry linked to the claim map entries that cite it — as a relationship record, not as a text reference? |  |
|  | Can source manifest entries be added after the article is submitted — and if not, how is this enforced? |  |
|  | How is source credibility tier defined and stored — and who has the authority to assign or change a tier? |  |
| **5.3 — Output Integrity Schema** | How is a hash generated from an output and its proof document together — and what algorithm is used? |  |
|  | Where is the hash stored — linked to both the output record and the proof document record? |  |
|  | What schema records a hash mismatch detection event — timestamp, detected by, output ID, proof document ID, hash values compared? |  |
|  | What workflow state does a work item move to when a hash mismatch is detected — and who is notified? |  |
| **5.4 — Verification Criteria Schema** | What fields does a verification criterion record contain — criterion ID, criterion text, evidence type required, pass condition, fail condition, version? |  |
|  | How is a criterion record linked to the proof template that contains it — and is this link immutable? |  |
|  | How are changes to criteria versioned — so historical verification records remain valid against the criteria in force at the time of verification? |  |

***

## Section 6 — Knowledge & Pattern Schemas

*How the system gets smarter — structurally encoded, not informally remembered.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **6.1 — Pattern Schema** | What fields does a pattern record contain — pattern ID, description, domain, pattern type, confidence score, application count, success count, failure count, created at, last applied, status? |  |
|  | How is a pattern's confidence score calculated — what formula, and what is the minimum application count before a confidence score is meaningful? |  |
|  | How is a pattern's status managed — active, under review, deprecated, retired — and what triggers each transition? |  |
|  | How is a pattern linked to the tasks and events that informed it — so its evidence base is traceable? |  |
| **6.2 — Pattern Application Schema** | What fields does a pattern application event contain — pattern ID, task ID, agent ID, applied at, outcome (success/failure/partial)? |  |
|  | How is a pattern application linked to the verification outcome of the task it was applied to — so the system knows whether the pattern contributed to success or failure? |  |
|  | How are pattern applications used to update the pattern's confidence score — automatically, or through a human review step? |  |
|  | How does the system detect when the same pattern is being applied repeatedly to similar tasks without improving — indicating the pattern may be wrong or stale? |  |
| **6.3 — Knowledge Base Entry Schema** | What fields does a knowledge base entry contain — entry ID, type, content, domain, author, created at, last validated, version, status? |  |
|  | How is a knowledge base entry versioned — so agents always know which version of an entry they retrieved? |  |
|  | How is a stale or potentially incorrect knowledge base entry flagged — and what is the schema for a validation record? |  |
|  | How are knowledge base retrievals logged — so the system can detect if a poisoned entry is being used and trace its impact? |  |
| **6.4 — Scaffolding Tier Schema** | What fields record a human actor's current scaffolding tier — actor ID, agent ID, current tier, previous tier, transition date, trigger event, approved by? |  |
|  | How is a tier transition recorded — as a new record, not an update to the existing one? |  |
|  | What evidence record is linked to a tier transition — the capability check-in result or other assessment that justified the change? |  |
|  | How is the scaffolding tier history exported as part of the human's portable contribution record? |  |
| **6.5 — Human Contribution Record Schema** | What fields does a human contribution record entry contain — actor ID, action type, task ID, decision made, reasoning provided, timestamp, context at decision time? |  |
|  | How is the contribution record distinguished from the audit log — same events, different access and ownership model? |  |
|  | What is the export schema for a human's portable contribution record — format, fields, verification mechanism? |  |
|  | How is the contribution record protected from platform deletion or modification — what infrastructure guarantees its permanence? |  |

***

## Section 7 — Workflow & State Schemas

*The lifecycle of every work item — from creation to completion.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **7.1 — Work Item State Schema** | What is the complete list of states a work item can be in — and is each state named as a discrete, unambiguous value? |  |
|  | Is state stored as the current value of a field — or derived from the sequence of state transition events? |  |
|  | What fields accompany a state record — state value, entered at, entered by, reason, prior state? |  |
|  | What states represent active processing, hold, failure, and completion — and are they structurally distinct? |  |
| **7.2 — Uncertainty Hold Schema** | What fields does an uncertainty hold record contain — task ID, raised by, raised at, uncertainty description, triggering condition, context references, routed to, resolved by, resolved at, resolution? |  |
|  | How is an uncertainty hold linked to the state transition event that halted the workflow? |  |
|  | How are recurring uncertainty holds on the same topic aggregated — so upstream patterns can be identified? |  |
|  | How is the resolution of an uncertainty hold recorded — including whether the resolution changed the task's acceptance criteria or scope? |  |
| **7.3 — Autonomy Mode Schema** | How is the autonomy mode assignment stored per action class — not as a prompt instruction, but as a structured record? |  |
|  | What fields does an autonomy mode record contain — action class, assigned mode, assigned by, assigned at, review date, version? |  |
|  | How is an autonomy mode escalation recorded — when a specific action is moved from agent-autonomous to agent-recommended, or from recommended to human-led? |  |
|  | How are out-of-bounds action attempts recorded — when an agent acts in a mode outside its declared assignment? |  |
| **7.4 — Human Approval Schema** | What fields does a human approval record contain — approver ID, task ID, action approved, information shown at time of approval, decision, reasoning, timestamp? |  |
|  | Is the information shown to the human at the time of approval stored as part of the approval record — so the decision can be contextualised if later disputed? |  |
|  | How are approval records linked to the state transition they enabled — so every state change requiring human approval has an approval record as a prerequisite? |  |
|  | How is approval fatigue detected — when approvals are consistently granted faster than the minimum reasonable review time? |  |

***

## Section 8 — Access Control & Privacy Schemas

*Who can see what — defined structurally, not by convention.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **8.1 — Access Tier Definitions** | What access tiers exist in this system — and what does each tier permit? |  |
|  | How are access tiers stored — as records linked to actor records, not as fields on the records being accessed? |  |
|  | Can access tiers be changed — and if so, is the change itself logged with attribution and timestamp? |  |
|  | What is the lowest-privilege tier — and is it the default for any new actor until explicitly elevated? |  |
| **8.2 — Field-Level Access Schema** | For schemas containing sensitive fields, how is field-level access control defined — as a separate schema, not embedded in the data schema? |  |
|  | What fields in each schema are restricted — and to which access tiers? |  |
|  | How is a redacted view of a record generated for a lower-access tier — from the complete record, not from a separately stored redacted version? |  |
|  | How are field-level access rules versioned — so changes to access rules do not retroactively alter the audit history? |  |
| **8.3 — Third-Party Access Schema** | What schema records a third-party access request — requestor, basis for request, records requested, decision, decision made by, timestamp? |  |
|  | How is the actor whose records are being accessed notified — and is that notification itself recorded? |  |
|  | What fields define the scope of a third-party access grant — duration, records covered, permitted use? |  |
|  | How is third-party access revoked — and what happens to copies of data made during the access period? |  |
| **8.4 — Portability & Export Schema** | What is the export schema for a human actor's full portable record — all their contribution records, scaffolding history, and owned data? |  |
|  | How is the exported record verified as authentic — what mechanism confirms it has not been tampered with since export? |  |
|  | What is the deletion schema — when a human actor requests data deletion, what is deleted, what is retained for legal or audit purposes, and how is the deletion itself recorded? |  |
|  | How is the export schema versioned — so a record exported today can still be interpreted in three years? |  |

***

## Section 9 — Integrity, Retention & Lifecycle

*How long records live — and what happens when they end.*

| Component | Guiding Questions | Your Responses |
| :---- | :---- | :---- |
| **9.1 — Retention Policy Schema** | What retention periods apply to each schema — and are those periods defined as schema metadata, not as operational convention? |  |
|  | What triggers archival — time elapsed, task completion, regulatory requirement, or human request? |  |
|  | What is the difference between archived and deleted — and which record types can never be deleted? |  |
|  | How is the retention policy itself versioned — so changes to retention rules are auditable and do not retroactively alter prior records? |  |
| **9.2 — Archival Schema** | What fields does an archival event record contain — record ID, schema type, archival timestamp, archived by, retrieval key, integrity hash? |  |
|  | How is integrity verified when a record is retrieved from archival storage — and what happens if verification fails? |  |
|  | Is the archival process itself logged in the audit trail — as an event attributed to a system actor? |  |
|  | How are archived records made available to legal or regulatory processes — without restoring them to the active system? |  |
| **9.3 — Schema Evolution & Migration** | What is the process for changing a schema — review, approval, versioning, migration, validation? |  |
|  | How are existing records migrated when a schema changes — and is the migration itself recorded as an event? |  |
|  | How is a schema change validated — ensuring that no records were corrupted or lost during migration? |  |
|  | Who approves schema changes — and is that approval recorded with attribution and timestamp? |  |
| **9.4 — Backup & Recovery Schema** | What fields does a backup record contain — backup ID, scope, timestamp, storage location, integrity hash? |  |
|  | How often are backups taken — and is the backup frequency defined as a schema configuration, not an operational convention? |  |
|  | How is a recovery event recorded — what was recovered, from which backup, by whom, and why? |  |
|  | How is the integrity of a restored record verified — against the original integrity hash before restoration? |  |

***

## Section 10 — Schema Dependency Map

*Before handing this document to the implementation team, map every schema to the schemas it depends on.*

| Schema Name | Depends On | Required Before | Principle Enforced |
| :---- | :---- | :---- | :---- |
|  |  |  |  |
|  |  |  |  |
|  |  |  |  |

***

## Data & Schema Readiness Checklist

*Every item must be resolved before this document is handed to the implementation team.*

| Check | Question | Status |
| :---- | :---- | :---- |
| **Mutability** | Is every schema assigned a mutability class — and is that class enforced at the storage layer? |  |
| **Attribution** | Is authorship captured as a field on every record — not detachable metadata? |  |
| **Immutability** | Are audit log records, proof documents, and contribution records immutable — enforced at the infrastructure layer? |  |
| **No Self-Judgment** | Is the executor's record structurally separate from the verifier's record — no single schema holds both roles for the same output? |  |
| **Privacy** | Is privacy implemented through access control — with no fields omitted from the record itself? |  |
| **Proof Linkage** | Is every proof document linked to its output via a cryptographic hash — so tampering is detectable? |  |
| **Pattern Library** | Is the pattern schema defined with a confidence scoring formula, minimum evidence threshold, and retirement trigger? |  |
| **Portability** | Is the human contribution record exportable in a format the human owns — with a verification mechanism? |  |
| **Retention** | Is a retention period assigned to every schema — defined as schema metadata, not operational convention? |  |
| **Schema Versioning** | Is every schema versioned — with the version recorded on every record it produces? |  |
| **Dependency Map** | Is the schema dependency map complete — so the implementation team knows the build order? |  |
| **Master Test** | Can every record be attributed, verified, and audited? Does the schema design support the human's ability to own, understand, and take their data with them? |  |
