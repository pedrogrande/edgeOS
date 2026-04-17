# Application Architecture: Agentic Design System Companion

## Architectural Overview

The application is fundamentally a **structured response engine with a document generation layer**. Three core concerns must stay cleanly separated:

- **Template** — the canonical questions (fixed, versioned, seeded by the system)
- **Response** — the user's answers (mutable, versioned, owned by the user)
- **Document** — the rendered output (generated view over response state, never stored as primary truth)

This separation means the document is always regenerable from responses, a schema change to a template doesn't corrupt existing responses, and generation is deterministic — the same responses always produce the same document.

***

## Application Layers

```
┌─────────────────────────────────────────────────────┐
│                   Frontend Layer                      │
│  Wizard UI │ Dashboard │ Preview │ Decisions Tracker │
└─────────────────────┬───────────────────────────────┘
                       │
┌─────────────────────▼───────────────────────────────┐
│                  API / Service Layer                  │
│  Template   Response   Dependency   Generation   Audit│
│  Service    Service    Service      Service     Service│
└─────────────────────┬───────────────────────────────┘
                       │
┌─────────────────────▼───────────────────────────────┐
│                  Storage Layer                        │
│  Relational DB │ Audit Log (append-only) │ Doc Store │
└─────────────────────────────────────────────────────┘
```


***

## Frontend Design

**Four primary views:**


| View | Purpose |
| :-- | :-- |
| **System Dashboard** | Completion status across all seven documents, dependency unlock state, open decisions count |
| **Question Wizard** | Section-by-section guided response entry, one component at a time, with cross-reference indicators showing where an answer flows from a prior document |
| **Document Preview** | Live markdown render of the document as responses are entered — unanswered required questions render as `[REQUIRED — UNANSWERED]` |
| **Decisions & Readiness** | Open decisions register per document, readiness checklist gate, progression controls |

**Progressive unlocking** is enforced in the UI and at the API layer:

```
Design Document          → always available
Architecture Document    → Design readiness checklist complete
Agent Spec (n instances) → Architecture Section 2 has ≥1 agent defined
Data & Schema            → Architecture complete
Workflow & State Machine → Agent Specs + Data & Schema complete
Infrastructure           → all prior complete
Test & Acceptance        → all prior complete
```


***

## Service Layer

| Service | Responsibility |
| :-- | :-- |
| **Template Service** | Serves canonical questions, sections, and templates — read-only in production, managed via migration only |
| **Response Service** | CRUD for responses, writes to response history on every change, resolves cross-references |
| **Dependency Service** | Enforces document ordering, calculates completion percentage, manages progressive unlocking, auto-populates cross-referenced responses |
| **Generation Service** | Resolves every question token in a template scaffold against the response store, renders to markdown/PDF/DOCX |
| **Audit Service** | Writes every application action as an immutable append-only event — never called by the user, always called by infrastructure |


---

## Key Architectural Decisions

**Why relational (Postgres) not document store?**
The cross-reference queries — "show me all acceptance criteria from all agent specs for this system" — are relational joins. A document store would require application-layer assembly that is error-prone.[^1]

**Why is `response_history` a separate table rather than versioned rows in `response`?**
The `response` table gives you the current state in O(1). The `response_history` table gives you the full audit trail. Combining them forces a self-join on every current-state read. The separation matches the mutability principle from the Data & Schema template.

**Why are template questions database records rather than code constants?**
Question wording will be refined. New questions will be added. Guidance text will evolve. Treating questions as seeded database records with a `template_version` field means these changes are governed migrations, not silent code changes — and every response record knows which version of the question it answered.[^1]

**Why is `generated_document` not the source of truth?**
If the generation engine changes, all documents can be regenerated. If a response is corrected, the document regenerates automatically. If a new export format is added, it generates from the same response store. Storing the generated document as primary truth creates a synchronisation problem that has no clean solution.[^2]

***

## Cross-Population Examples

These are the highest-value features of the Dependency Service:


| Source | Auto-populates |
| :-- | :-- |
| Agent names defined in Architecture Section 2 | Creates one Agent Spec `document_instance` per agent, pre-labelled |
| Role archetypes in Architecture Section 2 | Pre-fills Layer 2 identity card fields in each Agent Spec |
| Tool inventory in Architecture Section 3 | Pre-fills Layer 7 tool inventory in each Agent Spec |
| State names in Workflow Section 3 | Appear as selectable options in Infrastructure failure mode responses |
| Acceptance criteria in all Agent Specs | Auto-populate rows in Test & Acceptance Traceability Matrix Section 14 |
| Pilot hypotheses in Design Document Q4 | Auto-populate rows in Test & Acceptance Section 10 Pilot Test Register |
| Open decisions in any document | Aggregate into a cross-document open decisions dashboard |


***

## What to Build First

The build order follows the data dependency graph:

1. **Seed the template store** — all seven templates, all sections, all questions as database records. This is the foundation everything else reads from.
2. **Response CRUD + history** — the core write path with immutable history.
3. **Completion calculation** — the readiness checklist gate logic.
4. **Question wizard UI** — section-by-section form with progress tracking.
5. **Basic generation engine** — markdown output from token resolution.
6. **Cross-reference + auto-population** — the Dependency Service.
7. **Open decisions tracker** — surface and resolve open decisions across all documents.
8. **Export formats** — PDF and DOCX from the generated markdown.

The application is essentially a **governed, traceable form engine with a document renderer** — and the most important design decision is treating the templates as data, not code.