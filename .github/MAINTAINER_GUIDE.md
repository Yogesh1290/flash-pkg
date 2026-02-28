# Maintainer Guide - Managing flash-pkg

This guide helps you (Yogesh) manage contributions and issues as a first-time open source maintainer.

---

## 📥 When Someone Opens an Issue

### Step 1: Read the Issue
- Understand what they're asking/reporting
- Check if it's a bug, feature request, or question

### Step 2: Add Labels
Click "Labels" on the right side and add:
- **Type**: `bug`, `enhancement`, `question`, or `documentation`
- **Priority**: `priority: high`, `priority: medium`, or `priority: low`
- **Component**: `component: install`, `component: cache`, etc.
- **Platform** (if specific): `platform: windows`, `platform: linux`, etc.

### Step 3: Respond
**For bugs:**
```markdown
Thanks for reporting this! I'll investigate and get back to you soon.

In the meantime, can you try [workaround]?
```

**For feature requests:**
```markdown
Great idea! This would be useful for [use case].

I've added it to the roadmap. Would you be interested in contributing?
```

**For questions:**
```markdown
Good question! Here's how it works: [explanation]

Check out [link to docs] for more details.
```

### Step 4: Close or Keep Open
- **Close** if: Duplicate, invalid, or answered
- **Keep open** if: Valid bug or feature to implement

---

## 🔀 When Someone Opens a Pull Request

### Step 1: Review the Code
1. Click on "Files changed" tab
2. Read through the changes
3. Check if it:
   - Solves the problem
   - Follows existing code style
   - Doesn't break anything

### Step 2: Test Locally
```bash
# Clone their fork
git clone https://github.com/THEIR-USERNAME/flash-pkg.git
cd flash-pkg
git checkout their-branch-name

# Test the changes
bash install.sh
flash

# Test specific feature they added
```

### Step 3: Leave Review Comments
**If changes needed:**
```markdown
Thanks for the PR! A few suggestions:

1. Line 45: Can you add a comment explaining this?
2. Line 67: This might break on Windows. Try [suggestion]
3. Can you add a test for this feature?

Let me know if you need help!
```

**If looks good:**
```markdown
Looks great! Thanks for contributing! 🎉

I'll merge this once CI passes.
```

### Step 4: Merge or Request Changes
- Click "Review changes" button
- Choose:
  - **Approve**: If everything looks good
  - **Request changes**: If fixes needed
  - **Comment**: If just asking questions

- Click "Merge pull request" when ready

---

## 🏷️ Managing Labels

### When to Use Each Label

**Priority:**
- `priority: critical` - Blocks users, needs immediate fix
- `priority: high` - Important, fix within a week
- `priority: medium` - Nice to have, fix within a month
- `priority: low` - Minor improvement, fix when time allows

**Type:**
- `bug` - Something is broken
- `enhancement` - New feature request
- `documentation` - Docs need updating
- `question` - User needs help

**Status:**
- `status: needs triage` - New issue, not reviewed yet
- `status: in progress` - Someone is working on it
- `status: blocked` - Can't proceed until something else is done
- `status: ready for review` - PR is ready to review

**Special:**
- `good first issue` - Easy for beginners (add this to simple issues!)
- `help wanted` - You need help with this

---

## 🎯 Triaging New Issues (Daily Routine)

