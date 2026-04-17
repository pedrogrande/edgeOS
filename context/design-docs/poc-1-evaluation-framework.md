# PoC 1: Evaluation Framework

***

## The Fundamental Evaluation Challenge

The solo agent and the caste panel are being judged on **different** things at different levels: 
- The **solo agent** is judged purely on output quality
- The **caste panel** must be judged on *both* individual caste behaviour *and* collective output quality
- A panel that produces a great synthesis but where the castes didn't actually behave distinctively has proven nothing useful — it just means the integrative agent is good at writing

These are two separate measurement problems and conflating them will corrupt your results.

***

## Layer 1: Output Quality Factors

These apply to both the control and experimental outputs and form the blind comparison.

### Substantive Quality

- **Completeness** — Did it address all the meaningful angles of the problem, or did it implicitly ignore whole dimensions? A solo agent answering a governance question that never considers human impact isn't complete, even if it's technically correct - **Depth of reasoning** — Is the reasoning traceable and explicit, or is the conclusion asserted without derivation? "Use quorum-based approval" is less valuable than "use quorum-based approval *because* single-reviewer bottlenecks are both a throughput risk and a single point of trust failure"
- **Groundedness** — Are all claims supported by explicit reasoning or stated evidence? Or are they plausible-sounding assertions? 
- **Internal consistency** — Does the output contradict itself at any point? Does the recommended approach conflict with a constraint it identified earlier?

### Practical Quality

- **Actionability** — Could a downstream agent or human act on this output without asking a single clarifying question? This is your framework's own test for output excellence 
- **Specificity** — Are recommendations concrete and bounded, or vague and deferring? "Establish a governance process" is not actionable. "Store quorum thresholds as policy Things in the Groups dimension with a default of 3/5" is
- **Proportionality** — Is the response the *right length* for the problem? Longer is not better — an output that buries its key insight in 800 words of padding is worse than a 200-word output with the same insight surfaced first 

### Strategic Quality

- **Problem reframing** — Did either output identify that the stated problem might not be the real problem? This is one of the highest-value cognitive contributions and something a diverse panel *should* be better at than a solo agent - **Non-obvious insight rate** — Count the number of insights that a domain-competent reader would classify as "I hadn't considered that." This is the most direct measure of cognitive value-add
- **Constraint identification** — Did it identify what *must not* be done, not just what should be? Negative constraints are often more valuable than positive recommendations in system design

***

## Layer 2: Cognitive Diversity-Specific Factors

These only apply to the experimental arm and are the PoC's most important measurements.

### Caste Orientation Fidelity

This is the foundational test — before caring about collective output quality, you need to know whether the castes are behaving as designed: 
- **Critical agent** — Did it produce *distinct risk identification* or did it just rephrase the problem? Count the number of genuine risks surfaced vs. restatements of known constraints. A well-oriented critical agent should make you slightly uncomfortable — it should find the thing you didn't want to think about
- **Creative agent** — Did it produce genuinely *distinct* options, or variations of the same idea? Score each option as either "meaningfully different approach" or "variation of option N." A well-oriented creative agent should have at least one option that the solo agent would never have produced
- **Factual agent** — Did it explicitly separate *what we know* from *what we are assuming*? If it never used language like "we are assuming" or "we don't yet know," its orientation fidelity is low
- **Empathic agent** — Did it identify a human stakeholder or values conflict that *neither the solo agent nor any other caste* raised? If every insight the empathic agent produced was also in the solo agent's output, its caste is redundant
- **Procedural agent** — Did it produce a *sequence* or just a list? Implementation thinking is inherently temporal — an unordered list of steps is the procedural agent failing at its orientation

### Complementarity vs. Duplication

The most damaging failure mode for the framework is castes that all produce variations of the same output. Measure this explicitly:

- For each pair of caste outputs, score **overlap** (0–100%): what percentage of the insights in output A also appear in output B?
- If average pairwise overlap across all castes is >50%, the orientation prompts are insufficiently differentiated — the framework's premise is not holding in practice
- Target: average pairwise overlap below 30% for high-complexity problems

### Cross-Pollination Value (Pass 1 vs. Pass 2)

