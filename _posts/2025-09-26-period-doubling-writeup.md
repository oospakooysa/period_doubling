---
layout: default
title: "Period Doubling and a Route to Chaos"
date: 2025-09-26
tags: [chaos, nonlinear dynamics, simulation, octave, unreal-engine]
---

![Hero Image: Bifurcation Diagram](images/bifurcation.png)  
*Figure 1. Bifurcation diagram illustrating the transition from periodic motion to chaos.*

> Exploring nonlinear oscillators and chaos through simulation in **UDK Unreal Engine 3** and **GNU Octave**.

# Contents
1. [Introduction](#1-introduction)  
2. [From Linear to Nonlinear Oscillators](#2-from-linear-to-nonlinear-oscillators)  
3. [Period Doubling and the Route to Chaos](#3-period-doubling-and-the-route-to-chaos)  
4. [Chaos in the Skymaster Ride](#4-chaos-in-the-skymaster-ride)  
5. [The Jump Phenomenon](#5-the-jump-phenomenon)  
6. [Comparing Simulation Frameworks](#6-comparing-simulation-frameworks)  
7. [Mathematical Insights](#7-mathematical-insights)  
8. [Broader Connections](#8-broader-connections)  
9. [Conclusion](#9-conclusion)  

---

# 1. Introduction  

Chaos emerges when simple deterministic rules generate unpredictable, intricate motion. This project follows that path: beginning with linear oscillators, layering in nonlinearity, forcing, and damping, and arriving at the strange world of **period doubling** and the **route to chaos**.  

The goal was not to rely on black-box solvers, but to simulate each system inside **GNU Octave** and the **Unreal Engine (UDK)**, making the physics visible.  

---

# 2. From Linear to Nonlinear Oscillators  

Before diving into chaos, I began with familiar oscillators:  
- **Linear systems** behaved predictably, with smooth sinusoidal motion.  
- **Nonlinear stiffness** introduced subtle distortions.  
- Adding **forcing terms** created rich dynamics, leading to bifurcations.  

## 2.1 Simple Harmonic Oscillator (SHO)  

\[
m \ddot{x} + kx = 0
\]

Solution:  

\[
x(t) = A \cos(\omega t + \phi), \quad \omega = \sqrt{\tfrac{k}{m}}
\]

📊 *Octave simulation:*  

```octave
% SHO: simple harmonic oscillator
m = 1; k = 1;
omega = sqrt(k/m);
t = linspace(0, 20, 1000);
x = cos(omega*t);   % A=1, phi=0

plot(t, x);
xlabel('Time'); ylabel('Displacement');
title('Simple Harmonic Oscillator');
