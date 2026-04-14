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
  // --- Document Metadata ---
  set document(title: title, author: author)

  // --- Title Page Setup ---
  // We use an empty page setup first so the cover page doesn't get headers/footers
  set page(paper: "a4", margin: 2.5cm, fill: rgb("#013afb"))
  set text(fill: white, font: "Noto Sans", weight: "medium")

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
    #text(size: 12pt, weight: "bold")[Maître de stage/ Tuteurs :] \
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
    margin: (top: 3.5cm, bottom: 3.5cm, left: 2.5cm, right: 2.5cm),
    header: context {
      set text(size: 12pt, fill: white, font: "Noto Sans", weight: "medium")
      // Bleed the background to the top and side edges of the A4 page
      place(dx: -2.5cm, dy: 0cm, block(
        fill: rgb("#013afb"),
        width: 21cm,
        height: 3.5cm,
        inset: (left: 2.5cm, right: 2.5cm, bottom: 5mm),
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
      set text(size: 12pt, fill: white, font: "Noto Sans", weight: "medium")
      // Bleed the background to the bottom and side edges of the A4 page
      place(dx: -2.5cm, dy: 0cm, block(
        fill: rgb("#013afb"),
        width: 21cm,
        height: 3.5cm,
        inset: (left: 2.5cm, right: 2.5cm, top: 5mm),
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
    set text(font: "Noto Sans", fill: rgb("#013afb"))
    v(1.5em)
    it
    v(0.5em)
  }

  // --- Code Block Styling ---
  show raw.where(block: true): it => block(
    fill: rgb("#f4f6fd"), // Very light blue background
    inset: 10pt,
    radius: (left: 0pt, right: 4pt),
    stroke: (left: 3pt + rgb("#013afb")), // Brand blue left border
    width: 100%,
    it,
  )

  // --- Table & Figure Styling ---
  set table(
    stroke: 0.5pt + rgb("#d1d5db"), // Light gray borders
    fill: (x, y) => if y == 0 { rgb("#013afb") } else if calc.even(y) { rgb("#f4f6fd") } else { none },
  )
  show table.cell.where(y: 0): set text(fill: white, weight: "bold", font: "Noto Sans")
  show figure.caption: set text(size: 9pt, style: "italic", fill: rgb("#555555"))

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
