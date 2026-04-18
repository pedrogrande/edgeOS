# Magazine Article Writer — Agentic System Design Document

*Applying the HUMAN Framework for Agentic Systems Design*
*Version 1.0 — March 2026*

***

## Document Purpose

This document applies the HUMAN Framework — 26 principles across five clusters — to the design of an agentic system supporting a magazine article writer. It covers the full workflow: research, expert outreach, structuring and writing, editing and polishing, and submission for review and publishing. Every question in the design template is answered, producing a complete, deployable design brief.

***

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

***

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

***

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

***

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

***

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

***

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

***

### T3 — Authority Is Structural

**What capabilities does each agent actually hold — and what is structurally impossible for it to do?**

| Agent | Can Do | Structurally Cannot Do |
|---|---|---|
| Research Agent | Search, aggregate, summarise, cite sources | Send communications, access journalist's contacts, modify article drafts |
| Fact-Check Agent | Read and verify claims against sources | Modify any content, access outreach tools, initiate communications |
| Editorial Review Agent | Assess draft quality, flag style inconsistencies | Rewrite content, send to editor, access source contacts |
| Outreach Draft Agent | Draft interview request text for journalist review | Send any communication, access journalist's email or calendar directly |
| Submission Prep Agent | Format and package article to editor specifications | Submit without journalist explicit trigger, modify article content |

**How is authority granted — and by whom? Can it be escalated at runtime?**
Authority is defined at system configuration time by the system designer and journalist together. Agents receive capability tokens at initialisation; they cannot request additional capabilities at runtime. There is no escalation path — an agent that needs a capability it does not have must surface this as an uncertainty (C3) and route to the journalist.

**What prevents an agent from claiming authority it was not granted?**
The tool layer is scoped at the infrastructure level — agents are instantiated with only the API connections their role requires. The Outreach Draft Agent has no email API connection. The Research Agent has no write access to the article workspace. These are not policy rules; they are missing connections.

**Are authority boundaries enforced by architecture, or only by policy?**
Architecture. No policy statement or prompt instruction is treated as a substitute for structural scoping.

**How do you audit whether agents operated within their structural authority?**
Every tool call is logged with agent ID, tool name, input parameters, and output. The audit log is queryable. A weekly automated report flags any tool calls that approached boundary conditions (e.g., a Research Agent that attempted a write operation that was rejected).

***

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
For any disputed claim — a source contesting a quote, an editor questioning a fact, a subject disputing their representation — the audit log can reconstruct exactly which agent produced which content, from which sources, at which time, and which human approved it. This provides the journalist with a defensible record without relying on memory.

***

### T5 — No Self-Judgment

**For every executor role, who is the structurally separate verifier?**

| Executor | Verifier |
|---|---|
| Research Agent | Fact-Check Agent |
| Outreach Draft Agent | Journalist (mandatory human review) |
| Article Draft (journalist) | Editorial Review Agent + Human Editor |
| Fact-Check Agent | Journalist sign-off on disputed items |
| Submission Prep Agent | Journalist explicit submission trigger |

**Are there any stages where a single actor currently both executes and verifies?**
In the initial design, the journalist was the sole actor in interview execution and note synthesis. This is acceptable for the interview itself (human-led, H3), but note synthesis — where the journalist writes up interview notes — requires a separate Editorial Review Agent check before those notes enter the research record. This separation is added to prevent the journalist's memory and interpretation biases from entering the verified record unchecked.

**Does this separation apply to human actors as well as agents?**
Yes. The journalist cannot self-certify their own article as ready for submission — the Editorial Review Agent and human editor constitute the separate verification layer for human-produced content.

**How is the verifier's independence maintained under time pressure?**
Verification steps are not skippable under deadline pressure. The system does not offer a "bypass verification" option. If a deadline cannot be met with verification complete, the journalist is notified in advance (at task initiation, the system estimates completion time including verification) so the deadline can be renegotiated — not the verification.

**What happens when the verifier is unavailable?**
If the Fact-Check Agent is unavailable, verification is queued — the article does not proceed to draft stage. The journalist is notified with an estimated resolution time. There is no fallback that removes verification; only a delay is permitted.

