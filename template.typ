#let songti = "SimSun"
#let heiti = "SimHei"
#let kaiti = "Sitka Text"
#let textfont = "Times New Roman"
#let codefont = "DejaVu Sans Mono"
#show math.equation.where(block: false): it => h(0.25em, weak: true) + it + h(0.25em, weak: true)
#let font_size = (
  初号: 42pt,
  小初: 36pt,
  一号: 26pt,
  小一: 24pt,
  二号: 22pt,
  小二: 18pt,
  三号: 16pt,
  小三: 15pt,
  四号: 14pt,
  小四: 12pt,
  五号: 10.5pt,
  小五: 9pt,
  六号: 7.5pt,
  小六: 6.5pt,
  七号: 5.5pt,
  八号: 5pt
);
#let ifacconf(
  // The paper's title.
  title: "Paper Title",
  title_en: "English Title",
  // An array of authors. For each author you can specify a name, email
  // (optional), and affiliation. The affiliation must be an integer
  // corresponding to an entry in the 1-indexed affiliations list (or 0 for no
  // affiliation).
  authors: (),
  authors_en: (),
  // An array of affiliations. For each affiliation you can specify a
  // department, organization, and address. Everything is optional (i.e., an
  // affiliation can be an empty array).
  affiliations: (),
  affiliations_en: (),
  // The paper's abstract. Can be omitted if you don't have one.
  abstract: none,
  abstract_en: none,
  // A list of index terms to display after the abstract.
  keywords: (),
  keywords_en: (),
  // Sponsor or financial support acknowledgment
  sponsor: none,

  // The paper's content.
  body
) = {
  // Set document metadata.
  set document(title: title,  author: authors.map(author => author.name))

  // Set the body font.
  set text(font:(textfont,songti) , size: font_size.五号,top-edge: 1em,)

  // Configure the page.
  set page(
    paper: "a4",
    // The margins depend on the paper size.
    margin: (x: 1.5cm, y: 2.5cm),
    numbering:"1"
  )

  // Set line spacing
  set par(leading: 0.4em,first-line-indent:2em)

  // Configure equation numbering and spacing.
  set math.equation(numbering: "(1)")
  show math.equation: set block(spacing: 0.65em)

  // Configure appearance of equation references
  show ref: it => {
    if it.element != none and it.element.func() == math.equation {
      // Override equation references.
      link(
        it.element.label,
        numbering(
          it.element.numbering,
          ..counter(math.equation).at(it.element.location())
        )
      )
    } else {
      // Other references as usual.
      it
    }
  }

  // Configure lists.
  set enum(indent: 10pt, body-indent: 9pt)
  set list(indent: 10pt, body-indent: 9pt)


  // Configure Figures
  set figure.caption(separator: "  ")
  show figure.caption: set align(center)
  show figure.caption: set par(hanging-indent: 8mm)
  set figure(numbering: "1", supplement: [图])

  // Configure Tables
  show figure.caption.where(kind: "table"): set align(center)
  show figure.where(kind: "table"): set figure.caption(position: top)
  set table.hline(stroke: 0.5pt)

  // Configure Footnotes
  set footnote(numbering: "1")
  set footnote.entry(indent: 0mm, separator: line(length: 60%, stroke: 0.4pt), clearance: 0.35em)

  // Configure headings.
  set heading(numbering: "1.1.1")
  show heading: it => locate(loc => {
    set par(first-line-indent:0em)
    // Find out the final number of the heading counter.
    let levels = counter(heading).at(loc)
    let deepest = if levels != () {
      levels.last()
    } else {
      1
    }

    set text(10pt, weight: "regular")
    if it.level == 1 [
      #set text(font:(textfont,heiti),size:font_size.四号)
      // First-level headings are centered caps.
      // We don't want to number of the acknowledgment section.
      #let is-ack = it.body in ([Acknowledgments], [Acknowledgements], [REFERENCES])
      #set align(center)
      // #show: upper
      #v(20pt, weak: true)
      #if it.numbering != none and not is-ack {
        strong(
        numbering("1", deepest))
        h(5pt, weak: true)
      }
      #text(stroke:0.02875em)[#it.body]
      #v(13pt, weak: true)
    ] else if it.level == 2 [
      // Second-level headings left-aligned and italic.
            #set text(font:(textfont,heiti),size:font_size.小四)
      #v(16pt, weak: true)
      #if it.numbering != none {
        strong(
        numbering("1.1", ..levels))
        h(6pt, weak: true)
      }
      #text(stroke:0.02875em)[#it.body]
      #v(16pt, weak: true)
    ] else [
      // Third level headings are run-ins too, but different.
              #v(16pt, weak: true)
      #if it.numbering != none {
        numbering("1.1.1 ", ..levels)
        it.body
        h(8pt)
      }
      
    ]
  })


  let star = [\u{1F7B1}]
  pad(
    x: 3.5cm,
    [
      #set align(center)

      // Display the paper's title.
      #v(1cm)
      #let title-font-size = 42pt
      #if sponsor == none {
        text(title-font-size, strong(title))
      } else {
        set footnote(numbering: "1")
        set text(font:heiti,stroke:0.02857em)
        text(font_size.小二, [*#title*#h(-2pt)])
      }
      #v(2mm)

      // Display the authors list.
      #let alist = ()
      #for (i, a) in authors.enumerate() {
        let mark = text(8pt, [1] * (a.affiliation))
        alist.push(box([#strong(a.name)#h(2pt)#super[#mark]]))
      }
      #set text(font:kaiti)
      #alist.join(h(4pt))
      #v(1mm)

      // Display the affiliations list
      #for (i, af) in affiliations.enumerate() {
        set text(font:(textfont,songti),size:font_size.小五)
          let mark = text(8pt, [\1] * (i + 1))
          let email-array = ()
          for au in authors {
            if "affiliation" in au and au.affiliation == i + 1 and "email" in au {
              email-array.push(au.email)
            }
          }
          let emails = ""
          if email-array.len() > 0 {
            emails = "(email: " + email-array.join(", ") + ")"
          }
          
          let affil-array = ()
          if "department" in af { affil-array.push(af.department) }
          if "organization" in af { affil-array.push(af.organization) }
          if "address" in af { affil-array.push(af.address) }
          let affil = affil-array.join(", ")
          
          [#mark #affil \ #emph(emails)]
          if i != affiliations.len() - 1 [ \ ]
      }
      #v(3mm, weak: false)  
    ],
  )

  // Display abstract and keywords.
  if abstract != none {
    grid(
      columns: (0cm, 1fr, 0cm),
      [],
      [
        #set par(justify: true,first-line-indent:0em)

        #v(-1.5mm)
        #text(stroke:0.02857em)[摘要:] #abstract 

        #if keywords != () [
          #text(stroke:0.02857em)[关键词：] #keywords.join(", ")
        ]
        #v(2.5mm)

      ],
      []
    )
    v(0mm, weak: false)
  }
//英文标题
  let star = [\u{1F7B1}]
  pad(
    x: 3.5cm,
    [
      #set align(center)

      // Display the paper's title.
      #v(0.1cm)
      #let title-font-size = 42pt
      #if sponsor == none {
        text(title-font-size, strong(title_en))
      } else {
        set footnote(numbering: "1")
        set text(stroke:0.02857em)
        text(font_size.小二, [*#title_en*#h(-2pt)])
      }
      #v(2mm)

      // Display the authors list.
      #let alist = ()
      #for (i, a) in authors_en.enumerate() {
        let mark = text(8pt, [1] * (a.affiliation))
        alist.push(box([#strong(a.name)#h(2pt)#super[#mark]]))
      }
      #alist.join(h(4pt))
      #v(1mm)

      // Display the affiliations list
      #for (i, af) in affiliations_en.enumerate() {
        set text(font:(textfont,songti),size:font_size.小五)
          let mark = text(8pt, [\1] * (i + 1))
          let email-array = ()
          for au in authors_en {
            if "affiliation" in au and au.affiliation == i + 1 and "email" in au {
              email-array.push(au.email)
            }
          }
          let emails = ""
          if email-array.len() > 0 {
            emails = "(email: " + email-array.join(", ") + ")"
          }
          
          let affil-array = ()
          if "department" in af { affil-array.push(af.department) }
          if "organization" in af { affil-array.push(af.organization) }
          if "address" in af { affil-array.push(af.address) }
          let affil = affil-array.join(", ")
          
          [#mark #affil\ #emph(emails)]
          if i != affiliations_en.len() - 1 [ \ ]
      }
      #v(3mm, weak: false)
    ],
  )

  // Display abstract and keywords.
  if abstract_en != none {
    grid(
      columns: (0cm, 1fr, 0cm),
      [],
      [
        #set par(justify: true,first-line-indent:0em)

        #v(-1.5mm)
        #text(stroke:0.02857em)[Abstract:] #abstract_en
        #v(2mm)
        #if keywords_en != () [
          #text(stroke:0.02857em)[Keywords：] #keywords_en.join(", ")
        ]
        #v(2.5mm)

      ],
      []
    )
    v(0mm, weak: false)
  }

  // Start two column mode and configure paragraph properties.
  show: columns.with(2, gutter: 5mm)
  // show: columns.with(2, gutter: 3.5mm)
  set par(justify: true, leading: 0.4em)
  show par: set block(spacing: 3.5mm)

  // Display the paper's contents.
  body

}

#import "@preview/ctheorems:1.1.0": *
#let ifacconf-rules(doc) = { 
  show bibliography: set block(spacing: 5pt)
  show: thmrules
  doc
}

#let tablefig = figure.with(supplement: [表], kind: "table")



// Support for numbered Theorems, etc.
// NOTE: these definitions may be able to be cleaned up and compressed in the future
#let theorem = thmenv(
  "theorem",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Theorem #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Theorem",
  )

#let lemma = thmenv(
  "lemma",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Lemma #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Lemma",
  )

