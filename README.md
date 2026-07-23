
# 🌾 Basic Statistical Analysis for Plant Genetics in R

This repository contains an R script developed as part of a **Plant Genetics (Fitogenética) laboratory course**. The project demonstrates how to perform common statistical analyses used in plant breeding and quantitative genetics using a barley phenotypic dataset.

The workflow introduces descriptive statistics, hypothesis testing, multivariate analysis, correlation analysis, regression, and clustering techniques commonly applied to characterize genetic diversity and evaluate agronomic traits.

The objective was to introduce the students to data analysis and interpretation. Never to perform this level of statistics
---

## 📚 Overview

The analyses included in this project are:

- Descriptive statistics
- Analysis of Variance (ANOVA)
- Tukey's Honest Significant Difference (HSD) Test
- PERMANOVA
- Principal Coordinates Analysis (PCoA)
- Chi-Square Test of Independence
- Correlation Analysis
- Principal Component Analysis (PCA)
- Linear Regression
- Hierarchical Clustering

Each section includes practical examples and interpretation questions that were used during the laboratory session.

---

## 📁 Project Structure

```
.
├── updated_barley_dataset_275.csv    # Barley phenotypic dataset
├── statistical_analysis.R            # Main analysis script
└── README.md
```

---

## 🌱 Dataset

It uses a synthetic dataset based of the "275 barley accessions conducted at ICARDA in 2019" study. This dataset contains phenotypic measurements from **275 barley accessions**, including several agronomic and quality traits such as:

| Variable | Description |
|----------|-------------|
| GY | Grain Yield |
| PH | Plant Height |
| Area | Grain Area |
| Diameter | Grain Diameter |
| Length | Grain Length |
| HW | Hectoliter Weight |
| TKW | Thousand Kernel Weight |
| Protein | Grain Protein Content |
| B_glucan | β-glucan Content |
| DTH | Days to Heading |
| Fe | Iron Content |
| Zn | Zinc Content |

---

## 📦 Required R Packages

The project uses the following libraries:

```r
library(tidyverse)
library(vegan)
library(FactoMineR)
library(factoextra)
library(ape)
library(corrplot)
library(agricolae)
library(pastecs)
library(Hmisc)
```

Install them with:

```r
install.packages(c(
  "tidyverse",
  "vegan",
  "FactoMineR",
  "factoextra",
  "ape",
  "corrplot",
  "agricolae",
  "pastecs",
  "Hmisc"
))
```

---

## 🔬 Analyses Performed

### 1. Descriptive Statistics

Calculates summary statistics for grain yield (GY), including:

- Mean
- Standard deviation
- Variance
- Normality statistics

Packages used:

- `pastecs`
- `Hmisc`

---

### 2. Analysis of Variance (ANOVA)

Evaluates whether grain yield differs among plant height groups.

Steps:

- Categorize plant height into Low, Medium, and High
- Perform one-way ANOVA
- Conduct Tukey HSD post-hoc comparisons
- Visualize results with boxplots

---

### 3. PERMANOVA

Tests whether multivariate phenotypic profiles differ among plant height groups.

Features:

- Euclidean distance matrix
- Permutation-based multivariate analysis
- Suitable for multivariate trait comparisons

Package:

- `vegan`

---

### 4. Principal Coordinates Analysis (PCoA)

Visualizes multivariate relationships among barley accessions using distance-based ordination.

Package:

- `ape`

---

### 5. Chi-Square Test

Examines the association between categorical versions of:

- Protein content
- Thousand Kernel Weight (TKW)

Results are visualized using a mosaic plot.

---

### 6. Correlation Analysis

Computes the Pearson correlation matrix among quantitative traits and visualizes it using a correlation heatmap.

Package:

- `corrplot`

---

### 7. Principal Component Analysis (PCA)

Explores phenotypic diversity by reducing dimensionality.

Includes:

- Eigenvalue plot
- PCA biplot
- Trait relationships
- Accession distribution

Packages:

- `FactoMineR`
- `factoextra`

---

### 8. Linear Regression

Models the relationship between:

- Thousand Kernel Weight (TKW)
- Grain Yield (GY)

Outputs include:

- Regression coefficients
- R²
- Significance tests
- Scatter plot with regression line

---

### 9. Hierarchical Clustering

Groups genetically similar accessions using:

- Euclidean distance
- Ward's clustering method

Results are displayed as a dendrogram.

---

## 📈 Learning Objectives

After completing this laboratory, students should be able to:

- Perform exploratory statistical analyses in R
- Compare phenotypic groups using ANOVA
- Interpret post-hoc statistical tests
- Analyze multivariate phenotypic variation
- Explore diversity through PCA and PCoA
- Evaluate relationships among quantitative traits
- Fit and interpret simple linear regression models
- Cluster accessions based on phenotypic similarity

---

## ▶️ Running the Analysis

1. Clone this repository.

```bash
git clone https://github.com/yourusername/your-repository.git
```

2. Open the R script in RStudio.

3. Ensure the dataset (`updated_barley_dataset_275.csv`) is located in the working directory.

4. Install any missing packages.

5. Run the script sequentially.

---

## 🎓 Academic Context

This project was developed as part of a **Plant Genetics (Fitogenética)** laboratory course. Its purpose is educational, providing hands-on experience with statistical methods commonly used in plant breeding, quantitative genetics, and phenotypic data analysis.

---

## 📖 References

- R Core Team (2024). *R: A Language and Environment for Statistical Computing.*
- FactoMineR Documentation
- vegan Package Documentation
- corrplot Package Documentation
- Applied Plant Breeding and Quantitative Genetics literature

---

## 📄 License

This repository is intended for educational purposes. Feel free to use and adapt the code with appropriate attribution.