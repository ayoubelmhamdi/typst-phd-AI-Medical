#import "../functions.typ": heading_center, images, italic,linkb
#let finchapiter = text(size: 24pt, fill:rgb("#1E045B"),[■])

/*
 *
 * THESE 05
 *
 */
= DETECTING LUNG CANCER NODULES.
= Introduction


Medical images are extensively used in oncology for diagnosis, therapy planning and monitoring of tumors.

Oncologists analyze images to locate tumors and assess their different characteristics.

Different types of medical images are used, depending on the task (search of metastases, radiotherapy planning) and the region of interest (brain, lungs, digestive system).

The commonly used types of imaging include computed tomography (CT), magnetic resonance imaging (MRI) and positron-emission tomography (PET).

Positron-emission tomography [Gambhir 2002] is based on injection of a radioactive tracer in the blood of the patient in order to observe the metabolism of different tissues.

A commonly used tracer is fludeoxyglucose which is a structural analog of glucose.

As cancer cells need an important glucose supply due to their divisions, the tumoral tissues may be detected by their abundant absorption of the radioactive tracer.

PET scan is particularly useful for diagnosis and staging of tumors, for detecting cancer metastases and monitoring effects of a therapy.

However, due to physical limitations, PET scans have usually a considerably lower spatial resolution than MRI and CT scans.

Computed tomography [Hsieh 2009] measures the absorption of X-rays of different tissues in the body.

The radiation is emmited from different angles in order to acquire a series of $2 D$ radiographic images from which a $3 D$ scan is then reconstructed.

Even if CT scans have generally a better spatial resolution than MRI, they offer a significantly weaker contrast between soft tissues such as the ones present in (...the brain...).

Morever, the exposure to X-rays may induce cancers by damaging DNA of body cells.


=== Radiotherapy planning and organs at risk
Treatment of brain tumors often includes radiotherapy [Khan 2014], which uses a ionizing radiation to kill cancer cells or to stop their division by damaging their DNA.

The most common type of radiotherapy is external beam radiotherapy, in which the radiation is emitted from the exterior of the patient.

Radiotherapy planning is a particularly important application of automatic segmentation.

The objective of radiotherapy planing is to compute optimal irradiation doses, i.e. to deliver a radiation which destroys tumoral cells while sparing healthy structures.

The segmentation process requires medical expertise and takes typically several hours per patient for an experienced clinican.

It represents therefore a considerable cost and eventually delays the therapy.

The objective of this rapport is to propose efficient methods for segmentation tasks in neuro-oncology.

= Deep learning in medical imaging
The methods presented in this thesis are mainly based on deep learning, which is a branch of machine learning.

In this section, we briefly present the general principles of deep learning, we motivate its use for segmentation tasks in neuro-oncology and we discuss its limitations, some of which are addressed in this thesis.

Given an input space $X$ and a label space $Y$, the objective of supervised machine learning is to find a predictive function $f: X arrow Y$, using a database of training examples $x_{i}, y_{i}$, where $x_{i} \in X$ and $y_{i} \in Y$.

To achieve this goal, three main elements have to be defined:
- Family of candidate functions $f_{\theta}$, parametrized by a vector of parameters $\theta \in \Theta$
- Loss function $L: \Theta arrow \mathbb{R}$, which quantifies the mismatch between the outputs predicted by a candidate function $f_{\theta}$ and the ground truth.
- Training algorithm, which minimizes the loss function (with respect to the parameters $\theta$ ) over the training data The main particularity of deep learning is the nature of the considered candidate functions.

The term deep is related to multiple compositions of functions.

The considered composed functions are differentiable and organized in layers, with the idea to progressively transform the input vector, extracting more and more complex information.

The term neural network is related to the considered family of functions, represented typically by a graph.

Training of the model (minimization of the loss function) is typically based on iterative optimization with variants of the stochastic gradient descent.

Convolutional Neural Networks (CNN) [LeCun 1995] are a commonly used type of neural networks for image processing and analysis (classification, segmentation).

They exploit spatial relations between pixels (or voxels, in 3D) and are based on application of local operations such convolution, pooling (maximum, average) and upsampling.

The objectives of such design are to limit the number of parameters of the network and to limit computational costs, as images correspond generally to very large inputs.


CNNs for image segmentation are usually trained in an end-to-end manner, i.e. their input is the image and the output is the segmentation.

With an end-to-end training, the model automatically learns to extract relevant information from images, using the training database.


Despite the progress of GPU capacities, computational costs still severely limit the potential of CNNs for segmentation tasks in medical imaging.

A typical segmentation network, such as U-net [Ronneberger 2015] performs thousands of convolutions, max-poolings and upsamplings.

Outputs of these operations have to be stored in the memory of the GPU during each iteration of the the training, in order to compute gradients of the loss function by the Backpropagation algorithm.

A typical CT is composed of several millions of voxels.

Training of neural networks for an end-to-end segmentation on entire CTs requires therefore a huge amount of GPU memory and is often impossible using the currently available GPUs.

For this reason, current segmentation models are usually trained on subvolumes of limited size and have limited receptive fields.

Another important problem is the cost of the ground truth annotations necessary to train neural networks, and machine learning models in general.

Manual segmentation of tumors is particularly costly as it is not only time-consuming but also requires medical exprtise and therefore has to be performed by experienced clinicians.

Other difficulties are related to the use of multimodal data.


= Approach overview

The main idea of our approach is (...)

We address the problem of missing image modalities (...)

Our method was tested on a publicly available database of the (...) challenge and obtained one of the best performances of the challenge.

We assume that the training database contains a small (... number of segmented images and a large number of images with global labels ...), simply indicating presence or absence of a tumor tissue within the image (without any information on the location of the tumor, if present).


The main idea of our approach is to (...).


= Convolutional Neural Networks for Tumor Segmentation.

= Contents


= Introduction
= Methods
Our generic 2D-3D approach is illustrated on Fig. 2.2.

The main components of our method are described in the following.

First, we introduce an efficient 2D-3D model with a long-range 3D receptive field.

Second, we present our neural network architecture with modality-specific subnetworks.


The channels of a layer are called feature maps whose points represent neurons.

=== Training of the model
=== Loss functions and dealing with class imbalance
To train our models, we use a weighted cross-entropy loss.

In the 3D case, given a training batch $b$ and the estimated model parameters $\theta$, the loss function penalizes the output of the classification layer:
// \[
// \operatorname{Loss}_{b}^{3 D}(\theta)=-\sum_{i=1}^{|b|} \sum_{(x, y, z)} \sum_{c=0}^{C-1} \deltaG_{(x, y, z)}^{i, b}, c W_{c, b} \log p_{i,(x, y, z)}^{c}(\theta)
// \]
where $delta$ denotes the Kronecker delta, $W_{c, b}$ is a voxelwise weight of the class $c$ for the batch $b, p_{i,(x, y, z)}^{c}(\theta)$ is the classification softmax score given by the network to the class $c$ for the voxel at the position $(x, y, z)$ in the $i^{\text {th }}$ image of the batch and $G_{(x, y, z)}^{i, b}$ is the ground truth class of this voxel.

The purpose of using weights is to counter the problem of severe class imbalance, tumor subclasses being considerably under-represented.

In contrast to common approaches, the voxelwise weights are set automatically depending on the composition of the batch (number of examples of each class greatly varies accross batches).

We suppose that in each training batch there is at least one voxel of each class.

Let's note $C$ the number of classes and $N_{b}^{c}$ the number of voxels of the class $c$ in the batch $b$.

For each class $c$ we set a target weight $t_{c}$ with $0 \leq t_{c} \leq 1$ and $\sum_{c=0}^{C-1} t_{c}=1$.

