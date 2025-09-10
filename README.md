# EEG Semantic Category Classification
## Overview

This project explores the use of electroencephalographic (EEG) signals for identifying semantic categories in the human brain. The work was originally developed as part of my thesis, using a wearable EEG device (Emotiv EPOC).

The goal was to classify brain responses into three categories:
* Tools
* Animals
* Flowers/Fruits

This type of research contributes to the development of Brain-Computer Interfaces (BCI), which can improve life quality for people with speech or communication disorders.

## Dataset & Protocol

Participants: 10 users
Stimuli: Visual prompts belonging to the 3 categories
Acquisition device: Emotiv EPOC EEG headset
Signals recorded: 900 total (300 per class)

## Methodology

Signal Preprocessing
Noise filtering
Selection of frequency bands
Extraction of event-related components (including P300)
Feature Extraction
Time-domain and frequency-domain features
ERP components

## Classification Models

Multilayer Perceptron (MLP)
Naive Bayes
Logistic Regression
Random Forest
Support Vector Machine (SVM)

## Evaluation

Cross-validation methodology

## Results

Best model: Logistic Regression
Accuracy: 80.83% (3-class classification across all users)

## Repository Structure

wearable-eeg-classification/

│── notebooks/         # Jupyter notebooks with preprocessing, feature extraction, and classification

│── models/            # Trained models (or links if too large)

│── results/           # Accuracy scores, plots, and confusion matrices

│── thesis/            # Thesis summary or full PDF

│── requirements.txt   # Python dependencies

│── README.md          # This file

## How to Use

1. Clone the repository:

git clone [https://github.com/dlaura-vergaras/EEG-Semantic-Category-Classification.git]

cd EEG-Semantic-Category-Classification

2. Install dependencies:

pip install -r requirements.txt

3. Run the example notebook:

Open notebooks/01_preprocessing.ipynb

4. Test with provided sample EEG data.

## NOTES

* The original recordings were acquired using a commercial Emotiv EPOC headset, which I no longer have access to.

* This repository contains the full methodology, sample data (4 users), and models so that the pipeline can be reproduced.

* For research with new EEG data, replace the sample dataset with your own signals or with a public EEG dataset (e.g., PhysioNet, Kaggle).