This tests whether the two-pass structure adds value over a single pass: 
- For each caste, compare pass 1 and pass 2 outputs: did seeing peer summaries produce *new* insights, or just longer outputs?
- A well-functioning cross-pollination step should show castes *modifying their position* in response to peers, not just elaborating their original position
- Score each pass 2 output: "modified by peer context" / "extended from pass 1" / "identical to pass 1" — you want a high rate of the first category

### Synthesis Attribution Quality

The integrative agent's output should be explicitly traceable to its contributing castes: 

- Can you identify *which caste* contributed each key insight in the synthesis?
- Did the synthesis identify tensions that only become visible when *two specific castes are read together*? This emergent insight (not visible in any single output) is the highest-value output the panel can produce
- Did the synthesis make a *different recommendation* than the majority of individual castes? If it just picks the most common answer, it's a vote counter, not a synthesiser

***

## Layer 3: Process Quality Factors

These are often overlooked but directly relevant to your framework's claims.

### Transparency and Traceability

- **Attribution density** — In the final synthesis, what percentage of claims can be traced back to a specific caste's contribution? A synthesis that can't be attributed is either (a) the integrative agent doing its own original analysis, or (b) a vague averaging that loses all the caste-specific signal
- **Uncertainty surfacing** — Did any agent flag what it *didn't know* or couldn't resolve? An agent that never raises uncertainty isn't behaving honestly — it's performing confidence - **Tension identification** — Did the synthesis identify cases where two castes gave *contradictory recommendations*? These tensions are not problems to resolve quietly — they are the most important signal the panel produces, because they reveal genuine trade-offs

### Cost-Value Calibration

- **Token cost ratio** — Experimental total tokens ÷ Control total tokens. Target: the panel produces meaningfully better output at <8x the token cost. If it costs 15x for a marginal quality improvement, the architecture isn't viable 
- **Diminishing returns by complexity** — Run the cost-value calculation separately for low, medium, and high complexity problems. The hypothesis is that the ratio improves (gets more favourable) as complexity increases — low-complexity problems should show the panel at its *worst* relative value, high-complexity at its *best*
- **Synthesis length efficiency** — Does the integrative output get *longer* on harder problems, or does it get *more precise*? Length growth on harder problems suggests the synthesiser is padding rather than compressing

***

## Layer 4: Evaluator Bias Factors

This is the one most PoC designs skip — and it invalidates results if ignored.

### Blind Evaluation Protocol

- Both outputs must be labelled **Output A** and **Output B** with no indication of which is control vs. experimental
- If the evaluator knows which is the "panel output," they will unconsciously favour it — this is confirmed evaluator bias in research contexts
- Randomise which output is A vs. B across different problems

### Your Own Cognitive Profile as Evaluator

You have a defined cognitive profile — your top CliftonStrengths theme is **Futuristic** and your top realised strength is **Unconditionality**. This creates *predictable* evaluator biases: 

- You will naturally rate outputs higher that address long-term systemic implications (Futuristic)
- You will naturally rate outputs higher that surface values alignment and human-centred constraints (Unconditionality)
- You may under-rate outputs that are strong on short-term implementation detail but weak on vision

**Mitigation:** Add a secondary evaluator with a different profile for at least 4 of the 12 problems and measure inter-rater agreement. Where you diverge, the problem is likely one where your profile creates bias.

### Familiarity Bias

You wrote the framework the problems are drawn from. You will recognise when an output aligns with your existing thinking and rate it higher — not because it's better, but because it confirms what you already believe. This is confirmation bias at the evaluation layer. 
**Mitigation:** Include 2–3 problems from *outside* the framework domain (e.g., a product design question, a business operations question) where you have no prior position. Your evaluation will be cleaner there.

***

## Composite Scoring Model

| Factor | Weight | Applies To |
|---|---|---|
| Completeness | 15% | Both arms |
| Depth of reasoning | 15% | Both arms |
| Actionability | 15% | Both arms |
| Non-obvious insight rate | 20% | Both arms — highest weight because this is the core claim |
| Problem reframing | 10% | Both arms |
| Caste orientation fidelity | 10% | Experimental only — reported separately |
| Complementarity (low overlap) | 10% | Experimental only — reported separately |
| Synthesis attribution quality | 5% | Experimental only — reported separately |

The **caste-specific scores** (orientation fidelity, complementarity, attribution) should be reported *separately* from the output quality comparison — they answer a different question. Output quality tells you whether the framework produces better results. Caste fidelity tells you *why* or *why not* — which is what you need to improve the system. 