Then all voxels of the class $c$ are assigned the weight $W_{c, b}=t_{c} / N_{b}^{c}$ so that the total sum of their weights accounts for the proportion $t_{c}$ of the loss function.

To better understand the effect of this parameter, note that in the standard non-weighted cross-entropy each voxel has a weight of 1 and the total weight of the class $c$ is proportional to the number of voxels labeled $c$.

It implies that setting a target weight $t_{c}$ larger than the proportion of voxels labeled $c$ increases the total weight of the class $c$ (favoring its sensitivity) and conversely.

The same strategy is applied in the $2 D$ case, for each classification layer of the model.

The final loss of the 2D model is a convex combination of all intermediate losses, associated respectively with the main network and all subnetworks:
\[
\operatorname{Loss}_{b}^{2 D}(\theta)=c^{\text {main }} \operatorname{Loss}_{b}^{\text {main }}(\theta)+\sum_{k=1}^{K+1} c^{k} \operatorname{Loss}_{b}^{k}(\theta)
\]where $K$ is the number of input channels, $0 \leq c^{\text {main }} \leq 1,0 \leq c^{k} \leq 1 \forall k \in[1 . .

K+1]$ and $c^{\text {main }}+\sum_{k=1}^{K+1} c^{k}=1$
=== Training algorithm
Our training algorithm is a modified version of Stochastic Gradient Descent (SGD) with momentum [Rumelhart 1988].

In each iteration of the standard SGD with momentum, the loss is computed on one batch $b$ of training examples and the vector $v$ of updates is computed as a linear combination of the previous update and the gradient of the current loss with respect to the parameters of the network: $v^{t+1}=$ $\mu v^{t}-\alpha_{t} \nabla \operatorname{Loss}_{b}\theta^{t}$ where $\theta^{t}$ are the current parameters of the network, $\mu$ is the momentum and $\alpha_{t}$ is the current learning rate.

The parameters of the network are then updated: $\theta^{t+1}=\theta^{t}+v^{t+1}$.

We apply two main modifications to this scheme.

First, in each iteration of the training, we minimize the loss over several training batches in order to take into account a large number of training examples while bypassing hardware constraints.

In fact, due to GPU memory limits, backpropagation can only be performed on a training batch of limited size.

For large models, training batches may be too small to correctly represent the training database, which would result in large oscillations of the loss and a difficult convergence.

If we note $N$ the number of training batches per iteration, the loss at one iteration is given by $\operatorname{Loss}^{N}(\theta)=\sum_{b=1}^{N} \operatorname{Loss}_{b}(\theta)$ where $\operatorname{Loss}_{b}(\theta)$ is the loss over one training batch.

Given the linearity of derivatives, the gradient of this loss with respect to the parameters of the network is simply the sum of gradients of losses over the $N$ training batches: $\nabla \operatorname{Loss}^{N}(\theta)=\sum_{b=1}^{N} \nabla \operatorname{Loss}_{b}(\theta)$.

Each of the $N$ gradients is computed by backpropagation.

The second modification is to divide the gradient by its norm.

With the update rule of the standard SGD, strong gradients would cause too high updates of the parameters which can even result in the divergence of the training and numerical problems.

Conversely, weak gradients would result in too small updates and then a very slow training.

We want therefore to be independent of the magnitude of the gradient in order to guarantee a stable training.

To summarize, our update vector $v$ is computed as following:
\[v^{t+1}=\mu v^{t}-\alpha_{t} \frac{\nabla \operatorname{Loss}^{N}\theta^{t}}{\|\nabla \operatorname{Loss}^{N}\theta^{t}\|}
\]In order to converge to a local minimum, we decrease the learning rate automatically according to the observed convergence speed.

We fix the initial value $\alpha_{\text {init }}$ and the minimal value $\alpha_{\text {min }}$ of the learning rate.

After each $F$ iterations we compute the mean loss accross the last $F / 2$ iterations (Loss current) $^{\text {) and we }}$ compare it with the mean loss accross the previous $F / 2$ iterations (Loss previous) .

We fix a threshold $0<d_{\text {loss }}<1$ on the relative decrease of the loss: if we observe Loss $_{\text {current }}>d_{\text {loss }} \times$ Loss $_{\text {previous }}$ then the learning rate is updated as follows: $\alpha_{t+1}=\max \frac{\alpha_{t}}{2}, \alpha_{\min }$.

Given that the loss is expected to decrease slower with the progress of the training, the value of $F$ is doubled when we observe an insufficient decrease of the loss two times in a row.

For the training of our models we fixed $\alpha_{\text {init }}=0.25, \alpha_{\text {min }}=0.001, F=200$ and $d_{\text {loss }}=0.98$, i.e. initially we expect a $2 \%$ decrease of the loss every 200 iterations.

The high values of the learning rate are due to the fact that we divide gradients by their norm.

The values of these hyperparameters were chosen by observing the convergence of performed trainings for different values of $\alpha_{\text {init }}$ and choosing a high value for which the convergence is still observed.

Subsequently, the value of the learning rate is automatically adapted by the algorithm following the observed relative decrease of the loss (if the loss stops to decrease, the learning rate is halved).

The parameter $\alpha_{\min }$ (minimal value of the learning rate) was introduced in order to prevent the learning rate to decrease infinitely after convergence.
=== Fusion of multiclass segmentations
In order to be robust to limitations of particular choices of neural network architectures (kernels, strides, connectivity between layers, numbers of features maps, activation functions) we propose to combine multiclass segmentations produced by several models.

The final segmentation is obtained by a voxelwise voting strategy exploiting the following relations between tumor subclasses: - Whole tumor region includes tumor-induced edema (class 2) and tumor core- Tumor core region includes contrast-enhancing core (class 3) and nonenhancing core (class 1)
![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-029.jpg?height=877&width=1054&top_left_y=621&top_left_x=521)
Figure 2.7: Tree representing our decision process: leaves represent classes and nodes represent decisions according to aggregated votes for tumor subregions.

The class of a voxel is progressively determined by thresholding on proportions of models which voted for given subregions.

Suppose we have $n$ multiclass segmentations produced by different models and let's note $v_{c}$ the number of models which classified voxel $(x, y, z)$ as belonging to the class $c$, with $c \in\{0,1,2,3\}$.

The main idea is to aggregate the votes for classes according to their common regions and to take the decision in the hierarchical order, progressively determining the tumor subregions.

The number of votes for one region is the sum of votes for all classes belonging to the region (for example the votes for 'tumor core' are either votes for 'enhancing core' or 'non-enhancing core').

We define the following quantities:- $P_{\text {tumor }}=v_{1}+v_{2}+v_{3} /v_{0}+v_{1}+v_{2}+v_{3}$ (proportion of votes for the whole tumor region in the total number of votes)- $P_{\text {core }}=v_{1}+v_{3} /v_{1}+v_{2}+v_{3}$ (proportion of votes for the 'tumor core' region among all votes for tumor subclasses)- $P_{\text {enhancing }}=v_{3} /v_{1}+v_{3}$ (proportion of votes for the contrast-enhancing core among all votes for the tumor core) The decision process can be represented by a tree (Fig. 2.7) whose internal nodes represent the application of thresholding on the quantities defined above and whose leaves represent classes (final decision).

The first decision is therefore to determine if a given voxel represents a tumor tissue, given the proportion of networks which voted for one of the tumor subclasses.

If this proportion is above a chosen threshold, we consider that the voxel represents a tumor tissue and we apply the same strategy to progressively determine the tumor subclass.

For each internal node $R$ (corresponding to a tumor subregion) of the decision tree, we therefore have to choose a threshold $T_{R}$ with $0<T_{R} \leq 1$.

