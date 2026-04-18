# Schema 8: `response`

*A user's answer to a specific question in a specific document instance.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `document_id` | UUID FK → document_instance |  |
| `question_id` | UUID FK → template_question |  |
| `response_text` | TEXT | for long_text and short_text types |
| `response_structured` | JSONB | for table_row, checklist_item, select types |
| `is_auto_populated` | BOOLEAN | populated by cross-reference, not human entry |
| `source_response_id` | UUID FK → response | if auto-populated, the source |
| `current_version` | INTEGER | increments on each edit |
| `responded_by` | UUID FK → users | last editor |
| `responded_at` | TIMESTAMPTZ | last edit time |
| `is_flagged` | BOOLEAN | flagged for review or follow-up |
| `flag_reason` | TEXT |  |
