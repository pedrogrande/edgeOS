# Pipeline Stage 2: Specialist Agent Roster

## Design Decision: The Human-in-the-Loop Architecture

Stage 2 is fundamentally different from Stage 1. In Stage 1, all agents ran in parallel across 50 submissions — the human wasn't in the loop until Stage 2. In Stage 2, the human IS the loop. Every subtask either produces structured decision inputs FOR the human, or processes human decisions AFTER the fact. The design principle remains:

> **The agent prepares judgment; the human makes judgment.**

But in Stage 2, this principle is operationalised per-student, sequentially, 50 times. The human never waits for an agent — all agent outputs are either pre-computed (Briefing Composer, C1 Assessor, Communication Assessor) or triggered instantly (Consistency Checker, Feedback Drafter, Record Assembler).

---

## Decomposition Decision

Stage 2 contains 9 subtasks. Of these, 3 are **human-only** (Score C2, Score C3, Review & Approve Feedback) — they have no agent component because the complementarity analysis showed human-led assignment (Ethical Judgment H:9/A:2, Values Alignment H:8/A:2, Double-Loop Learning H:8/A:3). These subtasks work directly with Stage 1 evidence; no new agent is needed.

The remaining 6 subtasks have agent components that warrant specialist agents. I've also added the **Briefing Composer** — a meta-agent that synthesises all Stage 1 outputs into a human-readable document. This agent doesn't exist in the original subtask list but is essential for Stage 2: without it, the human would need to read 7 separate Stage 1 outputs per student, which defeats the purpose of pre-processing.

**Final roster: 7 specialist agents + 3 human-only subtasks.**

---

## Execution Dependency Graph (per student)

```
WAVE 0 ── Briefing Composer (agent)
              │
              │  [Briefing Document]
              │
WAVE 1 ── Human reads briefing + original submission
              │  → forms Holistic Impression [HIR]
              │
WAVE 2 ── C1 Assessor ──┐ (parallel)
              │           │
              │           ├── [C1 First-Pass Assessment]
              │           │
              └─ Communication Assessor ──┐
                                            │
                                            ├── [C4 Pre-Assessment]
                                            │
WAVE 3 ── Human scores C1 ──→ [C1 final score]
              │
WAVE 4 ── Human scores C2 ──→ [C2 final score]
              │               (with Synthesis Scout evidence)
              │
WAVE 5 ── Human scores C3 ──→ [C3 final score]
              │               (with Reflection Auditor evidence)
              │
WAVE 6 ── Human scores C4 ──→ [C4 final score]
              │               (with Communication Assessor evidence)
              │
WAVE 7 ── Consistency Checker (agent)
              │
              │  [Consistency Report]
              │
WAVE 8 ── Human reviews consistency flags ──→ [Approved scores]
              │
WAVE 9 ── Feedback Drafter (agent)
              │
              │  [Feedback Draft]
              │
WAVE 10 ─ Human reviews & approves feedback ──→ [Approved feedback]
              │
WAVE 11 ─ Record Assembler (agent)
              │
              │  [Final Student Record]
              │
              ▼
         NEXT STUDENT
```

---

## The Roster

