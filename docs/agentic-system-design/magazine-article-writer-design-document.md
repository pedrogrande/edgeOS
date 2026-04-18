# Magazine Article Writer — Agentic System Design Document

*Applying the HUMAN Framework for Agentic Systems Design*
*Version 2.0 — March 2026*
*Revised following architectural review. Changes from Version 1.0: Section 6 (Agent Inventory) added; Section 7 (Phasing Register) added; Section 8 (Workflow Topology) added; T3 authority table updated to reflect 13-agent roster; inline Phase 2 deferrals consolidated into Section 7.*

---

## Document Purpose

This document applies the HUMAN Framework — 26 principles across six clusters (Version 2.0 adds Cluster 6: Agent Integrity) — to the design of an agentic system supporting a magazine article writer. It covers the full workflow: research, expert outreach, structuring and writing, editing and polishing, and submission for review and publishing.

---

## Cluster 1 — Purpose

### H1 — Human Flourishing Is the Measure

**What does genuine human flourishing look like for the people this system serves?**
The journalist grows as a professional — deepening their subject-matter knowledge, expanding their network of trusted expert sources, sharpening their editorial judgment, and publishing work that is distinctly and recognisably theirs. Flourishing is not measured by article output volume; it is measured by whether the journalist is a more capable, better-connected professional after six months of using the system than before.

**How will you measure whether the system is serving human dignity and growth — not just task completion?**
Metrics include: the journalist's own assessment of their editorial confidence (surveyed quarterly); whether their source network has grown (number of new expert relationships initiated and sustained); quality signals from editors (not volume of pieces submitted); and whether the journalist can articulate the reasoning behind their article angles — not just accept agent-generated suggestions.

**What outcomes would indicate the system is causing harm, even if outputs are technically correct?**
- Articles that are factually accurate but no longer carry the journalist's distinctive voice or perspective
- The journalist unable to research a topic without agent assistance where they were previously capable
- Sources interacting with the agent rather than building a relationship with the journalist
- Editor feedback that articles feel "generic" or "AI-polished" despite meeting technical criteria

**Who are the humans in scope?**
Primary: the journalist (user). Secondary: expert sources and interview subjects (affected third parties whose relationships and time are at stake). Tertiary: editors and publishers (reviewers and gatekeepers). Readers (downstream audience whose trust in journalism depends on authentic, verified work) are the distal stakeholder.

**What does "success" look like for each of them?**
- *Journalist:* "I'm producing better work, faster, and I'm learning more about my beat than I could alone."
- *Expert sources:* "This journalist is well-prepared, respects my time, and the relationship feels genuine."
- *Editors:* "The work arrives well-researched, cleanly structured, and authentically voiced — and I can trust the sourcing."
- *Readers:* "This article is credible, well-sourced, and I can tell a human journalist cared about it."

---

### H2 — Amplification, Not Dependency

**Which capabilities do you want humans to grow through using this system?**
- Source evaluation judgment — discerning which sources are authoritative, which are biased, which are novel
- Angle development — the ability to frame a story in ways that are original and relevant
- Interview craft — preparation quality, question depth, and relationship-building with experts
- Structural thinking — understanding why certain article architectures serve certain stories
- Editorial self-awareness — recognising their own stylistic patterns, strengths, and gaps

**Which features risk creating reliance rather than growth? How will you detect this?**

| Feature | Dependency Risk | Detection Signal |
|---|---|---|
| Automated source lists | Journalist stops evaluating source quality independently | Sources used without any journalist annotation or rejection |
| AI-generated article angles | Journalist never proposes an angle without agent input | Zero journalist-originated angles in a 30-day window |
| Draft generation | Journalist edits rather than writes, losing voice development | Editor notes voice inconsistency; drafts require heavy revision |
| Interview question prep | Journalist arrives at interviews unprepared without agent | Journalist cannot explain why questions were asked |

**How will you know, six months in, whether the human is more capable or more dependent?**
Quarterly capability check-ins ask the journalist to complete a scoped task without agent assistance — research a topic, develop three angles, or draft a 200-word lead — and compare quality against baseline. A decline indicates dependency formation.

**What would you deliberately not automate in order to preserve human skill development?**
- The final selection of which angle to pursue (the agent offers options; the journalist chooses)
- The decision of who to contact for interview (the agent identifies candidates; the journalist selects)
- The first draft of any article section (the agent may suggest structure; the journalist writes first)
- The editorial relationship with the publication (submission, negotiation, and feedback belong entirely to the journalist)

**How does the system's design change as the human's capability grows?**
The system operates in scaffolding tiers. At onboarding, the research agent explains its source selection reasoning in detail. As the journalist demonstrates consistent source evaluation quality (tracked via their annotation behaviour), explanation depth reduces and the journalist is prompted to evaluate first before seeing agent reasoning. This withdrawal is explicit and flagged to the journalist as a milestone.

---

### H3 — Dignity Is the Constraint

**What decisions or actions must remain with the human — regardless of efficiency gains?**
- The story idea and the decision to pursue it
- Who to interview and the conduct of the interview itself
- The journalist's byline, voice, and stated perspective
- Any decision that affects a source's reputation or public exposure
- The final publish/don't publish decision

**Where could optimisation or automation diminish the human's sense of agency or worth?**
The most acute risk is in the writing stage — if the agent produces fluent, well-structured drafts, the journalist may feel that their role has been reduced to editing someone else's work rather than creating their own. This is a dignity failure regardless of output quality. A second risk is in expert outreach: if the agent drafts and sends interview requests, the journalist may feel embarrassed or professionally compromised if an expert asks about the outreach and the journalist had no awareness of its content.

**When principles conflict, how is dignity prioritised structurally — not just stated in a policy?**
The system is architecturally incapable of sending any communication to a third party (interview request, follow-up, submission) without the journalist explicitly reviewing and approving the specific text. No "auto-send after N hours" feature exists. Draft generation for article sections requires an explicit trigger from the journalist, not an automatic offer.

