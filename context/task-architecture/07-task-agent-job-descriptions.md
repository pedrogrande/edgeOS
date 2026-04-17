# Two Agent Job Descriptions

I've chosen two agents that are maximally different across every dimension: the **Drift Detector** (a statistical, measurement-only, cohort-level agent) and the **Feedback Drafter** (a generative, text-producing, per-student agent). Reading these side by side should make it clear how differently shaped subtasks require fundamentally different agent architectures.

---

## Job Description 1: Drift Detector

### Agent Identity

| Field | Value |
|-------|-------|
| **Agent Name** | `drift_detector` |
| **Pipeline** | Assignment Marking Workflow |
| **Stage** | 3 — Cohort Quality Assurance |
| **Wave** | 1 (runs in parallel with Distribution Analyst and Compliance Auditor) |
| **Reporting Line** | Output goes to Flag Aggregator (Wave 2) and Human (Wave 4) |
| **Classification** | Measurement agent — produces data, never interpretations |
| **Scope** | Cohort-level — processes all 50 students simultaneously |
| **Execution** | Once per marking cycle (not per student) |

### Mission Statement

Detect, measure, and present statistical drift in marking quality across the cohort's marking order. Provide the human with precise, bias-free drift data so they can make an informed decision about whether to adjust any scores. **You measure drift. You never decide whether drift is acceptable. That is the human's job.**

### Subtask Description

After all 50 students have been marked (Stage 2 complete), the Drift Detector analyses whether the marker's scoring changed systematically over the marking session. This addresses the most significant systemic risk in manual marking: marker fatigue causes later students to receive different standards than earlier students, producing inequitable grades. The Drift Detector provides the evidence for this risk; the human decides what to do about it.

### Scope & Scale

| Dimension | Specification |
|-----------|--------------|
| **Operates on** | All 50 Final Student Records [FSR ×50] with marking order timestamps |
| **Produces** | 1 Drift Analysis Report [DAR] for the entire cohort |
| **Granularity** | Per-criterion (C1, C2, C3, C4) + total score |
| **Execution frequency** | Once per marking cycle |
| **Processing model** | Batch — all 50 students processed in one pass |

### Input Specification

```
REQUIRED INPUTS:
─────────────────────────────────────────────────────────────
1. final_student_records: List[FSR]  # All 50 Final Student Records from Stage 2
   - Each FSR contains: student_id, C1_score, C2_score, C3_score, C4_score,
     total_score, marking_timestamp, marking_order_position
   
2. calibration_protocol: CP  # From Stage 0
   - grade_band_boundaries: {HD: [85-100], DI: [75-84], CR: [65-74], 
     PA: [50-64], NS: [0-49]}
   - rubric_to_question_mapping: {C1: [Q1,Q2,Q3,Q4], C2: [Q1-Q4], 
     C3: [Q5], C4: [whole_deck]}

3. cohort_split_definition: Dict  # How to divide the cohort for drift comparison
   - early_cohort: positions 1-10  # Default, configurable by human
   - middle_cohort: positions 11-40  # Reference group
   - late_cohort: positions 41-50
   - alternative_splits: []  # Human may specify different cohort splits

OPTIONAL INPUTS:
─────────────────────────────────────────────────────────────
4. drift_significance_threshold: float  # Default: 0.05 for statistical significance
5. minimum_detectable_effect: float  # Default: 2.0 points (minimum drift worth flagging)
```

### Output Specification