#let claim = thmenv(
  "claim",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Claim #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Claim",
  )

#let conjecture = thmenv(
  "conjecture",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Conjecture #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Conjecture",
  )

#let corollary = thmenv(
  "corollary",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Corollary #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Corollary",
  )

#let fact = thmenv(
  "fact",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Fact #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Fact",
  )

#let hypothesis = thmenv(
  "hypothesis",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Hypothesis #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Hypothesis",
  )

#let proposition = thmenv(
  "proposition",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Proposition #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Proposition",
  )

#let criterion = thmenv(
  "criterion",
  none,
  none,
  (name, number, body, ..args) => {
    set align(left)
    set par(justify: true)
    block(inset: 0mm, radius: 0mm, breakable: false, width: 100%)[_Criterion #number#if name != none [ (#name)]._#h(2pt)#body]
  },
).with(
  supplement: "Criterion",
  )

#let proof = thmbox(
  "proof",
  "Proof",
  inset: 0mm,
  base: none,
  bodyfmt: body => [#body #h(1fr) $square$],
  separator: [.#h(2pt)]
).with(numbering: none)

#let footnote = it => footnote[#h(4pt)#it]

#let citep(it) = {
  cite(it, style: "CSL/ifac-conference-citep.csl")
}










#let bib(bibliography-file) = {
  show bibliography: set text(font_size.五号)
  set bibliography(title: "参考文献 References", style: "gb-7714-2015-numeric")
  bibliography-file
  v(10pt)
}

#let appendix-num = counter("appendix")

#let appendix(title, body1) = {
  appendix-num.step()
  table(
    fill: (_, row) => if row == 0 or row == 1 {luma(200)} else {none},
    rows: 3,
    columns: 1fr,
    text[*附录 #appendix-num.display()：*],
    text[*#title*],
    body1
  )
}