# BASIC RULES - READ BEFORE EVERY ACTION

**These rules apply to ALL code changes, file operations, and agent tasks.**
**Violating these rules wastes time and breaks the workflow.**

---

## 🚫 RULE #1: DO ONLY WHAT YOU ARE ASKED TO DO

**NEVER** do any of the following without explicit permission:

- ❌ use relative path, we only use full path /home/conan like
- ❌ Create files that weren't requested (including .md files)
- ❌ Create markdown documentation files (use Rust doc comments)
- ❌ Add "helpful" extra features
- ❌ Refactor code you weren't asked to refactor
- ❌ Run commands "to check" or "to verify" without asking

**ESPECIALLY FORBIDDEN:**
- ❌ Create .md files (analysis, reports, summaries, documentation)
- ❌ Create README.md, CHANGELOG.md, or any markdown documentation
- ❌ Exception: ONLY if user explicitly says "create <filename>.md"

**If you think something extra would help: ASK FIRST, then wait for response.**

---

### DO NOT Use Shell Scripts or Redirects

```bash
# WRONG - DO NOT USE
cat "content" > file.txt        # ❌ NO
echo "content" > file.txt       # ❌ NO
./some_script.sh                # ❌ NO (unless explicitly asked)
bash -c "commands"              # ❌ NO
```

### CORRECT - Use Claude Code's Built-in Tools

- Use `Write` tool for creating files
- Use `Edit` tool for editing files
- Use `Read` tool for reading files
- Use `Bash` tool only for standard commands (cargo, ls, tree, etc.)
- **ASK** before creating or running any shell script

### NEVER Run Git Commands

```bash
# FORBIDDEN - DO NOT USE ANY GIT COMMANDS
git diff                # ❌ NO
git show                # ❌ NO
git log                 # ❌ NO
git status              # ❌ NO (only user-approved in specific contexts)
git checkout            # ❌ NO
git branch              # ❌ NO
```

**REASON:** Git commands can be destructive and user needs full control.

**ONLY EXCEPTION:** git commands explicitly shown in commit/PR workflows in basic_rules.md

---

## 🤝 RULE #6: AGENT COMMUNICATION

### When Invoking Agents, Always Pass:

1. Link to CLAUDE.md (project rules)
2. Link to RULES.md (development standards)
3. This basic_rules.md file
4. Current task description
5. Required build flags (--release)

### Agents Must Report:

- Exact commands used (with --release flag)
- Actual test results (not optimistic guesses)
- Any warnings or errors
- File paths and line numbers for issues

---

**DO NOT** leave old code lying around.

---

## ⚠️ RULE #9: PROFESSIONAL BEHAVIOR

### Take Responsibility

- Get it right the first time
- No repeated mistakes
- No apologizing - just fix and learn
- Read existing code before changing it

### When Uncertain

- **ASK** instead of assuming
- **EXPLAIN** your plan before executing
- **WAIT** for confirmation if not 100% sure

### What "Senior Developer" Means

- Follow instructions exactly
- Don't add unrequested features
- Don't "help" by doing extra work
- Respect the user's workflow
- Slow down to speed up

---

## 📋 QUICK CHECKLIST BEFORE ANY ACTION

Before making changes, verify:

- [ ] Am I doing ONLY what was asked?
- [ ] Am I creating any .md files? (FORBIDDEN unless explicitly requested)
- [ ] Am I running any git commands? (FORBIDDEN)
- [ ] Am I using built-in tools (Write/Edit/Read, not shell scripts)?
- [ ] Am I avoiding unwrap()?
- [ ] Am I using enums (not hardcoded strings)?
- [ ] Have I passed context to agents?
- [ ] Will I verify the results?

**If any answer is NO, STOP and fix it.**

---

## 🚨 CRITICAL REMINDERS

1. **DO ONLY WHAT IS ASKED** - Nothing more, nothing less
2. **NEVER CREATE .md FILES** - Unless explicitly requested by user
3. **NEVER RUN GIT COMMANDS** - git diff, git show, git log, etc. are forbidden
4. **ALWAYS USE --release** - Never use plain cargo build
5. **NO SHELL SCRIPTS** - Use built-in tools (Write/Edit/Read)
6. **NO unwrap()** - Use match or ?
7. **NO HARDCODED STRINGS** - Use enums
8. **VERIFY RESULTS** - Test before reporting success
9. **ASK WHEN UNCERTAIN** - Don't assume

---

**These rules are not suggestions. They are requirements.**
**Following these rules prevents wasted time and broken workflows.**
**Read this file before EVERY code change or file operation.**