***

### T6 — Resilience Through Structure

**What are the single points of failure in this system — and how are they mitigated?**

| Single Point of Failure | Mitigation |
|---|---|
| Research Agent failure | Research brief can be completed manually by journalist using structured template; agent failure triggers notification with manual fallback instructions |
| Fact-Check Agent failure | Verification queue holds; no content proceeds; journalist notified with estimated resolution time |
| Source Manifest corruption | Version-controlled with hourly snapshots; corruption triggers rollback to last verified state |
| Journalist unavailable for approval | No agent action proceeds without approval; work queues and notifies on journalist return |

**If any one agent fails, what is the impact on systemic trust?**
Each agent is isolated — failure of the Research Agent does not affect the integrity of the Fact-Check Agent or the audit log. The system is designed so that partial operation (some agents available, some not) produces no false confidence: unavailable verification always results in a hold, never a pass.

**What failure modes have you explicitly designed for?**
Agent hallucination (source cited does not exist), agent overconfidence (claim marked verified without adequate evidence), deadline pressure bypassing verification, and agent scope creep (gradually expanding actions beyond declared role). Unaddressed: cascading failures if multiple agents fail simultaneously — this is a Phase 2 design consideration.

**How is resilience tested before deployment at scale?**
A single-article pilot (Q4 principle) runs the full workflow including deliberate failure injection: the Fact-Check Agent is taken offline mid-verification to confirm the hold behaviour, and a source is intentionally misattributed to confirm the Claim Map hash mismatch detection.

***

### T7 — Distributable Verification

**Does verification require a central trusted party?**
In the current design, the human editor is the final centralised verification authority for submission readiness. This is appropriate for a single-journalist system but creates a bottleneck at publication scale.

**How could quorum-based verification be applied?**
For high-stakes investigative pieces, a three-agent quorum verification is implemented: the Fact-Check Agent, a second independent Fact-Check Agent instance with a different knowledge base, and the Editorial Review Agent must all pass the Claim Map before the journalist is given the submission trigger. Agreement of two of three is sufficient; a three-way disagreement surfaces to the journalist and editor jointly.

**What qualifies a verifier to participate in the pool?**
For automated verifiers: demonstrated accuracy above 95% on a calibration set of known-correct and known-incorrect claims. For human verifiers: editorial credentials verified by the publication.

**How is consensus reached when verifiers disagree?**
Disagreements are surfaced to the journalist with a structured summary of each verifier's finding and reasoning. The journalist resolves the dispute with their own judgment and documents their reasoning in the Claim Map. The journalist's resolution is final and attributed to them in the audit log.

***

## Cluster 3 — Human-Agent Complementarity

### C1 — Deliberate Role Allocation

**For each workflow stage, which tasks are assigned to agents and which to humans — and why?**

| Stage | Agent Tasks | Human Tasks | Rationale |
|---|---|---|---|
| **Research** | Web search, source aggregation, claim extraction, citation formatting, gap flagging | Source evaluation and selection, angle decisions, significance judgment | Agents excel at scale and recall; significance and newsworthiness require human judgment |
| **Expert Outreach** | Candidate identification, credential verification, draft request text | Contact selection, request personalisation, interview conduct, relationship cultivation | Relationship is the journalist's professional asset; agents support logistics only |
| **Structuring** | Outline options, structural templates, argument flow analysis | Angle selection, structure decision, argument framing | The journalist's perspective is the article's value; structure serves the argument the journalist chooses |
| **Writing** | Style consistency flagging, factual claim identification, quote formatting | All first-draft writing, voice, perspective, transitions | Voice and perspective are the journalist's professional identity; agents do not generate prose |
| **Editing** | Grammar and style guide compliance, fact-check pass, structural coherence flags | Final tone and voice decisions, all substantive edits, cut decisions | Editing is a craft judgment; agents surface issues but do not resolve them |
| **Submission** | Formatting to spec, metadata tagging, submission package prep | Review and approval of package, submission trigger, editor relationship | Submission is a professional act with relationship consequences; the journalist owns it |

