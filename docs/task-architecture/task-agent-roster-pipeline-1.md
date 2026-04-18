# Pipeline Stage 1: Specialist Agent Roster

## Design Decision: Decomposition of Subtask 1.3

The original subtask 1.3 ("Extract features from all 50 submissions") is a monolith. It bundles five **genuinely different cognitive operations** under one label:

| Operation | Type | Domain Knowledge? | Cross-Question? |
|-----------|------|--------------------|-----------------|
| Map slides to questions | Structural | No | No |
| Extract sources per question | Structural | No | No |
| Identify technical claims | Domain-semantic | Yes (blockchain) | No |
| Detect synthesis vs extraction patterns | Comparative-semantic | Partial | **Yes** |
| Audit Q5 reflection coverage | Structural-semantic | Partial | **Yes** |

Combining these into one agent creates a context overload problem — the agent would need structural parsing rules, blockchain domain knowledge, and cross-document semantic analysis all loaded simultaneously. Decomposing into specialists gives each agent a narrower, more tractable problem, clearer definitions of done, and independently testable proofs.

**Roster: 7 specialist agents** across 4 execution waves.

---

## Execution Dependency Graph

```
WAVE 1 ─── Submission Curator
                │
WAVE 2 ────────┼──── Format Sentinel ──────────────────┐
                └──── Deck Cartographer ─────┬──────────┤
                                             │          │
WAVE 3 ──────────────────────────────────────┼──── Claims Analyst ──┐
                                             ├──── Synthesis Scout ─┤
                                             └──── Reflection Auditor┤
                                                                      │
WAVE 4 ───────────────────────────────────────────────────────────────┴── Anomaly Sentinel
```

---

## The Roster

