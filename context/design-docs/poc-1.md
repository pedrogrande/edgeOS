# PoC 1: The Caste Panel

***

## What We're Proving

Three falsifiable claims, in order of importance: 

1. **Caste agents reliably produce orientation-aligned outputs** — the `critical` agent reliably spots risk, the `creative` agent reliably generates novelty, etc. If this doesn't hold, nothing else in the framework works.
2. **The diverse pipeline produces higher-quality outputs than a single agent** on complex, open-ended problems
3. **The `integrative` synthesiser adds value** — its output is better than the best individual caste output alone

***

## Architecture

```
INPUT: Problem Statement
         │
         ├──────────────────────────────────────────┐
         │                                          │
   CONTROL ARM                              EXPERIMENTAL ARM
         │                                          │
  [Single General                    ┌──────────────┼──────────────┐
   Purpose Agent]                    │              │              │
         │                    [critical]     [creative]    [factual]
         │                           │              │              │
   OUTPUT_A                   [empathic]    [procedural]           │
                                     └──────────────┴──────────────┘
                                                    │
                                           PASS 1 OUTPUTS
                                                    │
                                     (agents see peer summaries)
                                                    │
                                           PASS 2 OUTPUTS
                                                    │
                                       [integrative synthesiser]
                                                    │
                                              OUTPUT_B
         │                                          │
         └──────────────────┬───────────────────────┘
                            │
                     EVALUATION LAYER
                    (human scoring rubric)
```

***

## Component 1: The Problem Set

The problem set is the most important design decision — wrong problems will produce inconclusive results.

**Requirements for a good PoC problem:**
- Must be **open-ended** with no single correct answer (closed questions bias toward the single agent)
- Must be **complex enough** that multiple cognitive orientations each have something genuine to contribute
- Must be **domain-relevant** — use your own framework design decisions as the problem set, so you can actually judge output quality
- Must include **simple problems too** — to test whether the pipeline's overhead is unjustified on low-complexity tasks

**Recommended problem set of 12:**

| # | Problem | Expected Complexity |
|---|---|---|
| 1 | "How should an autonomous context management system handle a context card that conflicts with a newer policy?" | High |
| 2 | "What should happen when two caste agents produce contradictory outputs?" | High |
| 3 | "Design the retirement criteria for a pattern in the pattern library" | High |
| 4 | "How should an agent signal it has exceeded its context window?" | Medium |
| 5 | "What is the right quorum threshold for pattern crystallisation?" | Medium |
| 6 | "Should the integrative agent be allowed to reject all caste outputs?" | High |
| 7 | "How do we prevent approval fatigue in human-in-the-loop gates?" | High |
| 8 | "What is the minimum proof template for a low-stakes task?" | Medium |
| 9 | "What does 'done' mean for a context curation agent?" | Medium |
| 10 | "How should agent caste assignments be stored in the ontology?" | Low |
| 11 | "What is the best data format for an audit log entry?" | Low |
| 12 | "What should a cold-start onboarding flow for a new autonomous context management system user look like?" | High |

***

## Component 2: Skill Files (Cognitive Orientation Prompts)

Each caste agent receives a **system prompt** that encodes its orientation. These are the `.skill.md` equivalents for the PoC. Keep each one to under 200 words — any longer and you're violating your own minimum sufficient context principle. 

**`skill.critical.md`**
```
You are a critical analyst. Your role is to identify what is wrong, incomplete, 
risky, or dangerously assumed in the proposed solution or problem framing.

Your job is NOT to solve the problem. Your job is to find:
- Hidden assumptions that haven't been validated
- Edge cases and failure modes
- Logical contradictions or circular reasoning
- What is being optimised at the expense of something important
- What question is not being asked that should be

Output format:
- List of risks and concerns (each with a 1-sentence explanation)
- The single most dangerous assumption in the problem as stated
- One reframe: "The real problem might actually be..."
```

**`skill.creative.md`**
```
You are a creative ideator. Your role is to generate novel, unexpected, 
and unconventional responses to the problem.

Your job is NOT to evaluate ideas or find problems. Your job is to:
- Generate as many distinct approaches as possible (aim for 6+)
- Deliberately include at least one approach from an unrelated domain
- Surface the approach that would make most experts uncomfortable
- Identify what constraint, if removed, would unlock the best solution

Output format:
- Numbered list of distinct approaches (brief, no evaluation)
- The "uncomfortable" option with a one-line rationale
- One constraint worth challenging
```

**`skill.factual.md`**
```
You are a factual analyst. Your role is to ground the problem in what is 
verifiably true, what is known, and what the evidence actually supports.

Your job is NOT to speculate or generate ideas. Your job is to:
- Identify what is factually established vs. assumed in the problem
- Distinguish what we know from what we are guessing
- Surface what additional information would change the answer
- Provide only claims you can support with explicit reasoning

Output format:
- What we know (with basis)
- What we are assuming (with flag)
- What we need to know (with impact statement)
- The most evidence-backed approach available
```

