# Student Lifestyle & GPA Analysis (R)

Statistical analysis of the relationship between university students’ lifestyle habits and academic performance (GPA) using survey sampling techniques.

Completed for **SC/MATH 3430 – Sample Survey Methods** at **York University**.

---

## Overview
This project investigates how lifestyle factors such as sleep duration, study intensity, and screen exposure relate to academic performance among university students. Using real survey data and formal sampling theory, multiple sampling strategies are evaluated to compare estimator accuracy and precision.

---

## Data
- Survey of **100 York University students**
- Variables:
  - GPA
  - Study hours
  - Sleep duration
  - Screen time
  - Stress level
  - Exercise frequency
  - Lecture attendance

---

## Methodology
- Exploratory data analysis and correlation assessment
- Simple Random Sampling (SRS) as a baseline estimator
- Stratified Sampling approaches:
  - Proportional Allocation
  - Neyman Allocation (variance-optimal allocation)
- Precision comparison using variance and standard error analysis
- Data visualization using `ggplot2`

---

## Key Findings
- **Screen time exhibited the strongest negative linear association with GPA** (Pearson correlation **r ≈ −0.27**), indicating a moderate adverse relationship between prolonged daily screen exposure and academic performance.
- **Sleep duration demonstrated the strongest positive association with GPA** (Pearson correlation **r ≈ +0.19**), with peak academic outcomes observed among students reporting **7–8 hours of sleep per night**.
- Stratification by **sleep duration, study intensity, and screen exposure** identified a high-performing subgroup (7–8 hours sleep, 11–15 study hours/week, 0–2 hours screen time) with **mean GPA ≈ 9.0**, exceeding the overall sample mean (**≈ 6.6**) by over **2 GPA points**.
- Students in the **lowest-performing stratum** (9–12 hours/day screen time combined with 0–4 hours/night sleep) recorded **mean GPAs ≈ 5.0**, representing a **~24% reduction relative to the population mean**.
- Marginal increases in study hours alone were **not sufficient** to produce higher GPA; academic gains were conditional on **adequate sleep and constrained screen time**, suggesting **interaction effects** between lifestyle variables.
- **Stratified sampling produced substantial reductions in estimator variance relative to SRS**:
  - SRS variance: **1.74**
  - Proportional allocation variance: **1.52** (**~13% reduction**)
  - Neyman allocation variance: **1.48** (**~15% reduction vs. SRS**)
- **Neyman allocation achieved the lowest standard error**, demonstrating its effectiveness in exploiting within-stratum heterogeneity to improve estimation efficiency.

---

## Repository Structure
.
├── Group_5_Code.R # Data cleaning, sampling implementations, analysis, and visualizations
├── Group_5_Data.csv # Survey dataset
└── Group_5_Report.pdf # Final technical report

---

## Tools & Libraries
- R
- dplyr
- ggplot2
- sampling

---

## Author
**Yonatan Verch**  
BSc Mathematics — York University
