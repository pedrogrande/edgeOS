<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" style="height:64px;margin-right:32px"/>

# Now answer the questions here:

```
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
```

Here are the Section 3 answers applied to the full 13-agent roster.

***

## 3.1 — Tool Inventory per Agent

Every tool is defined as a single atomic capability. No bundled tools. The document's foundational principle applies throughout: "these are not policy rules; they are missing connections."[^1]

### Executors \& Synthesisers

| Agent | Tool | Type | Necessity |
| :-- | :-- | :-- | :-- |
| **Research Agent** | `web_search` | Executable | Source discovery — removes this, the agent cannot function |
|  | `source_metadata_lookup` | Read | Required to assign confidence tiers (primary/secondary/tertiary) [^1] |
|  | `source_manifest_write` | Write | Its primary output — the Source Manifest |
|  | `project_scope_read` | Read | Scopes the search to the current article topic |
|  | `uncertainty_surface` | Executable | C3 compliance — halts and routes conflicting or unverifiable claims [^1] |
| **Adversarial Research Agent** | `web_search` | Executable | Same tool, different search strategy configuration |
|  | `source_metadata_lookup` | Read | Credential verification for alternative sources |
|  | `adversarial_brief_write` | Write | Writes to a *separate* adversarial brief document — structurally distinct from `source_manifest_write` |
|  | `project_scope_read` | Read | Must understand the article's implied thesis to argue against it |
|  | `uncertainty_surface` | Executable | C3 compliance |
| **Outreach Draft Agent** | `expert_shortlist_read` | Read | Receives the journalist's confirmed candidate selection |
|  | `draft_template_library_read` | Read | Style templates for outreach requests |
|  | `outreach_draft_write` | Write | Produces draft text to a staging area only — no send path |
| **Interview Note Synthesis Agent** | `transcript_read` | Read | Reads audio/transcript of the interview |
|  | `interview_notes_write` | Write | Writes to an isolated interview notes folder only — not the article workspace |
| **Submission Prep Agent** | `article_draft_read` | Read | Packages the article content |
|  | `claim_map_read` | Read | Verifies hash match before packaging [^1] |
|  | `editor_specification_read` | Read | Publication formatting requirements |
|  | `hash_verification_check` | Executable | Confirms Claim Map hash matches article draft — submission is blocked if it fails [^1] |
|  | `submission_package_write` | Write | Formats and writes to submission staging area only |

### Reviewers

| Agent | Tool | Type | Necessity |
| :-- | :-- | :-- | :-- |
| **Fact-Check Agent** | `source_manifest_read` | Read | Claims and their cited sources — its entire verification input [^1] |
|  | `primary_source_lookup` | Executable | Retrieves primary sources for claim verification |
|  | `claim_map_read` | Read | Sees claim structure to verify each assertion |
|  | `verification_report_write` | Write | Structured pass/flag/fail output — its only write capability |
|  | `uncertainty_surface` | Executable | For claims that cannot be verified or falsified [^1] |
| **Editorial Review Agent** | `article_draft_read` | Read | The content being reviewed |
|  | `style_baseline_read` | Read | Consumes Style Baseline Agent's output for voice consistency check [^1] |
|  | `claim_map_read` | Read | Checks factual coverage of verified claims |
|  | `interview_notes_read` | Read | Verifies note synthesis before notes enter the research record [^1] |
|  | `editorial_flag_write` | Write | Structured flags only — no content modification path |
|  | `uncertainty_surface` | Executable | Voice inconsistency or structural incoherence requiring journalist judgment [^1] |
| **Capability Assessment Agent** | `journalist_action_log_read` | Read | Annotation rates, modification rates, angle origination signals [^1] |
|  | `dependency_threshold_check` | Executable | Compares current metrics against H2-defined thresholds |
|  | `pattern_analytics_read` | Read | Cross-references Pattern Analytics outputs to contextualise signals |
|  | `capability_report_write` | Write | Produces quarterly check-in prompt and monthly dependency flags |

### Exploration Agents

| Agent | Tool | Type | Necessity |
| :-- | :-- | :-- | :-- |
| **Expert Discovery Agent** | `professional_database_search` | Executable | Expert identification across academic and professional databases |
|  | `credential_verification_lookup` | Read | Two independent source verification required by T1 [^1] |
|  | `conflict_of_interest_check` | Read | Flags undisclosed conflicts before candidate enters shortlist [^1] |
|  | `expert_shortlist_write` | Write | Produces the shortlist with documented reasoning |
|  | `uncertainty_surface` | Executable | For candidates with unresolvable conflict flags [^1] |

