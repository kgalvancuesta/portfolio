import pandas as pd
import numpy as np
import sys
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.preprocessing import MinMaxScaler
import joblib

def main(args):
    np.set_printoptions(threshold=sys.maxsize)
    data = pd.io.stata.read_stata('C:/Users/Dublt/Documents/000/23 A/Job Search/Generated Data/Generated Data/80loglinear.dta')
    if data is not None:
        print("Data retrieved successfully")
    else:
        print("Error: Data Not Retrieved")

    # split into labels and features
    y = data['bp_exists']
    #, 'z_nhbd', 'randuu'
    X = data.drop(['bp_exists'], axis=1)

    # Split into random training and testing sets for X and y
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.80)
    print("CV Sets created sucessfully")

    # Preprocessing
    print("Beginning Preprocess")
    scaling = MinMaxScaler(feature_range=(-1, 1)).fit(X_train)
    X_test = scaling.transform(X_test)
    print("Preprocess completed")

    print("Loading Classifier")
    filename = 'C:/Users/Dublt/Documents/000/23 A/Job Search/Github Portfolio/CA SVM Model/Model Parameters/finalized_model-10loglinear.sav'
    svclassifier = joblib.load(filename)
    print("Classifier Loaded")

    y_pred = svclassifier.predict(X_test)
    print("SVM has predicted from the CV set")
    print("pred: " + str(y_pred))

    # Precision and Recall Curves
    print("Metrics being calculated")
    print(confusion_matrix(y_test,y_pred))
    print(classification_report(y_test,y_pred))
    print("Precision-Recall completed")

    # Set up False Positive Rate, True Positive Rate and Area Under Curve
    fpr, tpr, _ = metrics.roc_curve(y_test, y_pred, drop_intermediate=False)
    auc = metrics.roc_auc_score(y_test, y_pred)
    print("Metrics Calculated: beginning ROC")
    print("AUC: " + str(auc))
    # Create ROC curve
    plt.plot(fpr,tpr,label="AUC="+str(auc))
    plt.ylabel('True Positive Rate')
    plt.xlabel('False Positive Rate')
    plt.legend(loc=4)
    plt.savefig('ROC 10loglinear.png')
    print("ROC Curve generated")
    plt.show()

def get_args():
    pass

if __name__ == "__main__":
    args = get_args()

    main(args)