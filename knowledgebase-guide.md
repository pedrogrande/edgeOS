# Knowledge base guide

## Core Concepts: Metadata as the Foundation

The most effective strategy is pairing vector similarity search with **metadata filtering** — applying structured filters to narrow the dataset *before* running the expensive vector search. This dramatically reduces compute cost and improves result relevance. The key types of metadata to store alongside embeddings are: 

- **Scalar fields** – strings, numbers, booleans (e.g., `status = "active"`, `confidence_score > 0.8`)
- **Categorical tags** – topic, department, document type, audience
- **Temporal fields** – `created_at`, `updated_at`, `valid_until` for time-scoped queries
- **Relational fields** – `owner`, `team`, `tenant_id` for multi-user/multi-org access control

## Common Business Metadata Schema

These are the most widely used tag/field categories across enterprise knowledge systems: 

| Field | Examples | Purpose |
|---|---|---|
| `doc_type` | policy, SOP, FAQ, report, contract | Filter by content format |
| `department` | Legal, HR, Engineering, Finance | Scoped retrieval per team |
| `topic` / `category` | compliance, onboarding, product, customer | Semantic grouping |
| `access_level` | public, internal, restricted, confidential | Access control |
| `source` | Confluence, Notion, Salesforce, manual | Provenance and trust |
| `status` | draft, active, deprecated, archived | Lifecycle management |
| `language` | en, fr, es | Multilingual filtering |
| `created_at` / `updated_at` | ISO timestamps | Time-based freshness filtering |
| `owner` / `author` | person or team ID | Accountability and lineage |
| `tenant_id` | org/workspace ID | Multi-tenant isolation |
| `version` | v1, v2.1 | Document versioning |
| `tags` | free-form array | Flexible keyword enrichment |

## Best Practices for Schema Design

- **Define a consistent metadata schema upfront** — inconsistent tagging across teams is the most common failure mode 
- **Automate tagging during ingestion** — tag at ingest time using LLM classifiers or pipeline rules, not manually after the fact 
- **Apply filters early in the pipeline** — pre-filtering reduces the vector search space and cuts compute cost 
- **Use hierarchical categories with a max depth of ~3 levels** — e.g., `Knowledge > Product > Pricing` — industry best practice caps sub-categories at 7 levels, with 3 being optimal 
- **Store user-friendly preferred terms** and map internal jargon as synonyms in your schema
- **Version your metadata** so filter logic remains reproducible as the schema evolves 

## Filtering Strategies

- **Pre-filtering**: Filter by metadata first, then run vector search on the subset — best for large datasets with clear categorical boundaries 
- **Post-filtering**: Run vector search first, then apply metadata filters — simpler but less efficient at scale 
- **Hybrid search**: Combine vector similarity (semantic) with BM25 keyword search, then use weighted fusion for final ranking — produces the best recall for RAG pipelines 
- **Logical operators**: Support `AND`, `OR`, `IN`, range comparisons (e.g., `date > 2025-01-01`) for expressive filter queries 

## For Your Context (Agentic / RAG Systems)

Given you're building systems like Nexus and Future's Edge, a few additional considerations:

- **`agent_id` or `workflow_id`** as metadata fields lets you trace which agent produced or consumed a document — critical for audit completeness 
- **`confidence` or `quality_score`** fields allow filtering out low-quality chunks before retrieval
- **`chunk_index` + `parent_doc_id`** pairs are essential for maintaining chunk-to-document traceability in RAG pipelines
- **`embedding_model`** tag tracks which model generated the vector — important as models get updated and re-embedded chunks may have different semantic properties