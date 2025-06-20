# cancer-immune-dynamics
# Code for "Modeling Optimal Timing of Immunotherapy and Chemotherapy to Prevent Resistance and Recurrence in Triple-Negative Breast Cancer"

This repository contains the MATLAB codes used to perform the simulations presented in the article entitled:  
**"Modeling Optimal Timing of Immunotherapy and Chemotherapy to Prevent Resistance and Recurrence in Triple-Negative Breast Cancer."**

The codes are organized in the order in which their corresponding results appear in the *Results* section of the article.

## Overview

In this study, we developed a system of ordinary differential equations (ODEs) to model the dynamics of murine triple-negative breast cancer (TNBC) subpopulations, capturing tumor heterogeneity, and interactions with immune cells. Specifically, the model includes:

- The tumor suppression effect of immune killer cells
- The immunosuppressive role of myeloid-derived suppressor cells (MDSCs)
- Treatment interventions with:
  - **Abequolixron** (immune boosting agent)
  - **Methotrexate** (chemotherapy)

We conducted simulations under various treatment regimens, differing initiation times, and varying immune killing rates (τ) to assess their effects on tumor progression, resistance, and elimination.

All simulations were conducted using **MATLAB**.

## Code Description

The repository includes scripts for:

1. **Parameter Fitting**  
   - Estimation of model parameters by fitting to experimental data using MATLAB’s `lsqcurvefit` solver.

2. **Time-Series Simulations**  
   - Simulation of tumor and immune cell population dynamics over time under specified treatment conditions.

3. **Phase-Like Diagram Generation**  
   - Visualization of system behavior under different treatment regimens. The x-axis represents chemotherapy exposure duration, and the y-axis represents either immune boosting duration or drug-free periods within each cycle.  
   - Tumor fate after a specified simulation period is color-coded:  
     - **Red**: Tumor Escape  
     - **Blue**: Tumor Dormancy  
     - **Green**: Tumor Elimination

4. **Comparative Analysis**  
   - Scripts to compare the "escape regions" (red areas) across different simulation conditions, as described in Section 3.

## Requirements

- MATLAB R2021b (earlier or later versions may also work but are untested)
- Optimization Toolbox (for `lsqcurvefit`)
- Basic knowledge of MATLAB scripting

## How to Run

1. Clone the repository:
   ```bash
   git clone https://github.com/Mobina-Daneshparvar/cancer-immune-dynamics.git

2. Open MATLAB and navigate to the folder.

3. Run scripts (refer to the script headers for specific usage).
   
## Citation

If you use this code in your work, please cite our article:

Full citation will go here once the paper is published

## License

This project is licensed under the [MIT License](LICENSE).