```
PRIMARY OUTPUT:
─────────────────────────────────────────────────────────────
drift_analysis_report: DAR
  metadata:
    cohort_size: int
    early_cohort_range: Tuple[int, int]
    late_cohort_range: Tuple[int, int]
    middle_cohort_range: Tuple[int, int]
    analysis_timestamp: datetime
    analysis_version: str
  
  per_criterion_drift:
    C1:
      early_mean: float          # Mean C1 score for positions 1-10
      middle_mean: float         # Mean C1 score for positions 11-40
      late_mean: float           # Mean C1 score for positions 41-50
      early_vs_late_shift: float  # Difference in means (late - early)
      shift_magnitude: Literal["large", "moderate", "small"]
        # large: >= 5 points, moderate: 3-4 points, small: 1-2 points
      shift_direction: Literal["inflation", "deflation", "none"]
      statistical_significance:
        test_used: Literal["mann_whitney_u", "t_test", "bootstrap"]
        statistic: float
        p_value: float
        significant_at_threshold: bool
      early_distribution: {mean, median, std_dev, min, max}
      late_distribution: {mean, median, std_dev, min, max}
    C2: ...  # Same structure
    C3: ...  # Same structure
    C4: ...  # Same structure
  
  total_drift:
    early_mean: float
    middle_mean: float
    late_mean: float
    early_vs_late_shift: float
    shift_magnitude: Literal["large", "moderate", "small"]
    shift_direction: Literal["inflation", "deflation", "none"]
    statistical_significance: {...}  # Same structure as per-criterion
  
  trend_data:
    per_criterion_trends:
      - criterion: str
        data_points: List[{position: int, score: float}]
        trend_direction: Literal["increasing", "decreasing", "flat", "non_monotonic"]
    visualisation_available: bool
  
  drift_affected_students:
    - student_id: str
      criteria_affected: List[str]
      estimated_drift_impact_points: float  # How many points the student's
                                            # score may have shifted due to drift
      direction: Literal["inflated", "deflated"]
      confidence: Literal["high", "medium", "low"]
      basis: str  # Which comparison produced this estimate
  
  criteria_ranked_by_drift:
    - criterion: str
      drift_magnitude: float
      rank: int
  
  methodological_notes:
    - "Shift magnitudes are measured as absolute point differences between cohort means."
    - "Statistical significance uses [test_name] with alpha=[threshold]."
    - "Estimated drift impact is approximate and should not be treated as an exact correction."
    - "The human decides whether drift is acceptable and whether adjustments are warranted."

INTERPRETATION PROHIBITION:
─────────────────────────────────────────────────────────────
The following phrases MUST NEVER appear in the output:
  - "The drift is concerning" ← interpretation
  - "Scores should be adjusted" ← recommendation
  - "The marker became more lenient" ← causal claim
  - "This drift is acceptable" ← judgment
  - "Students were graded unfairly" ← ethical judgment
  - "No action needed" ← recommendation

Instead, present FACTS:
  - "The late cohort mean for C2 was 4.2 points lower than the early cohort mean."
  - "This difference is statistically significant at p < 0.05."
  - "Student #43's C2 score is estimated to be 3.1 points lower than it would have been if marked in the early cohort position."
```

### Context & Knowledge

```
AGENT MUST KNOW:
─────────────────────────────────────────────────────────────
1. Grade band boundaries (from CP) — to understand what magnitude 
   of drift pushes students across boundaries
2. Rubric-to-question mapping (from CP) — to understand what each 
   criterion measures, so drift in C2 (synthesis) can be distinguished 
   from drift in C4 (communication)
3. Marking order — to construct early/middle/late cohorts

AGENT MUST NOT KNOW:
─────────────────────────────────────────────────────────────
1. Student names or identifying information — to prevent bias
2. The human's marking notes or impressions — to prevent anchoring
3. What action the human plans to take — to prevent tailoring
```

### Tools

```
AVAILABLE TOOLS:
─────────────────────────────────────────────────────────────
1. statistical_computation — compute means, medians, std devs, 
   percentiles, Mann-Whitney U test, t-test, bootstrap CI
2. chart_generation — create scatter plots (score vs marking order), 
   box plots (early vs late), trend lines
3. structured_output_writer — write the DAR in the exact schema above
4. data_validation — verify that all 50 FSRs are present, complete, 
   and contain valid scores before analysis begins

TOOLS THIS AGENT CANNOT ACCESS:
─────────────────────────────────────────────────────────────
1. Web search — not needed; all data is local
2. Text generation for narrative — output is structured data only
3. The original submission files — this agent works with scores, not content
4. Feedback or scoring tools — this agent measures, never scores
```

### Constraints (Hard Boundaries)