**Are any human tasks currently being assigned to agents by default?**
In the initial design review, article outlining was incorrectly framed as an agent task. This has been reclassified: the agent offers structural options *after* the journalist has proposed an approach, not before. The journalist's thinking leads; the agent responds.

***

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

**Are these mode assignments made before deployment?**
Yes. The mode table above is reviewed and signed off by the journalist at system onboarding. Changes require a documented design review, not a runtime request.

**How are out-of-bounds actions detected, recorded, and escalated?**
Any tool call attempted by an agent outside its declared mode is rejected at the infrastructure level, logged as a boundary violation with full context, and surfaced to the system administrator. The journalist is notified of any boundary violation affecting their project.

***

### C3 — Uncertainty Surfaces Immediately

**What conditions should cause any actor to halt work and surface uncertainty?**
- Research Agent: conflicting authoritative sources on a factual claim; source recency concern on time-sensitive facts; inability to verify a claim to primary source level
- Fact-Check Agent: claim that cannot be verified or falsified with available sources; source that appears credible but cannot be independently corroborated
- Outreach Draft Agent: expert candidate with undisclosed conflicts of interest; contact information that may be outdated or incorrect
- Editorial Review Agent: voice inconsistency that may indicate the article has departed from the journalist's authentic style; structural incoherence that would require substantive journalist intervention

**How does the system route surfaced uncertainty to the appropriate decision-maker?**
Each uncertainty is classified at surface time: factual uncertainties route to the journalist with the Research Agent's evidence summary; editorial uncertainties route to the journalist with specific flagged passages; structural uncertainties route to the journalist with alternative options. No uncertainty is automatically resolved by another agent.

**Is surfacing uncertainty treated as correct behaviour?**
Explicitly. The system displays a "Research integrity maintained" notification each time an uncertainty is surfaced and resolved — framing it as a quality signal, not a failure. Journalists who never receive uncertainty surfaces are flagged for review, as this may indicate the Research Agent is operating on too-simple topics or suppressing flags.

**What is the expected response time when uncertainty is surfaced?**
The journalist is given a response time SLA at task initiation based on deadline. Unresolved uncertainties that breach the SLA generate an escalation notification. Work does not proceed on unresolved uncertainties; the task is held, not abandoned.

***

### C4 — Structural Ethics

**Which ethical constraints are enforced by architecture — structurally impossible to violate?**
- No communication sent to any third party without journalist explicit review and send action
- No article submitted without a complete, hash-verified Claim Map
- No source contact information shared with any external system or party
- No agent can access, read, or process the journalist's personal communications outside the system
- No draft content generated without an explicit journalist trigger

**Which constraints are currently only policy-based — and what is the plan to make them structural?**
The constraint against agents proposing story angles without being asked is currently policy (a prompt instruction), not structural. Phase 2 makes this structural by requiring an explicit "generate angle options" trigger from the journalist before the system can produce angle suggestions — the capability is disabled by default.

**Under what pressure conditions might declarative ethics fail?**
Deadline pressure is the primary risk. A journalist under pressure might be tempted to approve a verification pass they have not read, or to send an agent-drafted outreach message without personalisation. The structural response is: verification approval requires the journalist to confirm they have read the verification report (not just click approve); outreach messages have a mandatory 60-second review window before the send button activates.

**Who is responsible for maintaining and updating structural ethical constraints as the system evolves?**
A named system steward (initially the journalist or their editorial organisation) reviews structural constraints quarterly against any new agent capabilities added. No new agent capability is deployed without a C4 review that asks: "What is now structurally impossible that should be?" and "Does this capability require a new structural constraint?"

***

## Cluster 4 — Growth and Learning

### G1 — Scaffold, Don't Substitute

**At what point does the system do something for the human that they cannot yet do alone?**
Source aggregation at scale (searching hundreds of sources in minutes), citation formatting, style guide compliance checking, and structural coherence analysis are tasks the agent performs that the journalist either cannot do at speed or finds cognitively costly in ways that drain capacity for higher-value work. These are the legitimate scaffold zones.

