from sklearn import svm
import joblib
import numpy as np
from pyxll import xl_func

#  Load the SVM model from disk
@xl_func
def load_svm_model(model_file):
    clf = joblib.load(model_file)
    return clf

# Make predictions using the loaded SVM model
@xl_func
def svm_predict(X, model):
    X = np.array(X)
    y_pred = model.predict(X)
    return y_pred

