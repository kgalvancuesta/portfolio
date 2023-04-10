import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn.svm import SVC
from sklearn import metrics
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.preprocessing import MinMaxScaler
import joblib
import argparse

def main(args):
    print("\nParameters Selected:\nKernel = " + args.k + "\nC = " + str(args.c) + "\ng = " + str(args.g) + "\ntest size: " + str(args.t) + "\n\nfrom path: " + args.path)

    data = pd.io.stata.read_stata(args.path)
    print("\nData retrieved successfully")

    # split into labels and features
    # y is the column 'bp_exists' which determines whether a building permit exists
    y = data['bp_exists']
    X = data.drop('bp_exists', axis=1)

    # print vector y
    print(y)
    print(X)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=args.t)
    print("CV Sets created successfully")

    # Preprocessing mainly happens in a .do file, but scaling is done here
    print("\nBeginning Preprocess")
    scaling = MinMaxScaler(feature_range=(-1, 1)).fit(X_train)
    X_train = scaling.transform(X_train)
    X_test = scaling.transform(X_test)
    print("Preprocess completed")

    # Train the SVC using user arguments for k, c, and gamma
    svclassifier = SVC(kernel=args.k, C=args.c, gamma=args.g, cache_size=7500)
    print("\nBlank " + args.k + " SVM created, beginning train")
    svclassifier.fit(X_train, y_train)
    print("Linear SVM trained using training set")

    # Save the SVC parameters
    print("Saving Classifier")
    filename = 'final_' + args.k + '_C=' + str(args.c) + '_g=' + str(args.g) + '_t=' + str(args.t) + '.sav'
    joblib.dump(svclassifier, filename)
    print("Classifier Saved")

    # Predict from the trained SVC
    y_pred = svclassifier.predict(X_test)
    print("\nSVM has predicted from the CV set")

    # Precision and Recall Curves
    print("Metrics being calculated\n")
    print(confusion_matrix(y_test, y_pred))
    print(classification_report(y_test, y_pred))
    print("Precision-Recall completed")

    # Set up False Positive Rate, True Positive Rate and Area Under Curve
    fpr, tpr, _ = metrics.roc_curve(y_test, y_pred)
    auc = metrics.roc_auc_score(y_test, y_pred)
    print("Metrics Calculated: beginning ROC")
    print("AUC: " + str(auc))

    # Create, display, and save the ROC curve
    plt.plot(fpr, tpr, label="AUC=" + str(auc))
    plt.ylabel('True Positive Rate')
    plt.xlabel('False Positive Rate')
    plt.legend(loc=4)
    plt.show()
    plt.savefig('ROC_' + args.k + '_C=' + str(args.c) + '_g=' + str(args.g) + '_t=' + str(args.t) + '.png')
    print("ROC Curve generated")

def get_args():
    """
    Get the commandline arguments
    """
    # Set up argparse arguments
    parser = argparse.ArgumentParser(description='Run a Support Vector Machine')
    parser.add_argument('path', metavar='PATH', type=str, help='A string of the file path of the data')
    parser.add_argument('--k', dest='k', type=str,
                        help='A string used as the kernel type')
    parser.add_argument('--c', dest='c', type=float,
                        help='A float used as the C hyperparameter')
    parser.add_argument('--g', dest='g', type=float,
                        help='A float used as the gamma hyperparameter')
    parser.add_argument('--t', dest='t', type=float,
                        help='Percent used as testing for performance metrics')

    parser.set_defaults(k='rbf',c=1, g=1, t=.99)
    args = parser.parse_args()
    return args

if __name__ == "__main__":
    args = get_args()

    main(args)