**`skill.empathic.md`**
```
You are a human-impact analyst. Your role is to assess every dimension of 
the problem through the lens of human experience, values, and consequence.

Your job is NOT to find technical solutions. Your job is to:
- Identify who is affected by this decision and how
- Surface values conflicts embedded in the problem
- Identify the solution that serves human flourishing vs. the one that merely solves the stated problem
- Raise any ethical constraints that should be non-negotiable

Output format:
- Who is affected and how (each stakeholder group)
- Values in tension (list)
- The human-centred constraint that must not be violated
- Recommended approach from a human flourishing perspective
```

**`skill.procedural.md`**
```
You are an implementation analyst. Your role is to assess how a solution 
would actually work in practice — operability, sequencing, and failure modes.

Your job is NOT to generate new ideas. Your job is to:
- Identify the implementation sequence that minimises irreversible steps
- Surface the operability gaps in proposed approaches
- Identify what breaks first under load or edge conditions
- Recommend the simplest implementation that tests the core assumption

Output format:
- Implementation sequence (ordered steps)
- Top 3 operability risks
- What breaks first
- Minimum viable implementation
```

**`skill.integrative.md`**
```
You are an integrative synthesiser. You will receive outputs from 5 specialist 
agents who have each analysed the same problem from a distinct orientation.

Your job is to:
- Identify where agents converged (high-confidence signal)
- Identify productive tensions (where disagreement reveals a genuine trade-off)
- Identify blind spots (what no agent addressed that should have been)
- Produce a synthesised recommendation that incorporates the strongest insights from each orientation
- Explicitly attribute which orientation contributed which key insight

Output format:
- Points of convergence
- Productive tensions (and how to navigate each)
- Blind spots identified
- Synthesised recommendation (with attribution)
- Confidence level: HIGH / MEDIUM / LOW with brief rationale
```

***

## Component 3: The Orchestrator

A single Python script. No framework, no database — just clean logic. 

```python
# poc1_orchestrator.py

import asyncio
import json
import time
from datetime import datetime
from pathlib import Path
import anthropic  # or openai — swap as needed

client = anthropic.Anthropic()
MODEL = "claude-sonnet-4-5"  # use same model for all agents

# Load skill files
def load_skill(caste: str) -> str:
    return Path(f"skills/skill.{caste}.md").read_text()

CASTES = ["critical", "creative", "factual", "empathic", "procedural"]

# Single agent run (control arm)
def run_control_agent(problem: str) -> dict:
    start = time.time()
    response = client.messages.create(
        model=MODEL,
        max_tokens=1024,
        system="You are a thoughtful, balanced analyst. Respond to the problem with your best analysis and recommendation.",
        messages=[{"role": "user", "content": problem}]
    )
    return {
        "agent": "control",
        "output": response.content[0].text,
        "tokens": response.usage.input_tokens + response.usage.output_tokens,
        "latency_ms": round((time.time() - start) * 1000)
    }

# Single caste agent run
def run_caste_agent(caste: str, problem: str, peer_context: str = "") -> dict:
    skill = load_skill(caste)
    user_message = problem
    if peer_context:
        user_message = f"{problem}\n\n---\nPeer analysis summaries for context:\n{peer_context}"
    
    start = time.time()
    response = client.messages.create(
        model=MODEL,
        max_tokens=1024,
        system=skill,
        messages=[{"role": "user", "content": user_message}]
    )
    return {
        "agent": caste,
        "output": response.content[0].text,
        "tokens": response.usage.input_tokens + response.usage.output_tokens,
        "latency_ms": round((time.time() - start) * 1000)
    }

# Integrative synthesiser
def run_synthesiser(problem: str, caste_outputs: list[dict]) -> dict:
    skill = load_skill("integrative")
    peer_summaries = "\n\n".join([
        f"[{r['agent'].upper()} AGENT]:\n{r['output']}" 
        for r in caste_outputs
    ])
    user_message = f"PROBLEM:\n{problem}\n\n---\nSPECIALIST OUTPUTS:\n{peer_summaries}"
    
    start = time.time()
    response = client.messages.create(
        model=MODEL,
        max_tokens=2048,
        system=skill,
        messages=[{"role": "user", "content": user_message}]
    )
    return {
        "agent": "integrative",
        "output": response.content[0].text,
        "tokens": response.usage.input_tokens + response.usage.output_tokens,
        "latency_ms": round((time.time() - start) * 1000)
    }

# Full pipeline for one problem
def run_pipeline(problem_id: str, problem: str) -> dict:
    timestamp = datetime.utcnow().isoformat()
    run = {"problem_id": problem_id, "problem": problem, "timestamp": timestamp}

    # CONTROL ARM
    print(f"[{problem_id}] Running control agent...")
    run["control"] = run_control_agent(problem)

    # EXPERIMENTAL ARM — Pass 1 (blind, parallel in spirit; sequential here for simplicity)
    print(f"[{problem_id}] Running caste agents (pass 1)...")
    pass1_outputs = []
    for caste in CASTES:
        result = run_caste_agent(caste, problem)
        pass1_outputs.append(result)

    run["pass1"] = pass1_outputs

    # EXPERIMENTAL ARM — Pass 2 (with peer summaries)
    print(f"[{problem_id}] Running caste agents (pass 2 with peer context)...")
    peer_context = "\n\n".join([
        f"[{r['agent'].upper()}]: {r['output'][:300]}..."  # summarise to avoid bloat
        for r in pass1_outputs
    ])
    pass2_outputs = []
    for caste in CASTES:
        result = run_caste_agent(caste, problem, peer_context)
        pass2_outputs.append(result)

    run["pass2"] = pass2_outputs

    # SYNTHESISER
    print(f"[{problem_id}] Running integrative synthesiser...")
    run["synthesis"] = run_synthesiser(problem, pass2_outputs)

    # TOTALS
    all_results = [run["control"]] + pass1_outputs + pass2_outputs + [run["synthesis"]]
    run["total_tokens_control"] = run["control"]["tokens"]
    run["total_tokens_experimental"] = sum(r["tokens"] for r in pass1_outputs + pass2_outputs + [run["synthesis"]])

    return run

# Main
if __name__ == "__main__":
    problems = json.loads(Path("problems.json").read_text())
    results = []
    for p in problems:
        result = run_pipeline(p["id"], p["problem"])
        results.append(result)
        Path(f"results/{p['id']}.json").write_text(json.dumps(result, indent=2))
        print(f"[{p['id']}] Done. Control: {result['total_tokens_control']} tokens | Experimental: {result['total_tokens_experimental']} tokens\n")
    
    Path("results/all_results.json").write_text(json.dumps(results, indent=2))
    print("All runs complete.")
```

