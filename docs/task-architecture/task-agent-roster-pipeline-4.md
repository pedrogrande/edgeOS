# Pipeline Stage 4: Specialist Agent Roster

## Design Decision: Three-Track Architecture

Stage 4 is architecturally different from Stages 1–3. Those stages had a single linear flow — every agent was within one sequence. Stage 4 has **three parallel tracks** that serve different purposes and operate on different timelines:

- **Track A: Grade Finalisation** — gated on Stage 3 human decisions completing
- **Track B: Deliverable Production** — can start immediately after Stage 3 agent outputs
- **Track C: On-Demand Integrity** — event-driven, triggered when needed

This is the first stage where work proceeds concurrently across independent tracks. The orchestration layer must handle this.

---

## Execution Dependency Graph

```
STAGE 3 COMPLETE
    │
    ├─── [CDR] [DAR] [CCR] [Per-Student Flag Summaries] ── available immediately
    │
    ├─── TRACK B: Deliverable Production ────────────────── can start NOW
    │         │
    │    WAVE B1: Cohort Pattern Analyst ──┐ (parallel)
    │    WAVE B1: Rubric Analyst ──────────┘
    │         │
    │         │  [Cohort Pattern Report]
    │         │  [Rubric Difficulty Report]
    │         │
    │    WAVE B2: Human frames insights + interprets rubric data
    │         │
    │         │  [Human Insight Notes]
    │         │  [Human Rubric Reflection Notes]
    │         │
    │    WAVE B3: Cohort Feedback Drafter ──┐ (parallel)
    │    WAVE B3: Rubric Memo Drafter ────────┘
    │         │
    │         │  [Cohort Feedback Draft]
    │         │  [Rubric Performance Memo Draft]
    │         │
    │    WAVE B4: Human approves cohort feedback + rubric memo
    │         │
    │         ▼
    │    [Approved Cohort Feedback Document]
    │    [Approved Rubric Performance Memo]
    │
    │
    ├─── HUMAN: Completes Stage 3 decisions ───────────── gated input
    │         │  (borderline, drift, compliance)
    │         │
    │         │  [BDL] [Drift Decision] [Compliance Adjudication]
    │         │
    │    TRACK A: Grade Finalisation ────────────────────── starts NOW
    │         │
    │    WAVE A1: Grade Finaliser
    │         │
    │         │  [Final Grade Register]
    │         │
    │    WAVE A2: Human authorises grades
    │         │
    │         ▼
    │    [Authorised Grade Register] → LMS submission
    │
    │
    └─── TRACK C: On-Demand Integrity ─────────────────── triggered by event
              │
         WAVE C1: Integrity Briefing Agent  ← triggered by re-mark request
              │                                or integrity concern
              │  [Intelligence Briefing Pack]
              │
         WAVE C2: Human makes decision
              │
              ├── [No change] → no action
              └── [Grade change] → loops back to Grade Finaliser (A1)
```

---

## Decomposition Decision

The original Stage 4 had 4 subtasks. I've decomposed these into **6 specialist agents** and **6 human-only subtasks**. Key decomposition decisions:

1. **4.1 (Finalise grades)** → Grade Finaliser (Aggregator + Measurer hybrid). The grade computation is an aggregation task; the verification is a measurement task. I've combined them because they're tightly coupled — you verify what you just computed.

2. **4.2 (Prepare cohort-level feedback)** → Two agents: Cohort Pattern Analyst (Measurer) and Cohort Feedback Drafter (Generator). Pattern identification is a measurement task; feedback drafting is a generation task. These are genuinely different cognitive operations that should not be combined.

3. **4.3 (Handle re-mark/integrity)** → Integrity Briefing Agent (Extractor). The agent's role is to gather and present relevant evidence; the human makes the decision. This is similar to the Briefing Composer in Stage 2 — a meta-agent that selects and synthesises relevant data for a specific purpose.

