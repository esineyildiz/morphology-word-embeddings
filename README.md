## THIS SECTION IS UNDER CONSTRUCTION AND WILL BE DONE IN COUPLE DAYS :grimacing: (16/06/25)
# morphology-word-embeddings

This project evaluates whether static word embeddings (e.g., fastText, GloVe) capture productive morphological transformations — such as pluralization, verb tense, and nominalization — across different semantic and syntactic categories and 

It uses custom MATLAB scripts to compute transformation vectors for morphemes and test their ability to generalize to unseen words.

---

## Repository Contents

| File | Description |
|------|-------------|
| `func_morpheme_vector_pipeline.m` | Main function that generates and tests morpheme transformation vectors using word embeddings |
| `computeNeighborMetrics.m` | Script that loads model output, writes nearest neighbors to Excel, and computes evaluation metrics |
| `func_emb_metrics.m` | Helper function that calculates Top-1, Top-10 accuracy, and Mean Rank from prediction tables |
| `README.md` | This file |

---

