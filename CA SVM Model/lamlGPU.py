import pandas as pd
import numpy as np
import sys
import matplotlib.pyplot as plt
from sklearn.model_selection import train_test_split
from sklearn import metrics
from sklearn.metrics import classification_report, confusion_matrix
from sklearn.preprocessing import MinMaxScaler
import joblib

np.set_printoptions(threshold=sys.maxsize)
data = pd.io.stata.read_stata('svmtraining-93-gen.dta')
print("Data retrieved successfully")

# split into labels and features
y = data['bp_exists']
X = data.drop('bp_exists', axis=1)
X = X.drop('z_nhbd', axis=1)
X = X.drop('randuu', axis=1)

# print vector y
print(y)
print(X)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size = 0.80)
print("CV Sets created sucessfully")

# Preprocessing
print("Beginning Preprocess")
scaling= MinMaxScaler(feature_range=(-1, 1)).fit(X_train)
X_train = scaling.transform(X_train)
X_test = scaling.transform(X_test)
print("Preprocess completed")

#svc = SVC(kernel=’linear’, C=10, gamma=1, cache_size=2000)
#print("Blank Linear SVM created, beginning training")
#svclassifier.fit(X_train, y_train)
#print("Linear SVM trained using training set")

print("Saving Classifier")
filename = 'finalized_model-93-gen.sav'
#joblib.dump(svclassifier, filename)
svclassifier = joblib.load(filename)
print("Classifier Saved")

y_pred = svclassifier.predict(X_test)
print("SVM has predicted from the CV set")
print("pred: " + str(y_pred))

# Precision and Recall Curves
print("Metrics being calculated")
print(confusion_matrix(y_test,y_pred))
print(classification_report(y_test,y_pred))
print("Precision-Recall completed")

# Set up False Positive Rate, True Positive Rate and Area Under Curve
fpr, tpr, _ = metrics.roc_curve(y_test,  y_pred)
auc = metrics.roc_auc_score(y_test, y_pred)
print("Metrics Calculated: beginning ROC")
print("AUC: " + str(auc))
# Create ROC curve
plt.plot(fpr,tpr,label="AUC="+str(auc))
plt.ylabel('True Positive Rate')
plt.xlabel('False Positive Rate')
plt.legend(loc=4)
plt.show()
plt.savefig('SVMROC.png')
print("ROC Curve generated")