---
name: biblemate
description: Bible study tools via MCP — search, retrieve verses, commentaries, cross-references, Hebrew/Greek interlinear, devotions, sermons, and theological analysis.
metadata: {"openclaw":{"emoji":"📖","requires":{"bins":["mcporter"]}}}
---

# Biblemate (MCP)

Bible study MCP server with 49 tools. Use `mcporter call biblemate.<tool>` for all Bible-related queries.

## Workflow: Structured Bible Study

When a user asks a Bible-related question, **DO NOT** answer directly. Follow this structured approach:

---

### Step 1: Refine the Request (Prompt Engineering)

Before planning, **improve the user's request** to ensure optimal results from the tools. Apply prompt engineering principles:

#### 1.1 Identify Issues in the Original Request

Check for:
- **Ambiguities:** Words with multiple meanings (e.g., "love" — agape, phileo, eros?)
- **Vague scope:** "Tell me about Paul" (which aspect? theology? biography? letters?)
- **Missing context:** No time period, testament, or theological tradition specified
- **Unclear intent:** Study purpose not stated (academic, devotional, sermon prep?)
- **Assumed knowledge:** References that need clarification (e.g., "the passage about the armor")
- **Imprecise references:** Partial or incorrect verse citations

#### 1.2 Refinement Techniques

Apply these strategies:

| Technique | Description | Example |
|-----------|-------------|---------|
| **Specify scope** | Narrow broad topics to specific aspects | "grace" → "grace in Pauline epistles, specifically Ephesians 2:1-10" |
| **Clarify intent** | State the study purpose | Add: "for devotional reflection" or "for exegetical analysis" |
| **Add context** | Include relevant background | "faith" → "faith (πίστις/pistis) in Hebrews 11, examining OT examples" |
| **Define terms** | Clarify key concepts | "salvation" → "salvation as justification, sanctification, and glorification" |
| **Specify output** | Request particular deliverables | Add: "including cross-references and practical applications" |
| **Bound the search** | Limit testament, genre, or author | "prophecy" → "messianic prophecy in Isaiah 7-12" |
| **Resolve references** | Convert vague to precise | "that famous verse about love" → "1 Corinthians 13:4-7" |

#### 1.3 Output the Refined Request

Present the refinement in this format:

```
## Request Refinement

**Original Request:** [User's exact words]

**Issues Identified:**
- [Issue 1]: [Brief explanation]
- [Issue 2]: [Brief explanation]

**Refinements Applied:**
- [Technique used]: [How it improves the request]
- [Technique used]: [How it improves the request]

**Refined Request:** [Clear, specific, well-structured version]

**Assumed Parameters:**
- Study type: [exegetical | devotional | theological | historical | topical]
- Depth: [overview | moderate | deep-dive]
- Output focus: [academic | practical | both]
```

#### 1.4 Refinement Examples

**Example 1: Vague Topic**
- Original: "Tell me about faith"
- Issues: Too broad, no scope, unclear intent
- Refined: "Examine the concept of faith (πίστις) in Hebrews 11, analyzing how the author defines faith in v.1, the OT examples cited, and how this understanding applies to perseverance in trials. Include Greek word study and cross-references to James 2."

**Example 2: Unclear Reference**
- Original: "What's the verse about God's plans?"
- Issues: Ambiguous reference (multiple candidates), no context
- Refined: "Retrieve and analyze Jeremiah 29:11 ('For I know the plans I have for you'), examining its original context (exile in Babylon), proper interpretation (corporate vs. individual promise), and appropriate modern application."

**Example 3: Broad Character Study**
- Original: "Tell me about David"
- Issues: Massive topic, no focus area
- Refined: "Conduct a character study of David focusing on his spiritual journey through failure and restoration, specifically examining Psalm 51 in light of 2 Samuel 11-12, including the theological themes of repentance, forgiveness, and consequences of sin."

**Example 4: Simple Verse Request (Minimal Refinement)**
- Original: "What does John 3:16 mean?"
- Issues: None significant, but can add depth
- Refined: "Provide exegetical analysis of John 3:16, including the Greek terms (κόσμος, μονογενής, πιστεύων), the immediate context of Jesus' conversation with Nicodemus, theological significance of substitutionary love, and connection to John's broader 'believe' theme."

---

### Step 2: Analyze the Refined Request

