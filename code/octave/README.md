# Octave Code for Period Doubling Project

This folder contains the GNU Octave scripts used to generate the figures and results in the **Period Doubling and a Route to Chaos** writeup.  
They implement oscillator models, parameter sweeps, and the jump phenomenon — forming the numerical backbone of the report.

## 📂 Included Files

| Filename | Purpose / Description |
|----------|------------------------|
| `solve_DDHO.m`       | Simulates the forced nonlinear oscillator (Duffing / Double-Driven Harmonic Oscillator) over time. |
| `solve_DDHO_Sweep.m` | Parameter-sweep script to vary the forcing amplitude or frequency and record steady-state behavior (used for bifurcation diagrams). |
| `rhs_ddho.m`         | Right-hand-side function defining the differential equation for the oscillator (core dynamics). |
| `rhs_ddho_1.m`       | Alternate RHS function — used in variant tests or parameter regimes in the writeup. |
| `jump.m`             | Simulates and plots the **jump phenomenon** (hysteresis in amplitude vs parameter). |

## ▶️ Usage Instructions

1. Ensure you have **GNU Octave** installed (MATLAB is also supported with minor adjustments).  
2. Navigate to this folder:

```bash
cd path/to/period_doubling/code/octave
```

3. Run the desired scripts:

```bash
octave solve_DDHO.m
octave solve_DDHO_Sweep.m
octave jump.m
```

4. Figures will be generated corresponding to the writeup:
   - `solve_DDHO_Sweep.m` → `/images/bifurcation.png`  
   - `jump.m` → `/images/jump.png` (hysteresis curve)  
   - `solve_DDHO.m` → example oscillator time series / phase plane  

## 📊 Notes

- Parameters (forcing amplitude, frequency, damping, etc.) can be modified within each script to reproduce different test cases.  
- The scripts were validated against theoretical expectations and cross-checked with results presented in the [deep dive report](../../_posts/2025-09-29-deep-dive-period-doubling.md).