**How does the system deliberately withdraw support as capability grows?**
Three scaffolding tiers are defined at onboarding:
- *Tier 1 (Onboarding):* Agent shows full source selection reasoning; offers three structural options with explanations; highlights style guide violations with rule references
- *Tier 2 (Developing):* Agent surfaces source reasoning only on request; offers one structural suggestion rather than three; flags style violations without rule references
- *Tier 3 (Proficient):* Agent confirms source list without explanation unless the journalist asks; structural input only on explicit request; style check as a final pass, not ongoing

Tier progression is triggered by demonstrated capability in quarterly check-ins, not by time elapsed.

**Are there tasks where scaffolding is never appropriate?**
The interview itself, the story angle decision, the choice of voice and perspective, and the editorial relationship. These are permanently human-led regardless of capability tier.

***

### G2 — Learning Is Always Happening

**What learning opportunities exist in each workflow stage?**
- *Research:* Each Research Agent source selection is a teachable moment — "why this source, not that one?" is surfaced as an optional learning prompt
- *Expert outreach:* After each interview, the system prompts a structured debrief: what worked, what the journalist would ask differently, what new questions emerged
- *Structuring:* When the journalist selects a structural option, the system notes what made that structure appropriate for this story type — building a transferable structural vocabulary
- *Editing:* Each style flag resolved by the journalist becomes a pattern entry — "you consistently address this issue by doing X; would you like this added to your style guide?"
- *Submission:* Editor feedback is captured and connected back to specific structural or editorial choices in the article, creating a feedback loop that links decision to outcome

**How is growth treated as a by-product of doing — not a separate "training" activity?**
No learning mode exists. All of the above is integrated into the standard workflow as optional depth layers — the journalist can engage or skip, and the system tracks engagement without requiring it.

***

### G3 — Make the Invisible Visible

**What patterns, assumptions, and blind spots can the system surface?**
- Source diversity patterns: "In your last 10 articles, 80% of your sources have been from academic institutions. Your coverage of industry practitioners is thin."
- Structural habits: "You consistently open with an anecdote. Your editors have accepted this structure in 9 of 10 pieces."
- Interview patterns: "Questions beginning with 'how' generate longer, more usable quotes than questions beginning with 'do you think'."
- Topic depth patterns: "Your research briefs on technology topics have significantly lower source diversity than your pieces on policy topics."

**How are self-awareness outputs delivered in a way that is empowering rather than surveilling?**
All pattern reports are framed as observations, not evaluations. They are delivered monthly in a "Your journalism patterns" digest that the journalist can dismiss, explore, or discuss with their editor. No pattern data is shared with the publication without the journalist's explicit consent.

**Who owns the insights generated about the journalist?**
The journalist. All pattern data is stored in their personal workspace, is exportable in full, and is deleted from the system on their request. The publication has no access to this data.

***

### G4 — Contribution Has a Record

**How are the journalist's decisions, judgments, and contributions captured and attributed to them?**
Every journalist decision in the system — source selected, angle chosen, structural decision made, fact verified by judgment — is logged with the journalist's ID, timestamp, and decision context. The journalist's Claim Map for each article is a permanent record of their editorial judgment, distinguishable from agent-generated content.

**Is the record portable?**
Yes. The journalist can export their full contribution record at any time in structured JSON and human-readable PDF. The record is theirs; it does not belong to the platform or the publication.

