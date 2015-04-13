---
title       : Use of Github for Shared LateX documents
subtitle    : Version Control and Collaboration
author      : Ruhan Circi
job         : April 15th 2015
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : [mathjax]            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## My inspration to use Github is Picasso
### Do you recognize this famous painting?

</slide>

<slide class="" id="slide-1" style="background:;">
  <hgroup>
  <article>
<div style='text-align: center;'>
    <img height='350' width='450' src='pictures/picasso.jpg' />
</div>

</article>
</slide>


---

## The steps that I will follow today

> 1. What is LaTeX?

> 2. Github Example  
  - Put your LaTeX document into your Github repository 

> 3. Git to collaborate with others 
  - Fork and cloning the remote repository 
  - Make the changes in your local repo 
  - Submit pull request to project owner 
  - Fetch vs. Pull
  - Sycncing a fork
  - Git fetch upstream 
  - Push the commits into remote respository 
  - Dealing with conflict errors 
  - Let's have a short practice


---


## Are we ready to start? 

</slide>

<slide class="" id="slide-3" style="background:;">
  <hgroup>
  <article>
<div style='text-align: center;'>
    <img height='300' width='300' src='pictures/are_you_ready.jpg' />
</div>

</article>
</slide>



---

## LaTeX 
>1. What is LateX? 
>2. Steps to create a simple document:
  - Open the text editor
  - Save a blank file (name it as "latex_(your_initials)_trial.tex")


---    

## Step-by-step LaTeX example 

>  1. Remember that you need backslash ("\") for each command in LateX
  - \documentclass[11pt]{article}
  - \begin {document}
  - \section {Welcome}
  - \textit(Hello) \underline{from} \textbf{NCME}
  - Happy to see you all. Let's start with some math.  Given that $(z+1)$ and $(z+4)$,         
  - The area is presented by $Area=z^2+5z+4$ 
  - \subsection[10]{context} We will cover good things!!!
  - \end{document}
  


---

## Github: Put your document into your repository   

>  1. Open your command line (assuming your file is under Directory1)
  - cd Directory1 (change your working directory) 
  - git init      (Create or restart an existing repo)
  - git add <file name> (add files into staging area )
  - git commit -m "your message here"


---

## Github: Simple structure


</slide>

<slide class="" id="slide-7" style="background:;">
  <hgroup>
  <article>
<div style='text-align: center;'>
    <img height='500' src='pictures/gits_area.jpg' />
</div>

</article>
</slide>


---



## GITHUB for collaboration



---


## Thank You




   
