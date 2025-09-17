# **EEG Semantic Category Classification**
## **Overview**

This project explores the use of electroencephalographic (EEG) signals for identifying semantic categories in the human brain. The work was originally developed as part of my thesis, using a wearable EEG device ([Emotiv](https://www.emotiv.com/) EPOC).

The goal was to classify brain responses into three categories:
* Tools
* Animals
* Flowers/Fruits

This type of research contributes to the development of Brain-Computer Interfaces (BCI), which can improve life quality for people with speech or communication disorders.

## **Dataset & Protocol**

* **Participants:** 10 users
* **Stimuli:** Visual prompts (3 categories)
* **Acquisition device:** Emotiv EPOC (14 channels)
* **Trials recorded:** 900 total (300 per class)
* **Trial length:** 3 seconds (≈4.5 min of data per user)

### **Experiment Control (OpenViBE)**
The EEG dataset used in this project was collected with OpenViBE Designer (v2.2.0) and the Emotiv EPOC headset.

To control the experiment, three scenarios (prueba1, prueba2, prueba3) and three Lua scripts were implemented, corresponding to the three recording sessions per subject.

* **Lua scripts (.lua):** Handle stimulus sequence logic (randomization, start/stop conditions).

* **OpenViBE scenarios (.xml):** Define the experimental pipeline (stimulus presentation, EEG acquisition, event markers).

* **Stimuli images (.jpg):** 90 visual prompts for the three semantic categories (tools, animals, flowers/fruits).

### Reproducing the setup

1. Install [OpenViBE](http://openvibe.inria.fr) (tested with v2.2.0).

2. Open any of the provided scenarios in OpenViBE Designer (File → Open scenario).

3. Replace the Acquisition Client box with one of the following:

* Simulation: Use the built-in Signal Generator (for testing without hardware).

* Real EEG: Connect your headset via [Cykit](https://github.com/CymatiCorp/CyKit) or another compatible library, and configure it to stream data into the Acquisition Client port.

4. Run the scenario: stimuli will appear as defined, and EEG + event markers will be recorded.

## **Classification Methodology**

**Signal Preprocessing**
* Epoch extraction
* Normalization (per user)
* Detrending (linear & polynomial)
* Band-pass filtering (0.5–30 Hz)
* Baseline correction
* Channel selection

**Feature Engineering (ML pipeline)**
* Time-domain: Response time
* Frequency-domain: Power Spectral Density (PSD) in alpha, beta, theta, gamma, delta bands
* ERP features: P300, N400 statistical descriptors (mean, energy, AUC, etc.)

**Models**

**1. Machine Learning**
   
  * **Models:** Logistic Regression, SVM, Random Forest, Naïve Bayes, MLP, LightGBM

  * **Feature selection:** Variance Threshold, Correlation Filtering

  * **Best results:**
    - MLP – Accuracy ≈ 0.39, F1 ≈ 0.38
    - Logistic Regression – Accuracy ≈ 0.38, F1 ≈ 0.38

  * **Key insight:** Simpler models + correlation-based feature selection worked best.

**2. Deep Learning**

  * **Models:** CNN and CNN+LSTM hybrid (raw EEG input)

  * **Data Augmentation:** None, Reversed, Shuffled, Noise, Channel Drop

  * **Best results:**
    - CNN + Reversed/Noise augmentation → Accuracy ≈ 0.40–0.41

  * **Key insight:** CNN outperformed CNN+LSTM, but cross-subject generalization was weak.

## **Limitations**

* **Small dataset:** only 90 trials per subject (~4.5 min each)
* **10 users total**, making generalization across subjects difficult
* EEG is **noisy and user-dependent**, requiring more data for stability

## **Future Work**

* Expand dataset (more trials, more users) or make a complete new *larger* dataset (with other EEG device)

* Explore richer features (connectivity, wavelets, spectrograms)

* Use transfer learning & domain adaptation for better generalization

* Develop hybrid ML–DL pipelines (handcrafted + CNN embeddings)

* Personalize with subject-specific fine-tuning

## **NOTES:**

* The experiment control scripts and scenarios (OpenViBE) are included for documentation and reproducibility. They are not actively maintained.

* The original recordings were acquired using a commercial Emotiv EPOC headset, which I no longer have access to.

* This repository contains the full methodology, sample data (10 users), and models so that the pipeline can be reproduced.

* For research with new EEG data, replace the sample dataset with your own signals or with a public EEG dataset (e.g., PhysioNet, Kaggle).

# **TL;DR**

## **This repo benchmarks ML (LogReg, MLP) and DL (CNN, CNN+LSTM) models for EEG-based semantic category classification.**

* **ML + features → best Acc ≈ 0.39 (LogReg/MLP).**

* **DL + augmentation → best Acc ≈ 0.41 (CNN).**
  
* **Experiment control → EEG recordings were collected with an Emotiv EPOC headset and included experiment scripts.**

* **Main challenge: very limited dataset (10 users, 90 trials each).**

* **Takeaway: EEG-based classification is feasible, but generalization requires larger datasets + advanced ML/DL strategies.**
