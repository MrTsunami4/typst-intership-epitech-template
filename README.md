# Typst Internship Report Template (Epitech)

This repository provides a Typst template for writing an internship report with a structured layout and a full example document.

## Repository contents

- `template.typ`: reusable template with:
  - Cover page generation
  - Optional acknowledgements and abstract
  - Table of contents
  - Styled headings, tables, code blocks, figures, header/footer
  - Part separator pages via `part_page(...)`
- `example.typ`: complete example report using the template
- `example.pdf`: rendered output of `example.typ`

## Requirements

- [Typst](https://typst.app/) installed locally

## Usage

1. Copy `example.typ` to your own file (e.g., `internship-report.typ`).
2. Update report metadata in `#show: internship_report.with(...)`:
   - title, author, email
   - company/university names and optional logos
   - dates and supervisors
   - acknowledgements and abstract
3. Replace example sections with your own content.
4. Compile:

```bash
typst compile internship-report.typ internship-report.pdf
```

## Quick customization

- Edit global styles directly in `template.typ` (colors, fonts, margins, heading/table/figure styles).
- Use `#part_page("Part title", preamble: "...")` to split major report parts.
- Uncomment and set `university_logo` / `company_logo` in your report file to display logos.
