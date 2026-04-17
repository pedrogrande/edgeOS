# Schema 13: `generated_document`

*The rendered output — a computed view, never the primary record.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `document_id` | UUID FK → document_instance |  |
| `format` | ENUM | `markdown` / `pdf` / `docx` |
| `content` | TEXT | full rendered document content |
| `content_hash` | TEXT | SHA-256 of content — detects tampering |
| `completeness_at_generation` | INTEGER | % complete at time of generation |
| `generated_at` | TIMESTAMPTZ |  |
| `generated_by` | UUID FK → users |  |
| `version` | INTEGER |  |
| `is_current` | BOOLEAN | only one current version per document per format |
