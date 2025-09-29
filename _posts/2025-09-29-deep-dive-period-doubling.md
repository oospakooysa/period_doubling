---
layout: default
title: "From Oscillators to Chaos: A Deep Dive into Period Doubling"
date: 2025-09-29
tags: [physics, chaos, nonlinear]
---

# From Oscillators to Chaos: A Deep Dive into Period Doubling

This post expands on the material in my [period doubling site](https://oospakooysa.github.io/period_doubling/), drawing from extended worked examples, figures, and simulations. It’s aimed at readers who want to dig deeper into the physics, coding, and data behind nonlinear oscillators and chaos.

---

## 1. Introduction

Period-doubling bifurcations provide one of the cleanest routes to chaos. Starting with simple oscillators, we’ll explore how gradually adding nonlinearity, forcing, and amplitude changes drive systems from predictable motion into chaotic behaviour.  

We’ll use real-world analogies (fairground rides, suspension systems), coding in Octave, and figures from simulations to make this journey concrete.

---

## 2. Simple Systems and Verification

Before diving into chaos, we first **verify** our tools.

### The Apocalypse Ride
A 1D dynamic system, where a car free-falls from 54 m before braking at ~6 m.
We modelled the ride in Octave, observing the velocity and displacement over time.

*Key insight:* The braking distance relates to gravitational force via:

```
h₁ = (mg / B) * h₂
```

Graphs of velocity and acceleration confirm when braking occurs (~10.2s) and how deceleration peaks.

![Apocalypse Ride Velocity]({{ site.baseurl }}/images/apocalypse_velocity.png)
![Apocalypse Ride Acceleration]({{ site.baseurl }}/images/apocalypse_accel.png)

---

### Monster Truck Suspension
Here we verified solvers. Euler vs Euler-Cromer gave clear differences: Euler diverges, while Euler-Cromer preserves stable oscillations.

![Suspension Euler]({{ site.baseurl }}/images/suspension_euler.png)  
![Suspension Cromer]({{ site.baseurl }}/images/suspension_cromer.png)

Validation against experimental data showed errors < 10%, confirming the model.

---

## 3. Linear vs Nonlinear Oscillators

### Linear Oscillator
Produces clean sinusoidal motion with a fixed period (6.28s, 0.158 Hz).  

![Linear Oscillator]({{ site.baseurl }}/images/linear01.png)
![Linear Oscillator]({{ site.baseurl }}/images/linear02.png)
![Linear Oscillator]({{ site.baseurl }}/images/linear03.png)

### Soft Spring Oscillator
Adding a soft nonlinearity lengthens oscillations, introduces multiple frequencies, and changes phase-plane structure.

![Soft Spring]({{ site.baseurl }}/images/softspring01.png)
![Soft Spring]({{ site.baseurl }}/images/softspring02.png)
![Soft Spring]({{ site.baseurl }}/images/softspring03.png)

### Hard Spring Oscillator
Opposite effect: higher frequencies, shorter periods, and more force.

![Hard Spring]({{ site.baseurl }}/images/hardspring01.png)
![Hard Spring]({{ site.baseurl }}/images/hardspring02.png)
![Hard Spring]({{ site.baseurl }}/images/hardspring03.png)

---

## 4. Forced Oscillators & Chaos (Ueda’s Equation)

When forcing is added, things change rapidly. Using:

```
ẍ = -δẋ - βx³ + Fcos(ωt)
```

Simulations show subharmonics, irregular phase planes, and eventually chaos.  

![Ueda Chaos]({{ site.baseurl }}/images/ueda_chaos01.png)
![Ueda Chaos]({{ site.baseurl }}/images/ueda_chaos02.png)
![Ueda Chaos]({{ site.baseurl }}/images/ueda_chaos03.png)

---

## 5. Period-Doubling Bifurcations

One of the most striking routes to chaos in nonlinear dynamics is the **period-doubling cascade**.  
As the driving strength increases, oscillations progress from stable repetition into alternating cycles, doubling in complexity each time.  
Eventually, this sequence leads to fully chaotic motion.

---

### Period-1 Oscillations (γ = 1.060)

At low driving strength, the system exhibits **simple periodic motion**.  
The oscillator repeats the same path every cycle.

| ![Period 1 Time Series]({{ site.baseurl }}/images/period1a.png) | ![Period 1 Phase Plane]({{ site.baseurl }}/images/period1b.png) |
|---------------------------|---------------------------|
| *Period-1 – time series*  | *Period-1 – phase plane*  |
| ![Period 1 Spectrum]({{ site.baseurl }}/images/period1c.png) | ![Period 1 Return Map]({{ site.baseurl }}/images/period1d.png) |
| *Period-1 – spectrum*     | *Period-1 – return map*   |

- **Time series**: Regular oscillation with a single amplitude.  
- **Phase plane**: A single closed loop.  
- **Spectrum**: Dominated by the fundamental frequency.  
- **Return map**: One fixed point.  

> **Summary**: The system is stable and repeats identically each cycle.

---

### Period-2 Oscillations (γ = 1.078)

With greater driving, the system undergoes its first **bifurcation**: oscillations alternate between two states.

| ![](/images/period2a.png) | ![](/images/period2b.png) |
|---------------------------|---------------------------|
| *Period-2 – time series*  | *Period-2 – phase plane*  |
| ![](/images/period2c.png) | ![](/images/period2d.png) |
| *Period-2 – spectrum*     | *Period-2 – return map*   |

- **Time series**: Two alternating amplitudes.  
- **Phase plane**: The trajectory alternates between two loops.  
- **Spectrum**: Peaks appear at half the fundamental frequency.  
- **Return map**: Two distinct points.  

> **Summary**: The first doubling — the system now needs two cycles to repeat.

---

### Period-4 Oscillations (γ = 1.081)

Further increase in driving strength leads to another bifurcation: **Period-4 motion**.

| ![](/images/period4a.png) | ![](/images/period4b.png) |
|---------------------------|---------------------------|
| *Period-4 – time series*  | *Period-4 – phase plane*  |
| ![](/images/period4c.png) |                           |
| *Period-4 – spectrum*     |                           |

- **Time series**: Four distinct amplitudes before repeating.  
- **Phase plane**: Four interwoven loops.  
- **Spectrum**: New subharmonics appear.  

> **Summary**: The doubling continues — repetition now requires four cycles.

---

### Period-8 Oscillations (γ = 1.0826)

At even stronger driving, the system displays **Period-8 behaviour**.  
This is the last stage before chaos.

| ![](/images/period8a.png) | ![](/images/period8b.png) |
|---------------------------|---------------------------|
| *Period-8 – time series*  | *Period-8 – phase plane*  |
| ![](/images/period8c.png) | ![](/images/period8d.png) |
| *Period-8 – spectrum*     | *Period-8 – return map*   |

- **Time series**: Eight alternating amplitudes.  
- **Phase plane**: Eight-fold structure in the trajectory.  
- **Spectrum**: A dense cluster of peaks, precursors to chaos.  
- **Return map**: Eight visited points.  

> **Summary**: With repetition stretched to eight cycles, the system is on the verge of chaos.

---

### The Cascade and Feigenbaum’s Constant

This doubling process (Period-1 → Period-2 → Period-4 → Period-8 → …) accelerates rapidly.  
The intervals between bifurcations shrink geometrically, converging toward the **Feigenbaum constant**:

$$
\delta \approx 4.669
$$

This universal constant governs the rate at which period-doubling bifurcations accumulate, marking the onset of chaos in a wide range of nonlinear systems.


**Feigenbaum’s Constant:**  
As the sequence accumulates, the ratio of bifurcation intervals converges to δ ≈ 4.669.

---

## 6. Extended Findings: The SkyMaster Ride

The Skymaster, a pendulum-like fairground ride, highlights how chaos links to **safety**.  

Simulations showed:  
- At low drive amplitude (A=1.0) – smooth oscillations, tolerable g-forces.  
- At higher amplitudes (A=3.0–5.0) – unsafe g-forces (>10 G).  
- Beyond A=5.0 – rolling chaotic motion.  

Example calculation:

```
G = (ω² * r) / g
```

For A=4.0: ~22 G – *far beyond human tolerance*.  

![Skymaster Chaos]({{ site.baseurl }}/images/skymaster1a.png)
![Skymaster Chaos]({{ site.baseurl }}/images/skymaster1b.png)
![Skymaster Chaos]({{ site.baseurl }}/images/skymaster1c.png)
![Skymaster Chaos]({{ site.baseurl }}/images/skymaster1d.png)

---

## 7. Chaos and Beyond

We also observed phenomena like the **jump phenomenon**, where nonlinear resonance leads to sudden amplitude jumps.  

Bifurcation diagrams (below) map regions of stability, doubling, and chaos.  

![Bifurcation Diagram]({{ site.baseurl }}/images/bifurcation.png)

---

## 8. Conclusion

- We began with simple oscillators → added nonlinear springs → forced systems → period doubling → chaos.  
- Verification steps ensured our models matched reality.  
- Applications like the Skymaster ride show that chaos isn’t just theoretical: it has real engineering and safety implications.  

For a lighter introduction, check the [overview site](https://oospakooysa.github.io/period_doubling/). For those who want the deep dive—you just read it.

---

*Figures and data from Octave, UDK, Webots, and detailed analysis in the original Physics study.*
