# Pattern Analysis: What 16 Use Cases Reveal When You Treat Them as Data

---

## Pattern 1: The Meta-Use-Case

Strip away the domain labels and every use case is the same thing:

> **"Here is a complex, uncertain reality. Help me understand it well enough to act."**

Writing a report is making sense of what you know and presenting it clearly. Strategy is making sense of a complex landscape. Design thinking is making sense of a problem space. Data analysis is making sense of numbers. Research is making sense of a field. Decisions are making sense of trade-offs under uncertainty. Even "life management" is making sense of your own patterns.

This is important because it means we're not designing 16 different products. We're designing **one product that serves one meta-use-case** across 16 domains. The interaction paradigm needs to be domain-adaptable, not domain-specific. The same structural operations (decompose, relate, manipulate, track) apply whether you're analysing a market or managing your commitments.

**The product is a sensemaking environment.** Everything else is configuration.

---

## Pattern 2: The Type System — 17 Types That Recur Everywhere

When you look at what the agent is actually *producing* across all 16 use cases, the same categories of information appear over and over. They're just buried in prose so you can't see them.

| # | Type | What it is | Present in use cases |
|---|------|-----------|---------------------|
| 1 | **Claim** | An assertion that may or may not be true | 1, 4, 5, 13, 16 |
| 2 | **Evidence** | The basis for believing a claim | 1, 4, 5, 9, 13 |
| 3 | **Assumption** | Something taken as true without proof | 2, 6, 9, 12, 14 |
| 4 | **Option** | A possible path forward | 2, 3, 9, 10 |
| 5 | **Criterion** | A standard for evaluation | 4, 9, 12, 14 |
| 6 | **Action** | Something to do | 6, 8, 11 |
| 7 | **Question** | Something not yet answered | 3, 5, 8, 13 |
| 8 | **Connection** | A link between other types | 3, 5, 7, 12 |
| 9 | **Constraint** | A boundary on what's possible | 3, 6, 12, 14 |
| 10 | **Confidence** | How sure are we? | 4, 5, 9, 16 |
| 11 | **Perspective** | A different way of seeing the same thing | 2, 3, 10, 11, 13 |
| 12 | **Pattern** | A recurring structure | 4, 8, 15, 16 |
| 13 | **Gap** | What's missing | 5, 13 |
| 14 | **Tension** | Where things conflict | 3, 11, 13 |
| 15 | **Dependency** | What depends on what | 2, 6, 12 |
| 16 | **Outcome** | What happened as a result | 8, 9, 15 |
| 17 | **Provenance** | Where did this come from? | 5, 10, 13 |

**This is the root cause of the wall of text problem.**

It's not that the output is badly formatted. It's that 17 distinct types of information are being encoded as a single type — prose. The human is forced to do type inference in real time while reading: "Is this a claim or an assumption? Is this evidence or opinion? Is this an action or a suggestion?"

This is cognitively expensive and error-prone. It's like a database that stores everything as a single string field. The solution isn't "better prose" — it's **typed outputs** where each piece of information is explicitly what it is.

This type system is the foundation of the entire interaction paradigm. It's the periodic table of knowledge work.

---

## Pattern 3: The Operation Set — 14 Things Humans Need to Do With Types

Across all 16 use cases, humans need to perform the same operations on the type system:

| # | Operation | What it means | Example |
|---|-----------|--------------|---------|
| 1 | **Extract** | Pull one type out of a mixed output | "Give me just the assumptions" |
| 2 | **Isolate** | Separate one type from another | "Show claims separately from evidence" |
| 3 | **Compare** | Put two+ things side by side | Compare strategic options, scenarios, versions |
| 4 | **Adjust** | Change a parameter, see cascading effects | Change an assumption, see the impact |
| 5 | **Combine** | Merge two+ things into something new | Idea breeding, strategy synthesis |
| 6 | **Rearrange** | Change structure/order without changing content | Reorder priorities, restructure an argument |
| 7 | **Drill** | Go deeper into a specific component | "Show me the evidence for THIS claim" |
| 8 | **Navigate** | Move between related components | From claim → evidence → source → related claims |
| 9 | **Track** | Follow how something changes over time | Strategy evolution, decision outcomes |
| 10 | **Evaluate** | Apply criteria to assess quality/fitness | Score options against criteria |
| 11 | **Transform** | Convert between representations | Same data as narrative ↔ table ↔ diagram |
| 12 | **Annotate** | Add human judgment to agent output | Mark as "important", "disagree", "investigate" |
| 13 | **Branch** | Fork a path to explore separately | Two versions of a strategy, parallel ideas |
| 14 | **Stress-test** | "What happens if this assumption is wrong?" | Break the model, find the weak points |