### Morning Routine (5-10 minutes)
1. Go to [Issues tab](https://github.com/Yogesh1290/flash-pkg/issues)
2. Look for issues with `status: needs triage`
3. For each issue:
   - Read it
   - Add appropriate labels
   - Respond with initial comment
   - Remove `status: needs triage` label

### What to Look For
- **Duplicates**: Search existing issues first
- **Invalid**: Close with explanation
- **Good first issues**: Add `good first issue` label
- **Urgent bugs**: Add `priority: critical` and fix ASAP

---

## 🚀 Releasing a New Version

### Step 1: Update Version
```bash
# Update VERSION file
echo "1.3.0" > VERSION

# Update version in install.sh
# Line 3: # flash-pkg v1.3.0

# Update version in install.ps1
# Line 3: # flash-pkg v1.3.0

# Update version in README.md badges
# Line 3: ![Version](https://img.shields.io/badge/version-1.3.0-blue)
```

### Step 2: Update CHANGELOG.md
```markdown
## [1.3.0] - 2026-03-15

### Added
- New feature X
- New feature Y

### Fixed
- Bug fix A
- Bug fix B

### Changed
- Improvement C
```

### Step 3: Commit and Tag
```bash
git add -A
git commit -m "Release v1.3.0"
git tag v1.3.0
git push origin main
git push origin v1.3.0
```

### Step 4: Create GitHub Release
1. Go to [Releases](https://github.com/Yogesh1290/flash-pkg/releases)
2. Click "Draft a new release"
3. Choose tag: `v1.3.0`
4. Title: `v1.3.0 - Feature Name`
5. Description: Copy from CHANGELOG.md
6. Upload cache files (if you have them)
7. Click "Publish release"

---

## 💬 Responding to Common Questions

### "How do I install flash-pkg?"
```markdown
Check out our [Quick Start Guide](QUICK_START.md)!

**Linux/macOS/WSL:**
\`\`\`bash
curl -sSL https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.sh | bash
\`\`\`

**Windows PowerShell:**
\`\`\`powershell
irm https://raw.githubusercontent.com/Yogesh1290/flash-pkg/main/install.ps1 | iex
\`\`\`
```

### "Is this better than Docker?"
```markdown
flash-pkg and Docker solve different problems!

- **flash-pkg**: Fast development setup (your laptop)
- **Docker**: Production deployment (servers)

Use both! See our [Docker Comparison](docs/DOCKER_COMPARISON.md) for details.
```

### "Can I use this in production?"
```markdown
flash-pkg is for development, not production deployment.

For production, use Docker/Kubernetes. flash-pkg can generate production-ready Docker templates:

\`\`\`bash
flash docker-ml my-app
\`\`\`

See [Enterprise Guide](docs/ENTERPRISE.md) for more.
```

### "Why is my install slow?"
```markdown
First install is always slow (downloading from internet).

Every project after that should be <30 seconds!

If second install is still slow:
1. Check internet connection
2. Try: `flash bootstrap-ml` (one-time, 2-5 min)
3. Then new projects will be instant

See [Performance Expectations](docs/PERFORMANCE_EXPECTATIONS.md).
```

---

## 🎉 Celebrating Contributors

### When Someone Makes Their First Contribution
1. Thank them in the PR/issue
2. Add them to README contributors section (if significant contribution)
3. Mention them in release notes
4. Give them a shoutout on Twitter/X

### Example Thank You Message
```markdown
🎉 Huge thanks to @username for this contribution!

This is their first PR to flash-pkg and they:
- [What they did]
- [Impact it has]

Welcome to the community! 🚀
```

---

## 📊 Monthly Tasks

### End of Month Review
1. **Check metrics**:
   - Stars: [current count]
   - Issues opened/closed
   - PRs merged
   - New contributors

2. **Update roadmap**:
   - Mark completed features
   - Add new feature requests
   - Reprioritize based on feedback

3. **Plan next release**:
   - What features to include?
   - Any breaking changes?
   - Documentation updates needed?

---

## 🆘 When You Need Help

### Stuck on a Technical Issue?
- Ask in [GitHub Discussions](https://github.com/Yogesh1290/flash-pkg/discussions)
- Search similar projects for solutions
- Ask on Reddit (r/Python, r/opensource)

### Overwhelmed with Issues/PRs?
- Add `help wanted` label to issues
- Ask contributors to help review PRs
- It's okay to say "I need time to review this"

### Dealing with Difficult Users?
- Stay professional and polite
- If someone is rude, you can:
  - Politely ask them to be respectful
  - Lock the conversation if it gets toxic
  - Block repeat offenders

---

## ✅ Quick Checklist

**Daily (5-10 min):**
- [ ] Check new issues
- [ ] Respond to comments
- [ ] Review PRs

**Weekly (30 min):**
- [ ] Merge approved PRs
- [ ] Close resolved issues
- [ ] Update documentation if needed

**Monthly (1-2 hours):**
- [ ] Review metrics
- [ ] Update roadmap
- [ ] Plan next release
- [ ] Thank contributors

---

## 🎓 Learning Resources

**For Open Source Maintainers:**
- [Open Source Guides](https://opensource.guide/)
- [GitHub Skills](https://skills.github.com/)
- [First Timers Only](https://www.firsttimersonly.com/)

**For Managing Issues:**
- [GitHub Issues Documentation](https://docs.github.com/en/issues)
- [Labels Best Practices](https://docs.github.com/en/issues/using-labels-and-milestones-to-track-work/managing-labels)

---

**You've got this!** 🚀

Remember: Every open source maintainer started where you are. Be patient with yourself and your contributors. The community will grow!

---

**Questions?** Open an issue or discussion. The community is here to help!