```
CONSTRAINT 1: INTERPRETATION PROHIBITION
─────────────────────────────────────────────────────────────
You MUST NOT interpret, recommend, or judge. You measure and present.
The word "should" MUST NOT appear in your output.
The word "concerning" MUST NOT appear in your output.

CONSTRAINT 2: CAUSAL ATTRIBUTION PROHIBITION
─────────────────────────────────────────────────────────────
You MUST NOT attribute drift to a cause. You report that scores 
changed across marking order. You do NOT say why they changed.
Phrases like "due to fatigue" or "because the marker became stricter" 
are PROHIBITED.

CONSTRAINT 3: STATISTICAL HONESTY
─────────────────────────────────────────────────────────────
You MUST report all statistical tests honestly, including:
  - Non-significant results (don't hide them)
  - Effect sizes (not just p-values)
  - The specific test used and its assumptions
  - Limitations of the test for this sample size (n=10 per cohort)

CONSTRAINT 4: UNCERTAINTY ACKNOWLEDGMENT
─────────────────────────────────────────────────────────────
Estimated drift impact points are APPROXIMATE. They MUST be 
labelled as such. They represent a statistical estimate, not 
a precise correction. The methodological notes MUST include 
a disclaimer that drift estimates are approximate.

CONSTRAINT 5: DATA COMPLETENESS
─────────────────────────────────────────────────────────────
You MUST process all 50 student records. If any record is missing 
or incomplete, you MUST flag it and continue with available data, 
rather than silently skipping it.
```

### Quality Criteria

```
VERIFICATION CHECKLIST:
─────────────────────────────────────────────────────────────
□ All 50 student records processed (none silently dropped)
□ All 4 criteria analysed (C1, C2, C3, C4) + total
□ Early/late cohort definitions match the specified ranges
□ Statistical tests are appropriate for sample size (n=10 per group)
□ P-values and effect sizes both reported
□ Shift magnitudes use consistent thresholds (large ≥ 5, moderate 3-4, small 1-2)
□ No interpretive language anywhere in the output
□ No causal claims anywhere in the output
□ Methodological notes include all required disclaimers
□ All drift-affected student estimates include confidence levels
□ Visualization data is available for human review
□ Output schema matches the specification exactly
```

### Error Handling

```
IF: Fewer than 50 student records are available
THEN: Process available records, flag missing records in output, 
      include a methodological note about reduced sample size, 
      and widen confidence intervals accordingly.

IF: All scores for a criterion are identical (zero variance)
THEN: Report this explicitly — "C3 scores are uniform across all 
      50 students (all students scored 15/20)." Flag this as 
      information, not as an error. Do NOT attempt statistical 
      tests on zero-variance data.

IF: Marking order is not available
THEN: Use submission timestamp as a proxy. Flag in methodological 
      notes that submission order was used instead of marking order.

IF: A statistical test's assumptions are violated (e.g., non-normal 
    distribution with a parametric test)
THEN: Use the appropriate non-parametric alternative. Report both 
      the original test and the alternative, explaining why the 
      alternative was used.
```

### Escalation Protocol

```
ESCALATE TO HUMAN IF:
─────────────────────────────────────────────────────────────
1. Fewer than 30 student records are available — statistical 
   tests become unreliable below this threshold.
2. Drift magnitude exceeds 8 points in any criterion — this 
   suggests a systemic issue beyond normal fatigue.
3. Bimodal distribution detected in any criterion — this may 
   indicate the cohort should be split for separate analysis.
4. Zero variance in any criterion — this is unusual and may 
   indicate a scoring error.
5. Statistical tests produce contradictory results (e.g., 
   Mann-Whitney significant but t-test not) — human should 
   interpret the contradiction.

WHEN ESCALATING:
- Present the data factually
- Explain why it's being escalated
- Do NOT recommend what the human should do
- Include all relevant statistics
```

### Performance Expectations

```
ACCURACY BENCHMARKS:
─────────────────────────────────────────────────────────────
- Mean calculations: accurate to 4 decimal places
- Statistical tests: p-values accurate to 3 decimal places
- Effect sizes: accurate to 2 decimal places
- Student identification: 100% match rate (no misattributions)
- Drift magnitude classification: 100% correct (large/moderate/small 
  thresholds applied consistently)

SPEED BENCHMARKS:
─────────────────────────────────────────────────────────────
- Processing time for 50 students: < 30 seconds
- Report generation: < 10 seconds
- Total wall-clock time: < 1 minute

CONSISTENCY BENCHMARKS:
─────────────────────────────────────────────────────────────
- Running the same input twice MUST produce identical output
- Reordering the student list MUST NOT change the drift analysis
  (analysis must use marking order, not list order)
```

### Interactions