A high $T_{R}$ implies that a large proportion of models have to vote for this tumor subregion in order to consider its presence.

The choice of this threshold therefore allows the user to control the trade-off between sensitivity and specificity of the corresponding tumor subregion.

A low threshold gives priority to the sensitivity while a high threshold gives priority to the specificity.

A voting strategy was also used by the organizers of the BRATS 2015 challenge [Menze 2015] to combine multiclass segmentations provided by few experts.

In the merging scheme of BRATS 2015, the tumor subregions are ordered and the votes for different subregions are successively thresholded by the number of total votes divided by 2.

In contrast to this approach, in each step of our decision process we only consider the votes for the 'parent' region in the decision tree and we consider varying thresholds.


= $2.3 Experiments
We perform a series of experiments in order to analyze the effects of the main components of our method and to compare our results with the state of the art.

Our method is evaluated on a publicly available database of the BRATS 2017 challenge.
=== Data and evaluation
The datasets of BRATS 2017 contain multisequence MR preoperative scans of patients diagnosed with malignant brain tumors.

For each patient, four MR sequences were acquired: T1-weighted, post-contrast (gadolinium) T1-weighted, T2-weighted and FLAIR (Fluid Attenuated Inversion Recovery).

The images come from $19 imag-$ ing centers and were acquired with different MR systems and with different clinical protocols.

The images are provided after the pre-processing performed by the organizers: skull-stripped, registered to the same anatomical template and interpolated to $1 ~mm^{3}$ resolution.

The Training dataset contains 285 scans (210 high grade gliomas and 75 low grade gliomas) with provided ground truth segmentation.

The Validation dataset consists of 46 patients without provided segmentation and without provided information on the tumor grade.

The evaluation on this dataset is performed via a public benchmark.

The first test dataset used in our experiments is composed of 50 randomly chosen patients from the Training dataset and the networks are trained on the remaining 235 patients.

We refer to this dataset as 'test dataset' in the remainder (locally generated split training/test).

We then evaluate our method on the Validation dataset of BRATS 2017 (networks are trained on all 285 patients of the Training dataset).

The ground truth corresponds to voxelwise annotations with 4 possible classes: non-tumor (class 0), contrast-enhancing tumor (class 3), necrotic and non-enhancing tumor (class 1), tumor-induced edema (class 2).

The performance is measured by the Dice score between the segmentation $\tilde{Y}$ produced by the algorithm and the ground truth segmentation $Y$ :
\[
\operatorname{DSC}(\tilde{Y}, Y)=\frac{2|\tilde{Y} \cap Y|}{|\tilde{Y}|+|Y|}
\]We perform t-tests (paired, one-tailed) to measure statistical significance of the observed improvements provided by the main components of our method (2D-3D model, modality-specific subnetworks, merging strategy).

We consider the significance level of $5 \%$.
=== Technical details
The ranges of image intensities highly vary between the scans due to image acquisition differences.

We perform therefore a simple intensity normalization: for each patient and each MR sequence separately, we compute the median value of non-zero voxels, we divide the sequence by this median and we multiply it by a fixed constant.

In fact, median is likely to be more stable than the mean, which can be easily impacted by the tumor zone.

Experimentation with other normalization approaches such as histogram-matching methods [Nyúl 2000] will be a part of the future work.

Another potentially useful pre-processing could be bias field correction [Sled 1998].

Models are trained with our optimization algorithm described previously.

In each iteration of the training, gradients are computed on 10 batches (parameter $N$ introduced in section 2.2.3.2) in the $2 D$ case and on 5 batches in the 2D-3D case.

Batch normalization [Ioffe 2015] was used in the 2D model but was not required to train the 2D-3D model.

In the latter case, we normalized the input images to approximatively match the ranges of values of extracted $2 D$ features.

To train the $2 D$ model, the following target weights (defined in section 2.2.3.1) were fixed: $t_{0}=0.7, t_{1}=0.1, t_{2}=0.1, t_{3}=0.1$, corresponding respectively to 'non-tumor', 'non-enhancing core', 'edema' and 'enhancing core' classes.

The choice of these values has an influence on the sensitivity to different tumor subclasses, however, the final segmentation performance in terms of Dice score was not found to be very sensitive to these hyperparameters.

We fixed the same target weight for all tumor subclasses and we fixed a relatively high target weight for the non-tumor class to limit the risk of oversegmentation.

However, given that non-tumor voxels represent approximately $98 \%$ of voxels of the batch, we significantly decreased the weight of the non-tumor class compared to a standard cross-entropy loss (0.98 vs 0.7).

In the $3 D$ case, the following weights were fixed: $t_{0}=0.4, t_{1}=0.2, t_{2}=0.2$, $t_{3}=0.2$.

We observe a satisfying convergence of the training both for the $2 D$ and the 2D-3D model.

Fig. 2.8 shows the evolution of the training loss of the 2D model along with Dice scores of tumor subclasses.

The weights of the classification layers of the 2D model (section 2.2.3.1) were the following: $c^{\text {main }}=0.75, c^{k}=0.05 \forall k \in[1 . .5]$ (4 modality-specific subnetworks, one subnetwork combining all modalities and the main part of the network having a weight of 0.75 in the loss function).

A high weight was given for the main classification layer as it corresponds to the final output of the 2D model.

The classification layers of subnetworks were all given the same weight.
=== Training with missing modalities
We test our 2D model with modality-specific subnetworks in the context of missing MR sequences in the training database.

In this setting, we suppose that the four MR sequences are available only for $20 \%$ of patients and that for the remaining patients, one MR sequence out of the four is missing.

More precisely, we randomly split the training set of 235 patients in five equal subsets (47 patients in each) and we consider that only the first subset contains all the four MR sequences whereas the four other subsets exclusively miss one MR sequence (T1, T1c, T2 or T2-FLAIR).

We previously noted that modality-specific subnetworks can be trained independently: in this case, a subnetwork specific to a given MR sequence can be trained on $80 \%$ of the training database (on all training images except the ones for which the MR sequence is missing).

The goal of the experiment is to test if the training of these subnetworks improves the segmentation performance in practice.

We first evaluate the performance obtained by 2D model 1 (version CNN-2DAxl) trained only on the training subset containing all MR sequences ( 47 patients).

Then we evaluate the performance obtained when the subnetworks are pretrained, each of them using $80 \%$ of the training database.

The results are reported in Table 2.1.

Pretraining of the modality-specific subnetworks improved the segmentation performance on the test set for all tumor sub-![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-032.jpg?height=324&width=1380&top_left_y=2046&top_left_x=314)Figure 2.8: Evolution of the loss and of Dice scores of tumor subclasses during the training of the $2 D$ model. regions.

Even if the multiclass segmentation problem is very difficult for a small network using only one MR sequence, this pretraining forces the subnetwork to learn the most relevant features, which will then be used by the main part of the network, trained on the subset of training cases for which all MR sequences are available.

The improvement was found statistically significant ( $p$-value $<0.05$ ) for all the three tumor subregions (Table 2.5).

=== Using long-range $2D$ context

We perform a series of experiments to analyze the effects of using features learned by $2 D$ networks as an additional input to 3D networks.

In the first step, 2D model 1 is trained separately on axial, coronal and sagittal slices and the standard 3D model is trained on $70 \times 70 \times 70$ patches.

Then we extract the features produced by the $2 D$ model for all images of the training database and we train the same 3D model on 70x70x70 patches using these extracted features (Fig. 2.9) as an additional input (2D-3D model A specified on Fig. 2.4).

The experiment is performed on two datasets: the test dataset of 50 patients (networks trained on the remaining 235 patients) and the Validation dataset of BRATS 2017 (networks trained on 285 patients).

