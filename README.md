# Student Lifestyle & GPA Analysis (R)

Statistical analysis of the relationship between university students’ lifestyle habits and academic performance (GPA) using survey sampling techniques.

Completed for **SC/MATH 3430 – Sample Survey Methods** at **York University**.

---

## Overview
This project investigates how lifestyle factors such as sleep duration, study intensity, and screen exposure relate to academic performance among university students. Using real survey data and formal sampling theory, multiple sampling strategies are evaluated to compare estimator accuracy and precision.

---

## Exploratory Visualizations

### Screen Time/Study Hours vs. GPA
![Screen Time vs GPA](download(9).png)

### Sleep Hours vs. GPA
![Sleep Hours vs GPA](download(10)png)

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
- **Screen time exhibited the strongest negative linear association with GPA** (Pearson correlation **r ≈ −0.27**).
- **Sleep duration demonstrated the strongest positive association with GPA** (Pearson correlation **r ≈ +0.19**), with optimal outcomes at **7–8 hours/night**.
- A high-performing stratum (7–8 hours sleep, 11–15 study hours/week, 0–2 hours screen time) achieved **mean GPA ≈ 9.0**, exceeding the overall mean (**≈ 6.6**) by over **2 GPA points**.
- The lowest-performing stratum (9–12 hours/day screen time and 0–4 hours/night sleep) recorded **mean GPA ≈ 5.0** (**~24% below population mean**).
- Increased study hours alone were **not sufficient** to improve GPA without adequate sleep and controlled screen time.
- **Stratified sampling reduced estimator variance relative to SRS**:
  - SRS variance: **1.74**
  - Proportional allocation: **1.52** (**~13% reduction**)
  - Neyman allocation: **1.48** (**~15% reduction vs. SRS**)

---

## Repository Structure
.
├── Group_5_Code.R
├── Group_5_Data.csv
├── Group_5_Report.pdf
└── images/
├── screen_time_vs_gpa.png
├── study_hours_vs_gpa.png
└── sleep_hours_vs_gpa.png

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
