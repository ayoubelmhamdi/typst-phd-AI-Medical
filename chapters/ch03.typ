#import "../functions.typ": heading_center, images, italic

#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])


//== Summarize the main points and findings of your research
//== State the research question, methods, results, and conclusion
//== Use concise and clear language
//
//== INTRODUCTION
//=== Definitions.
//=== Approach for Training our Model involves five main steps
//=== Background and significance of lung cancer detection using deep learning
//=== Overview of your thesis structure
//=== Provide background and context for your research topic
//=== Explain the significance and motivation of your research
//=== Aim and objectives of your research
//
//
//== step 1: Manipulation the Data
//=== Data Conversions
//=== Data loading
//=== Raw CT Data Files
//=== Training and validation sets
//=== Loading individual CT scans
//=== Data Ranges and Model Inputs
//=== The Patient Coordinate System
//=== CT Scan Shape and Voxel Sizes
//=== Converting Between Millimeters and Voxel Addresses
//
//
//== step 2: Segmentation
//=== Semantic segmentation: Per-pixel classification
//=== Why we need heatmap or mask as output of segmentation
//=== UNet Architecture for Image Segmentation
//=== Visualizing CT Image with Predicted Nodules
//== step 3: Grouping nodules.
//== step 4: Classification
//== step 5: Diagnosing the patient
//== Conclusion
//
//
//
//= METHODS AND MATERIALS
//== Data acquisition
//== Data preprocessing and augmentation
//== Lung nodule segmentation
//=== U-Net model
//=== Evaluation metrics
//=== Post-processing techniques
//== Lung nodule clustering
//=== DBSCAN algorithm
//=== Cluster features extraction
//== Lung nodule classification
//
//= RESULTS AND DISCUSSION
//== Segmentation performance
//== Clustering results
//== Classification accuracy
//== Clinical implications


// = RÉFÉRENCES BIBLIOGRAPHIQUES.
// = CONCLUSION.
// == Summary of the main contributions.
// == Limitations and challenges.
// == Perspectives and recommendations
//= Literature Review and Theory Framework
//== Screening for lung cancer and challenges
//== Traditional methods for lung nodule detection and limitations
//== Deep learning applications in medical imaging and advantages
//== Relevant theories and concepts for your research
//
//= Methods and Materials
//== Data Preprocessing and Segmentation
//=== Image retrieval and annotation
//=== Image normalization and enhancement
//=== Lung nodule segmentation using region proposal networks
//== Classification using Convolutional Neural Networks
//=== Training data preparation
//=== Choice of deep learning architecture
//=== Training and validation
//
//= Results and Discussion
//== Data Analysis
//=== The confusion matrix
//=== Sensitivity, specificity, accuracy, F1 score
//=== Model performance evaluation
//==== Class-wise performance metrics
//==== Comparison with traditional methods
//=== Analysis of model performance
//
//= Conclusion and Future Work
//== Summary of main findings and implications
//== Answer to the research question
//== Limitations and future work
//
//= References
//
//= Literature Review and Theory Framework
//== Review the relevant literature and previous studies on your topic
//== Identify the gaps and limitations in the existing knowledge
//== Discuss the theoretical and conceptual frameworks that inform your research
//== Explain how your research contributes to the advancement of physics knowledge
//
//= Methods and Materials
//== Describe the data sources, collection, and preprocessing methods
//== Explain the segmentation technique using region proposal networks
//== Discuss the choice of convolutional neural networks for classification
//== Describe the training and validation procedures and parameters
//== Report the ethical considerations and approvals for your research
//
//= Results and Discussion
//== Present and analyze the results of your experiments
//== Use figures, tables, and graphs to illustrate your findings
//== Compare your results with previous studies and methods
//== Evaluate the performance of your model using various metrics
//== Discuss the implications, limitations, and challenges of your results
//
//= Conclusion and Future Work
//== Summarize the main findings and answer the research question
//== Highlight the originality and significance of your research
//== Discuss the limitations and directions for future work
//== Provide recommendations or suggestions for further research or applications
//
//= References
//== List all the sources that you cited in your paper
//== Use a consistent citation style (e.g., APA, MLA, IEEE)
//
//QUESTION
// reduce time:
// Transformers :
// [[ Transformers are designed to handle sequential input data. However, they aren't restricted to processing that data in sequential order. Instead, transformers use attention—a technique that allows models to assign different levels of influence to different pieces of input data and to identify the context for individual pieces of data in an input sequence. This allows for an increased level of parallelization, which can reduce model training times.]]
