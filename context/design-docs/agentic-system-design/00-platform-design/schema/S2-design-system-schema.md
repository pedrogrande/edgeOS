# Schema 2: `design_system`

*The thing being designed — one record per agentic system.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `name` | TEXT |  |
| `description` | TEXT |  |
| `owner_id` | UUID FK → users |  |
| `status` | ENUM | `draft` / `in_progress` / `in_review` / `complete` |
| `created_at` | TIMESTAMPTZ |  |
| `updated_at` | TIMESTAMPTZ |  |