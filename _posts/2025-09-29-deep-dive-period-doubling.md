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

| ![]({{ site.baseurl }}/images/period2a.png) | ![]({{ site.baseurl }}/images/period2b.png) |
|---------------------------|---------------------------|
| *Period-2 – time series*  | *Period-2 – phase plane*  |
| ![]({{ site.baseurl }}/images/images/period2c.png) | ![]({{ site.baseurl }}/images/period2d.png) |
| *Period-2 – spectrum*     | *Period-2 – return map*   |

- **Time series**: Two alternating amplitudes.  
- **Phase plane**: The trajectory alternates between two loops.  
- **Spectrum**: Peaks appear at half the fundamental frequency.  
- **Return map**: Two distinct points.  

> **Summary**: The first doubling — the system now needs two cycles to repeat.

---

### Period-4 Oscillations (γ = 1.081)

Further increase in driving strength leads to another bifurcation: **Period-4 motion**.

| ![]({{ site.baseurl }}/images/period4a.png) | ![]({{ site.baseurl }}/images/period4b.png) |
|---------------------------|---------------------------|
| *Period-4 – time series*  | *Period-4 – phase plane*  |
| ![]({{ site.baseurl }}/images/period4c.png) |                           |
| *Period-4 – spectrum*     |                           |

- **Time series**: Four distinct amplitudes before repeating.  
- **Phase plane**: Four interwoven loops.  
- **Spectrum**: New subharmonics appear.  

> **Summary**: The doubling continues — repetition now requires four cycles.

---

### Period-8 Oscillations (γ = 1.0826)

At even stronger driving, the system displays **Period-8 behaviour**.  
This is the last stage before chaos.

| ![]({{ site.baseurl }}/images/period8a.png) | ![]({{ site.baseurl }}/images/period8b.png) |
|---------------------------|---------------------------|
| *Period-8 – time series*  | *Period-8 – phase plane*  |
| ![]({{ site.baseurl }}/images/period8c.png) | ![]({{ site.baseurl }}/images/period8d.png) |
| *Period-8 – spectrum*     | *Period-8 – return map*   |

- **Time series**: Eight alternating amplitudes
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

To connect theory with the real world, we studied the **SkyMaster ride**, a fairground pendulum swing.  
Despite its simplicity, the ride captures the essence of nonlinear dynamics and exhibits the same route to chaos observed in abstract models.  
Here, the consequences are not only theoretical but also practical — oscillations translate directly into the **forces experienced by riders**, raising important questions of **comfort and safety**.

---

### Low-Amplitude Motion

At small driving forces, the SkyMaster behaves like a nearly linear pendulum.  
Oscillations are smooth, regular, and close to sinusoidal.

| ![]({{ site.baseurl }}/images/skymaster1a.png) | ![]({{ site.baseurl }}/images/skymaster1b.png) |
|------------------------------|------------------------------|
| *SkyMaster – low amplitude*  | *SkyMaster – higher amplitude* |

- **Low amplitude**: Periodic motion with a clear repeating cycle.  
- **Higher amplitude**: Oscillations deviate from sinusoidal form, marking the onset of nonlinearity.  

> **Summary**: At low drive, the SkyMaster is stable and predictable, with forces well within safe limits.

---

### Growing Nonlinearity

As the driving energy increases, nonlinear effects dominate the system.  
The oscillations grow in amplitude and complexity, and the forces acting on riders become less predictable.

| ![]({{ site.baseurl }}/images/skymaster1c.png) |                              |
|------------------------------|------------------------------|
| *SkyMaster – g-force profile* |                              |

- **G-force profile**: Riders experience rapidly varying forces, reflecting the system’s nonlinear response.  
  These fluctuations affect not only comfort but also **safety considerations in ride design and operation**.  

#### Example — estimated g-force at higher drive (safety check)

Using simulation parameters, we can estimate the peak g-force for a high drive amplitude:

```
G = (ω² * r) / g
```

For A = 4.0:

1. \(14.34 \times 14.34 = 205.6356\)  
2. \(205.6356 \times 1.84 = 378.369504\)  
3. \(378.369504 \times 0.57 = 215.67061728\)  
4. \(215.67061728 \div 9.81 = 21.98\)

**Result:** ≈ **22 G**

> **Safety note:** This is *far beyond* normal human tolerance (amusement rides typically remain well under 5 G).  
> Once nonlinear oscillations grow, the ride risks producing unsafe forces.

> **Summary**: The system now exhibits strong nonlinear features, and safety margins must account for unexpected force variations.

---

### Rolling Chaotic Motion

Beyond a critical threshold, the SkyMaster’s motion becomes irregular and unpredictable.  
Instead of smooth oscillations, the ride enters a state of **rolling chaotic motion**.

| ![]({{ site.baseurl }}/images/skymaster1d.png) | ![]({{ site.baseurl }}/images/skymaster1e.png) |
|------------------------------|------------------------------|
| *Onset of chaos*             | *Rolling chaotic motion*     |

- **Onset of chaos**: Motion becomes aperiodic and highly sensitive to initial conditions.  
- **Rolling chaotic motion**: Large, irregular swings dominate, making long-term prediction impossible.  

> **Summary**: At high drive, the SkyMaster exhibits rolling chaotic motion.  
> This unpredictability makes control difficult and increases risks to rider safety.

---

### From Theory to Experience

The SkyMaster demonstrates how **nonlinear oscillators and chaos theory** are not confined to equations and simulations.  
They manifest directly in mechanical systems — and in this case, in the **safety of real-world amusement rides**.  
Chaos here is not just abstract: it is something riders feel in their bodies.


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
