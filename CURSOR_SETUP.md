# Setting Up RapidChart MCP in Cursor

## Quick Start

### 1. Install the MCP Server

```bash
pip install rapidchart-mcp
```

Or install from GitHub:
```bash
pip install git+https://github.com/Samicostox/rapidchart-mcp.git
```

### 2. Get Your API Token

1. Go to [RapidChart Settings](https://rapidchart.com/settings)
2. Navigate to "API Tokens" section
3. Click "Generate New Token"
4. Give it a name (e.g., "Cursor MCP")
5. Copy the token (starts with `rc_`)

### 3. Configure Cursor

Open Cursor Settings → Features → Model Context Protocol

Or edit your MCP config file directly:

**Location:**
- macOS/Linux: `~/.cursor/mcp.json`
- Windows: `%APPDATA%\Cursor\mcp.json`

**Add this configuration:**

```json
{
  "mcpServers": {
    "rapidchart": {
      "command": "python",
      "args": ["-m", "rapidchart_mcp"],
      "env": {
        "RAPIDCHART_API_TOKEN": "rc_your_token_here",
        "RAPIDCHART_API_URL": "https://fastuml-0bb6938ba599.herokuapp.com",
        "RAPIDCHART_DEFAULT_TYPE": "general",
        "RAPIDCHART_FEW_PROMPTS": "false",
        "RAPIDCHART_GUIDELINES": "true"
      }
    }
  }
}
```

**Replace `rc_your_token_here` with your actual token!**

### 4. Restart Cursor

Close and reopen Cursor for the MCP server to load.

### 5. Verify Installation

In Cursor, try:
```
"List my available RapidChart models"
```

You should see a list of AI models with your credit status.

---

## Usage Examples

### Generate Diagram from Code

```
User: "Generate a class diagram from this code:

class User {
  id: number;
  name: string;
  email: string;
}

class Post {
  id: number;
  title: string;
  author: User;
}"

→ Cursor calls create_diagram and returns a URL
```

### From Files

```
User: "@src/models.py Generate a class diagram from this file"

→ Cursor reads the file and generates the diagram
```

### Update Existing Diagram

```
User: "Update diagram abc-123-def with new code from src/models.py"

→ Cursor reads the file and updates the diagram with context
```

### List Your Diagrams

```
User: "Show me my recent RapidChart diagrams"

→ Lists your diagrams with titles and types
```

### Check Available Models

```
User: "What RapidChart models can I use?"

→ Shows models with your credit status
```

---

## Configuration Options

| Variable | Default | Description |
|----------|---------|-------------|
| `RAPIDCHART_API_TOKEN` | *Required* | Your API token from RapidChart |
| `RAPIDCHART_API_URL` | Production | API base URL (use dev URL for testing) |
| `RAPIDCHART_DEFAULT_TYPE` | `general` | Default diagram type |
| `RAPIDCHART_DEFAULT_MODEL` | Auto | Default AI model ID (omit for auto-select) |
| `RAPIDCHART_FEW_PROMPTS` | `false` | Enable multi-step thinking (better quality, slower) |
| `RAPIDCHART_GUIDELINES` | `true` | Include diagram-specific guidelines |
| `RAPIDCHART_TIMEOUT` | `300` | Request timeout in seconds |

---

## Troubleshooting

### "Module not found" error
```bash
# Make sure rapidchart-mcp is installed
pip install rapidchart-mcp

# Or reinstall
pip uninstall rapidchart-mcp
pip install rapidchart-mcp
```

### "Invalid token" error
- Check your token is correct in the config
- Generate a new token at https://rapidchart.com/settings
- Make sure there are no extra spaces in the token

### "Insufficient credits" error
- Run `list_models` to see which models you have access to
- Add your own API key at https://rapidchart.com/settings for unlimited access
- Use a model with available credits

### MCP server not loading in Cursor
- Restart Cursor completely
- Check the MCP logs in Cursor's developer console
- Verify Python is in your PATH: `which python`

---

## Advanced Usage

### Use Specific Model

```
User: "Generate ER diagram with GPT-5.2 from schema.sql"

→ Agent uses model_id for GPT-5.2
```

### Organize in Folders

```
User: "Create class diagram in workspace 5, folder 10"

→ Agent passes workspace_id and folder_id
```

### Enable Thinking Mode

Set in config:
```json
"RAPIDCHART_FEW_PROMPTS": "true"
```

Or specify per request:
```
User: "Generate diagram with deep thinking enabled"
```

---

## Support

- 📧 Email: hello@rapidchart.com
- 🐛 Issues: [GitHub Issues](https://github.com/Samicostox/rapidchart-mcp/issues)
- 📖 Docs: [docs.rapidchart.com](https://docs.rapidchart.com/mcp)

