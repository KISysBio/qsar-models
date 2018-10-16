`OPLRAreg` can be applied to any regression problem but the main objective of this research problem was to develop regression algorithms for QSAR modelling.

This directory contains the data files used in the study `Optimal Piecewise Regression Algorithm for QSAR Modelling` which, at the time of writing, is going through peer review process. We will update this file as soon as the paper gets published somewhere.

# QSAR data sets were used in this study

We tested `OPLRAreg` on 5 data sets downloaded from ChEMBL:

- [rDHFR](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL2363): Dihydrofolate reductase (_Rattus norvegicus_)
- [hDHFR](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL202): Dihydrofolate reductase (_Homo sapiens_)
- [CHRM3](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL245): Muscarinic acetylcholine receptor M3
- [NPYR1](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL4777): 	Neuropeptide Y receptor type 1
- [NPYR2](https://www.ebi.ac.uk/chembl/target/inspect/CHEMBL4018): 	Neuropeptide Y receptor type 2


# Where does these data files come from?

First, we have downloaded these data sets from ChEMBL, selecting the compounds which had their $IC_50$ activities measured <sup id="a1">[1](#f1)</sup>.

Then, we generated molecular descriptors using the Java Chemistry Development Kit ([CDK](https://cdk.github.io/)) from within R (the great package [rcdk](https://github.com/rajarshi/cdkr)).

## Why did you not just stick with Python and use RDKit as the cheminformatics library? 

At the beginning of the project, I (Jonathan) was not very familiar with Python. R was my default language for programming and data exploration and we were using [GAMS](https://www.gams.com/latest/docs/UG_Tutorial.html) as the programming language for developing the algorithm. 

Later it became clearer that we could create the same algorithm in Python using Pyomo

So, because of that, parts of the pipeline of this project such as molecular descriptors and data preprocessing was implemented in R.




<b id="f1">1</b> Using $IC\_50$ as the sole measure of effectiveness was a decision made earlier in the project. The same pipeline would work perfectly fine with other metrics such as $K_i$ or by combining the log of concentrations measured with $K_i$ + $IC_50$. [↩](#a1)