**What would a user feel if they observed every action this system takes on their behalf?**
This question is used as a design review test at every build stage. Any action that would cause the journalist embarrassment, surprise, or a sense of loss of control if revealed is redesigned or removed before deployment.

**Are there any populations for whom this system could cause disproportionate harm?**
Early-career journalists are at highest risk of dependency formation — they have not yet built the baseline skills the system is designed to amplify. A separate onboarding protocol for early-career users increases scaffolding explanation depth and requires human mentor review of the journalist's capability check-ins. Freelance journalists without editorial oversight are also higher-risk; the verification layer (T5) is proportionally more important for them.

---

### H4 — Connection Over Isolation

**How does this system strengthen human-to-human relationships, not replace them?**
The system is designed to make the journalist *better prepared* for human interactions — not to replace them. Research outputs are briefing documents for conversations, not substitutes for them. Expert outreach produces drafted requests for the journalist to personalise and send themselves. Interview transcription supports the journalist's recall but does not replace the live conversation.

**Which tasks inherently involve human relationships that agents must not absorb?**
- The interview itself — the agent may transcribe and structure notes afterward, but the conversation is entirely human-to-human
- The editor relationship — feedback, negotiation, and submission are journalist-led
- Source cultivation — follow-up relationship maintenance is the journalist's responsibility, with the agent providing reminders and context, never initiating contact

**How will you detect if users are substituting agent interactions for human ones?**
The system tracks the ratio of agent-prepared materials that are used without any journalist modification versus those where the journalist adds, removes, or personalises content. A high unmodified-use ratio in outreach materials is an early warning signal. The journalist is shown this ratio monthly as part of their G3 (Make the Invisible Visible) report.

**What mechanisms actively route humans back to each other rather than to the agent?**
When the journalist asks the system a question that would be better answered by a colleague, mentor, or subject expert, the system explicitly names this: "This is a judgment question about editorial direction — it's better answered by your editor or a trusted peer than by me." The system does not attempt to answer questions that are relational or values-based in nature.

---

## Cluster 2 — Trust Architecture

### T1 — Verification Precedes Trust

**What are the pre-defined criteria that every output must be verified against before being treated as complete?**

| Output | Verification Criteria |
|---|---|
| Research brief | Every factual claim mapped to a named, accessible source; no single-source claims on contested facts; source recency flagged for time-sensitive topics |
| Expert shortlist | Each expert's credentials verified against at least two independent sources; no conflicts of interest undisclosed |
| Article draft | No factual claims unsupported by research brief; voice consistency with journalist's style baseline; all quotes attributed and confirmed accurate |
| Fact-check pass | Each verifiable claim checked against primary source; disputed claims flagged with evidence summary |
| Submission package | All editor requirements met; metadata complete; no unpublished third-party content included without attribution |

**Who or what performs verification — and are they structurally independent from the executor?**
Research verification is performed by a separate Fact-Check Agent that has no access to the Research Agent's reasoning chain — only its outputs. Article draft verification is performed by an Editorial Review Agent. Neither agent can modify the output it is verifying; it can only pass, flag, or reject with documented reasoning. Human editorial review is the final verification gate before submission.

**What happens to an output that fails verification?**
Failed outputs are quarantined — not returned to the journalist as "in progress." The Fact-Check Agent produces a structured failure report identifying specific claims and the evidence gap. The Research Agent must address each flagged item specifically; a general revision does not clear the failure. The journalist is notified of any failure that requires their judgment to resolve.

**Are verification criteria defined before the task begins, not after?**
Yes. At task initiation, the journalist selects a task type (research brief, interview prep, draft, fact-check, submission), and the system displays the verification criteria that will apply. The journalist may add criteria; they may not remove framework-mandated ones.

**Which outputs carry the highest risk if unverified? Are those verified most rigorously?**
Article drafts and fact-check passes carry the highest reputational risk — both for the journalist and the publication. These receive dual verification: automated agent check followed by mandatory human editorial review. Research briefs receive automated verification only unless the topic is flagged as sensitive (legal, medical, political), in which case human review is added.

---

### T2 — Proof Is the Product

**What structured evidence document will accompany each major output?**
Every research brief is accompanied by a **Source Manifest** — a structured document listing every source used, the specific claim it supports, the source's credentials, access date, and confidence tier (primary/secondary/tertiary). Every article draft is accompanied by a **Claim Map** — each factual assertion in the article linked to its entry in the Source Manifest. The Claim Map is the proof document; the article cannot be submitted without it.

**How does that document map evidence to criteria — not just assert compliance?**
The Claim Map uses a structured format: `[Claim text] → [Source ID] → [Verification status] → [Confidence tier]`. A claim marked "verified" must have a source ID that resolves to a specific entry in the Source Manifest. Assertions of compliance without a traceable source ID are automatically rejected by the system.

**Who can read, audit, and challenge the proof document?**
The journalist always has full read access. The editor receives the Claim Map alongside the article submission and may challenge any entry. The Fact-Check Agent has read access during verification. The system administrator has read access for audit purposes. No external party (source, third party) has access without journalist consent.

**What format does the proof document take, and where is it stored?**
Structured JSON with a human-readable markdown rendering. Stored in the journalist's project workspace, version-controlled, and linked immutably to the specific article draft version it certifies. A new draft version requires a new or updated Claim Map.

**How is the proof document linked immutably to the output it certifies?**
The Claim Map is cryptographically hashed alongside the article draft at certification time. Any modification to either the article or the Claim Map breaks the hash and requires re-verification. The system will not allow submission of a draft whose hash does not match its Claim Map.

---

### T3 — Authority Is Structural

**What capabilities does each agent actually hold — and what is structurally impossible for it to do?**

*See Section 6 (Agent Inventory) for the complete 13-agent authority table. The following is the updated authority summary:*