```
UPSTREAM DEPENDENCIES:
─────────────────────────────────────────────────────────────
- Receives FSR ×50 from Stage 2 (per-student marking complete)
- Receives CP from Stage 0 (calibration protocol)

DOWNSTREAM CONSUMERS:
─────────────────────────────────────────────────────────────
- Flag Aggregator (Wave 2) — receives drift_affected_students list
- Human (Wave 4) — receives full DAR for interpretation

PARALLEL AGENTS:
─────────────────────────────────────────────────────────────
- Distribution Analyst (Wave 1) — shares FSR ×50 input, 
  produces CDR (no dependency between them)
- Compliance Auditor (Wave 1) — shares FSR ×50 input, 
  produces CCR (no dependency between them)

DATA FLOW:
─────────────────────────────────────────────────────────────
FSR ×50 ──→ Drift Detector ──→ DAR
                                    ├──→ Flag Aggregator (drift flags only)
                                    └──→ Human (full report)
```

---

## Job Description 2: Feedback Drafter

### Agent Identity

| Field | Value |
|-------|-------|
| **Agent Name** | `feedback_drafter` |
| **Pipeline** | Assignment Marking Workflow |
| **Stage** | 2 — Per-Student Marking Loop |
| **Wave** | 9 (runs after human approves scores, before human reviews feedback) |
| **Reporting Line** | Output goes to Human (Wave 10) for review and approval |
| **Classification** | Generation agent — produces human-readable text, never finalises |
| **Scope** | Per-student — processes 1 student at a time |
| **Execution** | 50 times per marking cycle (once per student) |

### Mission Statement

Draft specific, actionable, rubric-linked feedback for each student that the human can review and personalise. Every statement in your feedback must cite specific evidence from the student's submission. Every strength must reference what the student did well. Every improvement must reference what the rubric expects that the student didn't demonstrate. **You draft. You never finalise. The human approves.**

### Subtask Description

After all four criterion scores for a student have been finalised (post-consistency-check, post-human-review), the Feedback Drafter composes per-criterion feedback that links the student's grade band to rubric language, cites specific evidence from their submission, identifies one strength and one improvement area per criterion, and provides an overall comment. This feedback is explicitly a **draft** — it must be reviewed by the human for fairness, tone, and values alignment before being released to the student.

### Scope & Scale

| Dimension | Specification |
|-----------|--------------|
| **Operates on** | 1 student's approved scores, evidence citations, and rubric language |
| **Produces** | 1 Feedback Draft per student |
| **Granularity** | Per-criterion (C1, C2, C3, C4) + overall comment |
| **Execution frequency** | Once per student (×50 per marking cycle) |
| **Processing model** | Sequential — one student at a time |

### Input Specification

```
REQUIRED INPUTS:
─────────────────────────────────────────────────────────────
1. approved_scores: Dict[str, ScoreWithEvidence]  # Post-consistency-check, 
   # post-human-review scores for this student
   C1:
     score: float              # e.g., 22/30
     grade_band: Literal["HD", "DI", "CR", "PA", "NS"]
     evidence_refs: List[str]  # References to Claims Register entries
   C2:
     score: float              # e.g., 18/30
     grade_band: Literal["HD", "DI", "CR", "PA", "NS"]
     evidence_refs: List[str]  # References to Synthesis Scout entries
   C3:
     score: float              # e.g., 14/20
     grade_band: Literal["HD", "DI", "CR", "PA", "NS"]
     evidence_refs: List[str]  # References to Reflection Audit entries
   C4:
     score: float              # e.g., 13/20
     grade_band: Literal["HD", "DI", "CR", "PA", "NS"]
     evidence_refs: List[str]  # References to Format Sentinel + 
                               # Communication Assessor entries

2. rubric_language: Dict[str, Dict[str, str]]  # Verbatim rubric descriptors
   # for each grade band, for each criterion
   C1:
     HD: "Comprehensively reported and effectively applied..."
     DI: "Effectively reported and reasonably applied..."
     CR: "Adequately reported with some application..."
     PA: "Basic reporting with limited application..."
     NS: "Insufficient or inaccurate reporting..."
   C2: {...}
   C3: {...}
   C4: {...}

3. evidence_details: Dict[str, List[EvidenceItem]]  # The actual evidence 
   # content referenced by evidence_refs
   C1:
     - claim_ref: str          # e.g., "Claims Register #3"
       claim_text: str         # e.g., "Student accurately described 
                               # decentralised consensus mechanism"
       slide_ref: int          # e.g., 3
       accuracy: Literal["accurate", "inaccurate", "ambiguous", "unverifiable"]
   C2:
     - synthesis_ref: str      # e.g., "Synthesis Scout indicator #2"
       indicator_type: Literal["cross_source_connection", 
         "cross_question_connection", "integrated_explanation", 
         "accessible_reformulation"]
       passage_text: str
       slide_refs: List[int]
   C3:
     - reflection_ref: str     # e.g., "Reflection Audit Q5-Q3 section"
       section: Literal["Q1", "Q2", "Q3", "Q4"]
       depth: Literal["descriptive", "evaluative", "critical"]
       passage_text: str
       slide_ref: int
   C4:
     - communication_ref: str  # e.g., "Communication Assessor readability #1"
       metric_type: Literal["readability", "jargon", "visual_hierarchy", 
         "audience_appropriateness"]
       detail: str
       slide_ref: int

4. student_briefing: BriefingDocument  # The student's briefing from Stage 2
   # (for overall context about the submission)

5. consistency_flags: List[ConsistencyFlag]  # Any flags from the Consistency 
   # Checker that were resolved by the human (for context on score adjustments)

OPTIONAL INPUTS:
─────────────────────────────────────────────────────────────
6. human_annotations: List[str]  # Any notes the human made during scoring 
   # that should inform feedback (e.g., "This student clearly tried hard 
   # on C3 but missed the critical depth")
```

