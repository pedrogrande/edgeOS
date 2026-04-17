# Part 1: Backcasting from Final Deliverables

## The Five Final Deliverables

| ID | Deliverable | Stakeholder |
|----|------------|-------------|
| **D1** | Final Grade Register — 50 approved grades entered in LMS | Student, Institution |
| **D2** | Per-Student Feedback — 50 individual feedback documents | Student |
| **D3** | Cohort Feedback Document — common strengths, weaknesses, recommendations | Course Coordinator |
| **D4** | Rubric Performance Memo — what worked, what didn't, recommendations | Course Coordinator, Future Cohorts |
| **D5** | Academic Integrity Files — flags, evidence, decisions (if any) | Integrity Office |

---

## Dependency Chain D1: Final Grade Register

```
D1: Final Grade Register
  ← requires: Approved final scores per student (4.1)
      ← requires: Decision authority sign-off on every score (4.1 human)
      ← requires: Compliance Consistency Report — all penalties verified equitable (3.4)
          ← requires: All 50 Compliance Reports + format penalty policy (1.3)
      ← requires: Borderline Decision Log — all boundary cases resolved (3.2)
          ← requires: Criterion Score Sets for all 50 students (2.3–2.6)
          ← requires: Calibration Protocol — what separates each grade band (1.2)
      ← requires: Drift Analysis Report — confirms no systematic drift (3.3)
          ← requires: Criterion Score Sets for all 50 students (2.3–2.6)
          ← requires: Marking order timestamps (2.3–2.6)
      ← requires: Cohort Distribution Report — confirms defensible distribution (3.1)
          ← requires: Criterion Score Sets for all 50 students (2.3–2.6)
      ← requires: Criterion Score Sets for all 50 students (2.3–2.6)
          ← requires: Holistic Impression Records for all 50 students (2.1)
              ← requires: Enhanced Submission Packages for all 50 students (1.1+1.3+2.2)
                  ← requires: Calibration Protocol — agent knows what evidence to extract (1.2)
                  ← requires: Raw Submissions — 50 files (1.1)
              ← requires: Calibration Protocol — human knows rubric-to-question mapping (1.2)
          ← requires: Calibration Protocol (1.2)
```

## Dependency Chain D2: Per-Student Feedback

```
D2: Per-Student Feedback (×50)
  ← requires: Approved Final Scores per student (post quality check)
      ← requires: Quality Check Reports — no unresolved contradictions (2.8)
          ← requires: Criterion Score Sets — the scores to check (2.3–2.6)
      ← requires: Feedback Drafts — agent-generated from rubric language + evidence (2.7)
          ← requires: Final Criterion Score Sets with evidence citations (2.3–2.6)
          ← requires: Calibration Protocol — rubric language per grade band (1.2)
      ← requires: Human review for tone, fairness, values alignment (2.7)
```

## Dependency Chain D3: Cohort Feedback Document

```
D3: Cohort Feedback Document
  ← requires: Human-framed teaching insights (4.2)
      ← requires: Agent-identified statistical patterns across 50 submissions (4.2)
          ← requires: Criterion Score Sets for all 50 students (2.3–2.6)
          ← requires: Cohort Distribution Report (3.1)
      ← requires: Double-loop reflection on what patterns mean for teaching (4.2 human)
```

## Dependency Chain D4: Rubric Performance Memo

```
D4: Rubric Performance Memo
  ← requires: Human meta-assessment of rubric quality (4.4)
      ← requires: Agent-documented patterns of rubric ambiguity (4.4)
          ← requires: Quality Check Reports — what was hard to score consistently (2.8)
          ← requires: Drift Analysis Report — where judgment was least stable (3.3)
          ← requires: Compliance Consistency Report — where rules were ambiguous (3.4)
      ← requires: Double-loop reflection on rubric design (4.4 human)
```

## Dependency Chain D5: Academic Integrity Files

```
D5: Academic Integrity Files (if needed)
  ← requires: Human ethical judgment on severity and evidence (4.3)
      ← requires: Integrity flags from agent pre-processing (2.2 / 1.3)
          ← requires: Compliance Reports for all 50 students
          ← requires: C3 pre-analysis — AI usage disclosure patterns (2.2)
```

---

## Backcasting Synthesis: Merged Dependency DAG

All five chains share common prerequisites. The merged dependency structure reveals **three critical design insights**:

