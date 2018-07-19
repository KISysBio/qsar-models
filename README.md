**WORK IN PROGRESS**

# Info

This repository uses the package `oplrareg` to develop QSAR models. Please install it following the instructions on the link: https://github.com/KISysBio/OPLRAreg

`OPLRAreg` can be applied to any regression problem but the main objective of this research problem was to develop regression algorithms for QSAR modelling.

This directory contains the data files used in the study `Optimal Piecewise Regression Algorithm for QSAR Modelling` which, at the time of writing, is going through peer review process. We will update this file with links to the study as soon as the paper gets published somewhere.

# QSAR data sets were used in this study

We tested `OPLRAreg` on 5 data sets downloaded from ChEMBL:

- rDHFR
- hDHFR
- [CHRM3](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL245): Muscarinic acetylcholine receptor M3
- NPYR1
- NPYR2

# Preprocessing: Where does these data files come from?

First, we have downloaded data about these data sets from [ChEMBL](https://www.ebi.ac.uk/chembl/), selecting the compounds which had their inhibitory activity against the common protein targets shown above measured by the $IC_50$ metric <sup id="a1">[1](#f1)</sup>.

Then, we preprocessed the data by merging entries of duplicated molecules and filtering out entries where the activities could not be entirely trusted using the column `Data Validity` from ChEMBL.

The next step was to generate 200+ molecular descriptors using the Java Chemistry Development Kit ([CDK](https://cdk.github.io/)) from within R (the great package [rcdk](https://github.com/rajarshi/cdkr)).

A list of all molecular descriptors can be found from CDK documentation [here](https://cdk.github.io/cdk/1.5/docs/api/org/openscience/cdk/qsar/descriptors/molecular/package-summary.html).

The spreadsheets under directory _data_ represent the final files after this preprocessing step. 

## Why did you not just stick with Python and use RDKit as the cheminformatics library? 

At the beginning of the project, I (Jonathan) was not very familiar with Python. R was my default language for programming and data exploration and we were using [GAMS](https://www.gams.com/latest/docs/UG_Tutorial.html) as the programming language for developing the algorithm. 

Later it became clearer that we could create the same algorithm in Python using [Pyomo](http://www.pyomo.org/), which would be much more accesible since not every one owns a GAMS license. It was only then that we ported part of the project to Python.

**So, because of that, parts of the pipeline of this project such as molecular descriptors and data preprocessing was implemented in R. Cross-validation and comparison to other machine learning algorithms was also implemented in R to take advantage of the functionalities of the caret package.**

We will update this repository to include the preprocessing steps as well.

## What are the data splits?

We split the data sets at random into 5 different test studies. At each test, 75% of samples were used during cross-validation to build and select the regression models and 25% were used as external validation set.

We wanted to compare algorithms using the same cross-validation folds and external set samples so the files under the directory _data\_splits_ contain the indices of all tests. This includes the indices for the 10 batches of 10-fold cross-validation performed on the internal set of samples. 

<b id="f1">1</b> Using $IC\_50$ as the sole measure of effectiveness was a decision made earlier in the project. The same pipeline would work perfectly fine with other metrics such as $K_i$ or by combining the log of concentrations measured with $K_i$ + $IC_50$. [↩](#a1)

