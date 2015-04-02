Template for the CU Thesis LaTeX class and Extension to HTML
============================================================

### Write Once Publish Everywhere

The [Thesis Class](http://www.colorado.edu/oit/software-hardware/tex-latex/thesis-class) is a template provided by the University of Colorado for writing a disertaion in LaTex.  This project provides the ability to convert LaTeX (.tex) files into a traditional PDF using a [pandoc](http://johnmacfarlane.net/pandoc/) template.  The use of these LaTeX files can be extended by converting them to Markdown, allowing for the rendering of the thesis in HTML and other formats.  This is accomplished by extracting key elements (thesis title, author info, advisor names, file names, etc.) into a YAML meta-data file and using [pandoc](http://johnmacfarlane.net/pandoc/) to convert files from one type to another.