**How does the record build the journalist's reputation and trust over time?**
Over time, the journalist accumulates a verified editorial track record: articles published, sources used and validated, interview relationships maintained, and fact-check pass rates. This record can be shared (at the journalist's discretion) with new publications as a credential — a structured, verifiable history of editorial practice.

***

### G5 — Knowledge Compounds

**What patterns from past outcomes are being crystallised?**
- Reliable experts by topic area (response rate, interview quality, accuracy of statements)
- Source types that consistently produce high-quality, verifiable claims by topic domain
- Article structures that have been accepted by this publication vs. rejected
- Research gaps that recurred across multiple articles on similar topics — indicating a structural knowledge gap to address

**How is knowledge validated before it is encoded as a pattern?**
A minimum of three data points is required before a pattern is encoded. The journalist reviews and approves each new pattern entry before it influences future recommendations. Patterns are marked with their data basis ("based on 5 interviews with this source type") so the journalist can assess their reliability.

**How does the system prevent outdated or incorrect patterns from compounding harm?**
All patterns have a recency weight that decays over 18 months. Patterns older than 24 months without corroboration are surfaced to the journalist for validation or removal. A pattern that has been contradicted by a recent outcome (e.g., a previously reliable source who provided inaccurate information) is flagged immediately and marked as requiring review.

***

## Cluster 5 — Quality and Performance

### Q1 — Expand, Never Collapse

**How does each interaction increase the journalist's options?**
The Research Agent always surfaces at least three different source perspectives on contested topics. The Outreach Agent provides multiple expert candidates, not a single recommendation. Structural options are presented as a range, with the tradeoffs of each noted. The system never presents a single "best" answer to an editorial judgment question.

**Where does the system risk narrowing options?**
The greatest risk is in the pattern library (G5) — if past successful angles are over-weighted in suggestions, the journalist's work may gradually converge on a narrow range. A "divergence prompt" is built into every angle suggestion: "Here are two approaches that differ from your recent patterns — one more investigative, one more feature-led."

**How do you guard against the system's own biases narrowing the option space?**
The Research Agent is audited quarterly for source diversity across political perspective, institutional type, geographic origin, and demographic representation of sources cited. Bias alerts are generated when any dimension falls below a threshold and surfaced to the journalist and system steward.

***

### Q2 — Progressive Disclosure

**How is complexity layered?**
Research briefs have three display levels: Summary (key claims and sources, one page), Standard (full source manifest with confidence tiers), and Deep (full research trail including rejected sources and reasoning). The journalist selects their level at brief request time. The default is Standard.

**How does the system know what level of detail is right for this human at this moment?**
The journalist's tier (G1 scaffolding tier) informs the default: Tier 1 journalists default to Standard with in-line explanations; Tier 3 journalists default to Summary. The journalist always overrides.

***

### Q3 — Cognitive Diversity by Design

**What range of perspectives is brought to complex problems?**
For investigative articles, the Research Agent is required to produce a "counterargument brief" — a structured summary of the strongest case against the article's implied thesis, with supporting sources. This is delivered to the journalist before drafting, not after. For controversial topics, a second Research Agent instance with a different search strategy is run in parallel to surface sources the primary instance missed.

**Which problem types require mandatory multi-perspective review?**
Political, legal, medical, and social justice topics trigger mandatory multi-perspective review. The journalist cannot proceed to drafting until the counterargument brief has been reviewed and their response to it documented.

**How is dissent captured and considered?**
During the editorial review stage, the Editorial Review Agent specifically flags claims where the article presents one perspective as established without adequately representing contested alternatives. The journalist must address each flag — either by adding nuance or by documenting why the flag does not apply to this article's scope.

***

### Q4 — Validate Before Scale

**What lightweight prototype will validate core assumptions?**
A single pilot article is commissioned before system deployment. The pilot tests:
1. Whether the Research Agent produces briefs the journalist finds genuinely useful (not just comprehensive)
2. Whether the Fact-Check Agent catches errors in a seeded test set (three deliberate errors planted in a research brief)
3. Whether the Claim Map hash verification detects a deliberate post-hoc modification
4. Whether the journalist feels their voice is preserved in an article written with system support vs. without

**What are the specific hypotheses being tested?**
- H1: The journalist assesses the system as amplifying their capability, not replacing it, after the pilot article
- H2: The Research Agent's source briefs are used as a starting point, with the journalist adding, removing, or annotating at least 20% of entries
- H3: The Claim Map hash verification successfully detects the deliberate modification in the test set
- H4: The pilot article passes editorial review at the same or higher rate than the journalist's previous three articles

**What would a validation failure look like — and what would you do?**
If the journalist assesses the system as replacing rather than amplifying (H1 failure), the scaffolding design is revised before proceeding — specifically, any stage where the agent acts before the journalist has had a chance to produce their own work first. If the hash verification fails to detect the deliberate modification (H3 failure), the submission pipeline is redesigned before deployment.

***

### Q5 — Problem Precedes Solution

**Has the problem been clearly defined and validated before agent design began?**
Yes. The problem was stated as: *"A journalist spends disproportionate time on research logistics, source formatting, and administrative workflow — time that reduces the cognitive space available for original thinking, source relationship-building, and high-quality writing."* This problem statement was validated through the design process by examining which stages benefit from agent support (logistics, scale, verification) and which are degraded by it (voice, judgment, relationships).

**What would solving the wrong problem perfectly look like in this context?**
A system that maximises research volume, structural coherence, and submission throughput — but produces articles that editors describe as "competent but generic" and sources find impersonal. This is the most dangerous failure mode: the system succeeds on every internal metric while failing the journalist's actual professional goal.

**How will the problem definition be revisited as the system reveals new information?**
After the pilot article and at each quarterly review, the journalist and system steward revisit the original problem statement and ask: "Is this still the right problem? What has the system revealed that we didn't know at the start?" The design document is a living record — updated after each review.

***

### Q6 — Lifecycle Efficiency

**How is efficiency measured across the full lifecycle?**
Efficiency is measured from story ideation to published article, not within individual stages. The target metric is: *time from angle decision to editor-accepted draft*, not *time for research agent to produce a brief*. Stage-level speed that creates downstream rework (e.g., fast research that produces unreliable sources requiring re-research) is classified as a lifecycle inefficiency, not a gain.

**Where is early cognitive investment being treated as waste?**
The most common lifecycle inefficiency in journalism is pursuing the wrong angle for three-quarters of the research and writing process before discovering the story doesn't hold. The system's Q5 enforcement (problem definition before solution) and the counterargument brief (Q3) are specifically designed to surface this failure early — when it costs a brief revision, not a full article rewrite.

**Which stages currently optimise locally in ways that create downstream inefficiency?**
Rapid source aggregation (fast at the research stage) can create slow fact-checking (many low-confidence sources require more verification time). The Research Agent is calibrated to prioritise source quality over source volume — measured by the ratio of sources retained after journalist review vs. discarded.

***

## The Master Test

*Applied at every design decision, feature, and agent behaviour in this system.*

| Test | Question | Answer |
|---|---|---|
| **System Test** | Can this be verified, attributed, and audited? | Yes. Every agent action is logged, attributed, and timestamped. Every output is accompanied by a Claim Map. Every human decision is captured in the contribution record. The hash-verified Claim Map links article content to its evidence chain. |
| **Human Test** | Does this leave the journalist more capable, more aware, and more connected than before? | By design, yes — when the system is operating correctly. Scaffolding tiers deliberately withdraw support as capability grows (G1). Pattern reports surface invisible habits (G3). The counterargument brief develops editorial judgment (Q3). Human relationship stages are structurally protected from agent absorption (H4, C1). |
| **If either answer is no — what must change?** | If auditability fails: the Claim Map and logging infrastructure must be redesigned before deployment. If the journalist is less capable after six months: the scaffolding tiers are recalibrated, and any feature that has created dependency is removed or made opt-in. Neither failure is acceptable; neither triggers a patch — both trigger a design review. |

***

## Open Design Questions for Phase 2

The following challenges were identified through this design process and are deferred to Phase 2:

1. **H4 at scale:** How does the system actively strengthen journalist-to-source relationships over time, rather than merely not degrading them? A "relationship cultivation layer" that reminds the journalist of source history and suggests follow-up connection points (without initiating contact) is a candidate feature.
2. **T7 for solo journalists:** Distributable verification assumes a pool of verifiers. For a solo freelance journalist without a publication's fact-checking infrastructure, a peer verification network (other journalists) or a publication-provided verification service is needed.
3. **C2 mode drift:** Preventing agent-recommended actions from becoming de facto autonomous over time requires an active audit signal — a monthly review of which recommended actions the journalist approved without reading, flagged as a governance concern.
4. **Q3 AI diversity:** Ensuring the Research Agent and its parallel instance are genuinely cognitively diverse (different training, different search strategies) rather than superficially different requires infrastructure investment not available in Phase 1.
5. **Voice preservation measurement:** No reliable automated metric for "voice consistency" currently exists. Phase 2 must either develop one or rely on editor assessment, which introduces subjectivity into a structural verification requirement.