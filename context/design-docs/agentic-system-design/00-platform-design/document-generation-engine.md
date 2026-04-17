# The Document Generation Engine

The generation service treats each template as a **scaffold with token placeholders**. Every question maps to a token; the engine resolves each token against the response store and renders the document.

```
Template scaffold:
  "| **1.1 — Human Need** | {{q_layer1_1_q1}} |"

Resolution:
  lookup response WHERE document_id = X AND question_id = q_layer1_1_q1
  → if found: insert response_text
  → if not found and required: insert "[REQUIRED — NOT YET ANSWERED]"
  → if not found and optional: insert "—"

Output:
  "| **1.1 — Human Need** | This agent exists to... |"
```

For **table schemas** (register tables, traceability matrices), the engine queries all `response_structured` JSONB rows for that section and renders them as a markdown table. Each row is one response record.

For the **Traceability Matrix** in Test \& Acceptance, the engine auto-populates rows by querying all acceptance criteria responses across all Agent Specification documents linked to the same system — this is the cross-reference engine doing its highest-value work.

***