| Agent | Can Do | Structurally Cannot Do |
|---|---|---|
| Research Agent | Search, aggregate, summarise, cite sources, produce Source Manifest | Send communications, access journalist's contacts, modify article drafts, propose angles unprompted |
| Adversarial Research Agent | Run divergent search strategy, produce adversarial brief | Write to Source Manifest, send communications, access article workspace |
| Fact-Check Agent | Read and verify claims against sources, produce verification report | Modify any content, access Research Agent reasoning chain, initiate communications |
| Editorial Review Agent | Assess draft quality, flag style inconsistencies, verify note synthesis | Rewrite content, send to editor, access source contacts |
| Expert Discovery Agent | Search expert databases, verify credentials, flag conflicts of interest, produce shortlist | Draft communications, contact experts, rank candidates without disclosure |
| Outreach Draft Agent | Draft interview request text for journalist review | Send any communication, access journalist's email or calendar directly |
| Interview Note Synthesis Agent | Structure interview transcript into timestamped notes | Interpret significance, editorially frame content, modify journalist's own notes |
| Submission Prep Agent | Format and package article to editor specifications, verify hash match | Submit without journalist explicit trigger, modify article content |
| Workflow Orchestrator Agent | Sequence tasks, route handoffs, track SLAs, escalate to journalist | Override journalist-gated checkpoints, read article or source content, make editorial judgments |
| Pattern Analytics Agent | Analyse action logs, produce patterns digest, maintain pattern library | Share data without journalist consent, encode pattern without 3+ data points and journalist approval |
| Style Baseline Agent | Build and version journalist style baseline from approved published articles | Read draft articles in progress, evaluate any draft against the baseline (that is ERA's role) |
| Source Relationship Agent | Maintain source history, monitor credential changes, queue journalist reminders | Initiate contact with sources, send communications, share source data externally |
| Capability Assessment Agent | Track dependency signals, produce capability reports, flag scaffolding tier changes | Modify scaffolding tier settings autonomously, share capability data with publication without consent |

**How is authority granted — and by whom? Can it be escalated at runtime?**
Authority is defined at system configuration time by the system designer and journalist together. Agents receive capability tokens at initialisation; they cannot request additional capabilities at runtime. There is no escalation path — an agent that needs a capability it does not have must surface this as an uncertainty (C3) and route to the journalist.

**What prevents an agent from claiming authority it was not granted?**
The tool layer is scoped at the infrastructure level — agents are instantiated with only the API connections their role requires. These are not policy rules; they are missing connections.

**Are authority boundaries enforced by architecture, or only by policy?**
Architecture. No policy statement or prompt instruction is treated as a substitute for structural scoping.

**How do you audit whether agents operated within their structural authority?**
Every tool call is logged with agent ID, tool name, input parameters, and output. The audit log is queryable. A weekly automated report flags any tool calls that approached boundary conditions. Capability tokens are audited at agent initialisation and the audit is itself logged — creating a record of what each agent was authorised to hold at deployment.

---

### T4 — All Actions Witnessed

**What logging and audit infrastructure will record every action with attribution and timestamp?**
All agent actions — searches, reads, writes, draft generations, verification passes, flags — are logged in an immutable append-only log with: timestamp (UTC), agent ID, action type, input summary, output summary, and status. Human actions within the system (approvals, rejections, edits) are logged identically. The log is stored separately from the operational system and cannot be modified by any agent or by the journalist.

**How is privacy protected — through access control, never through selective logging?**
All actions are logged. Access to the log is tiered: the journalist sees their own project logs; the editor sees submission-related logs for their projects; the system administrator sees all logs for audit purposes. Source contact information in logs is redacted from editor-level access. Nothing is omitted from the log to protect privacy — only access is restricted.

**Who has access to the audit log — and under what conditions?**
Journalist: full access to their own project logs, always. Editor: read access to submission and verification logs for submitted articles, upon submission. System administrator: full read access for audit and incident investigation. Third parties: no access except under legal compulsion, and the journalist is notified when this occurs.

**How long are logs retained, and are they immutable once written?**
Logs are retained for five years minimum (aligning with standard journalistic source protection periods). They are immutable once written — no deletion or modification is permitted. Archival after two years to cold storage with integrity verification on retrieval.

**What would the audit log reveal about a disputed action or outcome?**
For any disputed claim — a source contesting a quote, an editor questioning a fact, a subject disputing their representation — the audit log can reconstruct exactly which agent produced which content, from which sources, at which time, and which human approved it.

---

### T5 — No Self-Judgment

**For every executor role, who is the structurally separate verifier?**

| Executor | Verifier |
|---|---|
| Research Agent | Fact-Check Agent |
| Adversarial Research Agent | Journalist (reviews adversarial brief alongside primary brief) |
| Expert Discovery Agent | Journalist (selects from shortlist; agent does not self-certify candidate suitability) |
| Outreach Draft Agent | Journalist (mandatory human review before any send) |
| Interview Note Synthesis Agent | Editorial Review Agent (notes checked before entering research record) |
| Article Draft (journalist) | Editorial Review Agent + Human Editor |
| Fact-Check Agent | Journalist sign-off on disputed items |
| Submission Prep Agent | Journalist explicit submission trigger + hash verification |
| Style Baseline Agent | Journalist (approves each baseline update before it takes effect) |
| Pattern Analytics Agent | Journalist (approves each new pattern entry before it influences recommendations) |
| Capability Assessment Agent | Journalist + System Steward (joint review of scaffolding tier change recommendations) |

**Are there any stages where a single actor currently both executes and verifies?**
Note synthesis — where the journalist writes up interview notes — requires a separate Editorial Review Agent check before those notes enter the research record. This separation prevents the journalist's memory and interpretation biases from entering the verified record unchecked.

**Does this separation apply to human actors as well as agents?**
Yes. The journalist cannot self-certify their own article as ready for submission — the Editorial Review Agent and human editor constitute the separate verification layer for human-produced content.

**How is the verifier's independence maintained under time pressure?**
Verification steps are not skippable under deadline pressure. The system does not offer a "bypass verification" option. If a deadline cannot be met with verification complete, the journalist is notified in advance so the deadline can be renegotiated — not the verification.

**What happens when the verifier is unavailable?**
If the Fact-Check Agent is unavailable, verification is queued — the article does not proceed to draft stage. The journalist is notified with an estimated resolution time. There is no fallback that removes verification; only a delay is permitted.

---

### T6 — Resilience Through Structure

**What are the single points of failure in this system — and how are they mitigated?**

| Single Point of Failure | Mitigation |
|---|---|
| Research Agent failure | Research brief can be completed manually by journalist using structured template; agent failure triggers notification with manual fallback instructions |
| Fact-Check Agent failure | Verification queue holds; no content proceeds; journalist notified with estimated resolution time |
| Editorial Review Agent failure | Draft stage held; journalist notified; manual editorial checklist provided as fallback |
| Workflow Orchestrator failure | Individual agents can be triggered manually by journalist via task interface; orchestrator failure does not corrupt data |
| Source Manifest corruption | Version-controlled with hourly snapshots; corruption triggers rollback to last verified state |
| Journalist unavailable for approval | No agent action proceeds without approval; work queues and notifies on journalist return |
| Style Baseline corruption | Previous baseline version restored from version-controlled history; ERA flags this condition and halts voice-consistency checks until baseline is re-approved |

**If any one agent fails, what is the impact on systemic trust?**
Each agent is isolated — failure of the Research Agent does not affect the integrity of the Fact-Check Agent or the audit log. Unavailable verification always results in a hold, never a pass.

**What failure modes have you explicitly designed for?**
Agent hallucination (source cited does not exist), agent overconfidence (claim marked verified without adequate evidence), deadline pressure bypassing verification, and agent scope creep (gradually expanding actions beyond declared role).

*Note: Cascading failures if multiple agents fail simultaneously are recorded in the Phasing Register (Section 7, item 2) as a Phase 2 design requirement.*

**How is resilience tested before deployment at scale?**
A single-article pilot (Q4) runs the full workflow including deliberate failure injection: the Fact-Check Agent is taken offline mid-verification to confirm the hold behaviour; a source is intentionally misattributed to confirm Claim Map hash mismatch detection; the Workflow Orchestrator is disabled to confirm manual trigger fallback operates correctly.

---

### T7 — Distributable Verification

**Does verification require a central trusted party?**
In the current design, the human editor is the final centralised verification authority for submission readiness. This is appropriate for a single-journalist system but creates a bottleneck at publication scale.

**How could quorum-based verification be applied?**
For high-stakes investigative pieces, a three-agent quorum verification is implemented: the Fact-Check Agent, a second independent Fact-Check Agent instance with a different knowledge base, and the Editorial Review Agent must all pass the Claim Map before the journalist is given the submission trigger. Agreement of two of three is sufficient; a three-way disagreement surfaces to the journalist and editor jointly.

**What qualifies a verifier to participate in the pool?**
For automated verifiers: demonstrated accuracy above 95% on a calibration set of known-correct and known-incorrect claims. For human verifiers: editorial credentials verified by the publication.

**How is consensus reached when verifiers disagree?**
Disagreements are surfaced to the journalist with a structured summary of each verifier's finding and reasoning. The journalist resolves the dispute with their own judgment and documents their reasoning in the Claim Map. The journalist's resolution is final and attributed to them in the audit log.

---

## Cluster 3 — Human-Agent Complementarity

### C1 — Deliberate Role Allocation

**For each workflow stage, which tasks are assigned to agents and which to humans — and why?**

| Stage | Agent Tasks | Human Tasks | Rationale |
|---|---|---|---|
| **Research** | Web search, source aggregation, claim extraction, citation formatting, gap flagging, adversarial brief | Source evaluation and selection, angle decisions, significance judgment | Agents excel at scale and recall; significance and newsworthiness require human judgment |
| **Expert Outreach** | Candidate identification, credential verification, conflict-of-interest checking, draft request text | Contact selection, request personalisation, interview conduct, relationship cultivation | Relationship is the journalist's professional asset; agents support logistics only |
| **Interview & Notes** | Transcript structuring, note synthesis (ERA-reviewed before use) | Interview conduct, note judgment, significance assessment | Interview is permanently human-led; note synthesis requires verification before entering the record |
| **Structuring** | Outline options, structural templates, argument flow analysis | Angle selection, structure decision, argument framing | The journalist's perspective is the article's value; structure serves the argument the journalist chooses |
| **Writing** | Style consistency flagging, factual claim identification, quote formatting | All first-draft writing, voice, perspective, transitions | Voice and perspective are the journalist's professional identity; agents do not generate prose |
| **Editing** | Grammar and style guide compliance, fact-check pass, structural coherence flags | Final tone and voice decisions, all substantive edits, cut decisions | Editing is a craft judgment; agents surface issues but do not resolve them |
| **Submission** | Formatting to spec, metadata tagging, submission package prep, hash verification | Review and approval of package, submission trigger, editor relationship | Submission is a professional act with relationship consequences; the journalist owns it |

**Are any human tasks currently being assigned to agents by default?**
Article outlining was incorrectly framed as an agent task in the initial design. This has been reclassified: the agent offers structural options *after* the journalist has proposed an approach, not before. The journalist's thinking leads; the agent responds.

---

### C2 — Governed Autonomy

**For every action class, which mode applies?**

| Action | Mode | Rationale |
|---|---|---|
| Web search and source aggregation | Agent-autonomous | Reversible, low-risk, within defined scope |
| Source confidence tier assignment | Agent-recommended | Requires journalist validation before entering record |
| Expert candidate identification | Agent-recommended | Journalist must select; agent does not rank-order without disclosure |
| Interview request drafting | Agent-recommended | Journalist reviews and personalises before any send |
| Sending any communication | Human-led | Irreversible, relationship consequence |
| Structural outline options | Agent-recommended | Journalist selects or rejects each option |
| Any prose generation | Human-led | Journalist writes; agent may respond to explicit requests for examples only |
| Fact-check pass | Agent-autonomous | Within defined verification criteria; failures always surface to human |
| Formatting and submission prep | Agent-autonomous | Reversible, no external consequence until journalist triggers submission |
| Submission trigger | Human-led | Irreversible, professional consequence |
| Pattern encoding | Agent-recommended | Journalist reviews and approves before pattern influences recommendations |
| Scaffolding tier change | Human-led | Journalist and system steward jointly approve |

**Are these mode assignments made before deployment?**
Yes. The mode table above is reviewed and signed off by the journalist at system onboarding. Changes require a documented design review, not a runtime request.

**How are out-of-bounds actions detected, recorded, and escalated?**
Any tool call attempted by an agent outside its declared mode is rejected at the infrastructure level, logged as a boundary violation with full context, and surfaced to the system administrator. The journalist is notified of any boundary violation affecting their project.

---

### C3 — Uncertainty Surfaces Immediately

**What conditions should cause any actor to halt work and surface uncertainty?**
- *Research Agent:* conflicting authoritative sources on a factual claim; source recency concern on time-sensitive facts; inability to verify a claim to primary source level
- *Adversarial Research Agent:* inability to find credible counterarguments (which itself is a signal worth surfacing)
- *Fact-Check Agent:* claim that cannot be verified or falsified with available sources; source that appears credible but cannot be independently corroborated
- *Expert Discovery Agent:* expert candidate with undisclosed conflicts of interest; contact information that may be outdated or incorrect
- *Editorial Review Agent:* voice inconsistency that may indicate the article has departed from the journalist's authentic style; structural incoherence that would require substantive journalist intervention
- *Style Baseline Agent:* insufficient approved article history to construct a reliable baseline (fewer than three articles)
- *Capability Assessment Agent:* dependency signal that cannot be attributed to a specific feature or workflow change

**How does the system route surfaced uncertainty to the appropriate decision-maker?**
Each uncertainty is classified at surface time: factual uncertainties route to the journalist with evidence summary; editorial uncertainties route to the journalist with flagged passages; structural uncertainties route to the journalist with alternative options. No uncertainty is automatically resolved by another agent.

**Is surfacing uncertainty treated as correct behaviour?**
Explicitly. The system displays a "Research integrity maintained" notification each time an uncertainty is surfaced and resolved — framing it as a quality signal, not a failure.

**What is the expected response time when uncertainty is surfaced?**
The journalist is given a response time SLA at task initiation based on deadline. Unresolved uncertainties that breach the SLA generate an escalation notification. Work does not proceed on unresolved uncertainties; the task is held, not abandoned.

---

### C4 — Structural Ethics

**Which ethical constraints are enforced by architecture — structurally impossible to violate?**
- No communication sent to any third party without journalist explicit review and send action
- No article submitted without a complete, hash-verified Claim Map
- No source contact information shared with any external system or party
- No agent can access, read, or process the journalist's personal communications outside the system
- No draft content generated without an explicit journalist trigger
- No pattern encoded without minimum three data points and journalist approval
- No scaffolding tier changed without journalist and system steward joint action

**Which constraints are currently only policy-based — and what is the plan to make them structural?**
The constraint against agents proposing story angles without being asked is currently policy (a prompt instruction). Phase 2 makes this structural by requiring an explicit "generate angle options" trigger before the capability activates — disabled by default. *See Phasing Register, item 1.*

**Under what pressure conditions might declarative ethics fail?**
Deadline pressure is the primary risk. The structural responses: verification approval requires the journalist to confirm they have read the verification report (not just click approve); outreach messages have a mandatory 60-second review window before the send button activates.

**Who is responsible for maintaining and updating structural ethical constraints as the system evolves?**
A named system steward (initially the journalist or their editorial organisation) reviews structural constraints quarterly. No new agent capability is deployed without a C4 review.

---

## Cluster 4 — Growth and Learning

### G1 — Scaffold, Don't Substitute

**At what point does the system do something for the human that they cannot yet do alone?**
Source aggregation at scale, citation formatting, style guide compliance checking, and structural coherence analysis are the legitimate scaffold zones.

**How does the system deliberately withdraw support as capability grows?**

Three scaffolding tiers are defined at onboarding:
- *Tier 1 (Onboarding):* Agent shows full source selection reasoning; offers three structural options with explanations; highlights style guide violations with rule references
- *Tier 2 (Developing):* Agent surfaces source reasoning only on request; offers one structural suggestion rather than three; flags style violations without rule references
- *Tier 3 (Proficient):* Agent confirms source list without explanation unless the journalist asks; structural input only on explicit request; style check as a final pass, not ongoing

Tier progression is triggered by demonstrated capability in quarterly check-ins, not by time elapsed.

**Are there tasks where scaffolding is never appropriate?**
The interview itself, the story angle decision, the choice of voice and perspective, and the editorial relationship. These are permanently human-led regardless of capability tier.

---

### G2 — Learning Is Always Happening

**What learning opportunities exist in each workflow stage?**
- *Research:* Each Research Agent source selection is a teachable moment — "why this source, not that one?" is surfaced as an optional learning prompt
- *Expert outreach:* After each interview, the system prompts a structured debrief: what worked, what the journalist would ask differently, what new questions emerged
- *Structuring:* When the journalist selects a structural option, the system notes what made that structure appropriate for this story type
- *Editing:* Each style flag resolved by the journalist becomes a pattern entry — "you consistently address this issue by doing X; would you like this added to your style guide?"
- *Submission:* Editor feedback is captured and connected back to specific structural or editorial choices in the article

**How is growth treated as a by-product of doing — not a separate "training" activity?**
No learning mode exists. All of the above is integrated into the standard workflow as optional depth layers — the journalist can engage or skip, and the system tracks engagement without requiring it.

---

### G3 — Make the Invisible Visible

**What patterns, assumptions, and blind spots can the system surface?**
- Source diversity patterns: "In your last 10 articles, 80% of your sources have been from academic institutions."
- Structural habits: "You consistently open with an anecdote. Your editors have accepted this structure in 9 of 10 pieces."
- Interview patterns: "Questions beginning with 'how' generate longer, more usable quotes than questions beginning with 'do you think'."
- Topic depth patterns: "Your research briefs on technology topics have significantly lower source diversity than your pieces on policy topics."

**How are self-awareness outputs delivered in a way that is empowering rather than surveilling?**
All pattern reports are framed as observations, not evaluations. They are delivered monthly in a "Your journalism patterns" digest. No pattern data is shared with the publication without the journalist's explicit consent.

**Who owns the insights generated about the journalist?**
The journalist. All pattern data is stored in their personal workspace, is exportable in full, and is deleted from the system on their request.

---

### G4 — Contribution Has a Record

**How are the journalist's decisions, judgments, and contributions captured and attributed to them?**
Every journalist decision in the system — source selected, angle chosen, structural decision made, fact verified by judgment — is logged with the journalist's ID, timestamp, and decision context. The Claim Map for each article is a permanent record of their editorial judgment, distinguishable from agent-generated content.

**Is the record portable?**
Yes. The journalist can export their full contribution record at any time in structured JSON and human-readable PDF. The record is theirs; it does not belong to the platform or the publication.

**How does the record build the journalist's reputation and trust over time?**
Over time, the journalist accumulates a verified editorial track record: articles published, sources used and validated, interview relationships maintained, and fact-check pass rates. This record can be shared (at the journalist's discretion) with new publications as a credential.

---

### G5 — Knowledge Compounds

**What patterns from past outcomes are being crystallised?**
- Reliable experts by topic area (response rate, interview quality, accuracy of statements)
- Source types that consistently produce high-quality, verifiable claims by topic domain
- Article structures that have been accepted by this publication vs. rejected
- Research gaps that recurred across multiple articles on similar topics

**How is knowledge validated before it is encoded as a pattern?**
A minimum of three data points is required before a pattern is encoded. The journalist reviews and approves each new pattern entry before it influences future recommendations. Patterns are marked with their data basis so the journalist can assess their reliability.

**How does the system prevent outdated or incorrect patterns from compounding harm?**
All patterns have a recency weight that decays over 18 months. Patterns older than 24 months without corroboration are surfaced to the journalist for validation or removal. A pattern contradicted by a recent outcome is flagged immediately and marked as requiring review.

---

## Cluster 5 — Quality and Performance

### Q1 — Expand, Never Collapse

The Research Agent always surfaces at least three different source perspectives on contested topics. The Expert Discovery Agent provides multiple expert candidates, not a single recommendation. Structural options are presented as a range, with tradeoffs noted. The system never presents a single "best" answer to an editorial judgment question. A "divergence prompt" is built into every angle suggestion: "Here are two approaches that differ from your recent patterns — one more investigative, one more feature-led."

### Q2 — Right-Size the Interaction

Research briefs have three display levels: Summary (key claims and sources, one page), Standard (full Source Manifest with confidence tiers), and Deep (full research trail including rejected sources and reasoning). The journalist selects their level at brief request time. The default is Standard, calibrated to scaffold tier.

### Q3 — Adversarial Perspective by Design

For investigative articles, the Research Agent is required to produce a counterargument brief — a structured summary of the strongest case against the article's implied thesis — delivered to the journalist before drafting. For contested topics, the Adversarial Research Agent runs in parallel to surface sources the primary instance missed.

The threshold for triggering adversarial review — political, legal, medical, and social justice topics — is defined before deployment. *The precise classification boundary is recorded in the Phasing Register (item 4) as a Phase 2 refinement.*

### Q4 — Prove It in One Before Many

A single-article pilot validates the system before scale deployment. The pilot tests: Research Agent brief utility; Fact-Check Agent error detection (three seeded errors); Claim Map hash verification (deliberate post-hoc modification); journalist voice preservation; Workflow Orchestrator manual fallback; and cascading hold behaviour when the Fact-Check Agent is taken offline mid-verification.

### Q5 — Problem Precedes Solution

The problem: a journalist spends disproportionate time on research logistics, source formatting, and administrative workflow — time that reduces the cognitive space available for original thinking, source relationship-building, and high-quality writing. This problem statement is validated at every quarterly review: "Is this still the right problem? What has the system revealed that we didn't know at the start?"

---

## Cluster 6 — Agent Integrity

### A1 — Single-Responsibility Agents

Every agent in this system has been reviewed against the A1 test. The original five-agent design was found to contain four missing agents and two conflated agents. The 13-agent roster in Section 6 reflects A1 compliance. The separation principle applied in each case is documented in Section 6.2.

---

## Section 6 — Agent Inventory

*This section was added in Version 2.0 following architectural review. It supersedes the five-agent authority table from Version 1.0 T3.*

### 6.1 — Agent Roster

| # | Agent | Archetype | Orientation | Key HUMAN Constraints | Human Interaction Points |
|---|---|---|---|---|---|
| 1 | Research Agent | Executor + Synthesiser | Factual | T3, T5, C2, C3, Q1 | Surfaces uncertainty to journalist; journalist reviews Source Manifest |
| 2 | Adversarial Research Agent | Exploration | Divergent | A1, Q3, T5 | Journalist reviews adversarial brief alongside primary brief |
| 3 | Fact-Check Agent | Reviewer | Critical | T1, T5, T3 | Journalist resolves disputed items; journalist notified on failure |
| 4 | Editorial Review Agent | Reviewer + Articulation | Critical + Procedural | T5, C3, H3 | Journalist resolves all flags; journalist approves note synthesis |
| 5 | Expert Discovery Agent | Exploration | Critical + Factual | A1, T1, C3, H4 | Journalist selects from shortlist; journalist resolves conflict flags |
| 6 | Outreach Draft Agent | Executor | Procedural | H3, T3, C2 | Mandatory journalist review and personalisation before any send |
| 7 | Submission Prep Agent | Executor | Procedural | T2, T3, H3 | Journalist explicit submission trigger; journalist reviews package |
| 8 | Interview Note Synthesis Agent | Executor | Procedural + Synthesising | A1, T5, H4 | ERA review of notes; journalist approves notes for research record |
| 9 | Workflow Orchestrator Agent | Orchestrator | Procedural | T3, T6, C2 | Journalist notified of SLA breaches, escalations, and queue status |
| 10 | Pattern Analytics Agent | Synthesiser | Factual + Synthesising | G3, G5, H2, T3 | Journalist reviews digest monthly; journalist approves pattern entries |
| 11 | Style Baseline Agent | Synthesiser | Factual + Synthesising | A1, T5, G3 | Journalist approves each baseline update before it takes effect |
| 12 | Source Relationship Agent | Executor | Procedural + Synthesising | H4, T3, G5 | Journalist reviews reminders; journalist decides all follow-up actions |
| 13 | Capability Assessment Agent | Reviewer | Critical | H2, A1, T5, G1 | Journalist + steward review capability flags and tier recommendations |

### 6.2 — A1 Separation Rationale

| Separation Made | Original Form | Reason for Separation |
|---|---|---|
| Research Agent / Adversarial Research Agent | Single Research Agent with "parallel instance" | Different cognitive orientations (factual vs. divergent); parallel instance was implicit not structural |
| Expert Discovery Agent / Outreach Draft Agent | Single Outreach Draft Agent | Discovery is exploratory + critical; drafting is procedural; same agent evaluating then advocating for a candidate is a latent self-judgment risk (T5) |
| Interview Note Synthesis Agent | Unnamed — described functionally only | Missing executor for a described workflow function; without naming it, no tool scoping, no T5 verifier assignment, no audit attribution |
| Workflow Orchestrator Agent | Implicit — journalist-triggered handoffs | No named agent for sequencing, SLA tracking, or escalation; coordination function was silently assigned to journalist |
| Pattern Analytics Agent | Unnamed — described functionally only | Monthly digest and pattern library have distinct production requirements from capability assessment |
| Style Baseline Agent | Implicit — ERA "uses a style baseline" | ERA cannot verify against a baseline it also builds (T5); baseline production requires a separate, dedicated agent |
| Source Relationship Agent | Implicit — "agent provides reminders" | Named in Phase 2 open questions; applies H4 and requires dedicated scoping to prevent contact initiation |
| Capability Assessment Agent | Partially absorbed by Pattern Analytics | Dependency detection (critical orientation) is distinct from pattern observation (synthesising orientation); A1 requires separation |

### 6.3 — Coupling Analysis

| Agent | Depends On (Inputs) | Depended On By (Outputs Feed) | Failure Propagation |
|---|---|---|---|
| Research Agent | Workflow Orchestrator (trigger), project scope | Fact-Check Agent, Editorial Review Agent (via Claim Map) | Halts research stage; manual fallback available |
| Adversarial Research Agent | Workflow Orchestrator, project scope | Journalist (direct review) | Does not block primary workflow; reduces adversarial coverage |
| Fact-Check Agent | Research Agent (Source Manifest), Claim Map | Workflow Orchestrator (stage gate), Editorial Review Agent | Halts all downstream stages; highest-risk single failure |
| Editorial Review Agent | Article draft, Claim Map, Style Baseline Agent, Interview Note Synthesis Agent | Workflow Orchestrator (stage gate), Journalist | Halts editing and submission stages; manual checklist fallback |
| Expert Discovery Agent | professional databases (external) | Outreach Draft Agent, Journalist | Delays outreach stage; journalist can identify candidates manually |
| Outreach Draft Agent | Expert Discovery Agent (confirmed selection) | Journalist | No downstream block; journalist can draft manually |
| Interview Note Synthesis Agent | Transcript (external input) | Editorial Review Agent, Research Agent (notes feed record) | Delays note entry to research record; journalist can write notes manually |
| Submission Prep Agent | Article draft, Claim Map (hash verified) | Journalist (submission trigger) | Halts submission; manual formatting fallback |
| Workflow Orchestrator | All stage completion signals | All agents (sequencing) | Individual agent triggers become manual; highest operational impact |
| Pattern Analytics Agent | Journalist action log, editorial flag history, editor feedback | Journalist (digest), Capability Assessment Agent | Degrades pattern quality; does not block articles |
| Style Baseline Agent | Approved published articles store | Editorial Review Agent | ERA cannot perform voice-consistency checks; ERA flags condition and halts that check only |
| Source Relationship Agent | Source history, article history | Journalist (reminders) | Reminders cease; no workflow block |
| Capability Assessment Agent | Journalist action log, Pattern Analytics | Journalist + steward (capability flags) | Dependency detection ceases; no workflow block |

**Structural hub analysis:**
- **Fact-Check Agent** — most critical path agent; failure blocks all downstream stages
- **Editorial Review Agent** — second most connected; receives from 4 upstream sources; failure blocks editing and submission
- **Workflow Orchestrator** — highest operational impact; failure makes all handoffs manual
- **Pattern Analytics + Style Baseline + Capability Assessment** — peripheral; failure degrades quality signals but does not block article production

---

## Section 7 — Phasing Register

*All deferred decisions consolidated from inline notes throughout Version 1.0. No inline deferrals remain in the document body.*

| # | Deferred Decision | Risk Classification | Risk If Left Unresolved in Phase 1 | Trigger for Phase 1 Promotion | Owner |
|---|---|---|---|---|---|
| 1 | Angle-generation structural constraint (Research Agent) | High | Policy-only constraint may fail under deadline pressure; journalist may receive unsolicited angle suggestions | Phase 2 build cycle | System steward |
| 2 | Cascading multi-agent failure design | Critical | No defined behaviour if Fact-Check Agent and Editorial Review Agent fail simultaneously; could produce false operational confidence | Before scale deployment to >1 journalist | System steward + infrastructure lead |
| 3 | Voice consistency automated metric | High | Editorial Review Agent's voice-consistency check is a structural requirement (T1) but no reliable automated measure exists; check currently relies on Style Baseline Agent's heuristic model, which may not detect subtle drift | Phase 2 research cycle; validated metric required before Tier 3 scaffold progression is enabled | System steward + ERA designer |
| 4 | Investigative/sensitive piece classification threshold | High | Adversarial review and quorum verification trigger on "investigative" or "sensitive" topics, but boundary is currently journalist-determined at runtime; inconsistent application degrades Q3 compliance | Phase 2; requires a documented classification rubric signed off by system steward and at least one editor | System steward |
| 5 | Early-career journalist protocol specification | Medium | Increased scaffolding depth and mentor review described but not fully specified as a deployable configuration | Phase 2; required before system is offered to early-career users | System steward |
| 6 | C2 mode-drift structural enforcement | High | Recommended actions may gradually become de facto autonomous if journalist approves without reading; this is a dignity failure (H3) that is currently undetectable in real time | Phase 2; requires a monthly audit signal showing which recommended actions were approved without engagement; Capability Assessment Agent is the designated monitor | Capability Assessment Agent designer |
| 7 | Granted-but-unused capability detection | Medium | A capability token granted in error but not yet exercised would not be detected by boundary-violation logging; requires capability token audit at initialisation | Phase 1 — add to pilot test plan before deployment | Infrastructure lead |
| 8 | H4 at scale — active source relationship strengthening | Medium | System currently does not degrade source relationships but does not actively strengthen them either; a relationship cultivation layer is a candidate for Phase 2 | Phase 2 | Source Relationship Agent designer |
| 9 | T7 for solo freelance journalists — peer verification network | Medium | Distributable verification assumes a publication's editorial infrastructure; solo freelancers have no equivalent quorum pool | Phase 2; required before system is offered to freelance users without editorial affiliation | System steward |

---

## Section 8 — Workflow Topology

*The following describes the linear workflow sequence. A full state diagram with hold/fail/pass transitions at each verification gate is to be produced as a companion artefact before Phase 1 deployment approval.*

```
[JOURNALIST: Story idea + angle decision]
        ↓
[Stage 1: RESEARCH]
  Research Agent (autonomous) → Source Manifest
  Adversarial Research Agent (conditional: investigative/sensitive) → Adversarial Brief
        ↓ [HUMAN GATE: Journalist reviews Source Manifest + Adversarial Brief; selects/annotates sources]
        ↓
[Stage 1a: VERIFICATION — Research]
  Fact-Check Agent → Verification Report (pass / flag / fail)
        ↓ [If fail: quarantine + journalist notified → Research Agent revises → re-verify]
        ↓ [If pass: proceed]
        ↓
[Stage 2: EXPERT OUTREACH]
  Expert Discovery Agent → Expert Shortlist
        ↓ [HUMAN GATE: Journalist selects candidate]
  Outreach Draft Agent → Draft Request Text
        ↓ [HUMAN GATE: Journalist reviews, personalises, sends (60-second window enforced)]
        ↓
[Stage 2a: INTERVIEW — Human-led, no agent involvement in conversation]
  Interview Note Synthesis Agent → Structured Interview Notes
        ↓ [Editorial Review Agent: notes verification before entering research record]
        ↓ [HUMAN GATE: Journalist approves notes for record]
        ↓
[Stage 3: STRUCTURING]
  Editorial Review Agent (on request) → Structural Options
        ↓ [HUMAN GATE: Journalist selects structure; journalist proposes approach first]
        ↓
[Stage 4: WRITING — Human-led; agents do not generate prose]
  Editorial Review Agent (style flags, ongoing) → Style Flag Report
        ↓ [HUMAN GATE: Journalist writes first draft; resolves all style flags]
        ↓
[Stage 5: EDITING + FACT-CHECK]
  Fact-Check Agent → Claim Map verification
  Editorial Review Agent → Editorial Flag Report
        ↓ [HUMAN GATE: Journalist resolves all flags; human editor review]
        ↓
[Stage 6: SUBMISSION PREP]
  Submission Prep Agent → Submission Package + Hash Verification
        ↓ [If hash mismatch: submission blocked; journalist notified]
        ↓ [HUMAN GATE: Journalist reviews package]
        ↓ [HUMAN GATE: Journalist explicit submission trigger]

[PARALLEL, CONTINUOUS]
  Workflow Orchestrator → SLA tracking, handoff sequencing, escalations
  Pattern Analytics Agent → Monthly digest, pattern library maintenance
  Style Baseline Agent → Baseline maintenance from approved published articles
  Source Relationship Agent → Source history, credential monitoring, journalist reminders
  Capability Assessment Agent → Dependency signals, quarterly check-in prompts
```

---

## The Master Test

Applied at every design decision, feature, and agent behaviour in this system:

| Test | Question | Answer |
|---|---|---|
| **System Test** | Can this be verified, attributed, and audited? | Yes. Every agent action is logged, attributed, and timestamped. Every output is accompanied by a Claim Map. The hash-verified Claim Map links article content to its evidence chain. |
| **Human Test** | Does this leave the journalist more capable, more aware, and more connected than before? | By design, yes — when the system is operating correctly. Scaffolding tiers deliberately withdraw support as capability grows (G1). Pattern reports surface invisible habits (G3). The counterargument brief develops editorial judgment (Q3). Human relationship stages are structurally protected from agent absorption (H4, C1). |
| **If either answer is no** | What must change? | Neither failure is acceptable. Neither triggers a patch. Both trigger a design review. |