***

## Component 4: The Evaluation Rubric

Human evaluation is the ground truth. Use this rubric to score both `OUTPUT_A` (control) and `OUTPUT_B` (synthesis) **blind** — the evaluator doesn't know which is which. 

**Scoring sheet per problem (1–5 scale):**

| Dimension | What to Look For |
|---|---|
| **Completeness** | Did it address all meaningful angles of the problem? |
| **Blind spot coverage** | Did it identify risks or considerations that weren't obvious? |
| **Actionability** | Could you act on this output without asking a clarifying question? |
| **Internal consistency** | Does the reasoning hold together without contradiction? |
| **Novelty** | Did it produce at least one non-obvious insight or approach? |

**Caste reliability check** (score each caste agent separately, pass 1 only):

- Did the `critical` agent identify at least 2 genuine risks? Y/N
- Did the `creative` agent produce 5+ meaningfully distinct options? Y/N
- Did the `factual` agent distinguish known facts from assumptions? Y/N
- Did the `empathic` agent surface a human-impact consideration others missed? Y/N
- Did the `procedural` agent identify an implementation sequence? Y/N

This is the data that validates whether caste orientation actually works — if `critical` agents aren't reliably critical, the skill files need redesigning before building anything larger. [ppl-ai-file-upload.s3.amazonaws](https://ppl-ai-file-upload.s3.amazonaws.com/web/direct-files/collection_a4efe091-97be-43ae-a6a3-a10bf38025af/736a8130-a45b-4fe9-bef2-45c23d7e9939/i-want-to-think-through-the-de-1uknqXF9SA6WXLfbDBtvQw.md)

***

## Directory Structure

```
poc1/
├── skills/
│   ├── skill.critical.md
│   ├── skill.creative.md
│   ├── skill.factual.md
│   ├── skill.empathic.md
│   ├── skill.procedural.md
│   └── skill.integrative.md
├── problems.json
├── results/
│   └── (auto-generated per run)
├── evaluation/
│   ├── rubric.md
│   └── scores.csv         (filled in manually after blind review)
├── poc1_orchestrator.py
└── poc1_analysis.py       (aggregates scores, calculates token ratios)
```

***

## What to Do With Results

After running all 12 problems and scoring blind:

- **If caste reliability < 70%** — the skill files are the problem; redesign orientation prompts before any further PoC
- **If experimental pipeline beats control on high-complexity problems but not low-complexity ones** — the PF1 principle is validated; the framework should apply mandatory caste panels only above a complexity threshold 
- **If the synthesiser output is no better than the best single caste output** — the integrative agent's skill file needs redesigning, or pass 2 cross-pollination isn't adding value
- **If token cost of experimental arm is >8x the control arm** — the pipeline needs compression; likely the peer summaries in pass 2 are too long