**Insight 1: Calibration is the root node.** Everything downstream depends on the Calibration Protocol (1.2). It must be produced first and must be right — it determines what evidence the agent extracts, how the human scores, and what language appears in feedback.

**Insight 2: Agent pre-processing is a parallel fan-out.** Once the Calibration Protocol exists, the agent can process all 50 submissions simultaneously, producing Enhanced Submission Packages. This eliminates the human's mechanical workload entirely.

**Insight 3: The per-student loop is the critical path.** It's sequential (human reads one at a time), it's the longest phase, and it's where drift risk accumulates. Every other phase is either a prerequisite or a post-requisite of this loop.

---

# Part 2: Forward-Order Workflow Table

Data objects are shown in **[bold brackets]** to trace the flow explicitly.

| Step | Subtask | Assigned | Required Inputs | Required Outputs | Data Object Produced |
|------|---------|----------|-----------------|------------------|---------------------|
| **0** | **PIPELINE GATE: Calibration** | | | | |
| 0.1 | Calibrate rubric: resolve rubric-to-question mapping | **Human-led** | Assignment brief + rubric | Mapping of C1→Q1,Q2,Q3,Q4; C2→Q1-Q4; C3→Q5; C4→whole deck | |
| 0.2 | Calibrate rubric: define grade band boundaries | **Human-led** | Rubric descriptors (HD/DI/CR/PA/NS) | Explicit boundary definitions for C1–C4 (e.g., "comprehensive" = all questions addressed with depth + application; "effective" = same minus depth) | |
| 0.3 | Calibrate rubric: define format penalty policy | **Human-led** | Assignment brief constraints | Policy: how slide-count violations, missing sources, missing date/time affect C4 or trigger separate penalty | |
| | | | | ↓ | |
| | | | | **[CP] Calibration Protocol** — rubric-to-question mapping + boundary definitions + penalty policy | **[CP]** |
| **1** | **PIPELINE STAGE 1: Agent Pre-Processing (all 50, parallel)** | | | | |
| 1.1 | Gather & organise all 50 submissions | **Agent-led** | LMS submission portal access | 50 files in standardised format, logged in tracking spreadsheet | |
| 1.2 | Run format compliance checks on all 50 | **Agent-led** | [CP] + 50 raw files | Per-student compliance report: slide count per question, source presence per question, date/time on market data, Q5 per-section coverage | |
| 1.3 | Extract features from all 50 submissions | **Agent-led** | [CP] + 50 raw files | Per-student: question-to-slide mapping, source list per question, key technical claims extracted, cross-question evidence patterns (for C2 synthesis detection), C3 pre-analysis (does Q5 address Q1–Q4 individually?) | |
| 1.4 | Flag anomalies across all 50 submissions | **Agent-led** | Compliance reports + feature extractions | Per-student: anomaly flags (missing sources, exceeded slide limits, potential AI misuse signals, questionable technical claims, missing per-section Q5 reflection) | |
| | | | | ↓ | |
| | | | | **[ESP] Enhanced Submission Package** × 50 — original file + compliance report + question mapping + source extraction + claims extraction + cross-question patterns + anomaly flags + C3 pre-analysis | **[ESP] ×50** |
| **2** | **PIPELINE STAGE 2: Per-Student Marking Loop (×50, sequential)** | | | | |
| 2.1 | Holistic read-through | **Collaborative** | [CP] + [ESP] for student *n* | Overall quality signal, first impression, flagged strengths/weaknesses, bias-check prompts from agent | **[HIR] Holistic Impression Record** |
| 2.2 | Score C1 — Technical Information | **Collaborative** | [CP] + [ESP] + [HIR] for student *n* | C1 score (0–30) + evidence citations supporting score + grade band | **[C1ₙ]** |
| 2.3 | Score C2 — Synthesis & Audience | **Human-led** | [CP] + [ESP] + [HIR] + [C1ₙ] for student *n* | C2 score (0–30) + evidence citations + grade band + agent synthesis-pattern flags for human to confirm/override | **[C2ₙ]** |
| 2.4 | Score C3 — AI Critical Evaluation | **Human-led** | [CP] + [ESP] + [C3 pre-analysis from ESP] for student *n* | C3 score (0–20) + evidence citations + grade band + assessment of critical depth vs comprehensiveness | **[C3ₙ]** |
| 2.5 | Score C4 — Communication & Format | **Collaborative** | [CP] + [ESP] + [HIR] + compliance report for student *n* | C4 score (0–20) + evidence citations + grade band + agent format check results + human subjective judgment on coherence | **[C4ₙ]** |
| 2.6 | Quality check scores for student *n* | **Collaborative** | [CP] + [C1ₙ] + [C2ₙ] + [C3ₙ] + [C4ₙ] + [HIR] | Internal consistency check: criterion scores vs holistic impression, criterion cross-correlations, flagged contradictions | **[QCRₙ]** |
| 2.7 | Draft feedback for student *n* | **Collaborative** | [CP] + [C1ₙ] + [C2ₙ] + [C3ₙ] + [C4ₙ] + [QCRₙ] + [HIR] | Draft feedback per criterion: rubric language matched to grade band achieved + specific evidence from submission + 1 strength + 1 improvement area | **[FDₙ]** |
| 2.8 | Review & approve feedback for student *n* | **Human-led** | [FDₙ] | Approved feedback: tone check, fairness check, values alignment, actionable specificity confirmed | **[AFₙ] Approved Feedback** |
| 2.9 | Assemble Final Student Record | **Collaborative** | [C1ₙ] + [C2ₙ] + [C3ₙ] + [C4ₙ] + [QCRₙ] + [AFₙ] + compliance report + timestamp | Complete student record with all scores, feedback, compliance status, marking order position | **[FSRₙ]** |
| | | | | ↓ Repeat for n=1..50 | **[FSR] ×50** |
| **3** | **PIPELINE STAGE 3: Cohort Quality Assurance** | | | | |
| 3.1 | Compute score distributions | **Agent-led** | [FSR] ×50 | Distribution per criterion + total; mean, median, std dev; histograms; anomaly flags (outliers, unexpected clustering) | **[CDR]** |
| 3.2 | Check for marker drift | **Agent-led** | [FSR] ×50 (with timestamps) | First-10 vs last-10 comparison per criterion; drift magnitude; statistical significance; visual trend charts | **[DAR]** |
| 3.3 | Review borderline cases | **Human-led** | [CDR] + [DAR] + [FSR] for all students near grade boundaries | Per-borderline-student: decision (confirm or adjust) + rationale referencing CP boundary definitions | **[BDL]** |
| 3.4 | Verify compliance penalty consistency | **Collaborative** | [FSR] ×50 + [CP] | Cross-student audit: same violation → same penalty; edge cases flagged for human adjudication | **[CCR]** |
| 3.5 | Resolve all flags and adjust scores | **Human-led** | [BDL] + [CCR] + [DAR] | Final adjusted [FSR] ×50 with all drift corrections, borderline decisions, and compliance penalties applied | **[FSR] ×50 (final)** |
| **4** | **PIPELINE STAGE 4: Finalisation & Deliverable Production** | | | | |
| 4.1 | Compute & enter final grades | **Collaborative** | [FSR] ×50 (final) | Agent computes totals, converts to institutional grade scale; human authorises and enters into LMS | **[FGR] Final Grade Register** → **D1** ✓ |
| 4.2 | Release per-student feedback | **Collaborative** | [FSR] ×50 (final) | Agent assembles feedback into LMS format; human spot-checks 10% for accuracy | **D2** ✓ |
| 4.3 | Prepare cohort-level feedback | **Collaborative** | [CDR] + [DAR] + [FSR] ×50 | Agent identifies statistical patterns; human frames as teaching insights (what to reinforce, what to reteach) | **D3** ✓ |
| 4.4 | Handle academic integrity cases | **Human-led** | Anomaly flags from [ESP] + [CCR] + [FSR] | Per-case: evidence summary, decision, documentation | **D5** ✓ (if needed) |
| 4.5 | Reflect on rubric performance | **Human-led** | [QCR] ×50 aggregated + [DAR] + [CCR] + marking notes from 2.3–2.5 | Memo: where rubric was ambiguous, where students struggled, recommendations for next iteration | **D4** ✓ |