4. **4.4 (Reflect on rubric performance)** → Two agents: Rubric Analyst (Measurer) and Rubric Memo Drafter (Generator). The analysis is measurement; the memo is generation. The Rubric Memo Drafter is a separate Generator because it has a different audience (course coordinator), different tone (analytical, not constructive), and different structure (data-driven recommendations) than the Cohort Feedback Drafter.

---

## The Roster

| Wave | Subtask | Agent Title | Definition of Done | Tools Required | Context Required | Skills Required | Proof of Done |
|------|---------|-------------|-------------------|----------------|-----------------|----------------|---------------|
| **A1** | 4.1 — Compute final grades and verify correctness | **Grade Finaliser** | A complete, verified grade register exists for all 50 students. Every grade is computed correctly from criterion scores. Every grade band assignment is consistent with CP boundaries. Every adjustment from Stage 3 decisions is reflected. No transcription or calculation errors. | Structured output writer, calculation engine, cross-reference validator | [FSR ×50] from Stage 2 with all Stage 3 adjustments applied (BDL, Drift Decision, Compliance Adjudication). [CP] grade band boundary definitions and total score → grade conversion rules. [BDL] — borderline decisions that may have changed grade bands. [Drift Decision] — any score adjustments from drift correction. [Compliance Adjudication] — any changes from edge case resolution | Output consistency (A:7), Error containment (A:4), Parallelisation & scale (A:9), Skill preservation (A:8) | **[FGR] Final Grade Register** — {register_id, generation_timestamp, students: [{student_id, C1: final, C2: final, C3: final, C4: final, total: final, grade_band: final, adjustments_applied: [{source: "BDL"|"drift"|"compliance", criterion, original_score, adjusted_score, adjustment_reason, authorised_by: human_id}]}, ...], verification: {all_students_present: bool, total_count: 50, grades_sum_correct: bool, grade_bands_consistent_with_CP: bool, all_adjustments_reflected: bool, cross_check_hash: str}, pending_authorisation: true}. **Every grade is the product of approved scores + authorised adjustments. Verification checks are explicitly recorded. Register is NOT final until human authorises.** |
| **B1** | 4.2a — Identify cohort-level patterns across all submissions | **Cohort Pattern Analyst** | A pattern report exists that identifies common strengths, common weaknesses, per-question difficulty, per-criterion distributions, compliance patterns, and notable outliers — presented as data without teaching recommendations. | Statistical computation tools, text pattern analysis, cross-referencing tools, structured output writer | [FSR ×50] — all Final Student Records. [CDR] — Cohort Distribution Report. [DAR] — Drift Analysis Report. [CCR] — Compliance Consistency Report. [CP] rubric-to-question mapping and criteria definitions. Assignment brief question text and learning objectives | Parallelisation & scale (A:9), Handling ambiguous input (A:9), Output consistency (A:7), Cognitive bias resistance (A:6) | **[CPR] Cohort Pattern Report** — {common_strengths: [{criterion, question, frequency: n, example_student_ids: [id, id, id], evidence_summary: str}], common_weaknesses: [{criterion, question, frequency: n, example_student_ids: [id, id, id], evidence_summary: str}], per_question_difficulty: [{question, mean_score, std_dev, grade_distribution, most_common_error_type: str, frequency_of_error: n}], per_criterion_patterns: [{criterion, mean, std_dev, correlation_with_other_criteria: [{criterion, r_value}]}, compliance_patterns: {most_common_violation: {rule, frequency, affected_student_count}, least_common_violation: {rule, frequency, affected_student_count}}, notable_outliers: [{student_id, criterion, deviation_from_mean, potential_cause: str}], question_correlations: [{question_pair, correlation, interpretation_note: "data only — human to interpret"}]}. **No teaching recommendations. No "students struggled with X." Only "X had a mean score of Y with Z% of students scoring below PA." Data, not interpretation.** |
| **B1** | 4.4a — Analyse rubric difficulty and discrimination | **Rubric Analyst** | A rubric difficulty report exists showing per-criterion difficulty, discrimination indices, rubric language ambiguity indicators, and unexpected score patterns — presented as data without recommendations. | Statistical computation tools, text analysis, cross-referencing tools, structured output writer | [FSR ×50]. [CDR]. [CP] rubric language per grade band per criterion. [DAR] — drift data (to distinguish rubric difficulty from marker drift). [CCR] — compliance data (to distinguish rubric difficulty from compliance penalties). Assignment brief and rubric | Output consistency (A:7), Handling ambiguous input (A:9), Cognitive bias resistance (A:6), Context management (A:6) | **[RDR] Rubric Difficulty Report** — {per_criterion_difficulty: {C1: {mean_score_as_pct, median_score_as_pct, score_range, grade_distribution: {HD: n, DI: n, CR: n, PA: n, NS: n}, floor_effect: bool, ceiling_effect: bool, difficulty_label: "easy"|"moderate"|"hard"}, C2: {...}, C3: {...}, C4: {...}}, discrimination_indices: {C1: {discrimination_index: float, interpretation_note: "data only — higher values indicate the criterion better distinguishes between high and low performing students"}, C2: {...}, C3: {...}, C4: {...}}, rubric_language_analysis: {C1: {grade_bands_with_ambiguous_descriptors: [{grade_band, descriptor_text, ambiguity_flag: "overlapping_language_with_adjacent_band"|"subjective_term"|"undefined_threshold"}], potential_boundary_issues: [{boundary, grade_band_above_count, grade_band_below_count, proximity: "tight_clustering"|"spread"}]}, C2: {...}, C3: {...}, C4: {...}}, unexpected_patterns: [{pattern_description: str, affected_criterion, affected_students: n, statistical_evidence: str, note: "data only — human to interpret cause"}]}. **No recommendations. No "this rubric criterion is too hard." Only "C3 had a mean score of 58% with 62% of students scoring PA or below." Data, not interpretation.** |
| **B3** | 4.2b — Draft cohort-level feedback document | **Cohort Feedback Drafter** | A draft cohort feedback document exists that synthesises patterns into constructive, actionable teaching insights — explicitly labelled "draft for human review and framing." Uses data from the Cohort Pattern Report but reframes it for the student audience. | Structured output writer, template engine, text validator | [CPR] — Cohort Pattern Report. [Human Insight Notes] — the human's interpretation of the patterns. [CP] rubric language and learning objectives. Assignment brief. [FSR ×50] — for specific examples when needed | Generation & creativity (A:7), Semantic & social skill (A:7), Output consistency (A:7), Context management (A:6) | **[CFDoc Draft] Cohort Feedback Document Draft** — {document_structure: {common_strengths_section: {text: str, data_sources: [CPR_refs]}, common_areas_for_improvement: {text: str, data_sources: [CPR_refs]}, per_question_insights: [{question, text: str, data_sources: [CPR_refs]}], general_advice_for_future_cohorts: {text: str, data_sources: [CPR_refs]}}, tone_check: {constructive: bool, specific: bool, data_grounded: bool, vague_phrases_count: int}, draft_label: "DRAFT — FOR HUMAN REVIEW AND FRAMING", data_traceability: {every_claim_linked_to_CPR_data: bool}}. **Every claim linked to a CPR data point. No vague encouragement ("well done cohort") without specific data. Draft labelled for human review.** |
| **B3** | 4.4b — Draft rubric performance memo | **Rubric Memo Drafter** | A draft rubric performance memo exists that documents rubric difficulty, discrimination, and language ambiguity findings — for the course coordinator. Explicitly labelled "draft for human review." | Structured output writer, template engine, text validator | [RDR] — Rubric Difficulty Report. [Human Rubric Reflection Notes] — the human's reflections and recommendations. [CP] rubric language (for quoting in the memo). [DAR] — to distinguish rubric difficulty from drift. [CCR] — to distinguish rubric difficulty from compliance enforcement | Generation & creativity (A:7), Output consistency (A:7), Context management (A:6), Handling ambiguous input (A:9) | **[RPM Draft] Rubric Performance Memo Draft** — {executive_summary: {text: str, data_sources: [RDR_refs]}, per_criterion_findings: {C1: {difficulty_summary: str, discrimination_summary: str, language_ambiguity_flags: [{descriptor, issue, suggested_alternative: "human to determine"}], data_sources: [RDR_refs]}, C2: {...}, C3: {...}, C4: {...}}, cross_criterion_observations: [{observation: str, data_sources: [RDR_refs], note: "data-driven observation — human to interpret"}], draft_label: "DRAFT — FOR HUMAN REVIEW", audience_note: "This document is for the course coordinator, not for students", tone_check: {analytical: bool, evidence_grounded: bool, no_prescriptive_recommendations: bool}}. **Every claim linked to an RDR data point. No prescriptive recommendations ("change this descriptor") — the human decides. Suggested alternatives are offered as possibilities, not directives.** |
| **C1** | 4.3 — Gather evidence for re-mark requests and integrity concerns | **Integrity Briefing Agent** | A briefing pack exists that selects and presents all data relevant to the specific concern (re-mark request or integrity flag), with evidence cross-references and contextual data — without making any judgment about the case. | Data retrieval tools, structured output writer, cross-reference engine | [FSR] for the specific student. [Stage 1 outputs] for this student (Compliance Report, Deck Map, Claims Register, Synthesis Evidence Report, Reflection Audit, Anomaly Register). [CDR] — for distribution context (where this student sits relative to the cohort). [DAR] — for drift context (was this student affected by drift?). [CCR] — for compliance context (were penalties applied consistently?). [BDL] — for borderline context (was this a borderline decision?). [CP] rubric language and grade band boundaries. Concern type and description (from the re-mark request or integrity flag) | Context management (A:6), Handling ambiguous input (A:9), Output consistency (A:7) | **[IBP] Intelligence Briefing Pack** — {concern_type: "re_mark_request"|"integrity_concern"|"academic_integrity_flag", student_id: str, concern_description: str, student_record: {scores: {C1, C2, C3, C4, total, grade_band}, feedback_summary: str, compliance_status: {...}, anomaly_flags: [...]}, contextual_data: {cohort_position: {percentile_rank, distance_from_mean_per_criterion: {C1, C2, C3, C4}}, drift_impact: {student_affected: bool, estimated_impact_points, drift_direction, source: "DAR"}, compliance_consistency: {student_treatment_consistent_with_cohort: bool, relevant_ccr_flags: [...]}, borderline_status: {was_borderline: bool, bdl_entry: {...} or null}}, relevant_evidence: {for_concerned_criterion: [{evidence_ref, source_agent, slide_ref, detail, relevance_note: "potentially relevant to this concern"}], for_adjacent_criteria: [{...}]}, comparison_students: {if_re_mark: [{criterion, this_student_score, comparable_student_scores: [{student_id, score, similarity_note}], note: "data only — human to determine if treatment was equitable"}]}, agent_note: "This briefing presents all available data relevant to the stated concern. No judgment is made about the validity of the concern or the appropriate resolution. All decisions are the human's responsibility."}. **No judgment about the validity of the concern. No recommendation about whether to grant a re-mark or pursue an integrity case. All data is presented; the human decides.** |

---

## Human-Only Subtasks

| Wave | Subtask | Human Role | Evidence Sources | Why No Agent |
|------|---------|-----------|-----------------|--------------|
| **A2** | 4.1b — Authorise final grades | **Human authorises** the Final Grade Register. Verifies that grade bands are defensible. Checks a sample of students for accuracy. Signs off as the grade authority. | [FGR] from Grade Finaliser. Spot-check against [FSR ×50] and [CP] | Decision authority gap: H:9/A:2 (7 points). Reversibility awareness gap: H:8/A:5 (3 points). The human must own the grade register — this is the final authoritative record. |
| **B2** | 4.2c — Frame cohort-level insights | **Human interprets** the Cohort Pattern Report and frames teaching insights. What do these patterns mean for instruction? What should students focus on? What worked well this cohort? | [CPR] from Cohort Pattern Analyst. [DAR] for drift context. [CCR] for compliance context | Double-loop learning gap: H:8/A:3 (5 points). Creative problem framing gap: H:9/A:4 (5 points). The "so what" question — what do these patterns mean for teaching? — requires creative, values-laden interpretation. |
| **B2** | 4.4c — Reflect on rubric and recommend improvements | **Human reflects** on rubric difficulty, discrimination, and language. What should change? What worked? What was ambiguous? | [RDR] from Rubric Analyst. [DAR] for drift-rubric interaction. [CCR] for compliance-rubric interaction | Double-loop learning gap: H:8/A:3 (5 points). Creative problem framing gap: H:9/A:4 (5 points). Rubric improvement is a meta-assessment that requires questioning the assessment framework itself. |
| **B4** | 4.2d — Approve cohort feedback | **Human approves** the Cohort Feedback Document. Checks tone, fairness, accuracy, and whether the human's insight framing is represented correctly. | [CFDoc Draft] from Cohort Feedback Drafter. [Human Insight Notes] for comparison | Values alignment gap: H:8/A:2 (6 points). Reversibility awareness gap: H:8/A:5 (3 points). Cohort feedback goes to all students — it must be fair, accurate, and appropriately toned. |
| **B4** | 4.4d — Approve rubric memo | **Human approves** the Rubric Performance Memo. Checks that data is represented accurately and that the human's reflections are captured faithfully. | [RPM Draft] from Rubric Memo Drafter. [Human Rubric Reflection Notes] for comparison | Values alignment gap: H:8/A:2 (6 points). The memo informs the course coordinator's decisions about rubric changes — it must be accurate and the human must own the recommendations. |
| **C2** | 4.3b — Make re-mark/integrity decision | **Human decides** whether to grant a re-mark, pursue an integrity case, or take no action. Documents the decision with rationale. | [IBP] from Integrity Briefing Agent. Original submission if needed | Ethical judgment gap: H:9/A:2 (7 points). Values alignment gap: H:8/A:2 (6 points). Decision authority gap: H:9/A:2 (7 points). Manipulation resistance gap: H:6/A:4 (2 points). These are the most consequential decisions in the pipeline — they affect individual students directly and have institutional implications. |

---

## Agent Specifications Summary

| Track | Wave | Agent | Class | Cognitive Operation | Produces Judgment? | Boundary Principle |
|-------|------|-------|-------|--------------------|--------------------|-------------------|
| A | A1 | **Grade Finaliser** | Aggregator + Measurer | Computation + verification | No — computes and verifies; human authorises | Never decide — compute and verify only. Every calculation is double-checked. No grade is final without human authorisation. |
| B | B1 | **Cohort Pattern Analyst** | Measurer | Pattern identification across 50 submissions | No — presents data, not teaching recommendations | Never recommend — identify patterns only. "X had mean Y" not "students struggled with X." |
| B | B1 | **Rubric Analyst** | Measurer | Rubric difficulty and discrimination analysis | No — presents data, not rubric change recommendations | Never recommend changes — measure difficulty only. "C3 mean was 58%" not "C3 should be easier." |
| B | B3 | **Cohort Feedback Drafter** | Generator | Drafting constructive, data-grounded feedback for the cohort | No — drafts for human framing and approval | Never be vague — every claim linked to CPR data. No encouragement without evidence. |
| B | B3 | **Rubric Memo Drafter** | Generator | Drafting analytical memo for course coordinator | No — drafts for human reflection and approval | Never prescribe — suggest possibilities, not directives. "Consider revising" not "change this descriptor." |
| C | C1 | **Integrity Briefing Agent** | Extractor | Selective evidence gathering for a specific concern | No — presents evidence, never judges validity | Never judge the concern — gather and present evidence only. The human decides. |

---

## Critical Design Notes

### On the Three-Track Architecture

Stage 4 is the first stage where work proceeds in parallel tracks. This creates new orchestration requirements:

- **Track B can start before Track A** — the Cohort Pattern Analyst and Rubric Analyst only need Stage 3 agent outputs (CDR, DAR, CCR), not Stage 3 human decisions. This means deliverable production can begin while the human is still making borderline and drift decisions.

- **Track C is event-driven** — the Integrity Briefing Agent doesn't run on a schedule. It's triggered when a re-mark request arrives or an integrity concern is raised. This means the orchestration layer must support event-driven agent activation, not just wave-based activation.

- **Track C can loop back to Track A** — if the human grants a re-mark that changes a grade, the Grade Finaliser must re-run (at least for the affected student). This creates a feedback loop: C1 → C2 → (if grade change) → A1 → A2.

### On the Grade Finaliser's Verification Role

The Grade Finaliser is the last computation step before the human authorises grades. Its verification checks are the **final error barrier** between the pipeline and the LMS. A single calculation error at this point (e.g., C1=22 + C2=18 + C3=14 + C4=13 = 67 recorded as 76) would directly harm a student. The Grade Finaliser's verification section includes:

- **Sum verification**: C1 + C2 + C3 + C4 = total
- **Grade band consistency**: total maps to the correct grade band per CP
- **Adjustment reflection**: all Stage 3 adjustments are applied
- **Count verification**: exactly 50 students in the register
- **Cross-check hash**: a deterministic hash of all scores for audit trail integrity

This level of verification is not paranoia — it's error containment. The Grade Finaliser's failure mode (a single calculation error) has catastrophic impact for the individual student affected.

### On the Cohort Pattern Analyst vs. the Rubric Analyst

These two Measurers operate in parallel (Wave B1) but serve different audiences and produce different outputs:

| Dimension | Cohort Pattern Analyst | Rubric Analyst |
|-----------|----------------------|----------------|
| **Question** | "What did the cohort do?" | "How did the rubric perform?" |
| **Audience** | Students (via cohort feedback) | Course coordinator (via rubric memo) |
| **Unit of analysis** | Students | Criteria |
| **Pattern type** | Performance patterns | Assessment instrument patterns |
| **Followed by** | Cohort Feedback Drafter (Generator) | Rubric Memo Drafter (Generator) |

Keeping them separate prevents the Cohort Pattern Analyst from being contaminated by rubric evaluation concerns, and vice versa. A student performance pattern ("60% scored PA on C3") is a different finding from a rubric difficulty pattern ("C3 had a floor effect with 62% scoring PA or below") — even though they describe the same data. The first frames it as a student outcome; the second frames it as an instrument outcome. The human decides which framing is appropriate for which audience.

### On the Integrity Briefing Agent as a Selective Extractor

The Integrity Briefing Agent is different from the other Extractors in the pipeline. Stage 1 Extractors (Deck Cartographer, Claims Analyst, etc.) extract ALL relevant information from ALL submissions. The Integrity Briefing Agent extracts SELECTIVELY — only the data relevant to a specific concern about a specific student.

This requires a different extraction strategy:
- A re-mark request about C2 needs: the student's C2 evidence, comparable students' C2 scores, C2 borderline flags, C2 drift impact
- An integrity concern about AI-generated content needs: the student's C3 reflection, the Reflection Audit's depth classification, anomaly flags, the student's Claims Register for pattern analysis
- A compliance dispute needs: the student's Compliance Report, the CCR for consistency verification, comparable students' treatment

The Integrity Briefing Agent must understand the **nature of the concern** to select the right evidence. This is a contextual extraction task — not a brute-force scan. It's the Extractor class operating with a query filter, not a full-spectrum sweep.

### On the Two Generators' Different Constraints

Stage 4 has two Generator agents. Their constraints differ based on their audiences:

| Constraint | Cohort Feedback Drafter | Rubric Memo Drafter |
|-----------|----------------------|-------------------|
| **Audience** | Students (the whole cohort) | Course coordinator |
| **Tone** | Constructive, encouraging, specific | Analytical, evidence-grounded, precise |
| **Anti-vagueness** | Zero vague encouragement ("well done") without data | Zero prescriptive recommendations ("change this") without evidence |
| **Data source** | [CPR] + [Human Insight Notes] | [RDR] + [Human Rubric Reflection Notes] |
| **Failure mode** | Ungrounded encouragement | Prescriptive overreach (recommending instead of suggesting) |
| **Label** | "DRAFT — FOR HUMAN REVIEW AND FRAMING" | "DRAFT — FOR HUMAN REVIEW" |
| **Key constraint** | Every claim linked to CPR data | Every suggestion offered as a possibility, not a directive |

The Rubric Memo Drafter has a subtler constraint than the Cohort Feedback Drafter. "Consider revising the C3 descriptor to reduce ambiguity" is a **suggestion** (acceptable). "The C3 descriptor should be revised to reduce ambiguity" is a **recommendation** (unacceptable — the course coordinator decides). The distinction between suggesting and recommending is the boundary principle for this agent.

---

## Human Time Budget for Stage 4

| Step | Human Role | Estimated Time | Notes |
|------|-----------|----------------|-------|
| **A2** | Authorise final grades | 15–20 min | Spot-check ~5-10 students, verify grade bands, sign off |
| **B2** | Frame cohort insights | 20–30 min | Interpret CPR, decide what to tell students, draft insight notes |
| **B2** | Reflect on rubric | 15–25 min | Interpret RDR, consider rubric improvements, draft reflection notes |
| **B4** | Approve cohort feedback | 10–15 min | Review CFDoc draft for accuracy, tone, and insight representation |
| **B4** | Approve rubric memo | 5–10 min | Review RPM draft for accuracy and reflection representation |
| **C2** | Integrity/re-mark decisions | 15–30 min per case | Variable — depends on complexity and number of cases |
| **Total (excl. Track C)** | | **~65–100 min** | vs. estimated 2-3 hours fully manual |

---

## Updated Full Pipeline Roster

| Stage | Agents | Human-Only Subtasks | Total Subtasks |
|-------|--------|---------------------|---------------|
| **0** | 0 | 1 (Calibration) | 1 |
| **1** | 7 | 0 | 7 |
| **2** | 6 | 3 | 9 |
| **3** | 4 | 3 | 7 |
| **4** | 6 | 6 | 12 |
| **TOTAL** | **23** | **13** | **36** |The full pipeline is now complete — **23 agents across 4 stages, with 13 human-only subtasks**. 

Stage 4 introduced three genuinely new architectural patterns that didn't appear in Stages 1–3:

1. **Parallel tracks** — Track B (deliverable production) can start before Track A (grade finalisation) because its agents don't need human decisions from Stage 3. This maximises human attention efficiency by letting agents work while the human is still deciding borderline cases.

2. **Event-driven activation** — The Integrity Briefing Agent doesn't run on a schedule. It's triggered by external events (re-mark requests, integrity flags). This is a fundamentally different orchestration model from the wave-based execution in Stages 1–3.

3. **Feedback loops** — If an integrity decision changes a grade, the Grade Finaliser re-runs. The pipeline is not purely linear — it has cycles for correction.

These patterns scale. Any workflow that has post-hoc corrections (re-marks, appeals, audit findings) will need event-driven tracks and feedback loops. Any workflow with independent deliverables (student feedback vs. rubric memo vs. grade register) will benefit from parallel tracks that decouple production timelines.

The full pipeline totals tell the story: **23 agents preparing judgment, 13 human moments making judgment, 36 subtasks in total.** Every agent's boundary principle constrains its most likely failure mode. Every human-only subtask sits where the complementarity gap is 6+ points on ethical judgment, values alignment, or decision authority.