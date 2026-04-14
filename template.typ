#let internship_report(
  title: "",
  author: "",
  company_name: "",
  company_logo: none,
  university_name: "",
  university_logo: none,
  supervisors: (),
  dates: "",
  abstract: none,
  acknowledgements: none,
  body,
) = {
  // Variables
  let brand-color = rgb("#013afb")
  let bg-light = rgb("#f4f6fd")
  let font-sans = "Noto Sans"
  let margin-side = 2.5cm
  let margin-v = 3.5cm
  let page-width = 21cm

  // --- Document Metadata ---
  set document(title: title, author: author)

  // --- Title Page Setup ---
  // We use an empty page setup first so the cover page doesn't get headers/footers
  set page(paper: "a4", margin: margin-side, fill: brand-color)
  set text(fill: white, font: font-sans, weight: "medium")

  // Logos at the top
  grid(
    columns: (1fr, 1fr),
    align(left)[
      #if university_logo != none { image(university_logo, width: 4cm) } else { text(weight: "bold", university_name) }
    ],
    align(right)[
      #if company_logo != none { image(company_logo, width: 4cm) } else { text(weight: "bold", company_name) }
    ],
  )

  v(4cm)

  // Title and Author
  align(center)[
    #text(size: 26pt, weight: "bold", title)
    #v(1cm)
    #text(size: 16pt, author)
    #v(0.5cm)
    #text(size: 12pt, style: "italic", dates)
  ]

  v(1fr)

  // Supervisors block pushed to the bottom
  align(left)[
    #text(size: 12pt, weight: "bold")[Maître de stage / Tuteurs :] \
    #v(2mm)
    #for sup in supervisors [
      - #sup \
    ]
  ]

  pagebreak()

  // --- Main Document Page Setup ---
  // Now we apply your specific header and footer rules to the rest of the pages
  set page(
    fill: none, // Resets the blue background
    margin: (top: margin-v, bottom: margin-v, left: margin-side, right: margin-side),
    header: context {
      set text(size: 10pt, fill: white, font: font-sans, weight: "medium")
      // Bleed the background to the top and side edges of the A4 page
      place(dx: -margin-side, dy: 0cm, block(
        fill: brand-color,
        width: page-width,
        height: margin-v,
        inset: (left: margin-side, right: margin-side, bottom: 5mm),
        align(bottom)[
          #grid(
            columns: (1fr, auto),
            align(left + horizon, title),
            align(right + horizon)[
              #if company_logo != none { image(company_logo, height: 0.8cm) } else { text(company_name) }
            ],
          )
        ],
      ))
    },
    footer: context {
      set text(size: 12pt, fill: white, font: font-sans, weight: "medium")
      // Bleed the background to the bottom and side edges of the A4 page
      place(dx: -margin-side, dy: 0cm, block(
        fill: brand-color,
        width: page-width,
        height: margin-v,
        inset: (left: margin-side, right: margin-side, top: 5mm),
        align(top)[
          #grid(
            columns: (auto, 1fr, auto),
            align(left + horizon)[
              #if university_logo != none { image(university_logo, height: 0.8cm) } else { text(university_name) }
            ],
            align(right + horizon)[Page #counter(page).display("1")],
          )
        ],
      ))
    },
  )

  // --- Main Typography & Styling ---
  // Using a clean, readable font configuration (adjust to your liking)
  set text(font: "Libertinus Serif", size: 11pt, lang: "fr", fill: black)
  set par(justify: true, leading: 0.65em)
  set heading(numbering: "1.1.")

  // Add spacing around headings
  show heading: it => {
    set text(font: font-sans, fill: brand-color)
    v(1.5em)
    it
    v(0.5em)
  }

  // --- Code Block Styling ---
  show raw.where(block: true): it => block(
    fill: bg-light, // Very light blue background
    inset: 10pt,
    radius: (left: 0pt, right: 4pt),
    stroke: (left: 3pt + brand-color), // Brand blue left border
    width: 100%,
    it,
  )

  // --- Table & Figure Styling ---
  set table(
    stroke: 0.5pt + rgb("#d1d5db"), // Light gray borders
    fill: (x, y) => if y == 0 { brand-color } else if calc.even(y) { bg-light } else { none },
  )
  show table.cell.where(y: 0): set text(fill: white, weight: "bold", font: font-sans)

  // --- Figure & Caption Styling ---
  // Tweak caption text generally
  show figure.caption: set text(size: 9pt, style: "italic", fill: rgb("#555555"))

  // Style the content area of figures specifically for images/diagrams
  // so they match the code block aesthetic.
  show figure.where(kind: image): it => {
    // Center the whole figure block and add vertical spacing
    v(1em, weak: true)
    align(center, {
      // Create the thematic box around the image itself
      box(
        stroke: (left: 3pt + brand-color), // Signature left border
        fill: bg-light, // Very light blue tint background
        inset: 12pt, // Space between border and image edge
        radius: (right: 4pt), // Soft corners
        width: 90%, // Slight inset from main text width
        it.body,
      )
      // Space between image box and caption
      v(0.6em, weak: true)
      it.caption
    })
    v(1em, weak: true)
  }

  // --- Frontmatter (Acknowledgements, Abstract, TOC) ---
  if acknowledgements != none {
    heading(numbering: none)[Remerciements]
    acknowledgements
    pagebreak()
  }

  if abstract != none {
    heading(numbering: none)[Résumé]
    abstract
    pagebreak()
  }

  heading(numbering: none)[Sommaire]
  outline(title: none, indent: auto)
  pagebreak()

  // --- Main Content Inserted Here ---
  body
}
