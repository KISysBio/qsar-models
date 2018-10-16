# Info

This repository contains algorithms for QSAR modelling developed at the group of Dr. Sophia Tsoka at King's College London.

Our most recent paper `Optimal Piecewise Regression Algorithm for QSAR Modelling` has been published at Wiley's Molecular Informatics and can be found [here](https://onlinelibrary.wiley.com/doi/full/10.1002/minf.201800028).

In this study, we have developed an algorithm based on mathematical programming to build QSAR models. The algorithm is written in Python and can be applied to any regression analysis, details about how to download and use the `oplrareg` package can be found at the link https://github.com/KISysBio/OPLRAreg

This repository contains the data files used in the study.

# QSAR data sets were used in this study

We tested `OPLRAreg` on 5 data sets downloaded from ChEMBL:

- [rDHFR](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL2363): Dihydrofolate reductase (_Rattus norvegicus_)
- [hDHFR](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL202): Dihydrofolate reductase (_Homo sapiens_)
- [CHRM3](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL245): Muscarinic acetylcholine receptor M3
- [NPYR1](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL4777): 	Neuropeptide Y receptor type 1
- [NPYR2](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL4018): 	Neuropeptide Y receptor type 2

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

I am currently working on translating everything to Python and we will possibly use RDKit for most of the cheminformatics tasks.

## What are the data splits?

We split the data sets at random into 5 different test studies. At each test, 75% of samples were used to build and select the regression models under cross-validation while the remaining 25% were used as external validation set.

We wanted to compare algorithms using the same cross-validation folds and external set samples so the files under the directory _data\_splits_ contain the indices of all tests. This includes the indices for the 10 batches of 10-fold cross-validation performed on the internal set of samples. 

<b id="f1">1</b> Using $IC\_50$ as the sole measure of effectiveness was a decision made earlier in the project. The same pipeline would work perfectly fine with other metrics such as $K_i$ or by combining the log of concentrations measured with $K_i$ + $IC_50$. [↩](#a1)

# Contact

Sophia Tsoka: sophia.tsoka@kcl.ac.uk
Jonathan Cardoso-Silva: jonathan.silva@kcl.ac.uk
