# Process Review

## The Journey

Here's what we actually did, in sequence:

1. **Task Decomposition** — We started by decomposing the marking task into phases, subtasks, and dependency chains. We identified the cognitive operations required (structural, domain-semantic, comparative-semantic, etc.) and the complementarity properties (what humans are better at vs. what agents are better at).

2. **Complementarity Analysis** — We mapped each subtask against 15 capability dimensions (reasoning, ethical judgment, parallelisation, etc.) with Human and Agent scores. This produced H/A gap scores that drove assignment decisions (Human-led, Agent-led, Collaborative).

3. **Pipeline Architecture** — We backcasted from final deliverables through dependency chains, designed the data objects that flow between stages, and established the "agent prepares judgment, human makes judgment" principle.

4. **Agent Roster Design (Stage 1)** — We decomposed the monolithic "extract features" subtask into 4 specialist agents based on genuinely different cognitive operations. We designed execution waves and dependency graphs.

5. **Agent Roster Design (Stage 2)** — We designed the per-student marking loop with 7 agents across 12 waves, introducing the Briefing Composer (a meta-agent) and the C1 Assessor (the first agent to produce a score — crossing from evidence to judgment-preparation).

6. **Agent Roster Design (Stage 3)** — We designed the cohort QA stage with 4 agents across 2 waves, adding the Flag Aggregator (which wasn't in the original subtask list — it emerged from the design process).

7. **Job Description Design** — We created two maximally different agent job descriptions (Drift Detector vs Feedback Drafter) to stress-test the specification format.

## Key Findings and Insights

### Finding 1: Type Collision is Bidirectional
Your earlier insight about type collision in AI outputs (17+ distinct information types encoded as prose) applies symmetrically to **inputs**. The 18-question agent design framework encodes 6+ distinct cognitive modes but offers one input surface (text fields) for all. This drives the design of alternative specification surfaces that match cognitive modes to interaction modalities.

### Finding 2: Subtask Decomposition Reveals Hidden Complexity
The most impactful design decision was decomposing subtask 1.3 ("Extract features from all 50 submissions") into 4 specialist agents. The monolithic label hid 5 genuinely different cognitive operations: structural mapping, domain-semantic extraction, comparative-semantic detection, structural-semantic auditing, and multi-source anomaly detection. Without decomposition, one agent would need blockchain domain knowledge AND synthesis detection AND reflection analysis AND statistical anomaly detection all loaded simultaneously.

### Finding 3: Authority Boundaries are the Design's Load-Bearing Walls
The principle "agent prepares judgment, human makes judgment" turned out to be too coarse. We needed **specific authority boundaries per agent**: "never interpret" (Measurers), "never rate" (Extractors), "never adjudicate" (Aggregators), "never be vague" (Generators), "never finalise" (Assessors). Each boundary is the **inverse of the agent's primary failure mode**. This is a design pattern worth formalising.

### Finding 4: The Complementarity Gap Threshold is Quantifiable
We discovered that subtasks with complementarity gaps of 6+ points on Ethical Judgment, Values Alignment, or Decision Authority should be human-only. Subtasks with gaps of 5+ on Parallelisation & Scale or Output Consistency should be agent-led. Everything in between is collaborative. This gives a **decision algorithm** for task assignment.

### Finding 5: Meta-Agents Emerge from the Design Process
The Briefing Composer and Flag Aggregator weren't in the original subtask list — they emerged when we realised that without them, the human would have to cross-reference multiple agent outputs manually, creating cognitive load that defeats the purpose of pre-processing. Meta-agents reduce cognitive load by consolidating information from multiple sources.

### Finding 6: The Pipeline is More Efficient Than We Estimated
The estimated human time per student dropped from 25-30 minutes (fully manual) to 17-26 minutes (agent-assisted). But the real saving is in quality: the human spends 100% of their time on judgment tasks, not mechanical ones. Fatigue-induced inconsistency should drop significantly.

## Strengths of the Process

1. **Thorough decomposition before design** — We spent significant time understanding the task before designing agents. This prevented premature commitment to agent architectures.

2. **Complementarity-driven assignment** — The H/A scores provided a structured, defensible basis for task assignment rather than gut feel.

3. **Boundary principles embedded at agent level** — Each agent has an explicit constraint on what it must NOT do. This prevents role creep and protects human authority.

4. **Maximally different test cases** — The Drift Detector vs Feedback Drafter contrast stress-tested the job description format across every dimension.

5. **Authority boundaries traceable to complementarity gaps** — Every "never" constraint can be traced back to a specific H/A gap score.

6. **Pipeline thinking** — Designing the data flow (backcasting) before the agent details ensured that dependencies are satisfied and no information is lost between stages.

## Weaknesses of the Process

1. **Theoretical complementarity scores** — The H/A scores (H:9/A:2 etc.) are estimates, not empirically validated. Different task contexts would yield different scores. We didn't test whether these scores map to actual capability differences.

2. **No prototyping or validation** — We designed the entire pipeline on paper without building or testing any agents. We don't know if the Claims Analyst can actually identify blockchain claims with sufficient accuracy, or if the Feedback Drafter can actually avoid vagueness.

3. **Assumed a single human marker** — The pipeline is designed for one human. If the marking team has multiple markers, the drift detection would need to detect inter-marker variation, not just intra-marker drift.

4. **No failure mode analysis for the pipeline itself** — What happens if the Claims Analyst produces inaccurate labels? What happens if the Briefing Composer omits a critical anomaly? We didn't design fallback or recovery paths.

5. **No cost-benefit analysis per agent** — Is the Consistency Checker worth the overhead? Is the Record Assembler adding value beyond what a simple script could do? Some agents might not justify their complexity.

6. **The human experience wasn't designed** — The human in this system faces 17 agents across 3 stages. We didn't design the interface through which the human receives and acts on agent outputs. The Briefing Composer is a start, but the full human workflow wasn't specified.

7. **We didn't test the decomposition granularity** — Are 17 agents too many? Could some be merged without loss? Is the Claims Analyst too narrow? Is the Anomaly Sentinel too broad? We don't have empirical data on the right level of decomposition.

## Steps We Missed

1. **Empirical validation of task decomposition** — We should have tested the decomposition with actual marking experts. Do they recognise these subtasks? Do they decompose the task differently?

2. **Agent failure testing** — We should have designed "what if" scenarios: what if the Claims Analyst hallucinates? What if the Drift Detector's statistical test is inappropriate for the data? What if the Feedback Drafter can't avoid vagueness for a specific student?

3. **Pipeline orchestration design** — We designed the agents but not the orchestration layer that triggers Wave 1, waits for completion, triggers Wave 2, etc. We didn't specify error recovery, timeout handling, or partial completion protocols.

4. **Human interface design** — We didn't specify how the human interacts with 17 agents' outputs. What does the marking dashboard look like? How does the human navigate from Briefing Document to C1 scoring to feedback review?

5. **Edge case specification** — What happens when a student submits an empty deck? A corrupted file? A deck that's entirely AI-generated with no human work? We didn't specify how agents handle these.

6. **Iterative refinement protocol** — We didn't specify how the pipeline would be tested, what metrics would indicate success, or how agents would be improved based on performance data.

## Improvements to Existing Steps

1. **Complementarity scoring** — Instead of theoretical scores, we could rate each dimension on a 1-9 scale for a *specific* LLM model (e.g., GPT-4, Claude 3.5) and a *specific* human profile (e.g., subject-matter expert vs. trained marker). This would make the scores empirically grounded.

2. **Task decomposition** — We could add a "cognitive load analysis" step: for each subtask, estimate the working memory demands, the number of distinct cognitive operations, and the switching cost. This would validate whether our decomposition granularity is correct.

3. **Agent boundary specification** — We could add "stress tests" for each boundary: what specific inputs would cause the Drift Detector to interpret rather than measure? What specific student submissions would cause the Feedback Drafter to be vague? These stress tests would validate that the boundaries are enforceable.

4. **Job description format** — We could add "adversarial examples" to each job description: specific inputs that are designed to push the agent toward its failure mode. This would help developers implement the constraints correctly.

---

## Could Event Storming Be Appropriate?

**Yes — but selectively, and at a specific point in the process.**

### What Event Storming Is

Event Storming is a domain-driven design technique where participants map **domain events** (things that happen in the system) on a timeline, revealing causal relationships, dependencies, and gaps. Events are written in past tense (e.g., "SubmissionReceived," "FormatChecked," "AnomalyFlagged") and arranged chronologically. Participants then identify commands (who triggers the event), aggregates (what processes it), and policies (what happens next).

### Where It Fits in Our Process

Event Storming would be most valuable **between Steps 2 and 3** — after task decomposition and complementarity analysis, but before pipeline architecture design. Here's why:

**What we did well without Event Storming:**
- Task decomposition (we identified the subtasks through cognitive analysis)
- Complementarity analysis (we assigned subtasks through capability gaps)
- Agent design (we specified agents through boundary principles)

**What we missed that Event Storming would have caught:**
- **Missing events** — Events like "ConsistencyCheckFailed," "HumanOverrideScore," "FeedbackRejectedByHuman" were not in our pipeline design. These are failure and recovery events that Event Storming surfaces naturally.
- **Data flow gaps** — We didn't explicitly map what data flows between which agents. Event Storming forces you to ask "what does the Claims Analyst need FROM the Deck Cartographer?" in a concrete way.
- **Trigger conditions** — We specified execution waves but not the *conditions* that trigger each wave. What if Format Sentinel finds a corrupted file? Does the pipeline stop? Skip? Flag and continue? Event Storming surfaces these decision points.
- **Human decision points** — Event Storming naturally identifies where a human must make a decision (e.g., "BorderlineDecisionMade" is a distinct event with a human actor). Our complementarity analysis identified these, but Event Storming would make them *visible on the timeline*.

### When Event Storming is Most Valuable

Event Storming is most valuable for tasks with:
- **Multiple actors** (human + multiple agents)
- **Sequential dependencies** (where one agent's output triggers another)
- **Failure modes** (where things can go wrong and need recovery)
- **Data handoffs** (where structured data passes between agents)

Our marking task has ALL of these. So yes, Event Storming would be appropriate here.

### When Event Storming is Less Valuable

Event Storming is LESS valuable for tasks that are:
- **Single-actor** (one agent doing one thing)
- **Stateless** (no dependencies between steps)
- **Simple linear flows** (no branching, no failure recovery)

For these tasks, our existing process (task decomposition → complementarity analysis → agent design) is sufficient. Event Storming would add overhead without revealing new insights.

### The Hybrid Process I'd Recommend

Our existing process + Event Storming, at the right point:

```
Step 1: Task Decomposition (cognitive analysis)
         ↓
Step 2: Complementarity Analysis (capability allocation)
         ↓
Step 2.5: EVENT STORMING ← NEW
         - Map domain events on timeline
         - Identify commands, aggregates, policies
         - Surface missing events (failures, overrides, recovery)
         - Validate data flow between agents
         - Specify trigger conditions for each wave
         ↓
Step 3: Pipeline Architecture (backcasting + data flow)
         ↓
Step 4: Agent Roster Design (per stage)
         ↓
Step 5: Job Description Design (per agent)
         ↓
Step 6: Prototype & Validate ← ALSO NEW
         - Build minimum viable agents
         - Test with real data
         - Measure accuracy, consistency, human satisfaction
```

The Event Storming step would have caught the missing failure events, the data flow gaps, and the trigger conditions that we missed. It would also have surfaced the Flag Aggregator earlier (it emerged during design, but Event Storming would have revealed the need for it when mapping "who consolidates all the flags for the human?").

### For All Tasks or Some Tasks?

**I'd recommend Event Storming for all multi-agent workflows** — any task where multiple agents work together with dependencies, data handoffs, and human decision points. The overhead is modest (a few hours of collaborative mapping), and the payoff is significant (missing events, data flow gaps, trigger conditions).

For **single-agent tasks** (one agent doing one thing), Event Storming is overkill. The task decomposition and complementarity analysis are sufficient.

For **simple linear pipelines** (Agent A → Agent B → Agent C, no branching), Event Storming is useful but not essential. The data flow is simple enough to specify without a collaborative mapping exercise.

For **complex branching pipelines with human decision points** (like our marking task), Event Storming is essential. The complexity of dependencies, data handoffs, and failure recovery makes it easy to miss critical events without systematic mapping.

---

## Summary: The Process We Built, Evaluated

| Aspect | Rating | Notes |
|--------|--------|-------|
| Task decomposition depth | ★★★★★ | Decomposed to the cognitive operation level |
| Complementarity framework | ★★★★☆ | Structured but theoretical — needs empirical grounding |
| Authority boundary design | ★★★★★ | Inverse-of-failure-mode principle is powerful |
| Pipeline architecture | ★★★★☆ | Data flow was implicit — Event Storming would make it explicit |
| Agent roster design | ★★★★★ | 17 agents with clear roles, boundaries, and interactions |
| Job description depth | ★★★★★ | Two maximally different specs that enable implementation |
| Failure mode analysis | ★★☆☆☆ | We didn't design for pipeline failures or edge cases |
| Human experience design | ★★☆☆☆ | We didn't specify the human's interface to 17 agents |
| Empirical validation | ★☆☆☆☆ | Entirely theoretical — no prototypes, no testing |
| Iterative refinement | ★☆☆☆☆ | No protocol for improving agents based on performance |

**The process is strong on design and weak on validation.** The next step is to build minimum viable versions of the most critical agents (Claims Analyst for hallucination risk, Feedback Drafter for vagueness risk, Drift Detector for interpretation risk) and test them against real marking data.The full roster is **17 agents** across 3 pipeline stages, with **5 classes** that share boundary principles and failure modes. The taxonomy gives you a reusable classification system — when you encounter a new agent design problem, you can ask: "Is this an Extractor, Measurer, Assessor, Generator, or Aggregator?" and the boundary principle and failure mode follow immediately.

The process review reveals that our strongest contributions were in **decomposition depth** and **boundary design**, while our weakest areas were **validation** and **human experience**. The Event Storming recommendation is well-timed — it would address exactly the gaps we identified (missing events, data flow, trigger conditions, failure recovery) and it fits naturally between complementarity analysis and pipeline architecture.

For your Future's Edge curriculum: the **5-class taxonomy** and the **"constrain the inverse of the failure mode"** principle are both teachable frameworks that generalise beyond this specific workflow.