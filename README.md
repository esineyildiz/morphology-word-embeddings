<img width="443" alt="Screenshot 2025-06-18 at 17 44 07" src="https://github.com/user-attachments/assets/9bfa6dd4-0beb-496c-8497-39df77471c35" />

# morphology-word-embeddings

This project evaluates whether static word embeddings (e.g., fastText, GloVe) capture productive morphological transformations — such as pluralization, verb tense, and nominalization — across different semantic and syntactic categories. 

It uses custom scripts to compute transformation vectors for morphemes and test their ability to generalize to unseen words. Both MATLAB and Python implementations are available.


---

## Repository Contents

| File | Description |
|------|-------------|
| `func_morpheme_vector_pipeline.m` | Main function that generates and tests morpheme transformation vectors using word embeddings |
| `computeNeighborMetrics.m` | Script that loads model output, writes nearest neighbors to Excel, and computes evaluation metrics |
| `func_emb_metrics.m` | Helper function that calculates Top-1, Top-10 accuracy, and Mean Rank from prediction tables |
| `README.md` | This file |

---

### Python Implementation
| File | Description |
|------|-------------|
| `morphology_word_embeddings.ipynb` | Complete notebook with all functions integrated (`func_morpheme_vector_pipeline` `computeNeighborMetrics` `func_emb_metrics`) (recommended for Google Colab) |

## Method Overview

1. **Morpheme Vector Learning**  
   Computes the average vector difference between base and inflected word forms (e.g., `cats - cat`, `dogs - dog`).

2. **Prediction**  
   Applies this vector to a new word (e.g., `bird + plural_vector → ?`) and searches for the closest matches in the embedding space.

3. **Evaluation**  
   Compares predicted neighbors to the true target form. Outputs accuracy and rank statistics.
---

## How to Run
<img width="216" height="184" alt="Screenshot 2025-10-17 at 12 26 53" src="https://github.com/user-attachments/assets/227cfa56-c1ec-4dfb-852a-14675b0524e5" /> 

#### Input should look like this

### MATLAB
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

### Python

#### Using Jupyter Notebook / Google Colab

1. Open the notebook file, upload the .xlsx file to the contents, and run all cells in order
2. The notebook will:
   - Install required packages 
   - Load word embeddings (`'fasttext-wiki-news-subwords-300'`)
   - Run the pipeline and compute metrics 

## Output Example
#### The output table includes:

The expected inflected form

The top-10 predicted neighbors

#### Evaluation is based on:

Whether the true form is ranked 1st (Top-1)

Whether it appears in the top 10 (Top-10)

Average rank across all samples

For instance when the analysis was run on English regular nouns (table -> tables) and Turkish nouns (with no additional derivational morphemes) (masa -> masalar) 

English achieved a Top-1 accuracy of 46.88% and Top-10 accuracy of 100%. The correct plural form ranked, on average, at position 1.59.

Turkish had Top-1 accuracy of 6.25%, Top-10 accuracy at 84.38%, and a mean rank of 2.70.

## Notes

This project is a development of my master's thesis under the supervision of [Dr. Scott L. Fairhall](https://webapps.unitn.it/du/it/Persona/PER0053660/Curriculum) at the University of Trento, [CIMeC](https://www.cimec.unitn.it/). If you would like to take a look at the results of different morphological transformations feel free to contact me!

## Author
Esin Ezgi Yıldız  

📧 esinezgiyildiz@gmail.com