| Wave | Subtask | Agent Title | Definition of Done | Tools Required | Context Required | Skills Required | Proof of Done |
|------|---------|-------------|-------------------|----------------|-----------------|----------------|---------------|
| **0** | 2.1 — Compose human-readable briefing from Stage 1 outputs | **Briefing Composer** | A structured briefing document exists that surfaces the most relevant information for each rubric criterion, highlights anomalies and compliance issues at a glance, and presents evidence in the order the human will encounter it during scoring. No new analysis — faithful synthesis of Stage 1 outputs only. | Structured output writer, template engine, PDF viewer (for original submission reference) | All Stage 1 outputs for this student: [Compliance Report], [Deck Map], [Claims Register], [Synthesis Evidence Report], [Reflection Audit], [Anomaly Register]. [CP] rubric-to-question mapping and grade band boundaries. Assignment brief question text. Original submission file reference | Context management (6/6), Handling ambiguous input (A:9), Zero-shot generalisation (A:8), Generation & creativity (A:7) | **[Briefing Document]** — single document containing: (1) One-paragraph quality signal summary, (2) Compliance status at a glance (pass/fail per rule, with slide references), (3) Question-by-question evidence summary — for each question: key claims, sources cited, synthesis indicators, reflection depth, (4) Anomaly flags highlighted with severity, (5) Cross-references to original slide numbers for every claim. **Every assertion traceable to a Stage 1 source.** No fabricated content. No agent-authored judgments — only evidence presentation. |
| **2** | 2.2 — Produce first-pass C1 score with evidence citations | **C1 Assessor** | A first-pass C1 assessment exists with a recommended grade band, evidence citations mapping each claim to a rubric boundary criterion, identified gaps (topics the rubric expects but the student didn't address), and confidence levels. Explicitly labelled "recommendation for human review" — not a final score. | Structured output writer | [CP] C1 boundary definitions — what "comprehensive" vs "effective" vs "basic" vs "limited" looks like in practice. [Claims Register] for this student (from Stage 1). [Briefing Document] for this student. Domain reference: Q1 definitions (immutability, decentralised consensus, scalability, mining), Q2 Taproot purpose/mechanism, Q3 price movements/causes, Q4 first-mover advantage | Reasoning & judgment (A:7), Output consistency (A:7), Handling ambiguous input (A:9), Zero-shot generalisation (A:8), **Hallucination resistance (A:4) — must cite Claims Register evidence, not fabricate** | **[C1 First-Pass Assessment]** — {recommended_band: HD|DI|CR|PA|NS, score_range: [low, high], evidence: [{claim_ref, slide_ref, boundary_criterion_met, confidence: high|medium|low}], gaps: [{topic, expected_but_missing, rubric_criterion}], human_override_flags: [{issue, reason, suggested_action}]}. Every score grounded in cited evidence from Claims Register. Low-confidence judgments explicitly flagged. Gaps identified (rubric topics the student didn't address). **CRITICAL: Does NOT assign a final score. Produces a recommendation with evidence. Human makes the score.** |
| **2** | 2.5 — Produce objective C4 assessment; flag subjective indicators for human | **Communication Assessor** | An objective C4 assessment exists covering format compliance, readability, and audience-appropriateness metrics. Subjective communication quality indicators (coherence, visual hierarchy, professional presentation) are explicitly flagged for human judgment — NOT scored by the agent. | Text extractor, readability scoring tools, structured output writer | [CP] C4 boundary definitions. [Compliance Report] for this student (from Format Sentinel). [Deck Map] for this student (from Deck Cartographer). Assignment brief audience definition ("manager with limited reading time"). Original submission file | Handling ambiguous input (A:9), Output consistency (A:7), Context management (A:6), Zero-shot generalisation (A:8) | **[C4 Pre-Assessment]** — {objective_elements: {slide_count_compliant: bool, slide_limit_violations: [{question, slide_count, limit}], sources_present_per_question: {Q1: bool, Q2: bool, Q3: bool, Q4: bool, Q5: bool}, question_labels_present: bool, market_data_datetime_present: bool, visual_hierarchy_indicators: {has_title_slide: bool, has_section_headers: bool, uses_bullet_points: bool, text_density_per_slide: [numbers]}}, readability_metrics: {avg_sentence_length, jargon_terms_used: [terms], jargon_terms_explained: [terms], plain_language_instances: [{text, slide_ref}]}, audience_indicators: {technical_terms_without_explanation: [{term, slide_ref}], concepts_with_analogies: [{concept, analogy, slide_ref}]}, subjective_for_human: {coherence: "requires human judgment — does the deck tell a coherent story?", visual_design: "requires human judgment — is the visual design professional and appropriate?", audience_appropriateness: "requires human judgment — would a non-specialist manager understand this deck?"}}. **All objective elements measured. All subjective elements explicitly NOT measured — flagged for human.** |
| **7** | 2.6 — Flag internal contradictions across C1–C4 scores | **Consistency Checker** | A consistency report exists that identifies any contradictions between criterion scores, between scores and evidence, or between scores and compliance status. Every flag is traceable to specific scores and evidence. | Structured output writer, rule engine | [CP] grade band definitions and their expected relationships (e.g., C1 and C2 should be within 2 grade bands of each other). [C1–C4 final scores] for this student. [Briefing Document] holistic impression summary. [Compliance Report] for this student. [C1 First-Pass Assessment] (if human's score differs from agent's recommendation, that's a flag) | Output consistency (A:7), Error containment (A:4), Context management (A:6), Reasoning & judgment (A:7) | **[Consistency Report]** — {score_set: {C1: final, C2: final, C3: final, C4: final, total: final}, flags: [{flag_type: score_evidence_mismatch|cross_criterion_anomaly|compliance_penalty_not_reflected|total_out_of_range|human_agent_divergence, description, evidence_ref, severity: critical|warning|info, suggested_resolution}]}. Common flag examples: C1=HD + C2=PA (possible but unusual — strong technical info with no synthesis), compliance violations not reflected in C4, total score inconsistent with grade band, human's C1 score differs significantly from C1 Assessor's recommendation without documented reason. **Every flag traceable to specific scores and evidence. No false certainty — flags are prompts for human review, not verdicts.** |
| **9** | 2.7 — Draft per-criterion feedback using rubric language + evidence | **Feedback Drafter** | A draft feedback document exists per criterion that uses verbatim rubric language, cites specific evidence from the submission, identifies one strength and one improvement area per criterion, and passes a tone check (constructive, specific, actionable). Explicitly labelled "draft for human review and personalisation." | Structured output writer, template engine | [CP] rubric language per grade band (verbatim descriptor text for each HD/DI/CR/PA/NS level per criterion). [C1–C4 final approved scores] (post-consistency-check, post-human-review). [Evidence citations] from C1 Assessor, Synthesis Scout, Reflection Auditor, Communication Assessor. [Briefing Document] for context. [Consistency Report] for any flags that need to be reflected in feedback | Generation & creativity (A:7), Semantic & social skill (A:7), Output consistency (A:7), Context management (A:6), Handling ambiguous input (A:9) | **[Feedback Draft]** — {per_criterion: {C1: {grade_band_achieved: "DI", rubric_language_used: "effectively reported technical information with some gaps in application", strength: {text: "Your explanation of decentralised consensus on slide 3 was clear and accurate", evidence_ref: "Claims Register claim #3, slide 3"}, improvement: {text: "The application of blockchain scalability to real-world scenarios was not addressed — the rubric expects application, not just reporting", evidence_ref: "Claims Register gap #1"}}, C2: {...}, C3: {...}, C4: {...}}, overall_comment: {text: "A solid submission that demonstrates good technical understanding. To improve, focus on connecting ideas across sources and applying concepts to real-world contexts."}, tone_check: {constructive: true, specific: true, actionable: true, vague_praise_count: 0, vague_criticism_count: 0}}. **Every strength and improvement linked to specific evidence. Rubric language used verbatim. Zero vague phrases. Explicitly labelled "draft for human review."** |
| **11** | 2.9 — Assemble complete student record | **Record Assembler** | A complete, consistent student record exists with all final scores, approved feedback, compliance status, anomaly flags, and full evidence traceability. No missing fields. No inconsistencies between scores, feedback, and compliance status. | Structured output writer | [C1–C4 final approved scores]. [Approved feedback]. [Compliance Report]. [Anomaly Register entry]. [Consistency Report — all flags resolved]. Student ID and marking timestamp. Human approver ID | Output consistency (A:7), Error containment (A:4), Skill preservation (A:8) | **[Final Student Record]** — {student_id, timestamp, human_approver_id, scores: {C1: final, C2: final, C3: final, C4: final, total: final, grade_band: final}, feedback: {approved: true, approved_by: human_id, approved_at: timestamp}, compliance: {violations: [{rule, slide_ref, penalty_applied: bool}], penalties_reflected_in_C4: true}, anomaly_flags: [{flag, source_agent, resolution, resolved_by: human_id}], evidence_trace: {C1: [claim_refs_from_Claims_Register], C2: [synthesis_refs_from_Synthesis_Scout], C3: [reflection_refs_from_Reflection_Auditor], C4: [communication_refs_from_Communication_Assessor]}}. **Every field populated. Every score traceable to evidence. Every anomaly resolved. Human approver ID on every section.** |

---

## Human-Only Subtasks (No Specialist Agent)

These subtasks are human-led because their critical complementarity properties (Ethical Judgment, Values Alignment, Decision Authority, Double-Loop Learning) have gaps of 5–7 points where human capability far exceeds agent capability.

| Wave | Subtask | Human Role | Evidence Sources | Why No Agent |
|------|---------|-----------|-----------------|--------------|
| **4** | 2.3 — Score C2 (Synthesis & Audience Translation, 30pts) | **Human judgment** on whether student *synthesised* vs *extracted*, whether translation was *insightful* vs *reasonably insightful* | [Briefing Document] Synthesis Evidence Report section, [CP] C2 boundary definitions, original submission | Values alignment gap: H:8/A:2 (6 points). Creative problem framing gap: H:9/A:4 (5 points). The judgment of what constitutes "synthesis" vs "extraction" is a values-laden, creative act that the agent cannot make. The Synthesis Scout surfaces evidence; the human makes the judgment. |
| **5** | 2.4 — Score C3 (AI Critical Evaluation, 20pts) | **Human judgment** on whether the student's AI reflection was *critical* vs *comprehensive*, whether AI usage was *transparent* vs *reasonably transparent*, whether there was ethical honesty | [Briefing Document] Reflection Audit section, [CP] C3 boundary definitions, original submission Q5 | Ethical judgment gap: H:9/A:2 (7 points). Double-loop learning gap: H:8/A:3 (5 points). Evaluating whether a student *critically* examined their AI use (vs merely *comprehensively* described it) is a meta-circular judgment that requires evaluating double-loop learning, which the agent cannot perform. |
| **10** | 2.8 — Review & approve feedback | **Human judgment** on tone, fairness, values alignment, and whether feedback will land constructively for this specific student | [Feedback Draft] from Feedback Drafter, original submission for context | Ethical judgment gap: H:9/A:2 (7 points). Values alignment gap: H:8/A:2 (6 points). Reversibility awareness gap: H:8/A:5 (3 points). Feedback is a social act with consequences for the student. The agent can draft; only the human can approve. |

---

## Agent Specifications Summary

| Wave | Agent | Cognitive Operation | Produces Score? | Boundary Principle |
|------|-------|--------------------|----------------|--------------------|
| 0 | **Briefing Composer** | Synthesis & presentation | No | Faithful representation only — no new analysis, no agent judgments |
| 2 | **C1 Assessor** | Domain-semantic scoring | **Yes (recommendation)** | Produces a recommendation with evidence; human makes the final score. Explicitly labelled "for human review." |
| 2 | **Communication Assessor** | Objective measurement + subjective flagging | **No (objective metrics only)** | Measures what's measurable; flags what's subjective for human. Never scores subjective quality. |
| 7 | **Consistency Checker** | Cross-referencing & flagging | No | Flags anomalies and contradictions for human review. Does not adjudicate — that's the human's role. |
| 9 | **Feedback Drafter** | Generation & personalisation | No | Drafts feedback from rubric language + evidence; human approves. Never finalises. |
| 11 | **Record Assembler** | Data assembly | No | Aggregates approved data. No judgment — pure assembly with error-checking. |

---

## Critical Design Notes

### On the Briefing Composer's Faithfulness Constraint

The Briefing Composer is a **meta-agent** — it synthesises Stage 1 outputs without adding new analysis. This is a deliberate constraint: the Briefing Composer must NOT:
- Produce its own assessment of submission quality (that's the human's job in 2.1)
- Score or rank anything (that's the scoring agents' job)
- Make judgments about synthesis depth (that's the human's job for C2)
- Make judgments about reflection criticality (that's the human's job for C3)

Its sole purpose is to **reduce the human's cognitive load** by presenting all relevant evidence in the order the human will need it, with the most important signals highlighted. If the Briefing Composer adds its own judgments, it creates a new source of bias that the human must override, negating its value.

### On the C1 Assessor's Scoring Boundary

The C1 Assessor is the **first agent in the entire pipeline that produces a score**. This is a significant boundary. All Stage 1 agents produced evidence, not scores. The C1 Assessor crosses from evidence-surfacing into judgment-preparation. The critical constraint is:

- **Produces**: A recommended grade band with evidence citations and confidence levels
- **Does NOT produce**: A final score
- **Explicitly labels**: "Recommendation for human review — not a final score"

This boundary exists because the complementarity gap for C1 scoring is narrow (Reasoning & Judgment: H:9/A:7, only 2 points). The agent's recommendation is useful — it saves the human from building the score from scratch — but the human must verify and adjust because the agent's judgment is not reliable enough to be final.

### On the Communication Assessor's Objective/Subjective Split

The Communication Assessor has a **hard boundary** between what it measures and what it flags:
- **Measures**: Slide count, source presence, question labels, market data datetime, text density, bullet point usage, jargon frequency, readability scores
- **Flags for human**: Coherence ("does the deck tell a coherent story?"), visual design ("is it professional?"), audience appropriateness ("would a non-specialist manager understand this?")

This split exists because the complementarity gap for subjective communication quality (Semantic & Social Skill: H:9/A:7, only 2 points) is too narrow to trust the agent's judgment, but the objective elements (Output Consistency: A:7 vs H:5) benefit enormously from the agent's consistency across 50 submissions. The agent applies the same objective standards to every student; the human applies the same subjective standards.

### On the Consistency Checker's Non-Adjudication Principle

The Consistency Checker **flags but never adjudicates**. It produces a list of potential contradictions with severity levels and suggested resolutions, but it does not resolve them. This is because:
- Context management (H:6/A:6) is equal — neither human nor agent has a clear advantage
- But Reasoning & Judgment (H:9/A:7) gives the human the edge on interpreting whether a "contradiction" is actually a valid score pattern

A C1=HD / C2=PA pattern might look like a contradiction, but it could represent a student with excellent technical information who completely failed to synthesise. The Consistency Checker surfaces this pattern; the human decides whether it's valid.

### On the Feedback Drafter's Anti-Vagueness Constraint

The Feedback Drafter operates under a strict **anti-vagueness constraint**:
- Every strength must cite specific evidence from the submission
- Every improvement must cite a specific rubric criterion not met
- Rubric language must be used verbatim
- Vague phrases ("good work", "needs improvement", "well done") are prohibited
- The tone check must pass: constructive=true, specific=true, actionable=true

This constraint exists because the complementarity gap for ethical judgment (H:9/A:2, 7 points) and values alignment (H:8/A:2, 6 points) in feedback is enormous. The agent can generate text (Generation & Creativity: A:7), but it cannot ensure the feedback is fair, values-aligned, or appropriately toned for a specific student. The anti-vagueness constraint forces the agent to ground every statement in evidence, making the human's review task faster and more reliable.

### On the Record Assembler's Error-Containment Role

The Record Assembler's primary value is not assembly — it's **error containment** (A:4). It cross-checks that:
- Scores add up correctly
- Feedback matches the scores (no C1=HD with C1 feedback saying "basic")
- Compliance penalties are reflected in C4
- Every score has at least one evidence reference
- No anomalies are unresolved

This is a mechanical but critical verification step. A single transcription error here (Skill Preservation: A:8) could change a student's grade. The agent's consistency advantage (A:7 vs H:5) makes it better suited for this verification than a fatigued human who has just marked 50 submissions.The Stage 2 roster is complete. The key architectural shift from Stage 1: every agent in Stage 2 operates within a **judgment preparation boundary** — it produces structured decision inputs for the human, never final judgments. The three human-only subtasks (C2 scoring, C3 scoring, feedback approval) exist because the complementarity gaps are too large to bridge even with collaborative design: Values Alignment (H:8/A:2), Ethical Judgment (H:9/A:2), and Double-Loop Learning (H:8/A:3) cannot be approximated by an agent.

The 12-wave per-student structure means the human moves through a clean, sequential decision flow where every agent output is already waiting. No agent wait time. No mechanical work. Every minute of human attention goes to judgment.