### Orchestrator \& Synthesisers

| Agent | Tool | Type | Necessity |
| :-- | :-- | :-- | :-- |
| **Workflow Orchestrator** | `task_state_read_write` | Read + Write | Tracks workflow stage and agent queue status |
|  | `agent_trigger` | Executable | Routes completed tasks to next agent in sequence |
|  | `sla_tracker_read_write` | Read + Write | Deadline tracking and completion time estimation [^1] |
|  | `journalist_notification_write` | Write | Surfaces escalations, SLA breaches, and queue status |
|  | `audit_log_stage_read` | Read | Verifies stage completion status before triggering next stage — reads status flags only, never content |
| **Pattern Analytics Agent** | `journalist_action_log_read` | Read | Annotation history, decision log, modification rates |
|  | `editorial_flag_history_read` | Read | Historical ERA flags and journalist resolutions |
|  | `editor_feedback_read` | Read | Feedback records from submission history |
|  | `source_annotation_history_read` | Read | Source acceptance, rejection, and annotation patterns |
|  | `pattern_library_read_write` | Read + Write | Maintains the validated pattern library [^1] |
|  | `patterns_digest_write` | Write | Produces the monthly digest for journalist |
| **Style Baseline Agent** | `approved_articles_read` | Read | Reads journalist's approved, published articles only — never drafts in progress |
|  | `style_model_write` | Write | Creates and versions the style baseline |
| **Source Relationship Agent** | `source_history_read_write` | Read + Write | Source interaction records, accuracy history, last contact dates |
|  | `article_history_read` | Read | Which sources appeared in which articles |
|  | `external_credential_monitor` | Read | Monitors for changes in source credentials or institutional positions |
|  | `journalist_reminder_write` | Write | Queues reminders for journalist — no action taken without journalist decision |


***

## 3.2 — Forbidden Capabilities

**Enforcement method key:** **[S]** = structural (missing connection); **[P]** = policy only (prompt instruction); **[P→S]** = currently policy, Phase 2 conversion planned.[^1]


| Agent | Forbidden Capability | Enforcement |
| :-- | :-- | :-- |
| Research Agent | Write to article draft workspace | **[S]** — no write API connection to article workspace [^1] |
| Research Agent | Access journalist's contact list | **[S]** — no contact database connection |
| Research Agent | Propose story angles unprompted | **[P→S]** — currently a prompt instruction; Phase 2 requires explicit journalist trigger before angle generation capability activates [^1] |
| Adversarial Research Agent | Write to Source Manifest | **[S]** — write access scoped to `adversarial_brief_write` only; different endpoint |
| Fact-Check Agent | Modify any content | **[S]** — holds no write connections to article, Source Manifest, or Claim Map [^1] |
| Fact-Check Agent | Access Research Agent's reasoning chain | **[S]** — receives outputs only; reasoning chain is not an exposed API [^1] |
| Editorial Review Agent | Rewrite article content | **[S]** — `editorial_flag_write` is the only write tool; no article write connection [^1] |
| Expert Discovery Agent | Draft outreach communications | **[S]** — `outreach_draft_write` belongs to Outreach Draft Agent only |
| Outreach Draft Agent | Send any communication | **[S]** — no email API connection [^1] |
| Outreach Draft Agent | Access journalist's calendar or email directly | **[S]** — no calendar or email API connection [^1] |
| Submission Prep Agent | Trigger submission | **[S]** — no submission send capability; journalist trigger is a human-held action [^1] |
| Workflow Orchestrator | Read article content, Source Manifest, or Claim Map | **[S]** — `audit_log_stage_read` reads status flags only; content APIs are absent |
| Workflow Orchestrator | Override a journalist-gated checkpoint | **[S]** — `agent_trigger` cannot fire if the preceding stage's status flag is not human-approved |
| Pattern Analytics Agent | Share data with editors or publication | **[S]** — no outbound sharing API; journalist consent action is required to export [^1] |
| Style Baseline Agent | Read draft articles in progress | **[S]** — `approved_articles_read` is scoped to a published articles store, not the live draft workspace |
| Source Relationship Agent | Initiate contact with sources | **[S]** — no outreach API, no email connection [^1] |
| Capability Assessment Agent | Modify scaffolding tier settings | **[S]** — `capability_report_write` produces a recommendation only; tier change requires journalist + steward joint action |
| Any agent | Request additional capabilities at runtime | **[S]** — capability tokens are assigned at initialisation; no escalation path exists [^1] |

**Capabilities currently only policy-based and the plan to make them structural:**