With the refined request, identify:
- The core question or topic
- Type of study needed (exegesis, devotional, theological, historical, practical)
- Relevant Bible passages, characters, or themes
- User's apparent level (casual reader, student, scholar)
- Required depth and output format

---

### Step 3: Create Preliminary Action Plan

Output a plan in this format:

```
# Preliminary Action Plan

**Refined Request:** [The improved version from Step 1]
**Study Type:** [exegetical | devotional | theological | historical | topical | character | comparative]
**Depth:** [overview | moderate | deep-dive]

## Steps

1. **[Step Name]**
   - Tool: `biblemate.<tool_name>`
   - Purpose: [What this step accomplishes]
   - Input: [The request parameter — be specific and well-crafted]

2. **[Step Name]**
   - Tool: `biblemate.<tool_name>`
   - Purpose: [What this step accomplishes]
   - Input: [The request parameter]

[...continue for 3-7 steps as needed...]

## Measurable Outcomes

- [ ] [Specific deliverable 1]
- [ ] [Specific deliverable 2]
- [ ] [Specific deliverable 3]
```

**Tool Input Best Practices:**
- Be specific in request parameters (not just "John 3" but "John 3:1-8, focusing on the new birth dialogue")
- Include relevant context in the request string
- For thematic searches, use precise theological vocabulary
- For original language tools, specify what aspect to examine

---

### Step 4: Execute the Plan

Run each step sequentially using `mcporter call biblemate.<tool> request="..."`.

For each step:
- Execute the tool call with the **refined, specific input**
- Capture key findings
- Note any cross-references or follow-up insights
- If results are insufficient, refine the input and retry

---

### Step 5: Quality Control

Before finalizing, verify:
- All measurable outcomes have been addressed
- Findings are consistent across sources
- Original languages support the conclusions (if applicable)
- Practical application is grounded in the text
- The response matches the **refined request's** intent and scope

---

### Step 6: Final Report

Provide an integrated response:

```
# Final Report: [Topic/Question]

## Summary
[2-3 sentence overview of findings]

## Key Findings

### [Finding 1 Title]
[Details with verse references]

### [Finding 2 Title]
[Details with verse references]

[...continue as needed...]

## Original Language Insights
[Hebrew/Greek insights if relevant]

## Cross-References
[Related passages discovered]

## Theological Significance
[Broader meaning and doctrinal connections]

## Practical Application
[How this applies to life/faith]

## Sources Consulted
- [List of tools used and their contributions]
```

---

## Tool Reference

### Retrieve & Search
- `mcporter call biblemate.retrieve_bible_verses request="John 3:16-17"`
- `mcporter call biblemate.retrieve_chinese_bible_verses request="John 3:16-17"`
- `mcporter call biblemate.retrieve_bible_chapter request="Psalm 23"`
- `mcporter call biblemate.search_the_whole_bible request="love your neighbor"`
- `mcporter call biblemate.retrieve_bible_cross_references request="Romans 8:28"`

### Original Languages
- `mcporter call biblemate.retrieve_hebrew_or_greek_bible_verses request="Gen 1:1"`
- `mcporter call biblemate.retrieve_interlinear_hebrew_or_greek_bible_verses request="John 1:1"`
- `mcporter call biblemate.retrieve_verse_morphology request="Eph 2:8"`
- `mcporter call biblemate.translate_hebrew_bible_verse request="<Hebrew text>"`
- `mcporter call biblemate.translate_greek_bible_verse request="<Greek text>"`

### Compare & Commentary
- `mcporter call biblemate.compare_bible_translations request="Psalm 23:1"`
- `mcporter call biblemate.read_bible_commentary request="Rom 8:28"`
- `mcporter call biblemate.refine_bible_translation request="Gen 1:2"`

### Study & Analysis
- `mcporter call biblemate.write_bible_chapter_summary request="Genesis 1"`
- `mcporter call biblemate.write_bible_book_introduction request="Romans"`
- `mcporter call biblemate.write_bible_outline request="Ephesians"`
- `mcporter call biblemate.write_bible_insights request="Matt 5:1-12"`
- `mcporter call biblemate.interpret_old_testament_verse request="Isaiah 53:5"`
- `mcporter call biblemate.interpret_new_testament_verse request="Heb 11:1"`