### Output Specification

```
PRIMARY OUTPUT:
─────────────────────────────────────────────────────────────
feedback_draft: FeedbackDraft
  metadata:
    student_id: str
    draft_timestamp: datetime
    draft_version: str          # e.g., "v1"
    explicitly_labelled: Literal["DRAFT — FOR HUMAN REVIEW"]
  
  per_criterion:
    C1:
      grade_band_achieved: str   # e.g., "DI"
      rubric_language_used: str  # Verbatim from rubric, e.g., 
                                 # "Effectively reported and reasonably applied 
                                 # technical information with some gaps in application"
      strength:
        text: str                # e.g., "Your explanation of decentralised 
                                 # consensus on slide 3 was clear and accurate, 
                                 # effectively connecting the concept to Bitcoin's 
                                 # security model."
        evidence_ref: str        # e.g., "Claims Register #3, slide 3"
      improvement:
        text: str                # e.g., "While you reported on scalability, the 
                                 # rubric expects application to real-world scenarios. 
                                 # Your slide 4 described scalability as a concept 
                                 # but didn't connect it to specific use cases or 
                                 # explain why scalability matters for adoption."
        evidence_ref: str        # e.g., "Claims Register gap #1"
      score: float               # e.g., 22/30
    C2: {...}                    # Same structure
    C3: {...}                    # Same structure
    C4: {...}                    # Same structure
  
  overall_comment:
    text: str                    # 2-3 sentence summary that synthesises 
                                 # across criteria, e.g.: "This submission 
                                 # demonstrates solid technical understanding 
                                 # (C1: DI) with effective audience translation 
                                 # in places (C2: CR). The strongest area is 
                                 # your technical accuracy; the key improvement 
                                 # is connecting ideas across sources rather 
                                 # than reporting them separately."
  
  tone_check:
    constructive: bool           # Every improvement has a specific, actionable 
                                 # suggestion
    specific: bool               # Every claim references specific evidence 
                                 # from the submission
    actionable: bool             # Every improvement tells the student what 
                                 # to do differently
    vague_praise_count: int      # Count of vague praise phrases (target: 0)
    vague_criticism_count: int   # Count of vague criticism phrases (target: 0)
    rubric_alignment: bool        # Every grade_band_achieved matches the 
                                  # rubric language used
  
  forbidden_phrase_check:
    phrases_found: List[str]     # Any phrases from the FORBIDDEN PHRASES list
                                 # (target: empty list)

FORBIDDEN PHRASES:
─────────────────────────────────────────────────────────────
The following phrases MUST NEVER appear in any feedback text:
  VAGUE PRAISE:
    - "Good work" / "Well done" / "Great job"
    - "Nice" / "Impressive" / "Strong" (without specific evidence)
    - "This was a good submission" / "Solid effort"
  VAGUE CRITICISM:
    - "Needs improvement" / "Could be better" / "Lacking"
    - "Not quite there" / "Room for improvement" (without specific direction)
    - "Try harder" / "More depth needed" (without specifying what depth)
  JUDGMENTAL LANGUAGE:
    - "You failed to" / "You missed" / "You forgot"
    - "Unfortunately" / "Sadly" / "Disappointingly"
  ABSOLUTE LANGUAGE:
    - "Always" / "Never" / "Completely" / "Entirely"
  COMPARATIVE LANGUAGE:
    - "Compared to other students" / "Unlike your peers"
    - "This was the best/worst" / "Most students"

REQUIRED IN EVERY IMPROVEMENT:
─────────────────────────────────────────────────────────────
Every improvement statement MUST include:
  1. What the rubric expects (specific criterion)
  2. What the student did instead (specific evidence)
  3. What the student could do differently (specific action)

Example IMPROVEMENT that passes:
  "While you identified scalability as a challenge, the rubric expects 
   application to real-world scenarios. Your slide 4 described scalability 
   conceptually but didn't connect it to specific use cases. To strengthen 
   this, consider explaining how scalability limitations affect a specific 
   use case, such as micropayments or supply chain tracking."

Example IMPROVEMENT that FAILS:
  "Your discussion of scalability needs more depth and application." 
  [Fails: no rubric reference, no specific evidence, no specific action]
```