Current chat interfaces support exactly ONE of these operations natively: "generate more text." You can sometimes hack extraction by asking again, or comparison by asking for a table, but none of these are first-class interactions. They're all workarounds.

**The interaction paradigm must make ALL 14 operations first-class.** Each one should be as natural as "send a message" is in chat.

---

## Pattern 4: The Extraction Hierarchy — A Product Roadmap Disguised as an Insight

Looking at what the use cases collectively demand, there's a clear hierarchy of capability that no current tool supports:

```
┌─────────────────────────────────────────────────────────┐
│  L5  CONTEXTUAL     Personalised to your history,       │
│      COMPONENTS     patterns, preferences               │
├─────────────────────────────────────────────────────────┤
│  L4  EVOLVING       Track changes over time, version,   │
│      COMPONENTS     compare versions                    │
├─────────────────────────────────────────────────────────┤
│  L3  MANIPULABLE    Can adjust, compare, combine,       │
│      COMPONENTS     stress-test, branch                │
├─────────────────────────────────────────────────────────┤
│  L2  RELATED        Links between types — claim→evidence│
│      COMPONENTS     assumption→impact, option→criteria  │
├─────────────────────────────────────────────────────────┤
│  L1  TYPED          Claims, evidence, assumptions as    │
│      COMPONENTS     separate, labelled objects          │
├─────────────────────────────────────────────────────────┤
│  L0  RAW OUTPUT     Wall of text — what we have now     │
└─────────────────────────────────────────────────────────┘
```

**Current tools operate at Level 0.** The use cases demand Level 5.

But this isn't just an observation — it's a **product roadmap**. Each level is a milestone that unlocks new use cases:

- **L1 unlocks**: extraction ("just the assumptions"), isolation (claims from evidence)
- **L2 unlocks**: navigation (follow the links), drill-down (from claim to evidence)
- **L3 unlocks**: interactivity (adjust, compare, combine, stress-test)
- **L4 unlocks**: time ("what changed?"), versioning, evolution tracking
- **L5 unlocks**: personalisation (your patterns, your context, your history)

And crucially: **each level includes all levels below it.** L3 is worthless without L1 and L2. L5 is impossible without L4. This is an architecture, not a feature list.

---

## Pattern 5: The Temporal Spectrum

Use cases don't just differ in *what* they do — they differ in *how long they live*.

```
EPISODIC                    ITERATIVE                    ONGOING
"One shot, done"           "Build across sessions"       "Never done"
─────────────────────────────────────────────────────────────────
Quick content gen          Strategy development          Life management
One-off data analysis      Design thinking               Relationship mgmt
Single diagram             Research & learning            Personal development
                           Planning                      Monitoring
                           Decisions                     Sensemaking
                           Ideation
                           Architecture
                           Business modelling
```

**Current AI tools are designed for the left column.** The vast majority of real human value lives in the centre and right columns.

The implication: the workspace must treat artefacts as **first-class persistent objects**, not ephemeral chat outputs. A strategy you worked on yesterday should be there tomorrow, with what changed since last time surfaced as a primary output. A decision you made last month should carry its reasoning trail when you revisit it.

This is where **"What changed?"** becomes the most important question that current tools don't answer. Across every iterative and ongoing use case, the critical question is always: what's different since last time? In strategies. In plans. In decisions. In knowledge. In relationships. In markets. Current tools treat every interaction as stateless. A stateful tool that surfaces changes, drifts, and developments as primary output would be transformational.

---

## Pattern 6: The Agency Model — Confidence × Reversibility

Across all use cases, what the human needs from the agent is governed by two orthogonal axes:

```
                    REVERSIBLE          IRREVERSIBLE
              ┌──────────────────┬──────────────────┐
  HIGH       │                  │                  │
  CONFIDENCE  │  AGENT ACTS      │  HUMAN CONFIRMS  │
              │  AUTONOMOUSLY    │  BEFORE ACTION   │
              │                  │                  │
              ├──────────────────┼──────────────────┤
              │                  │                  │
  LOW        │  AGENT ACTS,     │  HUMAN DECIDES   │
  CONFIDENCE  │  HUMAN REVIEWS   │  AGENT PREPARES  │
              │  LATER           │  THE GROUND      │
              │                  │                  │
              └──────────────────┴──────────────────┘
```