The results on the two datasets are reported respectively in Table 2.2 and Table 2.3.

Further experiments, involving varying $2 D$ and $3 D$ architectures are presented in section 2.3.5.

Qualitative analysis is performed on the first dataset, for which the ground truth segmentation is provided.

For comparison, we also display the scores obtained by U-net processing axial slices, using our implementation (with batchnormalization).

On the two datasets and for all tumor subregions, our 2D-3D model obtained aTable 2.1: Mean Dice scores on the test dataset (50 patients) in the context of misssing MR sequences in the training database.

EC, TC and WT refer respectively to 'Enhancing Core', 'Tumor Core' and 'Whole Tumor' regions.

The numbers in brackets denote standard deviations.
\begin{tabular}{|c|c|c|c|}
\hline & EC & TC & WT \\
\hline 2D model 1, missing data & $70.2(22.3)$ & $68.6(27.9)$ & $83.0(14.6)$ \\
\hline 2D model 1 missing data + pretrained subnetworks & $\mathbf{7 1 . 9}(20.9)$ & $\mathbf{7 3 . 7}(23.7)$ & $\mathbf{8 4 . 1}(13.6)$ \\
\hline 2D model 1 full data & $73.6(19.8)$ & $79.4(15.7)$ & $86.6(11.1)$ \\
\hline
\end{tabular}
Table 2.2: Mean Dice scores on the test dataset (50 patients).

The numbers in brackets denote standard deviations.
\begin{tabular}{|c|c|c|c|}
\hline & EC & TC & WT \\
\hline Unet axial slices & $73.9(19.7)$ & $78.1(17.9)$ & $86.5(11.6)$ \\
\hline 2D model 1 axial slices & $73.6(19.8)$ & $79.4(15.7)$ & $86.6(11.1)$ \\
\hline Standard 3D model (without 2D features) & $73.7(19.9)$ & $77.0(18.5)$ & $85.7(8.3)$ \\
\hline 2D-3D model A, features from 2D model 1 & $\mathbf{7 7 . 4}(16.6)$ & $\mathbf{8 0 . 9}(16.9)$ & $\mathbf{8 7 . 3}(11.7)$ \\
\hline
\end{tabular}
Chapter 2. 3D Convolutional Neural Networks for TumorSegmentation using Long-range $2 D$ Context![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-034.jpg?height=840&width=1354&top_left_y=358&top_left_x=318)Figure 2.9: $2 D$ features computed for three different patients from the test set.

These features correspond to unnormalized outputs of the final convolutional layers of three versions of a 2D model (CNN-2DAxl, CNN-2DSag, CNN-2DCor).

The values of these features are used as an additional input to a 3D CNN.

Each feature highlights one of the tumor classes (columns 3-6) and encodes a rich information extracted from a long-range 2D context within an axial, sagittal or coronal plane (rows 1-3).

Each row displays a different case from the test set (unseen by the network during the training).better performance than the standard 3D CNN (without the use of 2D features) and than 2D model 1 from which the features were extracted (Table 2.2 and Table 2.3).

The qualitative analysis (Fig. 2.10) of outputs of 2D networks highlights two main problems of $2 D$ approaches.

First, as expected, the produced segmentations show discontinuities which appear as patterns parallel to the planes of processing.

The second problem are false positives in the slices at the borders of the brain and containing artefacts of skull-stripping.

Segmentations produced by the standard 3D model are more spatially consistent but the network suffers from a limited input information from distant voxels.

The use of learned features as an additional input toTable 2.3: Mean Dice scores on the Validation dataset of BRATS 2017 (46 patients).
\begin{tabular}{|c|c|c|c|}
\hline & EC & TC & WT \\
\hline Unet axial slices & $71.4(27.4)$ & $76.6(22.4)$ & $87.7(10.6)$ \\
\hline 2D model 1 axial slices & $71.1(28.8)$ & $78.4(21.3)$ & $88.6(8.7)$ \\
\hline Standard 3D model (without 2D features) & $68.7(30.0)$ & $74.2(23.7)$ & $85.4(10.9)$ \\
\hline 2D-3D model A, features from 2D model 1 & $\mathbf{7 6 . 7}(27.6)$ & $\mathbf{7 9 . 5}(21.3)$ & $\mathbf{8 9 . 3}(8.5)$ \\
\hline
\end{tabular}
$MRI$ T2![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-035.jpg?height=1486&width=1378&top_left_y=380&top_left_x=360)Figure 2.10: Examples of segmentations obtained with models using a different spatial context.

Each row represents a different patient from the local test dataset (images unseen during the training).

From left to right: MRI T2, '2D model 1' processing the image by axial slices, standard 3D model (without 2D features), '2D-3D model A' using the features produced by '2D model 1', ground truth segmentation.

Orange, blue and green zones represent respectively edema, contrast-enhancing core and non-enhancing core.the network gives a considerable advantage by providing rich information extracted from distant points.

The difference of performance is particulary visible for 'tumor core' and 'enhancing core' subregions.

The improvements of our 2D-3D approach compared to the standard 3D CNN (without the use of 2D features) were found statistically significant ( $p$-value $<0.05$ ) in all cases except the 'whole tumor' region $MRI T 2$![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-036.jpg?height=810&width=352&top_left_y=434&top_left_x=314)![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-036.jpg?height=223&width=354&top_left_y=608&top_left_x=657)![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-036.jpg?height=166&width=363&top_left_y=428&top_left_x=661)![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-036.jpg?height=402&width=368&top_left_y=428&top_left_x=656)MRI T1![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-036.jpg?height=974&width=1050&top_left_y=434&top_left_x=658)Figure 2.11: Results obtained by the 2D-3D model, displayed for each available MR sequence.

While both T2 and T2-FLAIR higlight the edema, T2-FLAIR allows for distinguishing it from the cerebrospinal fluid.

T1 with injection of a gadoliniumbased contrast agent highlights the degradation of the blood-brain barrier induced by the tumor.in the first dataset (Table 2.5).
=== Varying network architectures and combining segmentations
We perform experiments with varying architectures of $2 D$ and 2D-3D models.

The first objective is to test if the use of $2 D$ features provides an improvement when different 2D and 2D-3D architectures are used.

The second objective is to test our decision process combining different multiclass segmentations.

The third goal is to compare performances obtained by different models.

The experiments are performed on the Validation set of BRATS 2017, the performance is evaluated by the public benchmark of the challenge.

In our experiments we use two architectures of our 2D model and three architectures of the 2D-3D model.

The main difference between the two 2D networks used in experiments is the architecture of subnetworks processing the input MR sequences.

In the first 2D model, the subnetworks correspond to reduced versions ![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-037.jpg?height=312&width=1398&top_left_y=378&top_left_x=360)
2D model 2![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-037.jpg?height=360&width=1350&top_left_y=665&top_left_x=366)Figure 2.12: Architectures of complementary networks used in our experiments.of U-Net (Fig. 4.2) whereas in the second model, the subnetworks are composed of three convolutional layers (Fig. 2.12, top).

In the remainder, we refer to these models as ' $2 D$ model 1 ' and ' $2 D$ model 2'.

The difference between the two first 2D-3D models is the choice of the layer in which the $2 D$ features are imported: in the first layer of the network (Fig. 2.4) or before the final sequence of convolutional layers (Fig. 2.12, bottom left).

The third 2D-3D model (Fig. 2.12, bottom right) is composed of two streams, one processing only the 3D image patch and the other stream taking also the $2 D$ features as input.

We refer to these models as 2D-3D model A, 2D-3D model B and 2D-3D model C.

Please note that the two first models correspond to a standard 3D model with the only difference of taking an additional input.

Each of the 2D-3D models is trained twice using respectively features learned by $2 D$ model 1 or features learned by $2 D$ model 2 .

