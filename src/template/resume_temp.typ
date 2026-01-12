#let resume(data) = {
  // --- Icons (SVG Paths) ---
  let icon(path) = box(baseline: 0.1em, height: 0.8em, image.decode(path))

  // Simple Feather Icons SVGs (approximate)
  let icon-mail = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z'></path><polyline points='22,6 12,13 2,6'></polyline></svg>"
  let icon-phone = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z'></path></svg>"
  let icon-github = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22'></path></svg>"
  let icon-linkedin = "<svg xmlns='http://www.w3.org/2000/svg' viewBox='0 0 24 24' fill='none' stroke='currentColor' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'><path d='M16 8a6 6 0 0 1 6 6v7h-4v-7a2 2 0 0 0-2-2 2 2 0 0 0-2 2v7h-4v-7a6 6 0 0 1 6-6z'></path><rect x='2' y='9' width='4' height='12'></rect><circle cx='4' cy='4' r='2'></circle></svg>"

  // --- Configuration ---
  set text(font: ("Instrument Sans", "Inter", "Helvetica"), size: 10pt, lang: "en")
  set page(
    margin: (x: 1.5cm, y: 1.5cm),
    paper: "a4",
    // numbering: "1 of 1",
  )
  set par(justify: true)

  // Document Metadata
  set document(
    title: data.personal.name + " - Resume",
    author: data.personal.name,
    date: auto,
  )

  // Colors
  let accent-color = rgb("#000000")
  let gray-color = rgb("#555555")
  let link-color = rgb("#0056b3") // Subtle blue for links

  // --- Helpers ---
  let smart-link(url, content) = {
    let target = url
    if not (url.starts-with("http://") or url.starts-with("https://")) {
      target = "https://" + url
    }
    link(target)[#text(fill: link-color)[#content]]
  }

  // --- Styling Rules ---
  // Semantic Headings (replacing section-title function)
  show heading.where(level: 1): it => {
    v(0.4em)
    text(size: 14pt, weight: "bold")[#upper(it.body)]
    v(-0.6em)
    line(length: 100%, stroke: 1pt + black)
    v(0.6em)
  }

  let entry-header(title, date, subtitle, location) = {
    grid(
      columns: (1fr, auto),
      row-gutter: 0.2em,
      [
        #text(weight: "bold", size: 11pt)[#title]
        #if subtitle != none [ • #text(style: "italic", fill: gray-color)[#subtitle]]
      ],
      align(right)[
        #text(weight: "medium")[#date] \
        #text(size: 9pt, fill: gray-color)[#location]
      ],
    )
  }

  // --- Header ---
  align(center)[
    #text(size: 24pt, weight: "bold")[#data.personal.name] \
    #v(0.1em)
    #text(size: 9pt, weight: "medium")[#data.personal.title] \
    #v(0.1em)
    #text(size: 9pt)[
      #box(icon(icon-mail)) #link("mailto:" + data.personal.email)[#data.personal.email]
      #h(1em)
      #box(icon(icon-linkedin)) #smart-link(data.personal.linkedin, "LinkedIn")
      #h(1em)
      #box(icon(icon-github)) #smart-link(data.personal.github, "GitHub")
      #h(1em)
      #box(icon(icon-phone)) #data.personal.phone
    ]
  ]

  // --- Summary ---
  if "summary" in data {
    heading("Professional Summary")
    data.summary
  }

  // --- Technical Skills ---
  heading("Technical Skills")
  grid(
    columns: (auto, 1fr),
    row-gutter: 0.8em,
    column-gutter: 1.5em,
    ..for (category, items) in data.skills {
      (
        text(weight: "bold")[#category:],
        items.join(", "),
      )
    }
  )

  // --- Experience ---
  heading("Experience")
  for company_entry in data.experience {
    if "roles" in company_entry {
      // Company Name Row
      grid(
        columns: (1fr, auto),
        text(size: 11pt, weight: "bold")[#company_entry.company],
        text(size: 9pt, style: "italic")[#company_entry.location],
      )
      v(0.1em)

      for role in company_entry.roles {
        grid(
          columns: (1fr, auto),
          text(weight: "bold", fill: gray-color)[#role.title], text(size: 8pt)[#role.period],
        )
        for point in role.highlights {
          list(marker: [•], body-indent: 1em, spacing: 0.5em)[#text(size: 9pt)[#point]]
        }
        v(0.1em)
      }
    } else {
      // Fallback
      entry-header(company_entry.role, company_entry.period, company_entry.company, company_entry.location)
      for point in company_entry.highlights {
        list(marker: [•], body-indent: 0.3em, spacing: 0.5em)[#point]
      }
    }
    v(0.4em)
  }

  // --- Education ---
  heading("Education")
  for edu in data.education {
    entry-header(edu.school, edu.year, edu.degree, edu.location)
    v(0.5em)
  }

  // --- Projects ---
  heading("Projects")
  for project in data.projects {
    grid(
      columns: (1fr, auto),
      smart-link(project.link, text(weight: "bold", size: 10pt)[#project.name]), text(size: 9pt)[#project.date],
    )
    if "tech" in project {
      v(-0.2em)
      text(size: 9pt, style: "italic", fill: gray-color)[Tech: #project.tech]
    }
    v(0.2em)
    for point in project.highlights {
      list(marker: [‣], body-indent: 1em, spacing: 0.5em)[#text(size: 9pt)[#point]]
    }
    v(0.8em)
  }

  // --- Certifications ---
  if "certifications" in data {
    let valid-certs = data.certifications.filter(c => c.name != "")
    if valid-certs.len() > 0 {
      heading("Certifications")
      for cert in valid-certs {
        grid(
          columns: (1fr, auto),
          text(weight: "bold")[#cert.name], text(size: 9pt)[#cert.date],
        )
        text(size: 9pt, style: "italic", fill: gray-color)[#cert.issuer]
        v(0.5em)
      }
    }
  }

  // --- Footer ---
  // align(center + bottom)[
  //   #v(1fr)
  //   #line(length: 100%, stroke: 0.5pt + gray-color)
  //   #text(size: 8pt, fill: gray-color)[
  //     Last Updated: #datetime.today().display()
  //   ]
  // ]
}