| Wave | Subtask | Agent Title | Definition of Done | Tools Required | Context Required | Skills Required | Proof of Done |
|------|---------|-------------|-------------------|----------------|-----------------|----------------|---------------|
| **1** | 1.1 — Gather & organise all 50 submissions | **Submission Curator** | All 50 student submissions are downloaded, converted to a standardised format (PDF), integrity-verified, and logged in a tracking register with student ID, file reference, submission timestamp, and any access issues documented. | File system tools (read/write/move), PDF converter (pptx→pdf, gslides→pdf), hash verification, HTTP client (for Google Slides links), structured output writer | Submission portal URL, authentication credentials, file naming convention, tracking register schema | Parallelisation & scale (A:9), Handling ambiguous input (A:9), Output consistency (A:7), Error containment (A:4) | **[Tracking Register]** — A complete table with 50 rows: {student_id, file_path, original_format, pdf_path, hash, download_status, timestamp}. Every row has `download_status = success` or a documented failure reason. **No missing or corrupted files.** |
| **2** | 1.2 — Run format compliance checks on all 50 | **Format Sentinel** | Every submission is checked against all format rules from the assignment brief, and a per-student compliance report is produced showing pass/fail per rule with specific evidence. | PDF page/slide parser, text extractor, regex engine, structured output writer | [CP] Format penalty policy — which rules are hard constraints, which are advisory, what penalty applies to each violation. Assignment brief format rules: (1) max 2 slides per question, (2) questions clearly identified on slides, (3) sources listed per question, (4) market data sources include website + date/time accessed, (5) Q5 addresses each of Q1–Q4 individually | Output consistency (A:7), Parallelisation & scale (A:9), Motivational consistency (A:9), Approval fatigue resistance (A:9), Error containment (A:4) | **[Compliance Report] ×50** — Per student: {slide_count_per_question, question_labels_present: bool, sources_per_question: list, market_data_datetime_present: bool, q5_per_section_coverage: {Q1: bool, Q2: bool, Q3: bool, Q4: bool}}. Every field populated. Any rule violation flagged with the specific slide number and rule reference. |
| **2** | 1.3a — Map slides to questions; extract sources per question | **Deck Cartographer** | Every slide in every submission is mapped to the question it addresses (Q1–Q5 or unclassified), and every source cited on each slide is extracted with its full reference text and location. | PDF page/slide parser, text extractor, regex engine, structured output writer | Assignment brief question text (Q1–Q5 wording), question identifier patterns (students may label slides "Q1", "Question 1", "Blockchain Concepts", etc.). [CP] rubric-to-question mapping — agent must know which questions map to which criteria to flag relevant content | Handling ambiguous input (A:9), Output consistency (A:7), Context management (A:6), Zero-shot generalisation (A:8) | **[Deck Map] ×50** — Per student: {slides: [{slide_num, question_assigned, confidence, source_refs: [{ref_text, location}]}]}. Every slide assigned to a question. Confidence score on each assignment. Unclassified slides flagged. Source references extracted verbatim, not paraphrased. |
| **3** | 1.3b — Identify & extract technical claims per question | **Claims Analyst** | For each question (Q1–Q4), every substantive technical claim the student makes is extracted, tagged with its domain concept, and classified as accurate/inaccurate/ambiguous. | Text extractor, structured output writer, web search tool (optional — for verifying claims against authoritative sources) | [CP] rubric-to-question mapping for C1. Domain reference: Q1 definitions (Immutability, Decentralised Consensus, Scalability, Bitcoin Mining), Q2 Taproot purpose and mechanism, Q3 price movement events and causes, Q4 first-mover advantage concept. [Deck Map] from Deck Cartographer — which slides belong to which question | Reasoning & judgment (A:7), Handling ambiguous input (A:9), Zero-shot generalisation (A:8), Hallucination resistance (A:4 — critical: must flag uncertainty rather than fabricate accuracy judgments) | **[Claims Register] ×50** — Per student per question: {question, claims: [{claim_text, slide_ref, domain_concept, accuracy: accurate|inaccurate|ambiguous|unverifiable, confidence, evidence_if_flagged}]}. Every substantive claim extracted. Accuracy labels grounded in domain reference, not the agent's parametric knowledge alone. Low-confidence claims explicitly flagged for human review. |
| **3** | 1.3c — Detect cross-question evidence of synthesis vs extraction | **Synthesis Scout** | For each submission, evidence of synthesis (connecting ideas across sources/questions) vs extraction (listing information from individual sources) is identified with specific passages cited as evidence. | Text extractor, structured output writer | [CP] C2 boundary definitions — what "synthesised" vs "extracted" looks like in practice. [CP] rubric-to-question mapping for C2. [Deck Map] from Deck Cartographer — needed to know which content belongs to which question for cross-question analysis. Assignment brief audience definition ("manager with limited reading time") — synthesis evidence includes accessibility indicators | Reasoning & judgment (A:7), Handling ambiguous input (A:9), In-context adaptability (A:8), Hallucination resistance (A:4 — must not fabricate synthesis where none exists), Zero-shot generalisation (A:8) | **[Synthesis Evidence Report] ×50** — Per student: {synthesis_indicators: [{indicator_type: cross_source_connection|cross_question_connection|integrated_explanation|accessible_reformulation, passage_text, slide_refs, confidence}], extraction_indicators: [{indicator_type: source_listing|sequential_summaries|no_cross_references, passage_text, slide_refs}], audience_accessibility: {jargon_used: [terms], jargon_explained: [terms], plain_language_examples: [{text, slide_ref}]}}. Both synthesis AND extraction evidence captured. No student rated — evidence is presented for human judgment. |
| **3** | 1.3d — Audit Q5 reflection coverage and depth | **Reflection Auditor** | Q5 content is analysed for (1) per-section coverage (does the student reflect on Q1, Q2, Q3, Q4 individually?) and (2) depth classification (is each reflection descriptive, evaluative, or critical?). | Text extractor, structured output writer | [CP] C3 boundary definitions — what "critical" vs "comprehensive" vs "descriptive" looks like. [CP] rubric-to-question mapping for C3. [Deck Map] from Deck Cartographer — which slides are Q5. Assignment brief Q5 requirements ("provide a brief response for each of the previous sections") | Handling ambiguous input (A:9), Zero-shot generalisation (A:8), Output consistency (A:7), Reasoning & judgment (A:7) | **[Reflection Audit] ×50** — Per student: {per_section_coverage: {Q1: {present: bool, depth: descriptive|evaluative|critical, passage_text, slide_ref}, Q2: {...}, Q3: {...}, Q4: {...}}, overall_q5_depth: descriptive|evaluative|critical, ai_usage_transparency: {tools_named: [tool_names], process_described: bool, outputs_verified: bool, specific_examples_cited: bool}}. Every section accounted for. Depth classified with supporting passage. Transparency indicators extracted. |
| **4** | 1.4 — Flag anomalies across all 50 submissions | **Anomaly Sentinel** | Anomalies detected by any upstream agent are consolidated, cross-referenced across the cohort, and classified by severity and type. Cohort-level patterns are surfaced. | Structured output writer, statistical computation tools (for cohort-level pattern detection) | ALL upstream outputs: [Compliance Report] ×50, [Deck Map] ×50, [Claims Register] ×50, [Synthesis Evidence Report] ×50, [Reflection Audit] ×50. [CP] format penalty policy (for severity classification) | Handling ambiguous input (A:9), Output consistency (A:7), Context management (A:6), Parallelisation & scale (A:9), Error containment (A:4) | **[Anomaly Register] ×50** — Per student: {anomalies: [{source_agent, anomaly_type, severity: critical|warning|info, description, evidence, human_action_required: bool}]}. **[Cohort Anomaly Summary]** — Cross-student: {format_violation_frequency, common_inaccurate_claims, q5_coverage_patterns, anomaly_rate_per_student, flagged_for_integrity_review: [student_ids]}. Every anomaly traceable to the detecting agent. Cohort patterns visible. Integrity flags isolated from format flags. |