We combine the trained 2D-3D models with the voting strategy described in section 2.2.4.

As we observe that $2 D$ model 1 performs better than 2D model 2, we consider two ensembles: combination of all trained 2D-3D models and combination of three models using features from 2D model 1.

We use the following thresholds for merging (defined in section 2.2.4): $T_{\text {tumor }}=0.4, T_{\text {core }}=0.3, T_{\text {enhancing }}=0.4$.

The results are reported in Table 2.4.

In all experiments, the 2D-3D models obtain better performances than their standard 3D counterparts and than 2D networks from which the features were extracted.

The merging of segmentations with our decision rule further improves the performance.

For all tumor subregions, the ensemble of 6 models (the last row of Table 2.4) outperforms each of the individual models.

The improvement over the main 2D-3D model (2D-3D model A with features from 2D model 1) was found statistically significant (p-value $<0.05$ ) for 'whole tumor' and 'tumor core' subregions, as reported in the last row of Table 2.5.

Table 2.4: Mean Dice scores on the Validation dataset of BRATS 2017 (46 patients).
\begin{tabular}{|c|c|c|c|}
\hline & EC & TC & WT \\
\hline 2D model 1 axial slices & 71.1 & 78.4 & 88.6 \\
\hline 2D model 2 axial slices & 68.0 & 78.3 & 88.1 \\
\hline Standard 3D model (without 2D features) & 68.7 & 74.2 & 85.4 \\
\hline$*$ 2D-3D model A, features from 2D model 1 & 76.7 & 79.5 & 89.3 \\
\hline * 2D-3D model B, features from 2D model 1 & 76.6 & 79.1 & 89.1 \\
\hline$*$ 2D-3D model C, features from 2D model 1 & 76.9 & 78.3 & 89.4 \\
\hline * 2D-3D model A, features from 2D model 2 & 73.4 & 79.5 & 89.7 \\
\hline *2D-3D model B, features from 2D model 2 & 74.1 & 79.4 & 89.5 \\
\hline$*$ 2D-3D model C, features from 2D model 2 & 74.3 & 79.4 & 89.6 \\
\hline Combination of models A-C features from model 1 & 76.7 & 79.6 & 89.4 \\
\hline Combination of all models * (final segmentation) & $\mathbf{7 7 . 2}$ & $\mathbf{8 0 . 8}$ & $\mathbf{9 0 . 0}$ \\
\hline
\end{tabular}
Table 2.5: p-values of the t-tests (in bold: statistically significant results, with $p$ $<0.05)$ of the improvement provided by the different components of our method.

To lighten the notations, '2D' refers to '2D model 1 axial slices' and '2D-3D' refers to '2D-3D model A, features from 2D model 1'. 'Combination of 2D-3D' refers to the result obtained by merging 6 models with our hierarchical decision process.
\begin{tabular}{|c|c|c|c|}
\hline & EC & TC & WT \\
\hline 2D vs 2D with pretrained subnetworks, missing data & $\mathbf{0 . 0 0 5 4}$ & $\mathbf{0 . 0 0 0 3}$ & $\mathbf{0 . 0 0 7 4}$ \\
\hline Standard 3D vs 2D-3D, dataset 1 & $\mathbf{0 . 0 0 8 2}$ & $\mathbf{0 . 0 0 1 6}$ & 0.0729 \\
\hline Standard 3D vs 2D-3D, dataset 2 & $\mathbf{0 . 0 0 7 7}$ & $\mathbf{0 . 0 0 0 5}$ & $<\mathbf{0 . 0 0 0 1}$ \\
\hline 2D-3D vs combination of 2D-3D & 0.1058 & $\mathbf{0 . 0 1 3 8}$ & $\mathbf{0 . 0 4 9 6}$ \\
\hline
\end{tabular}
While the three 2D-3D architectures yield similar performances, 2D model 1 (subnetworks similar to U-net) performs better than $2 D$ model 2 for all three tumor regions.

However, the 2D-3D models trained with the features from 2D model 2 are useful for the merging of segmentations: the ensemble of all models yields better performances than the ensemble of three models (two last rows of Table 2.4).
=== Comparison to the state of the art
We have evaluated our segmentation performance on the public benchmark of the challenge to compare our results with few dozens of teams from renowned research institutions worldwide.

Our method compares favorably with competing methods of BRATS 2017 (Table 2.6): among 55 teams which evaluated their methods on all test patients of the Validation set, we obtain top-3 performance for 'core' and 'enhancing core' tumor subregions.

We obtain mean Dice score of 0.9 for the 'whole tumor' region, which is almost equal to the one obtained by the best scoring team $(0.905)$.

The winning method of UCL-TIG [Wang 2017] proposes to sequentially use three Table 2.6: Mean Dice scores of the 10 best scoring teams on the validation leaderboard of BRATS 2017 (state of January 22, 2018)
\begin{tabular}{|c|c|c|c|c|c|c|c|}
\hline & EC & TC & WT & Rank EC & Rank TC & Rank WT & Average rank \\
\hline UCL-TIG & 78.6 & 83.8 & 90.5 & $1 / 55$ & 1 & 1 & 1.0 \\
\hline MIC_DKFZ & 77.6 & 81.9 & 90.3 & $2 / 55$ & 2 & 2 & 2.0 \\
\hline inpm (our method) & 77.2 & 80.8 & 90.0 & $3 / 55$ & 3 & 7 & 4.3 \\
\hline UCLM_UBERN & 74.9 & 79.1 & 90.1 & $9 / 55$ & 6 & 3 & 6.0 \\
\hline biomedia1 & 73.8 & 79.7 & 90.1 & $12 / 55$ & 5 & 5 & 7.3 \\
\hline stryker & 75.5 & 78.3 & 90.1 & $6 / 55$ & 10 & 6 & 7.3 \\
\hline xfeng & 75.1 & 79.9 & 89.2 & $8 / 55$ & 4 & 11 & 7.7 \\
\hline Zhouch & 75.4 & 77.8 & 90.1 & $7 / 55$ & 12 & 4 & 7.7 \\
\hline tkuan & 76.5 & 78.2 & 88.9 & $4 / 55$ & 11 & 13 & 9.3 \\
\hline Zhao & 75.9 & 78.9 & 87.2 & $5 / 55$ & 7 & 16 & 9.3 \\
\hline
\end{tabular}
Table 2.7: Distribution of Dice scores (final result).

The numbers in brackets denote standard deviations.
\begin{tabular}{|c|c|c|c|}
\hline & EC & TC & WT \\
\hline Mean & $77.2(24.4)$ & $80.8(18.9)$ & $90.0(8.1)$ \\
\hline Median & 85.4 & 88.3 & 91.8 \\
\hline Quantile $25 \%$ & 76.9 & 75.0 & 89.6 \\
\hline Quantile $75 \%$ & 90.0 & 93.5 & 94.5 \\
\hline
\end{tabular}
3D CNNs in order to progressively determine the tumor subclass.

Each of the networks performs a binary segmentation (tumor/not tumor, core/edema, enhancing core/non-enhancing core) and was designed for one tumor subregion of BRATS.

A common point with our method is the hierarchical process, however in our method all models perform multiclass segmentation.

The method of the team MIC_DKFZ, according to [Isensee 2017], is based on an optimized version of 3D U-net and an extensive use of data augmentation.

The leaderboard of BRATS 2017 only shows mean performances obtained by participating teams.

However, the benchmark individually provides detailed scores and complementary statistics, in particular quartiles and standard deviations reported in Table 2.7.

Our method yields promising results with median Dice score of 0.918 for the whole tumor, 0.883 for the tumor core and 0.854 for the enhancing core.

