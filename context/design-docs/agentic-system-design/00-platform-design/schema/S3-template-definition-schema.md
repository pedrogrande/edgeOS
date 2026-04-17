# Schema 3: `template_definition`

*The seven companion documents — seeded records, never user-created.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `template_type` | ENUM | `design` / `architecture` / `agent_spec` / `data_schema` / `workflow` / `infrastructure` / `test_acceptance` |
| `title` | TEXT |  |
| `description` | TEXT |  |
| `version` | TEXT | e.g. `"1.0"` — incremented when questions change |
| `ordering` | INTEGER | 1–7, enforces document sequence |
| `allows_multiple_instances` | BOOLEAN | `true` only for `agent_spec` |
| `created_at` | TIMESTAMPTZ |  |
