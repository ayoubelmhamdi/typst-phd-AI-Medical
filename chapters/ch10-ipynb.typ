
== Data Preparation: Merging the CSV Files and Creating Named Tuples

One of the challenges of working with the LUNA16 dataset is that it provides two separate CSV files that contain information about the candidates and the annotations. The candidates.csv file has four columns: seriesuid, coordX, coordY, and coordZ, which indicate the unique identifier of the CT scan that contains the candidate and the coordinates of its center in the patient coordinate system. The annotation.csv file has five columns: seriesuid, coordX, coordY, coordZ, and diameter_mm, which indicate the same information as the candidates.csv file plus the diameter of the nodule in millimeters.

Using only one of these files is not sufficient or optimal for the analysis and modeling because:

- The candidates.csv file does not have information about the diameter of the candidates, which is an important feature that can affect the diagnosis and treatment of lung cancer.
- The annotation.csv file does not have information about whether the candidates are true or false nodules, which is necessary for training and evaluating a classifier.
- Both files have redundant information about the seriesuid and the coordinates, which can lead to errors or inconsistencies if they are not aligned properly.

To overcome these problems, we use a Python code that merges the information from both files and creates a list of named tuples that store relevant information for each candidate. A named tuple is a data structure that allows us to access values in a tuple using indexes or field names.

The code reads both CSV files and loops over each row in the candidates.csv file. For each candidate, it creates a tuple to represent its center coordinates and assigns it a default diameter of zero. It then fetches the annotations that belong to the same CT scan as the candidate from a dictionary called diameters. It loops over each annotation and compares its center coordinates with the candidate’s center coordinates along each axis (X, Y and Z). If the distance between them is less than half the radius of the annotation along all three axes, then it considers the candidate and the annotation as the same nodule and assigns the diameter of the annotation to the candidate. If no match is found, then it keeps the default diameter of zero.

The code also adds the information about whether the candidate is a true nodule or not (based on the class column in the candidates.csv file) to the named tuple.

== HU
In the context of HU (Hounsfield Units), which are used to measure the density of tissues in CT scans, We use a the clip function to limit the range of HU values to a certain interval, such as [-1000, 1000], which corresponds to the typical range of lung tissues. This can help to reduce the noise and improve the contrast of the images. For example, it will replace any values in ct_scan that are less than -1000 with -1000, and any values that are greater than 1000 with 1000.

== scan
The sentence means that the CT scan has a shape of (305, 512, 512), which means that it has 305 slices of size 512 by 512 pixels. Each slice is a grayscale image that represents a cross-section of the patient's body. 41 color channel in the same resolution. This is because 305 / 3 = 41.666, which we can round down to 41.

==
Here are the two tables in markdown format:

| Epoch | Loss   | Accuracy | Correct pos/neg |
| ----- | ------ | -------- | --------------- |
| 01    | 1.177  | 95.92%   | 0/141           |
| 02    | 0.000  | 100.00%  | 0/147           |
| 03    | 0.000  | 100.00%  | 0/147           |
| 04    | 0.000  | 100.00%  | 0/147           |
| 05    | 0.000  | 100.00%  | 0/147           |

Training metrics table

| Epoch | Loss    | Accuracy | Correct pos/neg |
| ----- | ------- | -------- | --------------- |
| 01    | 407.578 | 94.12%   | 0/16            |
| 02    | 658.517 | 94.12%   | 0/16            |
| 03    | 773.610 | 94.12%   | 0/16            |
| 04    | 820.082 | 94.12%   | 0/16            |
| 05    | 836.596 | 94.12%   | 0/16            |

Validation metrics table


== Evaluating Lung Nodule Detection Using FROC

One of the challenges of evaluating nodule detection algorithms is that there is no single threshold that can be used to classify a candidate as a nodule or not. Different thresholds may result in different trade-offs between sensitivity (the ability to detect true nodules) and false positive rate (the number of false alarms per scan) ².

To overcome this challenge, the LUNA16 framework uses a metric called Free-Response Receiver Operating Characteristic (FROC) curve, which plots the sensitivity versus the average number of false positives per scan at different operating points. The FROC curve can capture the performance of a nodule detection algorithm across a range of thresholds, and it can be summarized by a single score called the FROC score, which is the average sensitivity at seven predefined false positive rates: 1/8, 1/4, 1/2, 1, 2, 4, and 8 ².