While the Dice scores for the whole tumor region are rather stable (generally between 0.89 and 0.95 ), we observe a high variability of the scores obtained for the tumor subregions.

In particular the obtained median Dices are much higher than the means, due to the sensitivity of Dice score to outliers.

= Discussion and conclusion
In this work, we presented a deep learning system for multiclass segmentation of tumors in multisequence MR scans.

The goal of our work was to propose elements to improve performance, robustness and applicability of commonly used CNN-based systems.

In particular, we proposed a new methodology to capture a long-range 3D context with CNNs, we introduced a network architecture with modality-specific subnetworks and we proposed a voting strategy to merge multiclass segmentations produced by different models.

First, we proposed to use features learned by 2D CNNs (capturing a long-range 2D context in three orthogonal directions) as an additional input to a 3D CNN.

Our approach combines the strengths of $2 D$ and 3D CNNs and was designed to capture a very large spatial context while being efficient in terms of computations and memory load.

Our experiments showed that this hybrid 2D-3D model obtains better performances than both the standard 3D approach (considering only the intensities of voxels of a subvolume) and than the $2 D$ models which produced the features.

Even if the use of the additional input implies supplementary reading operations, the simple importation of few features to a CNN does not considerably increase the number of computations and the memory load.

In fact, in typical CNNs performing hundreds of convolutions, max-poolings and upsamplings, the data layer represents typically a very small part of the memory load of the network.

One solution to limit the reading operations could be to read downsampled versions of features or to design a 2D-3D architecture in which the features are imported in a part of the network where the feature maps are relatively small.

The improvement provided by the 2D-3D approach has the cost of increasing the complexity of the method compared to a pure 3D approach as it requires a twostep processing (first 2D, then 3D).

However, its implementation is rather simple as the only supplementary element to implement is the extraction of 2D features, i.e. computation of outputs of trained 2D networks (with a deep learning software such as TensorFlow) and saving the obtained tensors in files.

In the 3D part, the extracted features are then simply read as additional channels of the input image.

Despite the important recent progress of GPUs, pure 3D approaches may be easily limited by their computational requirements when the segmentation problem involves an analysis of a very large spatial 3D context.

In fact, Convolutional Neural Networks require an important amount of GPU memory and a high computational power as they perform thousands of costly operations on images (convolutions, maxpoolings, upsamplings).

The main advantage of our 2D-3D approach is to considerably increase the size of the receptive field of the model while being efficient in terms of the computational load.

The use of our 2D-3D model may therefore be particularly relevant in the case of very large 3D scans.

Second, we proposed a novel approach to process different MR sequences, using an architecture with modality-specific subnetworks.

Such design has the considerable advantage of offering a possibility to train one part of the network on databases containing images with missing MR sequences.

In our experiments, training of modality-specific subnetworks improved the segmentation performance in the setting with missing MR sequences in the training database.

Moreover, the fact that our 2D model obtained promising segmentation performance is particularly encouraging given that $2 D$ networks are easier to apply for the clinical use where images have a variable number of acquired slices.

Our approach can be easily used with any deep learning software (e.g.

Keras).

In the case of databases with missing MR sequences, the user only has to perform a training of a subnetwork (on images for which the given MR sequence is provided) and then read the learned parameters for the training of the main part of the network (on images for which all MR sequences are available).

In order to be less prone to limitations of particular choices of neural network architectures, we proposed to merge outputs of several models by a voxelwise voting strategy taking into account the semantics of labels.

In constrast to most methods, we do not apply any postprocessing on the produced segmentations.

Our methodological contributions can be easily included separately or jointly into a CNN-based system to solve specific segmentation problems.

The implementation of our method will be made publicly available on https://github.com/ PawelMlynarski.

= Related work
In the literature, there are several works related to weakly-supervised and semisupervised learning for object segmentation or detection.

Most of the related works were applied to natural images.

=== Deep learning model for binary segmentation
We designed a novel deep learning model, which aims to take advantage of all available voxelwise and image-level annotations.

We propose to extend a segmentation CNN with an additional subnetwork performing image-level classification and to train the model for the two tasks jointly.

Most of the layers are shared between the classification and segmentation subnetworks in order to transfer the information between the two subnetworks.

In this work we present the $2 D$ version of our model, which can be used on different types of medical images such as slices of a CT scan or a multisequence MRI.

The proposed network takes as input a multimodal image of dimensions 300x300 and extends U-Net [Ronneberger 2015] which is currently one of the most used architectures for segmentation tasks in medical imaging.

The different image modalities (e.g. sequences of a MRI) correspond to channels of the data layer and are the input of the first convolutional layer of the network (as in most of the currently used CNNs for image segmentation).

U-Net is composed of an encoder part and a decoder part which are connected by concatenations between layers at the same scale, in order to combine low-level and local features with high-level and global features.

This design is well suited for the tumor segmentation task since the classification of a voxel as tumor requires to compare its value with its close neighborhood but also taking into account a large spatial context.

The last convolutional layer of U-net produces pixelwise classification scores, which are normalized by softmax function during the training phase.

We apply batch normalization [Ioffe 2015] in all convolutional layers except the final layer.

We propose to add an additional branch to the network, performing image-level classification (Fig. 3.2), in order to exploit the information contained in weaklyannotated images during the training.

This classification branch takes as input the second to last convolutional layer of U-net (representing a rich information extracted from a local and a long-range spatial context) and is composed of one mean-pooling, one convolutional layer and 7 fully-connected layers.

The goals of taking a layer from the final part of U-Net as input of the classification branch are both to guide the image-level classification task and to force the major part of the segmentation network to take into account weakly-annotated 3.3.

Joint classification and segmentation with Convolutional Neural Networks![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-049.jpg?height=557&width=1396&top_left_y=367&top_left_x=364)Figure 3.2: Architecture of our model for binary segmentation.

The numbers of outputs are specified below boxes representing layers.

The height of rectangles represents the scale (increasing with pooling operations).

= Experiments
=== Data
We evaluate our method on the challenging task of brain tumor segmentation in multisequence MR scans, using the Training dataset of BRATS 2018 challenge.

It contains 285 multisequence MRI of patients diagnosed with low-grade gliomas or high-grade gliomas.

For each patient, manual ground truth segmentation is provided.

In each case, four MR sequences are available: T1, T1+gadolinium, T2 and FLAIR (Fluid Attenuated Inversion Recovery).

Preprocessing performed by the organizers includes skull-stripping, resampling to $1 ~mm^{3}$ resolution and registration of images to a common brain atlas.

The resulting volumes are of size 240x240x155.

The images were acquired in 19 different imaging centers.

In order to normalize image intensites, each image is divided by the median of non-zero voxels (which is supposed to be less affected by the tumor zone than the mean) and multiplied the image by a fixed constant.

Each voxel is labelled with one of the following classes: non-tumor (class 0), contrast-enhancing core (class 3), non-enhancing core (class 1), edema (class 2).

The benchmark of the challenge groups classes in three regions: whole tumor (formed by all tumor subclasses), tumor core (classes 1 and 3, corresponding to the visible tumor mass) and enhancing core (class 3).

Given that all 3D images of the database contain tumors (no negative cases to train a 3D classification network), we consider the 2D problem of tumor segmentation in axial slices of the brain.
=== Test setting
The goal of our experiments is to compare our approach with the standard supervised learning.

In each of the performed tests, our model is trained on fully-annotated and weakly-annotated images and is compared with the standard U-Net trained on fully-annotated images only.

The goal is to compare our model with a commonly used segmentation model on a publicly available database.

We consider three diffferent training scenarios, with a varying number of patients for which we assume a provided manual tumor segmentation.

In each scenario we perform a 5 -fold cross-validation.