---

## Agent Specifications Summary

| Wave | Agent | Cognitive Operation | Domain Knowledge | Cross-Question | Upstream Dependency |
|------|-------|--------------------|------------------|---------------|--------------------|
| 1 | **Submission Curator** | File management | None | No | None |
| 2 | **Format Sentinel** | Rule application | Brief rules only | No | Submission Curator |
| 2 | **Deck Cartographer** | Structural mapping | Question text | No | Submission Curator |
| 3 | **Claims Analyst** | Domain-semantic extraction | **Blockchain** | No | Deck Cartographer |
| 3 | **Synthesis Scout** | Comparative-semantic detection | C2 rubric language | **Yes** | Deck Cartographer |
| 3 | **Reflection Auditor** | Structural-semantic audit | C3 rubric language | **Yes** | Deck Cartographer |
| 4 | **Anomaly Sentinel** | Synthesis & classification | CP penalty policy | Cohort-level | All above |

---

## Critical Design Notes

### On the Claims Analyst and Hallucination Risk

The Claims Analyst has a **hallucination resistance score of A:4** — the lowest of any agent in the roster. This is the agent most likely to confidently label a claim as "accurate" when it is not, or vice versa. The design must enforce three safeguards:

1. **Domain reference grounding** — The agent must verify claims against the provided domain reference, not its parametric knowledge alone. If the domain reference doesn't address a claim, the label must be `unverifiable`, not guessed.
2. **Confidence scoring** — Every accuracy judgment includes a confidence level. Claims below a confidence threshold are explicitly flagged for human review.
3. **Web search verification** — For claims the agent cannot verify from the domain reference, the web search tool is used as a secondary source. The search results are cited, not trusted blindly.

### On the Synthesis Scout's Non-Judgment Principle

The Synthesis Scout is explicitly prohibited from **rating** the student's synthesis quality. It reports **evidence of synthesis** and **evidence of extraction** — both. The rating (HD/DI/CR/PA/NS for C2) is a human judgment task (Step 2.3, Human-led). This boundary exists because:

- Values alignment on what constitutes "insightful synthesis" is H:8/A:2 — the agent cannot make this call
- The Synthesis Scout's value is in **surfacing evidence**, not **making the judgment**

### On the Reflection Auditor's Depth Classification

The depth classification (`descriptive|evaluative|critical`) is a **pre-analysis**, not a final assessment. It prepares the human for Step 2.4 (Score C3, Human-led) by labelling what kind of reflection the student produced. The human may override these labels. The auditor's value is in ensuring **no section is missed** and **transparency indicators are captured** — tasks where the agent's consistency and scale advantages are decisive.

### On the Anomaly Sentinel's Integrity Boundary

The Anomaly Sentinel flags potential academic integrity issues (e.g., AI output presented without disclosure, identical passages across submissions) but **does not adjudicate** them. Academic integrity decisions are Step 4.4 (Human-led) with Ethical Judgment H:9/A:2. The sentinel provides the evidence; the human makes the ethical call.The roster is complete. The key architectural decision was decomposing subtask 1.3 from a single monolith into four specialist agents — each with a distinct cognitive operation, a clear boundary on what it does NOT do, and a proof standard that makes the output independently verifiable. The execution wave structure ensures no agent waits on data it doesn't need, and the Anomaly Sentinel at the end synthesises all upstream outputs into a coherent anomaly picture for the human.

The three most important design constraints to carry forward:
1. **Hallucination-sensitive agents get stronger grounding requirements** (Claims Analyst)
2. **Evidence-surfacing agents are prohibited from judgment** (Synthesis Scout)
3. **Detection agents are denied adjudication authority** (Anomaly Sentinel)

These map directly to the complementarity gaps: wherever the human-advantage is largest (values alignment, ethical judgment, decision authority), the agent's role contracts to preparation, and the human's role expands to decision.