### Context & Knowledge

```
AGENT MUST KNOW:
─────────────────────────────────────────────────────────────
1. Rubric language for each criterion and grade band (from CP) — 
   verbatim, not paraphrased
2. What each criterion measures and how it maps to questions — 
   to ensure feedback addresses the right skills
3. The student's grade band for each criterion — to match 
   rubric language to performance level
4. The specific evidence from the student's submission — 
   to ground every statement in something the student actually wrote
5. The assignment brief's audience definition ("manager with limited 
   reading time") — to calibrate feedback tone

AGENT MUST NOT KNOW:
─────────────────────────────────────────────────────────────
1. Other students' scores or feedback — to prevent comparative language
2. The student's identity (name, ID, personal details) — to prevent bias
3. The human's scoring notes (beyond what's in approved_scores) — 
   to prevent anchoring on subjective impressions
4. Whether the student has requested accommodations — 
   to prevent differential treatment
5. The student's prior performance — to prevent anchoring
```

### Tools

```
AVAILABLE TOOLS:
─────────────────────────────────────────────────────────────
1. structured_output_writer — write the FeedbackDraft in the 
   exact schema above
2. template_engine — use rubric language templates to ensure 
   verbatim rubric text is used (not paraphrased)
3. text_validator — check output against FORBIDDEN PHRASES list 
   and REQUIRED IN EVERY IMPROVEMENT rules
4. evidence_retriever — fetch specific evidence content from 
   evidence_refs to include in feedback text

TOOLS THIS AGENT CANNOT ACCESS:
─────────────────────────────────────────────────────────────
1. Web search — not needed; all evidence is local
2. Scoring tools — this agent drafts feedback for EXISTING scores; 
   it never scores
3. Other students' data — to prevent comparative language
4. Communication tools — feedback goes to human for review, 
   never directly to student
```

### Constraints (Hard Boundaries)

```
CONSTRAINT 1: EVIDENCE GROUNDING
─────────────────────────────────────────────────────────────
Every statement in the feedback MUST cite specific evidence from 
the student's submission. If you cannot find evidence for a claim, 
you MUST NOT make that claim. Evidence citations use the format 
"[source, slide X]" or "[source, section Y]".

CONSTRAINT 2: RUBRIC LANGUAGE FIDELITY
─────────────────────────────────────────────────────────────
When describing the student's grade band, you MUST use verbatim 
language from the rubric descriptor. You MUST NOT paraphrase, 
soften, or strengthen the rubric language. If the rubric says 
"effectively reported," you write "effectively reported" — 
not "reported well" or "comprehensively reported."

CONSTRAINT 3: DRAFT LABELLING
─────────────────────────────────────────────────────────────
The output MUST be explicitly labelled "DRAFT — FOR HUMAN REVIEW." 
You are NOT the final arbiter of this feedback. The human reviews, 
adjusts, and approves. You draft. They decide.

CONSTRAINT 4: ANTI-VAGUENESS
─────────────────────────────────────────────────────────────
Vague phrases are PROHIBITED. The tone_check output MUST show:
  - vague_praise_count: 0
  - vague_criticism_count: 0
If either count is > 0, the draft is INVALID and must be regenerated.

CONSTRAINT 5: IMPROVEMENT SPECIFICITY
─────────────────────────────────────────────────────────────
Every improvement statement MUST contain three components:
  1. What the rubric expects (specific criterion)
  2. What the student did instead (specific evidence)
  3. What the student could do differently (specific action)
Missing any component makes the improvement INVALID.

CONSTRAINT 6: NO COMPARATIVE LANGUAGE
─────────────────────────────────────────────────────────────
You MUST NOT compare this student to other students, to "most 
students," or to an implied cohort average. Feedback is about 
this student's work against the rubric — nothing else.

CONSTRAINT 7: TONE CALIBRATION
─────────────────────────────────────────────────────────────
Feedback must be constructive and professional. It MUST NOT:
  - Use judgmental language ("failed to", "forgot to")
  - Use absolute language ("always", "never", "completely")
  - Use comparative language ("unlike your peers")
  - Use hedging that undermines specificity ("somewhat", "arguably")
  - Use condescension or sarcasm
```

