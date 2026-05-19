#let part_page(title, preamble: none) = {
  page(
    fill: rgb("#013afb"),
    margin: 2.5cm,
  )[
    #set text(fill: white, font: "Noto Sans")
    #v(1fr)
    #align(center)[
      #text(size: 32pt, weight: "bold", title)
      #if preamble != none {
        v(1cm)
        text(size: 14pt, preamble)
      }
    ]
    #v(1fr)
  ]
}

#let internship_report(
  title: "",
  author: "",
  email: "",
  company_name: "",
  company_logo: none,
  university_name: "Epitech",
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
  let font-serif = "Libertinus Serif"
  let margin-side = 2.5cm
  let margin-v = 3.5cm
  let page-width = 21cm

  // --- Document Metadata ---
  set document(title: title, author: author)

  // --- Title Page Setup ---
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
    #text(size: 30pt, weight: "bold", title)
    #v(1cm)
    #text(size: 24pt, author)
    #v(0.2cm)
    #text(size: 18pt, email)
    #v(0.5cm)
    #text(size: 12pt, style: "italic", dates)
  ]

  v(1fr)

  // Supervisors block pushed to the bottom
  align(left)[
    #text(size: 12pt, weight: "bold")[Supervisors / Mentors:] \
    #v(2mm)
    #for sup in supervisors [
      - #sup \
    ]
  ]

  pagebreak()

  // --- Main Document Page Setup ---
  set page(
    fill: none,
    margin: (top: margin-v, bottom: margin-v, left: margin-side, right: margin-side),
    header: context {
      set text(size: 10pt, fill: white, font: font-sans, weight: "medium")
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
  set text(font: font-serif, size: 11pt, lang: "en", fill: black)
  set par(justify: true, leading: 0.35em, first-line-indent: 1.5em)
  set heading(numbering: "1.1.")

  show heading: it => {
    set text(font: font-sans, fill: brand-color)
    v(1.5em)
    it
    v(0.5em)
  }

  show raw.where(block: true): it => block(
    fill: bg-light,
    inset: 10pt,
    radius: (left: 0pt, right: 4pt),
    stroke: (left: 3pt + brand-color),
    width: 100%,
    it,
  )

  set table(
    stroke: 0.5pt + rgb("#d1d5db"),
    fill: (x, y) => if y == 0 { brand-color } else if calc.even(y) { bg-light } else { none },
  )
  show table.cell.where(y: 0): set text(fill: white, weight: "bold", font: font-sans)

  show terms: set text(font: font-sans, size: 10pt)

  show outline.entry: it => link(
    it.element.location(),
    it.indented(it.prefix(), {
      it.body()
      h(1fr)
      it.page()
    }),
  )

  show figure.caption: set text(size: 9pt, style: "italic", fill: rgb("#555555"))

  show figure.where(kind: image): it => {
    v(1em, weak: true)
    align(center, {
      box(
        stroke: (left: 3pt + brand-color),
        fill: bg-light,
        inset: 12pt,
        radius: (right: 4pt),
        width: 90%,
        it.body,
      )
      v(0.6em, weak: true)
      it.caption
    })
    v(1em, weak: true)
  }

  // --- Frontmatter ---
  if acknowledgements != none {
    heading(numbering: none)[Acknowledgements]
    acknowledgements
    pagebreak()
  }

  if abstract != none {
    heading(numbering: none)[Abstract]
    abstract
    pagebreak()
  }

  heading(numbering: none)[Table of Contents]
  outline(title: none, indent: 2em)
  pagebreak()

  body
}
