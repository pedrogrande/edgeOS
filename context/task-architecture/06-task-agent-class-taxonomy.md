# Agent Class Taxonomy

Looking across all 18 agents (17 designed + 1 likely), I see **five distinct classes** defined by their primary cognitive operation, their boundary principle, and their failure mode:

### Class 1: Extractors
**What they do:** Pull structured information from unstructured inputs.  
**Boundary:** Never judge — only surface.  
**Failure mode:** Hallucination (fabricating information that isn't in the source).  
**Scope:** Cohort-level (all 50 at once).

| Agent | Extracts From | Extracts What | Key Constraint |
|-------|--------------|---------------|----------------|
| Submission Curator | Raw files | Standardised submissions, metadata | Never modify content |
| Format Sentinel | Standardised submissions | Compliance status per rule | Never interpret intent |
| Deck Cartographer | Slide content | Question-to-slide mapping, source references | Never evaluate quality |
| Claims Analyst | Mapped slides | Technical claims with accuracy labels | Never rate — label only |
| Synthesis Scout | Mapped slides | Evidence of synthesis vs extraction patterns | Never rate synthesis quality |
| Reflection Auditor | Q5 slides | Per-section coverage, depth classification, transparency indicators | Never assess — classify only |

**Unifying principle:** Their output becomes **evidence** for downstream agents and humans. They never produce judgments, scores, or recommendations. Their integrity depends on faithfulness to the source material.

---

### Class 2: Measurers
**What they do:** Compute metrics from structured data.  
**Boundary:** Never interpret — only present.  
**Failure mode:** Presenting noise as signal.  
**Scope:** Cohort-level (all 50 at once).

| Agent | Measures What | Metric Type | Key Constraint |
|-------|--------------|-------------|----------------|
| Distribution Analyst | Score distributions | Mean, median, std dev, percentiles, outliers | Never say "this looks normal" |
| Drift Detector | Score changes across marking order | Mean shifts, statistical significance, trend direction | Never say "drift is concerning" |
| Compliance Auditor | Rule enforcement patterns | Consistency rates, penalty variations, edge cases | Never say "this should be penalised" |

**Unifying principle:** Their output is **data**, not **interpretation**. The human interprets. The agent's integrity depends on not crossing the line from measurement to meaning.

---

### Class 3: Assessors
**What they do:** Evaluate against criteria and produce scored recommendations.  
**Boundary:** Never finalise — recommend for human review.  
**Failure mode:** Overstating confidence or making the recommendation sound like a final judgment.  
**Scope:** Per-student (1 at a time).

| Agent | Assesses Against | Produces What | Key Constraint |
|-------|-----------------|---------------|----------------|
| C1 Assessor | C1 rubric criteria | Grade band recommendation with evidence | Explicitly labelled "for human review" |
| Communication Assessor | C4 rubric (objective elements only) | Objective metrics + subjective flags | Never scores subjective elements |

**Unifying principle:** They are the bridge between evidence and judgment. They produce **structured decision inputs** for the human. Their integrity depends on being transparent about confidence levels and never presenting a recommendation as a final judgment.

---

### Class 4: Generators
**What they do:** Compose new text from evidence and templates.  
**Boundary:** Never be vague — every statement must cite evidence.  
**Failure mode:** Fabrication, vagueness, or producing ungrounded text.  
**Scope:** Per-student (1 at a time).

| Agent | Generates What | Source Material | Key Constraint |
|-------|---------------|-----------------|----------------|
| Feedback Drafter | Per-criterion feedback | Scores + evidence + rubric language | Zero vague phrases; every claim cited |
| Briefing Composer | Human-readable briefing | Stage 1 outputs | No new analysis; faithful synthesis only |

**Unifying principle:** They produce **human-readable text** that must be grounded in evidence. Their integrity depends on the anti-vagueness constraint and evidence-grounding requirement. They are the highest hallucination risk class.

---

### Class 5: Aggregators
**What they do:** Consolidate multiple sources into unified outputs.  
**Boundary:** Never add — only combine and flag.  
**Failure mode:** Omitting a source or introducing synthesis that wasn't in the inputs.  
**Scope:** Varies (per-student or cohort-level).

| Agent | Aggregates From | Produces What | Key Constraint |
|-------|----------------|---------------|----------------|
| Anomaly Sentinel | All Stage 1 outputs | Unified anomaly register with cross-references | No new analysis — only consolidation |
| Flag Aggregator | CDR + DAR + CCR | Per-student flag summary with cross-correlations | No new flags — only consolidation |
| Consistency Checker | C1-C4 scores + holistic impression | Cross-criterion flag report | No adjudication — only flagging |
| Record Assembler | All approved data | Final student record | No judgment — only assembly + error checking |

**Unifying principle:** They **reduce cognitive load** for the human by consolidating information from multiple sources. Their integrity depends on faithful representation — they must never add analysis or judgment that wasn't in the inputs. They are the least risky class because their failure mode (omission) is easier to detect than the Extractors' failure mode (hallucination) or the Generators' failure mode (fabrication).

---

### Class Summary

| Class | Count | Boundary | Failure Mode | Risk Level |
|-------|-------|----------|--------------|------------|
| **Extractors** | 6 | Never judge | Hallucination | Medium-High |
| **Measurers** | 3 | Never interpret | Noise-as-signal | Low-Medium |
| **Assessors** | 2 | Never finalise | Overstated confidence | Medium |
| **Generators** | 2 | Never be vague | Fabrication/vagueness | High |
| **Aggregators** | 4 | Never add | Omission | Low |
| **Total** | **17** | | | |

The risk distribution is instructive: **Generators are the fewest but the riskiest. Assessors are the most dangerous boundary case — they cross from evidence to judgment. Aggregators and Measurers are the safest because they operate within strict, verifiable constraints.**