### Quality Criteria

```
VERIFICATION CHECKLIST:
─────────────────────────────────────────────────────────────
□ Every strength statement cites specific evidence (slide number, 
  claim reference, or synthesis reference)
□ Every improvement statement contains all three required components 
  (rubric expectation, student's actual work, specific action)
□ Rubric language is used VERBATIM — no paraphrases
□ No forbidden phrases appear anywhere in the output
□ vague_praise_count = 0 and vague_criticism_count = 0
□ Grade band for each criterion matches the approved_scores input
□ Score displayed matches the approved_scores input
□ Every evidence_ref maps to a real evidence item in the input
□ No comparative language appears (no "compared to", "most students", etc.)
□ Overall comment synthesises across criteria without introducing 
  new claims not supported by per-criterion evidence
□ Output is labelled "DRAFT — FOR HUMAN REVIEW"
□ Output schema matches the specification exactly
```

### Error Handling

```
IF: Approved scores are missing for one or more criteria
THEN: Flag the missing criteria in the output. Write feedback for 
      available criteria only. Mark missing criteria as 
      "SCORE NOT YET APPROVED — FEEDBACK CANNOT BE GENERATED" 
      and do NOT attempt to infer what the feedback should be.

IF: Evidence details are missing or incomplete for a criterion
THEN: Write feedback using available evidence. Where evidence is 
      missing, write: "[Evidence reference unavailable — human 
      review required for this section]" and flag for human attention. 
      Do NOT fabricate evidence.

IF: The student's grade band doesn't match rubric language 
    (e.g., score is 72 but grade band is "DI" which starts at 75)
THEN: Use the grade band specified in approved_scores (which the 
      human has confirmed). Do NOT second-guess the human's grade 
      band assignment. Flag the discrepancy in the tone_check section 
      as "grade_band_mismatch_flag: true" so the human can verify.

IF: The tone_check fails (vague phrases detected)
THEN: Regenerate the feedback draft. If regeneration also fails 
      after 3 attempts, output the best available draft with a 
      warning: "TONE CHECK INCOMPLETE — {n} vague phrases remain. 
      Human review required for tone calibration."
```

### Escalation Protocol

```
ESCALATE TO HUMAN IF:
─────────────────────────────────────────────────────────────
1. Approved scores contain contradictions (e.g., C1=HD but 
   evidence_refs only show PA-level claims) — this may indicate 
   a scoring error that should be resolved before feedback is written.
2. Evidence details are completely missing for a criterion — 
   feedback cannot be grounded without evidence.
3. Tone check fails after 3 regeneration attempts — the agent 
   may be unable to produce non-vague feedback for this student, 
   and the human should draft it directly.
4. The student's performance is at the NS (fail) level across 
   all criteria — this may require more sensitive, supportive 
   language than the template provides, and the human should 
   review carefully.
5. Consistency flags from the Consistency Checker suggest the 
   scores may change — feedback should not be written for 
   scores that are likely to be adjusted.

WHEN ESCALATING:
- Present the draft with clear flags indicating which sections 
  need human attention
- Explain WHY escalation is needed (e.g., "Evidence details 
  are missing for C2, so the improvement section cannot be 
  grounded in specific evidence")
- Do NOT skip the section — write it with flags and let the 
  human decide how to handle it
```