This 2×2 matrix governs the entire human-agent interaction model:

- **High confidence + reversible** → Agent acts autonomously (reformatting, monitoring, consistency checks)
- **High confidence + irreversible** → Agent recommends, human confirms (sending emails, making payments, publishing)
- **Low confidence + reversible** → Agent tries, human reviews (draft content, exploration, ideation)
- **Low confidence + irreversible** → Agent prepares the ground, human decides (strategic decisions, hiring, pivoting)

**This matrix is completely absent from current AI tools.** They treat every interaction as if it's in the top-left quadrant: the agent generates, the human accepts. But real knowledge work spends most of its time in the bottom-right — where the human must decide under uncertainty and the agent's job is to *prepare the judgment*, not to *make the judgment*.

This reframes the entire interaction model:

> **The agent is a JUDGMENT PREPARATION system, not an ANSWER GENERATION system.**

The agent's highest-value role is to reduce everything between the human's decision points to its minimum, structured form — so the human can see clearly what they're deciding, what they're assuming, and what they're risking. The agent doesn't give you the answer. The agent gives you the clearest possible frame for YOUR answer.

---

## Pattern 7: The Shannon Channel Problem

From Shannon's communications theory, the efficiency of a channel depends on how well the encoding matches the decoder's needs.

The LLM channel has enormous bandwidth. But it encodes everything as a single symbol set (prose) with no structural differentiation. The decoder (the human) must do all the demultiplexing — separating claims from evidence, assumptions from conclusions, actions from suggestions, questions from statements.

This is why the wall of text problem gets worse as outputs get longer: the human's demultiplexing load increases linearly with output length, while the value extracted increases sub-linearly (because valuable components are diluted in filler).

What the use cases collectively demand is a **multi-channel communication system**:

| Channel | Carries | Current treatment |
|---------|---------|-------------------|
| **Claims** | What's being asserted | Buried in prose |
| **Evidence** | What supports the claim | Buried in prose |
| **Uncertainty** | How confident, how reversible | Absent or buried |
| **Action** | What to do | Buried in prose |
| **Context** | Why this matters | Absent |
| **Relationship** | How this connects | Lost in linearisation |
| **Time** | When true, how changed | Absent |

Seven channels of information, one pipe (prose), zero demultiplexing support. The human does it all in their head.

**The workspace must be a demultiplexer.** Not a chat window. Not a document editor. A structured channel where each type of information arrives on its own frequency, labelled, linked, and ready for the operation the human needs to perform on it.

---

## Pattern 8: Six Design Tensions

The use cases don't all pull in the same direction. Several important tensions must be designed for, not resolved:

### T1: Convergence ↔ Divergence
Some use cases narrow (decisions, planning) while others widen (creative exploration, research). The same tool must support both modes. **Design implication**: the workspace needs a mode switch — not a separate tool, but a toggle on the same environment that shifts the agent's orientation from convergent to divergent and back.

### T2: Structure ↔ Freedom
Structured outputs (typed components, cards, diagrams) are more useful but constrain expression. Free-form prose is more expressive but creates the wall of text problem. **Design implication**: structure by default, freedom on demand. Every output is typed and decomposed unless the human explicitly asks for free-form, in which case the agent can generate prose — but the human can always restructure it later.

### T3: Speed ↔ Depth
Quick answers vs. deep exploration. **Design implication**: two gears. A fast gear for "just give me the assumptions" (instant extraction) and a deep gear for "let's build a strategy" (collaborative, multi-step). The human should be able to shift between gears mid-interaction without starting over.

### T4: Personalisation ↔ Universality
The most valuable outputs are personal (your patterns, your history). The most scalable approach is generic. **Design implication**: personal by design. The workspace accumulates context about the human over time — their patterns, preferences, past decisions, recurring themes. Every new interaction starts from this accumulated context, not from scratch. Generic advice is the floor; personal insight is the ceiling.

### T5: Autonomy ↔ Control
The human wants delegation for some things, granular control for others. **Design implication**: the confidence × reversibility matrix (Pattern 6) determines the default. But the human can override: "Just do it" or "Show me everything before you act." The interaction cost of switching between modes must be near-zero.

