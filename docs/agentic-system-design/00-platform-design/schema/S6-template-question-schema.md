# Schema 6: `template_question`

*Every individual question in every template — the canonical record.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `section_id` | UUID FK → template_section |  |
| `component_label` | TEXT | e.g. `"2.1 — Agent Roster"` |
| `question_text` | TEXT | the exact question as written |
| `question_order` | INTEGER |  |
| `response_type` | ENUM | `long_text` / `short_text` / `boolean` / `select` / `table_row` / `checklist_item` |
| `is_required` | BOOLEAN |  |
| `is_readiness_check` | BOOLEAN | part of the readiness checklist |
| `is_identity_card_field` | BOOLEAN | part of the top identity card |
| `guidance_text` | TEXT | additional guidance shown below the question |
| `cross_ref_source_question_id` | UUID FK → template_question | if auto-populated from another question's answer |
| `cross_ref_population_rule` | TEXT | describes how the cross-reference population works |
| `template_version` | TEXT | version of template when question was written |
| `deprecated_at` | TIMESTAMPTZ | null if active |
