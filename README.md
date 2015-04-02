Template for the CU Thesis LaTeX class and Extension to HTML
============================================================

### Write Once Publish Everywhere

The [Thesis Class](http://www.colorado.edu/oit/software-hardware/tex-latex/thesis-class) is a template provided by the University of Colorado for writing a disertaion in `LaTeX`.  This project provides the ability to convert `LaTeX` (.tex) files into a traditional PDF using a [`pandoc`](http://johnmacfarlane.net/pandoc/) template.  The use of these `LaTeX` files can be extended by converting them to Markdown, allowing for the rendering of the thesis in HTML and other formats.  This is accomplished by extracting key elements (thesis title, author info, advisor names, file names, etc.) into a [YAML meta-data file](http://en.wikipedia.org/wiki/YAML) and using `pandoc` to convert files from one type to another.

#### Converting `LaTeX` to PDF

The example files provided by the University of Colorado are ready to be run (i.e. typeset) in `LaTeX` to produce the example thesis .pdf file.  This is accomplished by typesetting the "mythesis.tex" file using any `LaTeX` distribution (although results may vary - I have had the best luck with the XeLaTeX engine in TeXShop for Mac).  The same .pdf file can be produced using the custom [`pandoc`](http://johnmacfarlane.net/pandoc/) template (/templates/thesis.tex) along with the thesis.yaml file in place of the "mythesis.tex" file. The purpose of this project, however, is not to re-invent the wheel.  Rather, we want to add more wheels - specifically Markdown, HTML and potentially Epub wheels.

#####  The `pandoc` Template and `YAML` Front Matter Files

The .latex template and .yaml configuration files were produced by extracting information from "mythesis.tex".  This can be seen in the [first changes made for these two files](https://github.com/CenterForAssessment/NCME_Training_Session_2015/commit/e719f6fed42eb3f8edf3cab0a31daa85e118423e).  The custom `LaTeX` template allows us to produce the same pdf file as simply typesetting the document, but the extracted YAML data can be used to produce similar documents using HTML and Epub templates.  For more information about the syntax and structure of a `YAML` file, there are many resources on the web ([here](http://docs.ansible.com/YAMLSyntax.html) and [here](http://www.yaml.org/refcard.html) for example).

We put the two together and (assuming you have [`pandoc` installed](http://johnmacfarlane.net/pandoc/installing.html) as well as a [`LaTeX` distribution](http://latex-project.org/ftp.html)) produce the .pdf document from the OS command line.  Here we also assume you are working from the CU_Thesis directory, and we are first creating a set of sub-directories for our output in the first line.

```
mkdir -p output/pdf
pandoc -o output/pdf/my_thesis_rendered.pdf --filter pandoc-citeproc --bibliography refs.bib --template templates/thesis.latex -s thesis.yaml
```

One can also use pandoc to simply compile the chapter\*.tex and appendix\*.tex files into a single file (for debugging, reference, posterity etc.).

```
pandoc -o output/pdf/my_thesis_complete.tex --filter pandoc-citeproc --bibliography refs.bib --template templates/thesis.latex -s thesis.yaml
```


#### Converting `LaTeX` to HTML

Again, the production of a pdf file is not the ultimate point of this project.  We want to take the .tex files that we have put so much work into and use them to produce the same document but in different formats.

##### Direct Conversion to HTML

One option is to produce a very simple HTML document using the .tex files directly.  This can be done using the following call to `pandoc` using the individual chapter\*.tex and appendix\*.tex files.  The output will be a simple .html file with virtually none of the stylization provided in the Thesis Class document (see the "thesis.cls" file).  It also lacks the document information found in the "thesis.yaml" and "mythesis.tex" files (author and advisor names, title, etc.).  However it gives us a glympse of what is possible.

```
pandoc -o my_thesis_body.html --number-sections \
  --filter pandoc-citeproc --bibliography refs.bib \
  --self-contained --standalone -s \
    chapter1.tex \
    chapter2.tex \
    appendixA.tex \
    appendixB.tex

```

The resulting file is a standalone HTML document that can be opened directly in a web browser to view the contents.

##### Converting `LaTeX` to Markdown and HTML

A more entailed work-flow can produce a more visually appealling product that includes all the documentation information that is excluded going directly from .tex to .html.  This workflow requires us to first produce a markdown document from the latex component files, which can then be converted to HTML utilizing the YAML file, as well as a custom `pandoc` template for html, and CSS to stylize and add other features.

```
mkdir output/html
pandoc -s chapter1.tex chapter2.tex appendixA.tex appendixB.tex -o output/mythesis.md

pandoc -s thesis.yaml output/mythesis.md -o output/html/my_thesis.html --number-sections --table-of-contents --toc-depth 2 \
--filter pandoc-citeproc --bibliography refs.bib --self-contained --standalone \
--template templates/thesis.html --css templates/thesis.css
```

We again have a standalone HTML document that can be opened directly in a web browser to view the contents.  This file is getting closer to something that we might want to host online (for [free on Github pages!](https://pages.github.com/)).  We have some of the features we wanted (the use of footnotes and a biblography, numbered sections and figures, etc.), and ones we don't have with the simple pdf like a navigable table of contents.

However, in this example there are still many flaws with the output because it was originally set up to be rendered in `LaTeX`.  For example, many of the images and equations are mangled and quite ugly.  The `pandoc` conversion of some lists also gets screwed up a bit (an additional line is put in leading to the first elements being interpreted as paragraphs in HTML instead of list items).  Some of these issues can be fixed with a little pre-processing of the markdown file (e.g. deleting those extra lines in the lists).  Such formatting changes can be done manually, or you might come up with a text parsing routine in another language to preprocess the intermediate files before producing the final product.  Other issues, such as the use of PDF figures in the text of the thesis, might require more elaborate or inovative solutions.

