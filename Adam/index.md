---
title       : Leveraging Open Source Software and Tools for Statistics/Measurement Research
subtitle    : Reproducible Research, Collaborative Writing and Web Publishing
author      : Adam Van Iwaarden
job         : NCME - April 15, 2015
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Introduction

The internet is the Gutenberg Press of the 21st Century.

>1.  Free (at least some places, like Github)
>2.  Open
>3.  Collaborative
>4.  Customizable - as simple or complex as you want.

Version control and open environment lend itself to collaboration, replication and elaboration.

--- .class #id 

## Grim Reality ...

Much of the world is still stuck in the dark ages of printed media.  There is still a demand for traditional document formats.
>- PDF
>- Word Documents


---

## The Complete Workflow

My typical workflow for going from data and script file to a reproducible report that can be hosted on Github:

`R` / `knitr` **/ R markdown   ->   markdown  ->  YAML / Jekyll / Liquid -> static HTML**

---

##  The Simple Workflow,  markdown  ->  static HTML

At the heart of creating a Github pages site is simply adding a markdown file to a branch named "gh-pages" on any Github repository.  Github runs Jekyll in the background and this will produce a static site at a URL like http://my_user_name.github.io/My_Project/ or similar. For example, http://adamvi.github.io/Simple_Site/

Markdown is a language and formatting syntax that can be read by humans and easily converted to HTML.

For more information about markdown, see the [project website](http://daringfireball.net/projects/markdown/) and wikipedia (http://en.wikipedia.org/wiki/Markdown).

---

## Add in Complexity as Desired

Complexity can be added to the workflow in multiple areas.

1.  Using `R`, R markdown and the `knitr` package to process `R` code and include results in an output markdown file that can be converted to HTML.
2.  Inline and in text HTML.
3.  Using css, javascript, Bootstrap frameworks and other tools to create more stylized pages and complex (navigable) websites.  These are elements included in the gh-pages directory along with the markdown file.

---

##  Markdown_Document Project

I wanted to create something that would allow me to easily turn a markdown file into an attractive document with an academic feel to it.  I wanted to be able to include features such as the inclusion of a section numbering, interactive (D3) visualizations, and mathematical equations.  Using css, Liquid templating (for Jekyll), and a few other tools, I've created the "Markdown_Document" project.

This is a simple, static site that displays an example of the documents that it can produce, which also serves as a manual for its use.  The example page can be viewed [here](http://adamvi.github.io/Markdown_Document/), and the Github repository can be viewed/forked/downloaded [here.](https://github.com/adamvi/Markdown_Document)

---

##  Uses of Markdown_Document

1.  Reports for state-level work with Student Growth Percentiles
2.  White papers and research reports
3.  Dissertation work

*Note* this can also be used to produce an html file locally using Jekyll directly.  From there one can either distribute the html file directly, use Google Chrome to print a pdf, use pandoc to convert to some other markup language, etc.

---

##  Example Demonstration

I've created an example R markdown file that runs through a demonstration of Baseline referenced SGP production and a brief report of the results.  This file (Baseline_SGP_Report.Rmd) will use the `SGP` package, as well as some others (`plyr`, `data.table`, `devtools`, etc. that you should have installed).  Most importantly, you will need the `knitr` package to "knit" the .Rmd file and `R` code into a regular markdown file.

```
install.packages('knitr', dependencies = TRUE)
```

I will step through the creation of the Github repo, knitting the file, and pushing the resulting files and Markdown_Document directories and components to Github to create the static page.  The necessary files will then be available in that newly created Repo.

---

##  Set up the New Repo on Github

*  I'll name the repo "Baseline_SGP_Report."  Add README and .gitignore (R) files
*  Add a branch named (exactly) "gh-pages"
*  Make that branch the default
*  Clone the repo to my local machine
*  Make sure the gh-pages branch is the current branch

---

##  Knit the .Rmd file

*  Move the Baseline_SGP_Report.Rmd file into the cloned directory file
*  In R, switch the working directory to the Baseline_SGP_Report directory and then "knit" the file.

```
setwd('Baseline_SGP_Report')

library(knitr)
render_jekyll()

knit('Baseline_SGP_Report.Rmd', output='index.md')

```

---

##  Edit some files

When we knit the file, we produced a directory called the "cache," which saves some interim results from running the R code.  This is useful when drafting the document and changing `R` code because we don't have to re-run time consuming calculations, data structuring, etc.  However, we don't want this cache to be included in our Github repository.  We will "ignore" it using the .gitignore file.

*  Add "cache/*" to .gitignore.  Other additions may be desired too, such as "_site/*" if you've used Jekyll from the command line to review the finished site before pushing it to Github.
*  Commit these changes and push to Github.  There will now be a plain website at http://adamvi.github.io/Baseline_SGP_Report/

---

## Add in the Markdown_Document elements

*  Add in the relevant files from the Markdown_Document repository.  Again, you will either want to fork or download the zip file of [this repo.](https://github.com/adamvi/Markdown_Document)  Do not add in .md files (index, README, etc.) or any of the other "example" files.
*  Commit these changes and push to Github.  There will now be a formatted site at http://adamvi.github.io/Baseline_SGP_Report/

---

## Make changes and push those to the master

Now lets assume we've done some additional work, or one of our colleagues has added in their sections.  Let's add in some text and push that to the gh-pages branch.
*  Here we are only adding text, so we *could* modify the .md file directly and simply update that without having to "re-knit" our .Rmd file.  However, then we would have our files out of sync.  So lets add in text to the .Rmd file and then re-run `knit('Baseline_SGP_Report.Rmd', output='index.md')`.
* Once this is done we can push the changes to the gh-pages branch.  Since this is my repo I do not have to do a pull request.  It all happens automatically.  However, if someone were to fork this report and want to make changes or additions to this specific ("official") repo, they would need to issue a pull request to merge their edits in.