### Themes & Context
- `mcporter call biblemate.study_bible_themes request="grace"`
- `mcporter call biblemate.study_old_testament_themes request="Exodus 20"`
- `mcporter call biblemate.study_new_testament_themes request="Galatians 5"`
- `mcporter call biblemate.write_old_testament_historical_context request="1 Kings 18"`
- `mcporter call biblemate.write_new_testament_historical_context request="Acts 2"`
- `mcporter call biblemate.write_bible_canonical_context request="Daniel"`
- `mcporter call biblemate.write_bible_thought_progression request="Romans 8"`

### Characters & Locations
- `mcporter call biblemate.write_bible_character_study request="David"`
- `mcporter call biblemate.write_bible_location_study request="Jerusalem"`

### Devotional & Practical
- `mcporter call biblemate.write_bible_devotion request="Phil 4:6-7"`
- `mcporter call biblemate.write_bible_applications request="James 1:2-4"`
- `mcporter call biblemate.write_bible_questions request="Mark 4:1-20"`
- `mcporter call biblemate.quote_bible_verses request="comfort in grief"`
- `mcporter call biblemate.quote_bible_promises request="anxiety"`

### Psalms
- `mcporter call biblemate.anyalyze_psalms request="Psalm 51:1-5"`

### Theology & Teaching
- `mcporter call biblemate.expound_bible_topic request="justification by faith"`
- `mcporter call biblemate.write_bible_theology request="Trinity"`
- `mcporter call biblemate.write_bible_perspectives request="suffering"`
- `mcporter call biblemate.explain_bible_meaning request="born again"`
- `mcporter call biblemate.identify_bible_keywords request="faith hope love"`
- `mcporter call biblemate.write_bible_sermon request="John 14:1-6"`

### Highlights & Summaries
- `mcporter call biblemate.write_old_testament_highlights request="Isaiah 40"`
- `mcporter call biblemate.write_new_testament_highlights request="Hebrews 11"`
- `mcporter call biblemate.write_bible_related_summary request="parables of Jesus"`

### Prayer
- `mcporter call biblemate.write_bible_prayer request="healing"`
- `mcporter call biblemate.write_short_bible_prayer request="peace"`
- `mcporter call biblemate.write_pastor_prayer request="Sunday service"`

### Ask Experts
- `mcporter call biblemate.ask_theologian request="predestination vs free will"`
- `mcporter call biblemate.ask_pastor request="how to forgive someone"`
- `mcporter call biblemate.ask_bible_scholar request="authorship of Hebrews"`

---

## Complete Example Workflow

**User asks:** "What does it mean to be 'born again' in John 3?"

---

### Step 1: Request Refinement

**Original Request:** "What does it mean to be 'born again' in John 3?"

**Issues Identified:**
- Scope slightly vague: Which verses specifically? (John 3 has 36 verses)
- Depth unclear: Surface explanation or deep exegesis?
- Missing: No mention of Greek analysis (critical for "born again" ambiguity)

**Refinements Applied:**
- Specify scope: Focus on John 3:1-8 (the Nicodemus dialogue)
- Add linguistic depth: Include Greek analysis of ἄνωθεν (anōthen)
- Clarify theological dimension: Connect to regeneration doctrine
- Add practical element: Modern application for believers

**Refined Request:** "Provide exegetical analysis of 'born again' (γεννηθῇ ἄνωθεν) in John 3:1-8, examining: (1) the Greek double-meaning of ἄνωθεν (again/from above), (2) Jesus' explanation of water and Spirit birth, (3) why Nicodemus as a Pharisee should have understood this from OT background, (4) the theological doctrine of regeneration, and (5) practical implications for understanding conversion today."

**Assumed Parameters:**
- Study type: exegetical + theological
- Depth: deep-dive
- Output focus: both academic and practical

---

### Step 2: Analysis

- Core question: Meaning of spiritual rebirth in Jesus' teaching
- Study type: Exegetical with theological application
- Key passage: John 3:1-8
- Themes: Regeneration, Holy Spirit, new birth, kingdom entry
- Level: Moderate to advanced (includes Greek)

---

### Step 3: Preliminary Action Plan

**Refined Request:** Exegetical analysis of "born again" in John 3:1-8 with Greek study, OT background, theology, and application
**Study Type:** exegetical + theological
**Depth:** deep-dive

## Steps

1. **Retrieve the Text**
   - Tool: `biblemate.retrieve_bible_verses`
   - Purpose: Get the primary passage in full
   - Input: "John 3:1-8 — Jesus' conversation with Nicodemus about being born again"