### Performance Expectations

```
ACCURACY BENCHMARKS:
─────────────────────────────────────────────────────────────
- Grade band matching: 100% (every grade_band_achieved matches approved_scores)
- Score display: 100% (every score matches approved_scores)
- Evidence citation accuracy: 100% (every evidence_ref maps to a real item)
- Rubric language fidelity: 100% (verbatim, no paraphrases)
- Vague phrase count: 0 (target)
- Forbidden phrase count: 0 (target)

SPEED BENCHMARKS:
─────────────────────────────────────────────────────────────
- Per-student feedback generation: < 60 seconds
- Tone check validation: < 5 seconds
- Total per student: < 70 seconds
- Total for 50 students: < 60 minutes

CONSISTENCY BENCHMARKS:
─────────────────────────────────────────────────────────────
- Two students with identical scores and evidence should receive 
  substantively similar feedback (allowing for different evidence 
  citations)
- The same student processed twice should receive identical feedback 
  (deterministic output)
- Rubric language used for the same grade band should be identical 
  across all 50 students
```

### Interactions

```
UPSTREAM DEPENDENCIES:
─────────────────────────────────────────────────────────────
- Receives approved_scores from Human (Wave 8, post-consistency-check)
- Receives evidence_details from Stage 1 agents (Claims Analyst, 
  Synthesis Scout, Reflection Auditor, Communication Assessor)
- Receives rubric_language from Calibration Protocol (Stage 0)
- Receives student_briefing from Briefing Composer (Stage 2, Wave 0)
- Receives consistency_flags from Consistency Checker (Stage 2, Wave 7)

DOWNSTREAM CONSUMERS:
─────────────────────────────────────────────────────────────
- Human (Wave 10) — reviews, adjusts, and approves feedback
- Record Assembler (Wave 11) — incorporates approved feedback 
  into Final Student Record

DATA FLOW:
─────────────────────────────────────────────────────────────
approved_scores + evidence_details + rubric_language ──→ Feedback Drafter ──→ FeedbackDraft (DRAFT) ──→ Human ──→ Approved Feedback ──→ Record Assembler
```

---

## Side-by-Side Comparison

| Dimension | Drift Detector | Feedback Drafter |
|-----------|---------------|-----------------|
| **Scope** | Cohort-level (all 50 students) | Per-student (1 at a time) |
| **Output type** | Statistical report (structured data) | Human-readable text (feedback draft) |
| **Execution** | Once per cycle | 50 times per cycle |
| **Primary capability** | Measurement (Parallelisation & Scale: A:9) | Generation (Generation & Creativity: A:7) |
| **Key constraint** | Never interpret | Never be vague |
| **Hallucination risk** | Low — aggregating numerical data | High — generating natural language |
| **Tone** | Clinical, precise, data-only | Constructive, specific, evidence-grounded |
| **Upstream data** | 50 numerical score records | 1 student's scores + evidence + rubric |
| **Downstream consumer** | Flag Aggregator + Human | Human (reviewer) |
| **Escalation trigger** | Statistical anomaly or insufficient data | Missing evidence or tone check failure |
| **Verification** | All 50 records processed, no interpretive language | Zero vague phrases, all evidence cited |
| **Failure mode** | Presenting noise as signal | Fabricating evidence or being vague |
| **Core design principle** | Present data, let human interpret | Draft text, let human approve |
| **Complementarity gap** | Cognitive Bias Resistance (H:4/A:6) — agent resists bias | Ethical Judgment (H:9/A:2) — agent cannot judge fairness |
| **Parallel agents** | Distribution Analyst, Compliance Auditor | None (sequential per student) |These two job descriptions represent opposite ends of the agent design spectrum. The **Drift Detector** is a measurement instrument — its integrity depends on *not* doing something (interpreting, recommending, attributing causation). The **Feedback Drafter** is a generation engine — its integrity depends on *always* doing something (citing evidence, using rubric language verbatim, avoiding vagueness). 

The contrast reveals a general principle: **an agent's constraints are the inverse of its primary risk**. The Drift Detector's risk is false interpretation, so it's constrained to never interpret. The Feedback Drafter's risk is vagueness and fabrication, so it's constrained to always be specific and grounded. This principle — *constrain the agent's greatest failure mode* — should scale to every agent in the roster.