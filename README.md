# morphology-word-embeddings

This project evaluates whether static word embeddings (e.g., fastText, GloVe) capture productive morphological transformations — such as pluralization, verb tense, and nominalization — across different semantic and syntactic categories. 

It uses custom MATLAB (Python version is coming out soon!) scripts to compute transformation vectors for morphemes and test their ability to generalize to unseen words. 


---

## Repository Contents

| File | Description |
|------|-------------|
| `func_morpheme_vector_pipeline.m` | Main function that generates and tests morpheme transformation vectors using word embeddings |
| `computeNeighborMetrics.m` | Script that loads model output, writes nearest neighbors to Excel, and computes evaluation metrics |
| `func_emb_metrics.m` | Helper function that calculates Top-1, Top-10 accuracy, and Mean Rank from prediction tables |
| `README.md` | This file |

---

## Method Overview

1. **Morpheme Vector Learning**  
   Computes the average vector difference between base and inflected word forms (e.g., `cats - cat`, `dogs - dog`).

2. **Prediction**  
   Applies this vector to a new word (e.g., `bird + plural_vector → ?`) and searches for the closest matches in the embedding space.

3. **Evaluation**  
   Compares predicted neighbors to the true target form. Outputs accuracy and rank statistics.
---

## How to Run

1. Make sure you have a word embedding object loaded into MATLAB (in MATLAB emb = fastTextWordEmbedding automatically uploads wiki-news-300d-1M.vec.zip. Any other embeddings can be uploaded with emb = readWordEmbedding(filename)).
2. Prepare a `.csv` file with two columns: base word and inflected form (e.g., `dog,dogs`).
3. Run the main function:
```matlab
[acc, sum] = func_morpheme_vector_pipeline('pluralRegularnew.csv', myRs, emb);
```
This will save a .mat file with predictions and accuracy.  

4. Then run:
```matlab
computeNeighborMetrics
```
This will:
Load the saved .mat file
Write predictions to Excel
Print Top-1, Top-10, and Mean Rank scores

## Output Example
#### The output table includes:

The expected inflected form

The top-10 predicted neighbors

#### Evaluation is based on:

Whether the true form is ranked 1st (Top-1)

Whether it appears in the top 10 (Top-10)

Average rank across all samples

## Notes
The evaluation assumes file names follow the format: morphoEmbVec[task]_[lang]_[date].mat  

This project is a development of my master's thesis under the supervision of [Dr. Scott L. Fairhall](https://webapps.unitn.it/du/it/Persona/PER0053660/Curriculum) at the University of Trento, [CIMeC](https://www.cimec.unitn.it/). If you would like to take a look at the results of different morphological transformations feel free to contact me!

## Author
Esin Ezgi Yıldız  

📧 esinezgiyildiz@gmail.com