In each fold, 57 patients are used for test and $T 2$![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-053.jpg?height=694&width=400&top_left_y=434&top_left_x=360)T2-FLAIR![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-053.jpg?height=680&width=278&top_left_y=441&top_left_x=774)
$T 1$![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-053.jpg?height=684&width=284&top_left_y=440&top_left_x=1047)
$T 1 c$![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-053.jpg?height=680&width=280&top_left_y=442&top_left_x=1339)Figure 3.4: Examples of multisequence MRI from the BRATS 2018 database.

While T2 and T2-FLAIR highlight the edema induced by the tumor, T1 is suitable for determining the tumor core.

In particular, T1 acquired after injection of a contrast agent (T1c) highlights the tumor angiogenesis, indicating presence of highly proliferative cancer cells.
228 patients are used for training.

Among the 228 training images, few cases are assumed to be fully-annotated and the remaining ones are considered to be weaklyannotated, with slice-level labels.

The fully-annotated images are different in each fold.

If the 3D volumes are numbered from 0 to 284 , then in $k^{\text {th }}$ fold, the test images correspond to the interval $[(k-1)^{*} 57, k^{*} 57-1]$, the next few images correspond to fully-annotated images and the remaining ones are considered as weakly-annotated (the folds are generated in a circular way).

In the following, $F A$ denotes the number of fully-annotated cases and $W A$ denotes the number of weakly-annotated cases (with slice-level labels).

In particular, note that the split training/test is on 3D MRIs, i.e. the different slices of the same patient are always in the same set (training or test).

In the first training scenario, 5 patients are assumed to be provided with a manual segmentation and 223 patients have slice-level labels.

In the second and the third scenario, the numbers of fully-annotated cases are respectively 15 and 30 and the numbers of weakly-annotated images are therefore respectively 213 and 198 .

The three training scenarios are independent, i.e. folds are re-generated randomly (the list of all images is permuted randomly and the folds are generated).

In fact, results are likely to depend not only on the number of fully-annotated images but also on qualitative factors (for example the few fully-annotated images may correspond to atypical cases), and the goal is to test the method in various settings.

Overall, our approach is compared to the standard supervised learning on 60 tests (5-fold cross-validation, three independent training scenarios, three binary problems and Chapter 3.

Deep Learning with Mixed Supervision for Brain Tumorone multiclass problem).

We evaluate our method both on binary segmentations problems (separately for each of three tumor regions considered in the challenge) and on the end-to-end multiclass segmentation problem.

In each binary case, the model is trained for segmentation and classification of one tumor region (whole tumor, tumor core or enhancing core).

Segmentation performance is expressed in terms of Dice score quantifying the overlap between the ground $\operatorname{truth}(Y)$ and the output of a model $(\tilde{Y})$ :
\[
\operatorname{DSC}(\tilde{Y}, Y)=\frac{2|\tilde{Y} \cap Y|}{|\tilde{Y}|+|Y|}
\]In order to measure the statistical significance of obtained results, we perform two-tailed and paired t-tests.

Pairs of observations correspond to segmentation scores obtained with the standard supervised learning (U-Net trained on fullyannotated images) and with our approach.

Dice scores for all patients from 5 folds are concatenated to form a set of 285 pairs of observations.

The statistical test is performed for each training scenario and for each segmentation task (three binary problems and one multiclass problem).

We consider a significance level of $5 \%$.
=== Model hyperparameters
=== Loss function and training of the model
The main introduced training hyperparameter is the parameter $a$, corresponding to the trade-off between classification and segmentation losses.

We report mean Dice scores obtained with a varying value of the parameter $a$, on a validation set of 57 patients ( $20 \%$ of the database used for testing and $80 \%$ used for training) in the case with 5 fully-annotated cases and 223 weakly-annotated cases.

Segmentation accuracy obtained for the whole tumor in the binary case is reported on Fig. 3.5.

The peak of performance is observed for $a=0.7$ (improvement of approximately 12 points of Dice over the standard supervised learning on this validation set), i.e. for the configuration where the segmentation loss accounts for $70 \%$ of the total loss.

With high values of $a$, the improvement over the standard supervised learning is limited: around 2.5 points of Dice for $a=0.9$.

In fact, setting a high value of $a$ corresponds to giving less importance to the image-level classification task and therefore ignoring weakly-annotated images.

For too low values of $a$, segmentation accuracy decreases too, probably because the model focuses on the secondary task, of image-level classification.

In the end-to-end multiclass case (Fig. 3.6), lower values of $a$ seem more suitable, possibly because of an increased complexity of the image-level classification task.

In all subsequent tests, we fix $a=0.7$ for binary segmentations problems and $a=0.3$ for the end-to-end multiclass segmentation.

Training batches in our experiments contain 10 images, including 8 images with tumors (4 images with provided tumor segmentation and 4 without provided segmentation) and 2 images without tumors.

The number of images was fixed to fit in the memory of the used GPUs (Nvidia GeForce GTX 1080 Ti), i.e. to form training batches for which Backpropation can be performed using the memory of the GPU.

In each training batch there are only 2 images without tumors because most of the pixels of tumor images correspond to non-tumor zones.

The parameters $t_{c}$, corresponding to target weights of classes in the segmentation loss, were fixed manually.

Both in binary and multiclass cases, we chose $t_{0}=$ 0.7 , which corresponds to giving a target weight of $70 \%$ to non-tumor voxels.

In fact, tumor pixels represent approximately $1 \%$ of pixels of the training batch and therefore non-tumor pixels account approximately for $99 \%$ of non-weighted crossentropy segmentation loss.

With $t_{0}=0.7$, relative weight of non-tumor pixels is therefore decreased compared to the standard, non-weighted cross entropy, while still giving the non-tumor class a high weight in order to avoid oversegmentation.

In the multiclass setting, we fixed the same target weight to all three tumor subclasses, i.e. $t_{1}=0.1, t_{2}=0.1, t_{3}=0.1$.

As a good convergence of the training was obtained in terms of Dice scores of tumor subclasses, we did not further need to optimize these hyperparameters.

Morever, U-Net trained with these weights and using 228 fullyannotated images obtained a mean Dice score of almost 0.87 for whole tumor (last row of Table 3.1), which is a satisfactory performance for a model independently processing axial slices without any postprocessing.

Mean Dice (validation set 5 FA + 223 WA)![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-055.jpg?height=608&width=1191&top_left_y=1598&top_left_x=455)Figure 3.5: Mean Dice scores for the 'whole tumor' region obtained with a varying value of the parameter 'a', corresponding to the trade-off between segmentation and image-level classification losses.

Segmentation scores are evaluated on a validation set of $57 MRI$ in the training scenario where 5 fully-annotated MRI and 223 weaklyannotated MRI are available for training.

The case $a=1.0$ corresponds to ignoring the classification loss and therefore ignoring weakly-annotated images. ![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-056.jpg?height=648&width=1136&top_left_y=407&top_left_x=423)Figure 3.6: Mean Dice scores for 'whole tumor' and 'tumor core' regions obtained with a varying value of the parameter 'a' in the multiclass case.

Segmentation scores are evaluated on a validation set of $57 MRI$ in the training scenario where 5 fullyannotated MRI and 223 weakly-annotated MRI are available for training.

The case $a=1.0$ corresponds to ignoring the classification loss and weakly-annotated images.
=== Model architecture
One of the most important attributes of our method is the architecture of classification branches extending segmentation networks.

We perform experiments to compare our model with alternative types of architectures of classification subnetworks.

We report the segmentation accuracy obtained on the previously defined validation set of 57 patients.

In the binary case, we consider two alternative architectures of classification subnetworks.

