# Schema 4: `template_dependency`

*Which documents must be complete before another unlocks.*


| Field | Type | Notes |
| :-- | :-- | :-- |
| `id` | UUID PK |  |
| `template_id` | UUID FK → template_definition | the document being unlocked |
| `depends_on_template_id` | UUID FK → template_definition | what must be complete first |
| `dependency_type` | ENUM | `must_complete` / `section_complete` / `informs` |
| `required_section_id` | UUID FK → template_section | if `section_complete`, which section |