- The angle-generation constraint (Research Agent) is the primary outstanding case. Phase 2 converts it to a disabled-by-default capability that requires an explicit journalist trigger.[^1]
- The C2 mode-drift risk — recommended actions gradually becoming de facto autonomous — is flagged in the document's Phase 2 open questions as requiring an active audit signal: a monthly review of which recommended actions the journalist approved without reading.  This is currently unstructured.[^1]

**If a forbidden capability were accidentally granted:**
The document's weekly automated boundary report would catch tool calls that *approach* boundary conditions, but a granted-and-unused capability would not necessarily trigger a call attempt.  This is a detection gap. The recommended closure: capability token contents are audited at agent initialisation and logged. Any discrepancy between the declared capability set and the configuration-time approved set surfaces immediately as a provisioning violation, before the agent executes any task.[^1]

***

## 3.3 — Authority Assignment

**How authority is granted and by whom:** Authority is defined at system configuration time by the system designer and journalist together. Agents receive capability tokens at initialisation encoding exactly which tools they hold. No agent can hold a tool not listed in its token.[^1]

**Runtime escalation:** There is no escalation path. An agent that encounters a task requiring a capability it does not hold must surface this as a C3 uncertainty and route to the journalist. It cannot request a tool at runtime.  This applies to all 13 agents without exception.[^1]

**Capability-based, not declarative:** Authority is entirely capability-based — the agent either holds the tool connection or it does not. No authority is declared or asserted at runtime through prompts or instructions. The design principle is explicit: "no policy statement or prompt instruction is treated as a substitute for structural scoping."[^1]

**Verifying agents operate within declared authority:** Every tool call is logged with agent ID, tool name, input parameters, output, and status. A weekly automated report flags any tool call that approached a boundary condition.  For the initialisation-time gap identified above, the audit log should also record the capability token contents at agent startup — creating a permanent record of what each agent was authorised to hold at the moment it was deployed.[^1]

***

## 3.4 — Minimum Sufficient Toolset

**Could any agent perform its role with fewer tools?**

- **Research Agent** — No reduction possible. Each tool maps to a distinct requirement: search (discovery), metadata lookup (confidence tiers), manifest write (output), scope read (relevance), uncertainty surface (integrity). Removing any one creates a functional gap.
- **Adversarial Research Agent** — `project_scope_read` could be argued as redundant if scope is passed as a parameter at invocation. Under the "if in doubt" principle, keeping the direct read connection is preferable to relying on parameter passing for a safety-critical function (knowing what thesis to argue against).
- **Fact-Check Agent** — `claim_map_read` is technically derivable from `source_manifest_read` if the Claim Map structure mirrors the Source Manifest. They are kept separate because the Claim Map links article text to source IDs — a different read task from reading the Source Manifest itself. Merging them would bundle capabilities unnecessarily.
- **Outreach Draft Agent** — Could function with only `expert_shortlist_read` and `outreach_draft_write`. The `draft_template_library_read` is a convenience tool. However, removing it risks the agent generating inconsistent draft formats, creating downstream rework. It stays.
- **Interview Note Synthesis Agent** — Two tools is already minimum. Neither can be removed.
- **Submission Prep Agent** — `hash_verification_check` is the most critical tool in the system for preventing unverified content submission.  It must not be removed or merged with another tool. All five tools are necessary.[^1]
- **Workflow Orchestrator** — `audit_log_stage_read` is the key integrity tool — it is what prevents the Orchestrator from triggering a downstream stage on the basis of an unverified upstream one. Without it, stage sequencing could advance past a failed verification. It must remain, and it must remain scoped to status flags only, never content.
- **Pattern Analytics Agent** — `source_annotation_history_read` and `journalist_action_log_read` partially overlap. They are kept separate because the action log captures all decisions, while annotation history is specifically the journalist's source-level judgments — the primary dependency signal from H2.  Merging them would obscure the signal.[^1]
- **Style Baseline Agent** — Two tools. Cannot reduce further.
- **Capability Assessment Agent** — `pattern_analytics_read` could be removed and replaced by the Pattern Analytics Agent pushing signals to it. Under the "if in doubt" principle, a direct read connection is preferable to inter-agent push dependencies, which create coupling and make audit harder.

**Preventing tool scope creep as new capabilities become available:**
The document's C4 review mechanism applies directly here: no new agent capability is deployed without a review that asks "What is now structurally impossible that should be?" and "Does this capability require a new structural constraint?"  Applied to tools, this means every new tool addition requires a C4 review before it can be added to any agent's capability token — not a configuration change, a design review. This is the structural gate against scope creep.[^1]

<div align="center">⁂</div>

[^1]: agentic-system-design-responses-author.md