The first one is composed of four fully-connected layers having respectively 2000, 500, 100 and 2 neurons.

It corresponds therefore to a shallow variant of the classification subnetwork with a relatively high number of parameters.

We name this architecture Shallow model.

The second variant has the same architecture as our model (7 fully-connected layers) but with removed concatenation between the first and the fifth fully-connected layer.

We name this architecture Deep-sequential.

The comparison of segmentation accuracy for whole tumor obtained by these two variants and by our model is reported on Fig. 3.7.

All three models using mixed level of supervision obtain a better segmentation accuracy than the standard U-Net using 5 fully-annotated images (64.48).

Among the three architectures, the shallow variant yields the lowest accuracy (72.29).

Our model obtains the highest accuracy (76.56) and performs slightly better than its counterpart with removed concatenation, Deep-sequential model (75.78).

The improvements over the standard model and the Shallow model were found statistically significant (two-tailed and paired t-test). ![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-057.jpg?height=642&width=1131&top_left_y=373&top_left_x=474)Figure 3.7: Mean Dice scores for the 'whole tumor' region obtained by the standard U-Net and by different models using mixed level of supervision.

Standard deviations are represented by error bars.

The segmentation scores are evaluated on a validation set of $57 MRI$ in the training scenario where 5 fully-annotated MRI and 223 weaklyannotated MRI are available for training.

Our model corresponds to U-Net extended with a classification branch composed of 7 fully-connected layers and containing one skip-connection.

We also report results obtained with an alternative architecture of the multiclass model.

In our model, we considered separate classification branches for all tumor subclasses.

We consider an alternative architecture, having only one classification branch (with the same architecture as our model for binary segmentation and classification) shared between the three final fully-connected layers performing image-level classification.

In this configuration, the classification layer of each tumor subclass takes as input the 6th fully-connected layer of the shared classification branch.

We name this architecture Shared classification.

The comparison with our multiclass model (separate classification branches for all tumor subclasses) on the same validation set as previously is reported on Fig. 3.8.

Our model obtains the highest accuracy for the three tumor subregions while the alternative model (Shared classification) obtains higher accuracy than the standard multiclass U-Net for whole tumor and tumor core.

The improvements of our model over the standard model were found statistically significant for whole tumor and tumor core regions.

The improvements over the alternative model with mixed supervision (Shared classification) were not found statistically significant ( $p$-values $>0.05$ ).
=== Results
The main observation is that our model with mixed supervision provides a significant improvement over the standard supervised approach (U-Net trained on fullyannotated images) when the number of fully-annotated images is limited.

In the two Chapter 3.

Deep Learning with Mixed Supervision for Brain Tumor Segmentation


= Mean Dice (validation set 5 FA + 223 WA)

![](https://cdn.mathpix.com/cropped/2023_06_21_375ec9675e3c660da887g-058.jpg?height=699&width=1379&top_left_y=473&top_left_x=316)Figure 3.8: Mean Dice scores for the 'whole tumor' region obtained by the standard multiclass U-Net and by different multiclass models using mixed level of supervision.

The error bars represent standard deviations.

The segmentation scores are evaluated on a validation set of $57 MRI$ in the training scenario where 5 fullyannotated MRI and 223 weakly-annotated MRI are available for training.

Our model is multiclass U-Net extended with three separate classification branch (for each tumor subclass), each branch having the same architecture as in the binary segmentation/classification problem.first training scenarios (5 FA and $15 FA$ ), our model outperformed the supervised approach on the three binary segmentation problems (Table 3.1) and in the multiclass setting (Table 3.3).

The largest improvements are in the first scenario (5 FA) for the whole tumor region where the improvement is of 8 points of the mean Dice score in the binary setting and of 9 points of Dice in the multiclass seting.

Results on different folds of the second scenario (intermediate case, $15 FA$ ) are displayed in Table 3.2 for the binary problems and in Table 3.4 for the multiclass problem.

Our approach provided an improvement in all folds of the second scenario and for all tumor regions, except one fold for enhancing core in the binary setting.

In the third scenario (30 FA + $198 WA$ ), our approach and the standard supervised approach obtained similar performances.

Furthermore, we observe that standard deviations are consistently lower with our approach, in all training scenarios and for all tumor subregions.

The results obtained with mixed supervision are therefore more stable than the ones obtained with the standard supervised learning.

All improvements were found statistically significant for binary segmentations problems.

In the multiclass case, all improvements were found statistically significant except for enhancing core in the first training scenario and for whole tumor in the third training scenario.

Qualitative results are displayed on Figures 3.9, 3.10 and 3.11.

Each figure shows segmentations of one tumor region (whole tumor, tumor core, enhancing core) produced by models trained with a varying number of fully-annotated and weaklyannotated images available for training.

Segmentation performance increases quickly with the first fully-annotated cases, both for the standard supervised learning and the learning with mixed supervision.

For instance, mean Dice score obtained by the supervised approach for whole tumor increases from 70.39 , in the case with 5 fully-annotated images, to 77.9 in the case with 15 fully-annotated images.

Our approach using 5 fully-annotated images and 223 weakly-annotated images obtained a slightly better performance (78.3) than the supervised approach using 15 fully-annotated cases (77.9).

This result is represented on Fig. 3.12.

On Fig. 3.13, we report cross-validated results obtained with a varying number of weakly-annotated while images keeping a fixed number of fully-annotated images.

This complementary experiment is performed for segmentation of whole tumor in the first training scenario (5 fully-annotated images).

We observe that the improvement slows down with the number of added weakly-annotated scans.

Inclusion of the first 100 weakly-annotated MRIs yields an improvement of approximately 5 points of the cross-validated mean Dice score (from 70.39 to 75.28), while addition of the remaining 123 weakly-annotated images improves this score by 3 points (from 75.28 to 78.34$)$.

Note that each fully-annotated case corresponds to a large $3 D$ volume with voxelwise annotations.

Each manually segmented axial slice of size $240 \times 240$ corresponds to 57600 labels, which represents indeed a huge amount of information compared to one global label simply indicating presence of absence of a tumor tissue within the slice.

Table 3.1: Mean Dice scores (5-fold cross-validation, 57 test cases in each fold) in the three binary segmentation problems obtained by the standard supervised approach and by our model trained with mixed supervision.

The numbers in brackets denote standard deviations computed on the distribution of Dice scores for all patients of the 5 folds.


In terms of the annotation cost, manual delineation of tumor tissues in one MRI may take about 45 minutes for an experienced oncologist using a dedicated segmentation tool.

Determing the range of axial slices containing tumor tissues may take 1-2 minutes but can be done without a specialized software.

More importanty, determining global labels may require less medical expertise than performing an exact tumor delineation and can therefore be performed by a larger community.

Table 3.3: Mean Dice scores (5-fold cross-validation, 57 test cases in each fold) obtained by the standard supervised approach and by our model in the multiclass setting.

The numbers in brackets denote standard deviations computed on the distribution of Dice scores for all patients of the 5 folds.

The asterisks represent statistically significant improvements ( p-value $<0.0$ ) provided by our method compared to the standard supervised learning.


The results are displayed on MRI $T 1$ +gadolinium.

The observations are similar to the problem of binary segmentation of the 'whole tumor' region.

In particular, in the first training scenario, the standard supervised approach does not detect the tumor core zone, in contrast to our method.

Figure 3.11: Comparison of our approach with the standard supervised learning for binary segmentation of the 'enhancing core' region.

Each row corresponds to a different training scenario (5, 15 or 30 fully-annotated scans available for training).


The example shows false positives obtained by the model trained with standard supervision.

The number of false positives decreases with the number of fully-annotated images available for training.

No false positives are observed for our model trained with mixed supervision, in any of the three training scenarios.
