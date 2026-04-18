# Schema 5: `template_section`

*Sections within each template — e.g. "Section 2 — Agent Inventory".*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `template_id` | UUID FK → template_definition |  |
| `section_number` | TEXT | e.g. `"2"`, `"2.1"` |
| `section_title` | TEXT |  |
| `section_description` | TEXT | the italicised guidance under each section heading |
| `ordering` | INTEGER |  |
| `section_role` | ENUM | `standard` / `identity_card` / `register_table` / `readiness_checklist` / `open_decisions` |
