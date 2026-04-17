# Subtask → Complementarity Property Mapping

## The Master Table

| ID | Subtask | Critical Properties (H/A) | Max Gap | Assignment | Rationale |
|----|---------|---------------------------|---------|------------|-----------|
| **1.1** | Gather & organise submissions | Parallelisation & scale: 2/**9** · Output consistency: 5/**7** · Handling ambiguous input: 7/**9** · Context management: 6/6 | Parallelisation: **7** | **Agent-led** | Mechanical, repetitive, at scale — agent's parallelisation and consistency dominate. Human spot-check for corrupted files. |
| **1.2** | Calibrate rubric + mapping | Ethical judgment: **9**/2 · Decision authority: **9**/2 · Values alignment: **8**/2 · Creative problem framing: **9**/4 · Double-loop learning: **8**/3 · Reasoning & judgment: **9**/7 | Decision authority: **7** | **Human-led** | Non-negotiable. Highest-value, highest-risk subtask. Wrong calibration corrupts ALL 50 grades. Ethical, values, and authority gaps are enormous. |
| **1.3** | Establish format compliance checks | Commonsense inference: **9**/7 · Output consistency: 5/**7** · Error containment: 6/4 · Context management: 6/6 | Commonsense: **2** (small) | **Collaborative** | Human designs the checklist (what to check, why it matters); agent operationalises it into a repeatable scan. Small gap = natural handoff. |
| **2.1** | Full deck read-through | Semantic & social skill: **9**/7 · Reasoning & judgment: **9**/7 · Cognitive bias resistance: 4/**6** · Commonsense inference: **9**/7 · Context management: 6/6 | Semantic & social: **2** (small) | **Collaborative** | Agent pre-processes (highlights key features, flags anomalies, extracts source lists); human reads for holistic impression. Agent's bias resistance (6) > human's (4) is exploitable: agent can flag where human might be anchoring. |
| **2.2** | Format compliance check (×50) | Parallelisation & scale: 2/**9** · Approval fatigue resistance: 4/**9** · Motivational consistency: 5/**9** · Output consistency: 5/**7** · Error containment: 6/4 | Approval fatigue: **5** | **Agent-led** | Rules-based, repetitive, fatigue-prone for humans. Agent applies identical checks with zero motivation decay. Human spot-checks 10% for validation. |
| **2.3** | Score C1 — Technical Info (30pts) | Reasoning & judgment: **9**/7 · Semantic & social skill: **9**/7 · Output consistency: 5/**7** · Cognitive bias resistance: 4/**6** · Context management: 6/6 | Reasoning: **2** (small) | **Collaborative** | Core tension: human has better individual judgment; agent has better consistency and bias resistance. Agent provides first-pass score with evidence citations; human reviews and adjusts. The human compensates for agent's judgment gap; the agent compensates for human's consistency gap. |
| **2.4** | Score C2 — Synthesis & Audience (30pts) | Reasoning & judgment: **9**/7 · Semantic & social skill: **9**/7 · Creative problem framing: **9**/4 · Values alignment: **8**/2 · Commonsense inference: **9**/7 · Output consistency: 5/**7** | Values alignment: **6** | **Human-led** | Hardest criterion. "Synthesised vs extracted" and "insightful vs reasonably insightful" require deep semantic, creative, and values-based judgment. Agent can surface evidence patterns but the grade band decision requires human interpretation of what synthesis *looks like*. |
| **2.5** | Score C3 — AI Critical Eval (20pts) | Ethical judgment: **9**/2 · Double-loop learning: **8**/3 · Values alignment: **8**/2 · Reasoning & judgment: **9**/7 · Commonsense inference: **9**/7 | Ethical judgment: **7** | **Human-led** | Meta-circular: the marker evaluates whether the student engaged in double-loop learning about AI. Ethical judgment on honesty of AI disclosure. Agent scores 2 on both ethical judgment and values alignment — it cannot evaluate the very thing C3 assesses. |
| **2.6** | Score C4 — Communication (20pts) | Semantic & social skill: **9**/7 · Commonsense inference: **9**/7 · Reasoning & judgment: **9**/7 · Output consistency: 5/**7** · Handling ambiguous input: 7/**9** | Semantic & social: **2** (small) | **Collaborative** | Objective format elements (slide count, source presence) → agent. Subjective quality (visual coherence, effective communication) → human. Agent's consistency and input-handling advantages apply to the mechanical checks. |
| **2.7** | Write per-student feedback | Semantic & social skill: **9**/7 · Ethical judgment: **9**/2 · Reversibility awareness: **8**/5 · Values alignment: **8**/2 · Generation & creativity: **9**/7 · Commonsense inference: **9**/7 | Ethical judgment: **7** | **Collaborative** | Agent drafts from rubric language + evidence citations (leveraging generation 9/7, output consistency 5→7). Human reviews for tone, fairness, and values alignment. The agent handles the heavy lifting of personalisation at scale; the human ensures each feedback is ethically and socially appropriate. |
| **2.8** | Quality check scores | Reasoning & judgment: **9**/7 · Output consistency: 5/**7** · Error containment: 6/4 · Commonsense inference: **9**/7 · Context management: 6/6 | Error containment: **2** (small) | **Collaborative** | Agent systematically flags internal contradictions (e.g., C1=HD but C2=PA, or criterion scores don't match overall impression). Human adjudicates flagged cases. Agent's consistency catches patterns humans miss; human's judgment resolves ambiguous flags. |
| **3.1** | Review score distribution | Parallelisation & scale: 2/**9** · Reasoning & judgment: **9**/7 · Cognitive bias resistance: 4/**6** · Handling ambiguous input: 7/**9** | Parallelisation: **7** | **Collaborative** | Agent computes distributions, plots charts, flags anomalies (parallelisation 9). Human interprets whether distribution is defensible (reasoning 9). Agent's bias resistance (6 > 4) prevents unconscious nudging. |
| **3.2** | Review borderline cases | Ethical judgment: **9**/2 · Decision authority: **9**/2 · Values alignment: **8**/2 · Reversibility awareness: **8**/5 · Reasoning & judgment: **9**/7 | Decision authority: **7** | **Human-led** | Non-negotiable. One-point shifts change grade bands. Ethical, values, and authority gaps are enormous. The human must own these decisions because their consequences (student record, transcript) require reversibility awareness and accountability. |
| **3.3** | Check marker drift | Parallelisation & scale: 2/**9** · Output consistency: 5/**7** · Cognitive bias resistance: 4/**6** · Reasoning & judgment: **9**/7 | Parallelisation: **7** | **Collaborative** | Agent computes drift metrics (first-10 vs last-10 distributions) efficiently and without bias. Human interprets whether observed drift is meaningful vs. noise. This is the only backstop against the biggest systemic risk. |
| **3.4** | Verify format compliance penalties | Output consistency: 5/**7** · Ethical judgment: **9**/2 · Values alignment: **8**/2 · Error containment: 6/4 | Values alignment: **6** | **Collaborative** | Agent verifies consistent enforcement across 50 submissions (consistency advantage). Human adjudicates edge cases where format violations are ambiguous (values/ethical judgment). |
| **4.1** | Finalise grades | Decision authority: **9**/2 · Output consistency: 5/**7** · Error containment: 6/4 · Skill preservation: 5/**8** · Parallelisation & scale: 2/**9** | Decision authority: **7** | **Collaborative** | Agent computes sums, converts scales, populates system (parallelisation + consistency). Human authorises final grades (decision authority). Skill preservation (5→8) interesting: agent retains calculation skill perfectly; human's role is authorisation, not computation. |
| **4.2** | Prepare cohort-level feedback | Generation & creativity: **9**/7 · Double-loop learning: **8**/3 · Semantic & social skill: **9**/7 · Novel situation reasoning: **8**/5 · Reasoning & judgment: **9**/7 | Double-loop learning: **5** | **Collaborative** | Agent identifies statistical patterns across 50 submissions (what's common, what's anomalous). Human frames these as teaching insights (creative problem framing, double-loop learning). The agent asks *what*; the human asks *so what*. |
| **4.3** | Handle re-marks & academic integrity | Ethical judgment: **9**/2 · Values alignment: **8**/2 · Decision authority: **9**/2 · Reversibility awareness: **8**/5 · Manipulation resistance: 6/4 · Semantic & social skill: **9**/7 | Decision authority: **7** | **Human-led** | Non-negotiable. Agent scores 2 on ethical judgment, 2 on values, 2 on decision authority — the three most critical properties. This subtask requires evaluating honesty, adjudicating disputes, and making consequential decisions. Entirely human domain. |
| **4.4** | Reflect on rubric performance | Double-loop learning: **8**/3 · Creative problem framing: **9**/4 · Novel situation reasoning: **8**/5 · Reasoning & judgment: **9**/7 | Creative problem framing: **5** | **Human-led** | Meta-assessment: questioning whether the rubric worked. Requires double-loop learning (questioning the framework itself) and creative problem framing (how to improve it). Agent can document findings but the reflective insight is human. |

---

## Assignment Distribution Summary

| Assignment | Count | Subtask IDs |
|------------|-------|-------------|
| **Human-led** | 5 | 1.2, 2.4, 2.5, 3.2, 4.3 (+ 4.4 with doc support) |
| **Agent-led** | 2 | 1.1, 2.2 |
| **Collaborative** | 12 | 1.3, 2.1, 2.3, 2.6, 2.7, 2.8, 3.1, 3.3, 3.4, 4.1, 4.2, 4.4 |

---

## Property Signature Patterns

### What drives Human-led assignment

| Property | H | A | Gap | Appears in Human-led subtasks |
|----------|---|---|-----|-------------------------------|
| Ethical judgment | 9 | 2 | **7** | 1.2, 2.5, 3.2, 4.3 |
| Decision authority | 9 | 2 | **7** | 1.2, 3.2, 4.1, 4.3 |
| Values alignment | 8 | 2 | **6** | 1.2, 2.4, 2.5, 3.2, 3.4 |
| Double-loop learning | 8 | 3 | **5** | 1.2, 2.5, 4.2, 4.4 |
| Creative problem framing | 9 | 4 | **5** | 1.2, 2.4, 4.4 |

**Pattern:** Human-led assignment is driven by **high-stakes, low-frequency decisions** where ethical, values, and authority gaps make agent participation inappropriate. These subtasks occur 1–5 times, not 50 times.

### What drives Agent-led assignment

| Property | H | A | Gap | Appears in Agent-led subtasks |
|----------|---|---|-----|-------------------------------|
| Parallelisation & scale | 2 | 9 | **7** | 1.1, 2.2, 3.1, 3.3, 4.1 |
| Approval fatigue resistance | 4 | 9 | **5** | 2.2 |
| Motivational consistency | 5 | 9 | **4** | 2.2 |
| Output consistency | 5 | 7 | **2** | 1.1, 2.2, 2.3, 2.6, 2.8 |

**Pattern:** Agent-led assignment is driven by **repetitive, rules-based, high-volume tasks** where human fatigue and inconsistency are the dominant failure modes. These subtasks occur 50+ times.

### What drives Collaborative assignment

| Property (Human-advantaged) | H | A | Property (Agent-advantaged) | H | A | Appears in |
|----------|---|---|----------|---|---|---|
| Reasoning & judgment | 9 | 7 | Output consistency | 5 | 7 | 2.3, 2.6, 2.8 |
| Semantic & social skill | 9 | 7 | Cognitive bias resistance | 4 | 6 | 2.1, 2.6, 2.7 |
| Commonsense inference | 9 | 7 | Handling ambiguous input | 7 | 9 | 2.1, 3.1 |
| Generation & creativity | 9 | 7 | Skill preservation | 5 | 8 | 2.7, 4.1 |

**Pattern:** Collaborative assignment is driven by the **structural tension between judgment quality (human) and judgment consistency (agent)**. The human makes the decision but benefits from agent-mediated evidence, bias resistance, and consistency enforcement. This tension is the core design challenge of any agentic marking system.

---

## The Core Design Insight

The marking task has a single structural tension that repeats across almost every scoring subtask:

> **Judgment Quality** (H=9, A=7) vs **Judgment Consistency** (H=5, A=7)

The human makes better individual judgments. The agent applies judgments more consistently across 50 submissions. **Neither alone is sufficient.** A human-only process drifts. An agent-only process misjudges. The Collaborative pattern resolves this by making the agent a **judgment preparation layer** — surfacing evidence, flagging patterns, and applying consistency constraints — while the human retains **decision authority** over the actual grade.

This mirrors your earlier insight about AI+Human collaboration: **the agent's highest-value role is judgment preparation, not answer generation.**