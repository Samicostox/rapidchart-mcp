# RapidChart MCP Usage Examples

## Basic Examples

### 1. Generate Class Diagram

```
User: "Generate a class diagram from this code:

class User {
  id: number;
  name: string;
  email: string;
  password: string;
}

class Post {
  id: number;
  title: string;
  content: string;
  author: User;
  createdAt: Date;
}"

Response:
✅ Diagram created successfully!
Title: User and Post Classes
Type: class
URL: https://rapidchart.com/editor/abc-123
```

### 2. Generate from File

```
User: "@src/models/user.py Generate a class diagram from this file"

→ Cursor reads the file automatically
→ Calls create_diagram with file contents
→ Returns diagram URL
```

### 3. Generate ER Diagram

```
User: "Generate an ER diagram from this SQL schema:

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  email VARCHAR(255) UNIQUE,
  name VARCHAR(100)
);

CREATE TABLE posts (
  id SERIAL PRIMARY KEY,
  user_id INTEGER REFERENCES users(id),
  title VARCHAR(255),
  content TEXT
);"

Response:
✅ Diagram created successfully!
Type: er
URL: https://rapidchart.com/editor/def-456
```

---

## Advanced Examples

### 4. Use Specific AI Model

```
User: "List my available models"

Response:
📊 Available AI Models:
✅ [10] GPT-5 mini (unlimited credits)
✅ [11] GPT-5.2 (using your API key)
❌ [12] GPT-5 nano (0 credits)

User: "Generate class diagram with model 11 from src/models.py"

→ Uses GPT-5.2 specifically
```

### 5. Update Existing Diagram

```
User: "List my diagrams"

Response:
[abc-123] User Models (class)
[def-456] Database Schema (er)

User: "Update diagram abc-123 with new code from src/models.py"

→ Fetches old diagram
→ Passes as context to AI
→ Regenerates with awareness of old structure
```

### 6. Organize in Workspaces

```
User: "List my workspaces"

Response:
🏠 Personal [1] My Workspace
👥 Team [5] Company Project

User: "Generate diagram in workspace 5 from src/api.py"

→ Creates diagram in team workspace
```

### 7. Use Folders

```
User: "List folders in workspace 5"

Response:
[10] Backend
[11] Frontend
[12] Database

User: "Generate ER diagram in workspace 5, folder 12 from schema.sql"

→ Creates diagram in: Company Project / Database /
```

---

## Agent Mode Examples

### 8. Multi-File Analysis

```
User: "Analyze all files in src/models/ and generate a comprehensive class diagram"

→ Cursor agent:
  1. Lists files in src/models/
  2. Reads each file
  3. Combines code
  4. Calls create_diagram with all code
  5. Returns URL
```

### 9. Code Change Detection

```
User: "I updated src/models/user.py, update the User Models diagram"

→ Cursor agent:
  1. Reads updated file
  2. Searches for "User Models" diagram
  3. Calls update_diagram with new code
  4. Returns updated URL
```

### 10. Architecture Diagrams

```
User: "Generate AWS architecture diagram for this infrastructure:

- API Gateway
- Lambda functions
- DynamoDB
- S3 bucket
- CloudFront CDN"

→ Creates AWS architecture diagram with proper icons
```

---

## Workflow Examples

### 11. Development Workflow

```
# Day 1: Initial design
User: "Generate class diagram from src/models/"
→ Creates diagram abc-123

# Day 15: Code evolved
User: "Update diagram abc-123 with current code from src/models/"
→ Updates with new classes/relationships

# Day 30: Refactoring
User: "Update diagram abc-123, I refactored the User class"
→ Regenerates with context
```

### 12. Documentation Workflow

```
# Generate diagrams for docs
User: "Generate sequence diagram for authentication flow"
User: "Generate ER diagram for database schema"
User: "Generate C4 diagram for system architecture"

# Export URLs for documentation
User: "List all my diagrams from today"
→ Copy URLs into docs
```

---

## Tips & Best Practices

### ✅ DO:
- Use descriptive titles for diagrams
- Specify diagram type explicitly
- Check available models first with `list_models`
- Use workspace/folder organization for large projects
- Update diagrams when code changes significantly

### ❌ DON'T:
- Don't paste huge files (>1000 lines) - summarize or split
- Don't regenerate diagrams for tiny changes
- Don't forget to specify diagram type (defaults to "general")
- Don't use expired tokens

---

## Diagram Types Reference

| Type | Description | Best For |
|------|-------------|----------|
| `general` | Generic flowchart | Processes, workflows |
| `class` | UML class diagram | OOP code, data models |
| `er` | Entity-relationship | Database schemas |
| `sequence` | Sequence diagram | API flows, interactions |
| `usecase` | Use case diagram | System requirements |
| `userflow` | User flow | UI/UX flows |
| `c4` | C4 architecture | System architecture |
| `aws` | AWS architecture | Cloud infrastructure |
| `azure` | Azure architecture | Azure cloud |
| `google` | GCP architecture | Google Cloud |

---

## Common Patterns

### Pattern 1: Code-to-Diagram Pipeline

```bash
# In your CI/CD
rapidchart-mcp generate \
  --code "$(cat src/models/*.py)" \
  --type class \
  --title "System Models" \
  --output diagram-url.txt
```

### Pattern 2: Documentation Generator

```python
# Script to generate all diagrams
diagrams = [
    ("src/models/", "class", "Data Models"),
    ("db/schema.sql", "er", "Database Schema"),
    ("docs/flows.md", "sequence", "API Flows")
]

for path, type, title in diagrams:
    code = read_file(path)
    url = create_diagram(code, type, title)
    print(f"{title}: {url}")
```

---

## Troubleshooting Common Issues

### Issue: "Diagram looks wrong"

**Solution:**
- Enable guidelines: `RAPIDCHART_GUIDELINES=true`
- Enable thinking: `RAPIDCHART_FEW_PROMPTS=true`
- Be more specific in your prompt
- Try a different AI model

### Issue: "Too slow"

**Solution:**
- Disable few_prompts for faster generation
- Use GPT-5 mini instead of GPT-5.2
- Reduce code size (summarize or split)

### Issue: "Wrong diagram type"

**Solution:**
- Explicitly specify type: "Generate CLASS diagram..."
- Check default type in config
- Agent might misinterpret - be explicit

---

For more examples, see the [README](../README.md) and [Cursor Setup Guide](../CURSOR_SETUP.md).





