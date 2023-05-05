[Return to Portfolio](https://kgalvancuesta.github.io/portfolio/)

# California Department of Housing Support Vector Machine Ensemble

Here you will find several sample files of the work I conducted while working for the California Department of Housing for the final SVM. Since most of the original files were too large for GitHub, the files you will find here were generated for this portfolio. However, I was able to include some of the original work. Lastly, the datasets were much too large to include, but it is possible to load a sample SVM on your device.

## CAML and XL
Above you will see slightly edited Python files (so that you may run them yourself) made to train or load an SVM. Additionally, sample Excel functions are under 'XLFunctions'.  

To load an SVM, the Python paths must be edited to match the location of the .SAV file. To train an SVM on your own dataset, first change the Python paths, then the command can be run in Anaconda as follows:  

> **python CAML.py --k [kernel type] --c [value for C] --g [value for Gamma]**
 
## [Stata Files](https://github.com/kgalvancuesta/portfolio/tree/main/CA%20SVM%20Model/Stata%20Files)
Under the Stata files section, there are final dataset processors to generate 'test' and 'train' sets for the SVM ensemble. You will also find some work-in-progress files, including a specific work day's file.

## [Model Parameters](https://github.com/kgalvancuesta/portfolio/tree/main/CA%20SVM%20Model/Model%20Parameters)
This file contains model parameters that were saved using the **Joblib** Python library. I was able to include one of our actual SVM test parameters. They can be tested using 'CAML_LOAD_SAV.py'.

## [Results](https://github.com/kgalvancuesta/portfolio/tree/main/CA%20SVM%20Model/Results)
The Results file contains confusion matrices, classification reports, and ROC curves for the different tests. I was able to include the final SVM ROC curve!