### T6: Individual ↔ Collaborative
Some work is deeply personal; some requires multiple perspectives. **Design implication**: the same artefact can be worked on solo or with a team of agents. The human chooses the agent topology: one generalist, one specialist, or a team. The artefact doesn't change; the collaboration mode does.

---

## Ten Unexpected Insights

These emerged from the cross-pattern analysis. None of them is obvious from any single use case.

## 1. The fundamental unit is the ARTEFACT, not the conversation.

Every use case has something that persists: a strategy, a model, a decision record, a knowledge map. The conversation is just the mechanism for building and refining the artefact. Current tools are conversation-centric when they should be artefact-centric. The conversation should serve the artefact, not be the artefact.

## 2. The wall of text is a TYPE COLLISION problem.

Seventeen types of information, one encoding, zero demultiplexing. The solution isn't "better prose" — it's typed outputs where each piece of information is explicitly what it is. This is an architecture problem, not a formatting problem.

## 3. The most valuable AI capability is STRUCTURING, not generation.

Across every use case, the bottleneck isn't getting more content — it's getting structured, decomposable, manipulable content. The highest-value capability is taking an undifferentiated mass and giving it structure that matches human cognition. Generation is commoditised. Structuring is the differentiator.

## 4. The agent should be a MIRROR, not an ORACLE.

The most valuable outputs aren't new information — they're reflections of the human's own patterns, assumptions, and blind spots. Across personal development, decision support, and sensemaking, the agent's highest-value role is showing you what you already implicitly know but haven't made explicit. This is the Articulation Agent archetype from your own design principles — and it applies to nearly every use case, not just personal ones.

## 5. "What changed?" is the most important unanswered question.

Across iterative and ongoing use cases, the critical question is always "what's different since last time?" Current tools treat every interaction as stateless. Stateful artefacts that surface changes, drifts, and developments as primary output would be transformational.

## 6. Confidence × Reversibility governs everything.

This 2×2 matrix determines whether the agent acts autonomously, recommends, tries, or prepares. It's the control law for the entire human-agent interaction model, and it doesn't exist in any current tool.

## 7. Every use case has a "dark matter" layer.

The unstated assumptions, emotional context, and cognitive load that the human carries but never types. Current tools only see what's in the prompt. A workspace that accumulates this context over time — like a persistent model of the human's world — could dramatically reduce cognitive load per interaction. The prompt is the visible 5%. The workspace should carry the invisible 95%.

## 8. The same content needs MULTIPLE VIEWS, not one.

A strategy is a narrative AND a set of assumptions AND a dependency map AND a risk matrix AND a scenario comparison. The content is the same; the view changes. Current tools give you one view (prose) and force you to request others one at a time. The workspace should show multiple views simultaneously or allow instant view-switching without re-generation.

## 9. The Extraction Hierarchy is a product roadmap.

Level 0 (raw output) through Level 5 (contextual components) isn't just a model — it's a build order. Each level unlocks new use cases and new value. This gives us a principled way to prioritise features and validate that we're building the right thing at the right time.

## 10. The workspace is not a tool — it's an ENVIRONMENT.

Tools are picked up and put down. Environments are inhabited. The 16 use cases describe a space where the human lives and works, not a sequence of transactions. The workspace should feel like an environment you arrange for yourself — with your artefacts, your agents, your views, and your accumulated context — not a chat you restart every time.

This echoes the architectural insight from your dream workspace: **a governed society, not a toolbox.** The agents are actors in your environment. The artefacts are the structures they build and maintain. You are the inhabitant, not the operator.

---

## What This Collectively Tells Us About What We're Building

If I had to compress this entire analysis into a single design brief:

> **Build a sensemaking environment where the human inhabits a workspace of persistent, typed artefacts. Agents serve as judgment preparation systems — structuring, decomposing, relating, and tracking information so the human can see clearly what they're deciding. The fundamental interaction is not "ask and receive" but "arrange, inspect, adjust, and evolve." Conversation is one mode among many. The artefact is primary. The human's role is judgment. The agent's role is preparation. The workspace's role is persistence and structure.**

This is a fundamentally different product category from "AI chat." It's not a better chat interface. It's a new thing.

Ready to take this into interaction paradigm design, or do you want to drill deeper into any of these patterns?

