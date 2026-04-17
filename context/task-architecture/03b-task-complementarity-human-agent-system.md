# Human-Agent-System Complementarity Matrix

| Property | Human | Agent | System |
|---|:---:|:---:|:---:|
| Handling ambiguous input | 7 | 9 | 1 |
| Zero-shot generalisation | 8 | 8 | 1 |
| Reasoning & judgment | 9 | 7 | 1 |
| Commonsense inference | 9 | 7 | 1 |
| Creative problem framing | 9 | 4 | 1 |
| Novel situation reasoning | 8 | 5 | 1 |
| Double-loop learning | 8 | 3 | 1 |
| Generation & creativity | 9 | 7 | 1 |
| Output consistency | 5 | 7 | 9 |
| Hallucination resistance | 7 | 4 | 9 |
| Goal alignment | 7 | 6 | 7 |
| In-context adaptability | 7 | 8 | 1 |
| Semantic & social skill | 9 | 7 | 1 |
| Ethical judgment | 9 | 2 | 1 |
| Values alignment | 8 | 2 | 1 |
| Decision authority | 9 | 2 | 1 |
| Reversibility awareness | 8 | 5 | 3 |
| Behaviour under observation | 5 | 6 | 9 |
| Parallelisation & scale | 2 | 9 | 9 |
| Motivational consistency | 5 | 9 | 9 |
| Cognitive bias resistance | 4 | 6 | 9 |
| Approval fatigue resistance | 4 | 9 | 9 |
| Manipulation resistance | 6 | 4 | 7 |
| Context management | 6 | 6 | 4 |
| Error containment | 6 | 4 | 8 |
| Cognitive diversity preservation | 6 | 4 | 1 |
| Skill preservation | 5 | 8 | 9 |

---

### Reading the Pattern

The System column creates a stark profile: **9s and 1s, almost nothing in between.** System is extreme — near-perfect at mechanical operations, near-zero at everything requiring understanding. This is the insight that drives the ternary allocation priority: System gets first refusal because it eliminates an entire failure mode category (hallucination, inconsistency, fatigue, bias) at near-zero cost — but only for subtasks that don't require semantic reasoning.

Three clusters emerge:

| Cluster | Properties | Best Actor | Why |
|---|---|---|---|
| **Judgment** | Ethical judgment, values alignment, decision authority, creative problem framing, novel situation reasoning, double-loop learning | **Human** | Scores 8-9 where System scores 1 and Agent scores 2-5 |
| **Semantic** | Handling ambiguous input, in-context adaptability, zero-shot generalisation, semantic & social skill | **Agent** | Agent scores 7-9 where System scores 1; Human is competitive but can't scale |
| **Mechanical** | Output consistency, hallucination resistance, parallelisation & scale, motivational consistency, approval fatigue resistance, cognitive bias resistance | **System** | System scores 9 where Human scores 2-7; Agent is competitive but costs more and hallucinates |

**Goal alignment (7/6/7)** is the interesting outlier — all three actors are reasonably aligned when goals are explicit, but for different reasons: Human aligns through shared values, Agent aligns through instruction following, System aligns through programmed rules. All three degrade when goals become ambiguous, just through different failure modes.

**Manipulation resistance (6/4/7)** is another: System is immune to social manipulation but vulnerable to technical exploitation (injection, logic bugs). Agent is vulnerable to both. Human is vulnerable to social manipulation but can detect technical inconsistencies.