---

## Pipeline Architecture Diagram

```
                        ┌─────────────────────────────┐
                        │    STEP 0: CALIBRATION      │
                        │     Human-led (1 session)    │
                        │  Output: [CP]               │
                        └──────────┬──────────────────┘
                                   │
                    ┌──────────────▼──────────────────┐
                    │  STEP 1: AGENT PRE-PROCESSING    │
                    │  Agent-led (all 50, parallel)     │
                    │  Output: [ESP] ×50              │
                    └──────────────┬──────────────────┘
                                   │
              ┌────────────────────▼────────────────────┐
              │  STEP 2: PER-STUDENT MARKING LOOP ×50   │
              │  Sequential — one student at a time     │
              │                                         │
              │  2.1 Holistic Read ──► [HIR]            │
              │     │                                   │
              │     ├── 2.2 Score C1 ──► [C1]           │
              │     ├── 2.3 Score C2 ──► [C2]  ← Human│
              │     ├── 2.4 Score C3 ──► [C3]  ← Human│
              │     ├── 2.5 Score C4 ──► [C4]           │
              │     │                                   │
              │     ├── 2.6 Quality Check ──► [QCR]     │
              │     ├── 2.7 Draft Feedback ──► [FD]     │
              │     ├── 2.8 Approve Feedback ─► [AF]   │
              │     └── 2.9 Assemble Record ──► [FSR]   │
              │                                         │
              │  Output: [FSR] ×50                      │
              └────────────────────┬────────────────────┘
                                   │
              ┌────────────────────▼────────────────────┐
              │  STEP 3: COHORT QUALITY ASSURANCE        │
              │                                         │
              │  3.1 Distributions ──► [CDR]  ← Agent  │
              │  3.2 Drift Check ──► [DAR]    ← Agent  │
              │  3.3 Borderlines ──► [BDL]    ← Human  │
              │  3.4 Compliance ──► [CCR]     ← Collab │
              │  3.5 Resolve Flags ──► [FSR]  ← Human  │
              │                                         │
              │  Output: [FSR] ×50 (final)              │
              └────────────────────┬────────────────────┘
                                   │
         ┌─────────────────────────▼─────────────────────────┐
         │  STEP 4: FINALISATION & DELIVERABLE PRODUCTION    │
         │                                                    │
         │  4.1 Compute & Enter Grades ──► D1 ✓  ← Collab   │
         │  4.2 Release Feedback ──► D2 ✓         ← Collab │
         │  4.3 Cohort Feedback ──► D3 ✓          ← Collab │
         │  4.4 Integrity Cases ──► D5 ✓          ← Human  │
         │  4.5 Rubric Reflection ──► D4 ✓         ← Human  │
         └───────────────────────────────────────────────────┘
```