The LUNA16 framework provides a script for validation that computes the FROC curve and score for a given nodule detection algorithm. The script takes as input a csv file that contains the predicted locations and probabilities of candidates for each scan in the dataset. The script then compares the predictions with the reference standard annotations and calculates the sensitivity and false positive rate at different probability thresholds. The script then plots the FROC curve and prints the FROC score for the algorithm ³.

The purpose of the script is to provide a consistent and objective way of evaluating nodule detection algorithms on the LUNA16 dataset. The script also allows participants to submit their results to the online leaderboard and compare their performance with other algorithms.


== Résumé.

We present a machine learning experiment where we attempted to classify lung nodules as benign or malignant based on CT scan images. We used a convolutional neural network (CNN) model and trained it on a dataset of 10861 nodules, of which only 25 were malignant. We evaluated the model on a validation set of 2709 nodules, of which only 6 were malignant. We obtained an accuracy of 99.78%, but a recall of 0% for the malignant class. We discuss the reasons for this poor performance and suggest some possible solutions to address the class imbalance problem.

== Introduction

Lung cancer is one of the leading causes of cancer-related deaths worldwide. Early detection and diagnosis of lung nodules, which are small masses of tissue in the lungs, can improve the survival rate and treatment outcomes for lung cancer patients. However, lung nodules are difficult to detect and classify, as they can vary in size, shape, location, and appearance. Moreover, most lung nodules are benign, meaning they are not cancerous, and only a small fraction are malignant, meaning they are cancerous. This poses a challenge for machine learning models that aim to automate the task of lung nodule detection and classification.

In this rapport, we present a machine learning experiment where we used a CNN model to classify lung nodules as benign or malignant based on CT scan images. We used a publicly available dataset called LUNA16, which contains 888 CT scans with annotated nodules. We extracted 10861 nodules from the scans, of which only 25 were malignant. We split the nodules into a training set of 8152 nodules and a validation set of 2709 nodules. We trained the CNN model on the training set and evaluated it on the validation set. We measured the performance of the model using accuracy and recall.

== Results
We obtained an accuracy of 99.78% on the validation set, which means that the model correctly predicted the class of 2703 out of 2709 nodules. However, when we looked at the confusion matrix, we found that the model predicted all the nodules as benign, and none as malignant. This means that the model had a recall of 0% for the malignant class, which means that it failed to identify any of the 6 malignant nodules in the validation set. This also means that the model had a precision of 0% for the malignant class, which means that none of its predictions for the malignant class were correct.

== Discussion

The main reason for this poor performance is the class imbalance problem in our dataset. The dataset has a very large imbalance between the benign and malignant classes, with the benign class being over 400 times more frequent than the malignant class. This makes it hard for the model to learn how to distinguish between the classes, and it might default to predicting the most common class. Moreover, because our dataset is highly imbalanced, accuracy is not a good measure of performance, as it can be misleadingly high even when the model makes incorrect predictions for the minority class.

To address this problem, we need to use a better strategy to train our model and also a better indication of model performance instead of accuracy. Some possible solutions are:

- Using data augmentation techniques to increase the number of malignant samples in our dataset.
- Using oversampling or undersampling methods to balance the classes in our dataset.
- Using weighted loss functions or class weights to penalize incorrect predictions for the minority class more than for the majority class.
- Using metrics such as F1-score, ROC-AUC, or PR-AUC that take into account both precision and recall for each class.

We plan to implement some of these solutions in our future work and hope to improve our model's performance on lung nodule classification.

== Conclusion

We presented a machine learning experiment where we attempted to classify lung nodules as benign or malignant based on CT scan images. We used a CNN model and trained it on a dataset of 10861 nodules, of which only 25 were malignant. We evaluated the model on a validation set of 2709 nodules, of which only 6 were malignant. We obtained an accuracy of 99.78%, but a recall of 0% for the malignant class. We discussed the reasons for this poor performance and suggested some possible solutions to address the class imbalance problem.