2. **Greek Interlinear Analysis**
   - Tool: `biblemate.retrieve_interlinear_hebrew_or_greek_bible_verses`
   - Purpose: Examine γεννηθῇ ἄνωθεν — the ambiguous "born again/from above"
   - Input: "John 3:3-7 focusing on the Greek word ἄνωθεν and its double meaning"

3. **Cross-References**
   - Tool: `biblemate.retrieve_bible_cross_references`
   - Purpose: Find OT background and NT parallels on spiritual rebirth
   - Input: "John 3:3-5 — passages about spiritual rebirth, new heart, and Spirit"

4. **Commentary**
   - Tool: `biblemate.read_bible_commentary`
   - Purpose: Scholarly interpretation of the passage
   - Input: "John 3:3-5 born again water and Spirit, Nicodemus dialogue"

5. **Theological Exposition**
   - Tool: `biblemate.expound_bible_topic`
   - Purpose: Doctrinal significance of regeneration
   - Input: "regeneration and new birth in John 3, including relationship to Ezekiel 36:25-27"

6. **Practical Application**
   - Tool: `biblemate.write_bible_applications`
   - Purpose: How this applies to believers today
   - Input: "John 3:1-8 — what being born again means for conversion and Christian life"

## Measurable Outcomes

- [ ] Greek meaning of ἄνωθεν (anōthen) — "again" vs "from above" — clarified
- [ ] Water and Spirit birth relationship explained (baptism? Ezekiel 36? amniotic?)
- [ ] OT background identified (Ezek 36:25-27, Jer 31:33, etc.)
- [ ] Theological doctrine of regeneration summarized
- [ ] Practical application for understanding conversion provided

---

[Then execute each step, verify outcomes, and compile the Final Report]

---

## Google Drive Integration

After completing a Bible study, archive all work to Google Drive for future reference.

### Configuration

- **Root Folder ID:** `1nAtV-o7SLPKhloDEy0slhqqQxZVQmkAs`
- **Root Folder Name:** `bible-study-agent`
- **Web Link:** https://drive.google.com/drive/folders/1nAtV-o7SLPKhloDEy0slhqqQxZVQmkAs

> ⚠️ Always use this folder ID. Check `memory/google-drive.md` if unsure.

### Workflow: Save Study to Google Drive

After generating the Final Report, follow these steps:

#### Step 1: Generate Study Title

Create a descriptive, filesystem-safe title for the study:
- Format: `YYYY-MM-DD - Topic or Passage`
- Example: `2026-02-21 - Born Again in John 3`
- Keep it concise but descriptive

#### Step 2: Create Study Subfolder

```bash
gog drive mkdir "2026-02-21 - Born Again in John 3" --parent 1nAtV-o7SLPKhloDEy0slhqqQxZVQmkAs --json
```

Capture the subfolder ID from the response.

#### Step 3: Save Request Refinement and Study Plan

**Before executing any tools**, save the request refinement and preliminary action plan:

```bash
mkdir -p /tmp/bible-study-output

# Save as the FIRST file (00 prefix)
# File: 00-request-and-study-plan.md
```

This file should contain:
1. **Request Refinement** — Original request, issues identified, refinements applied, refined request
2. **Preliminary Action Plan** — Study type, depth, numbered steps with tools and purposes, measurable outcomes

This documents the planning phase and provides context for all subsequent outputs.

#### Step 4: Execute Tools and Save Outputs

Save each MCP tool output as a separate file:

```bash
# Example filenames:
# - 00-request-and-study-plan.md  ← NEW: Planning phase
# - 01-verses-john-3-1-8.md
# - 02-interlinear-analysis.md
# - 03-cross-references.md
# - 04-commentary.md
# - 05-theological-exposition.md
# - 06-applications.md
# - final-report.md
```

Use numbered prefixes to preserve execution order.

#### Step 5: Convert Markdown to DOCX

Use pandoc to convert each markdown file to docx format:

```bash
# Convert all markdown files to docx
for f in /tmp/bible-study-output/*.md; do
  pandoc "$f" -o "${f%.md}.docx"
done
```

This creates both `.md` and `.docx` versions of every file.

#### Step 6: Upload All Files

Upload both markdown and docx files to the study subfolder:

```bash
# Upload markdown files
for f in /tmp/bible-study-output/*.md; do
  gog drive upload "$f" --parent <subfolder-id>
done

# Upload docx files
for f in /tmp/bible-study-output/*.docx; do
  gog drive upload "$f" --parent <subfolder-id>
done
```

#### Step 7: Send Final Report DOCX to Telegram

Send the final report docx file directly to the Telegram group:

```
Use the message tool with action=send and filePath=/tmp/bible-study-output/final-report.docx
```

#### Step 8: Share Study Folder

Share the study subfolder with read-only access (anyone with link can view):

```bash
gog drive share <subfolder-id> --to anyone --role reader
```

Then send the shared link to the Telegram group. The link format is:
`https://drive.google.com/drive/folders/<subfolder-id>`

#### Step 9: Confirm Upload

```bash
# List uploaded files
gog drive ls <subfolder-id>
```

#### Step 10: Cleanup

```bash
rm -rf /tmp/bible-study-output
```

### Output File Naming Convention

| Step | Filename Pattern | Example |
|------|-----------------|---------|
| **Request & Plan** | `00-request-and-study-plan.md` | `00-request-and-study-plan.md` |
| Verse retrieval | `01-verses-<reference>.md` | `01-verses-john-3-1-8.md` |
| Interlinear | `02-interlinear-<reference>.md` | `02-interlinear-john-3-3-7.md` |
| Cross-references | `03-cross-references.md` | `03-cross-references.md` |
| Commentary | `04-commentary.md` | `04-commentary.md` |
| Thematic/Theological | `05-theological-<topic>.md` | `05-theological-regeneration.md` |
| Application | `06-applications.md` | `06-applications.md` |
| Final Report | `final-report.md` | `final-report.md` |

> **Note:** The `00-request-and-study-plan.md` file captures the request refinement and preliminary action plan BEFORE tool execution begins. This provides crucial context for the study.

### Example Complete Flow

```bash
# 1. Create subfolder
STUDY_FOLDER=$(gog drive mkdir "2026-02-21 - Born Again in John 3" \
  --parent 1nAtV-o7SLPKhloDEy0slhqqQxZVQmkAs --json | jq -r '.folder.id')

# 2. Create local output directory
mkdir -p /tmp/bible-study-output

# 3. Save request refinement and study plan FIRST
# Write 00-request-and-study-plan.md with:
#   - Request Refinement (original, issues, refinements, refined request)
#   - Preliminary Action Plan (study type, depth, steps, outcomes)

# 4. Execute tools and save each output to /tmp/bible-study-output/*.md
# Files: 01-verses.md, 02-summary.md, 03-context.md, etc.

# 5. Create final integrated report
# File: final-report.md

# 6. Convert all markdown to docx
for f in /tmp/bible-study-output/*.md; do
  pandoc "$f" -o "${f%.md}.docx"
done

# 7. Upload all files (both md and docx)
for f in /tmp/bible-study-output/*.md /tmp/bible-study-output/*.docx; do
  gog drive upload "$f" --parent "$STUDY_FOLDER"
done

# 8. Send final report docx to Telegram
# Use: message tool with action=send, filePath=/tmp/bible-study-output/final-report.docx

# 9. Share folder with read-only access
gog drive share "$STUDY_FOLDER" --to anyone --role reader

# 10. Send shared link to Telegram
# Link: https://drive.google.com/drive/folders/$STUDY_FOLDER

# 9. Verify
gog drive ls "$STUDY_FOLDER"

# 10. Cleanup
rm -rf /tmp/bible-study-output
```

### Telegram Delivery Checklist

After completing a study, send to the Telegram group:

1. ✅ **Text summary** — Brief response in chat
2. ✅ **Final report DOCX** — Send as file attachment using message tool
3. ✅ **Shared folder link** — Read-only Google Drive link to all study materials

---

## Notes

- **Always refine first:** Even simple requests benefit from clarification
- **Skip refinement only if:** The request is already precise with clear scope and intent
- All tools take a `request` parameter (string) — make it detailed and specific
- For verse references, use standard format: `Book Chapter:Verse` (e.g., `John 3:16`, `Gen 1:1-3`)
- Adjust steps based on complexity (simple = 3-4, complex = 5-7, comprehensive <= 50)
- Always include original language tools for exegetical questions
- The final report should **integrate** findings in detail, not concatenate outputs
- If a tool returns thin results, **refine the input** and retry before moving on