---

## Human Time Budget Estimate

| Pipeline Stage | Human Role | Estimated Time | Notes |
|----------------|-----------|----------------|-------|
| **0. Calibration** | Full ownership | 60–90 min | Single session; determines quality of everything downstream |
| **1. Pre-processing** | None (spot-check only) | 15 min | Review 5 ESP samples to verify agent extraction quality |
| **2. Per-student loop** | Primary judgment | 12–15 min × 50 = **10–12.5 hrs** | The critical path. Human reads, judges 4 criteria, reviews feedback, approves |
| **3. Cohort QA** | Decision authority | 60–90 min | Review distributions, drift report, resolve borderlines, verify compliance |
| **4. Finalisation** | Authorisation + insight | 45–60 min | Approve grades, review cohort feedback, write rubric memo |
| **Total human time** | | **~13–15.5 hrs** | vs. estimated 20–25 hrs fully manual |

**Human time saved by agent pre-processing**: ~5–10 hours eliminated from mechanical tasks (downloading, compliance checking, feature extraction, feedback drafting, distribution computation, drift calculation, grade entry). The human's entire time budget is spent on **judgment, evaluation, and decision** — the tasks where human capability exceeds agent capability per the complementarity analysis.

---

## Critical Design Principle

The pipeline architecture embodies the core insight from the complementarity analysis:

> **The agent prepares judgment; the human makes judgment.**

Every agent-led step produces a **structured decision input** — not a final answer. The Enhanced Submission Package prepares the human to read efficiently. The agent's first-pass C1 score prepares the human to confirm or adjust. The feedback draft prepares the human to approve with minimal revision. The drift report prepares the human to decide whether intervention is needed.

The human never waits. The human never does mechanical work. The human never marks without calibrated standards. **Every minute of human attention is spent on the irreplaceable tasks: ethical judgment, values alignment, semantic interpretation, and decision authority.**The workflow is now fully specified with explicit data flow between every stage. The backcasting ensures nothing is missing — every deliverable traces back to its prerequisites, and the forward table shows exactly what each step consumes and produces. The key architecture decision — agent pre-processes ALL 50 before the human starts — eliminates human wait time and ensures every minute of human attention goes to irreplaceable judgment work.