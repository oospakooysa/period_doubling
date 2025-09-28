# Octave Code for Period Doubling Project

This folder contains the core GNU Octave scripts used to generate the figures and results in the **Period Doubling and a Route to Chaos** writeup. The scripts are the numerical backbone of the report, implementing the oscillator models, parameter sweeps, and the jump phenomenon.

## Included Files

| Filename | Purpose / Description |
|---|------------------------------|
| `solve_DDHO.m` | Main script to simulate the forced nonlinear oscillator (Duffing / Double-Driven Harmonic Oscillator) over time. |
| `solve_DDHO_Sweep.m` | Parameter-sweep script to vary the forcing amplitude or frequency and record steady-state behavior (used for bifurcation diagrams). |
| `rhs_ddho.m` | Right-hand-side function defining the differential equation for the oscillator (core dynamics). |
| `rhs_ddho_1.m` | Alternate version of the RHS — used in variant tests or parameter regimes in the writeup. |
| `jump.m` | Script to simulate and plot the **jump phenomenon** (hysteresis in amplitude vs parameter). |

## Usage Instructions

1. Ensure you have GNU Octave installed on your system.
2. Navigate to this folder in your terminal or Octave prompt:
   ```bash
   cd path/to/period_doubling/code/octave
```
3. Run the simulation scripts in sequence or as needed:
octave solve_DDHO.m
octave solve_DDHO_Sweep.m
octave jump.m
4. The scripts generate plots or data which correspond to figures in the writeup:

solve_DDHO_Sweep.m → bifurcation-style diagrams
jump.m → jump/hysteresis plots
