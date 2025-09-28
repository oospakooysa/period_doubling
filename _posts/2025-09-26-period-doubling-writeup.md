---
layout: default
title: "Period Doubling and a Route to Chaos"
date: 2025-09-26
tags: [chaos, nonlinear dynamics, simulation, octave, unreal-engine]
---

![Hero Image: Bifurcation Diagram]({{ site.baseurl }}/images/bifurcation.png)
*Figure 1. Bifurcation diagram illustrating the transition from periodic motion to chaos.*

> Exploring nonlinear oscillators and chaos through simulation in **UDK Unreal Engine 3** and **GNU Octave**.

## Report Outline  

1. [Introduction](#1-introduction)
2. [From Linear to Nonlinear Oscillators](#2-from-linear-to-nonlinear-oscillators)
3. [Chaos and Period Doubling](#3-chaos-and-period-doubling)
4. [The Skymaster Ride](#4-the-skymaster-ride)
5. [The Apocalypse Ride](#5-the-apocalypse-ride)
6. [The Jump Phenomenon](#6-the-jump-phenomenon)
7. [Comparison of Simulators](#7-comparison-of-simulators)
8. [Mathematical Insights](#8-mathematical-insights)
9. [Discussion](#9-discussion)
10. [Conclusion](#10-conclusion)

---

# 1. Introduction

Chaos emerges when simple deterministic rules generate unpredictable, intricate motion. This project follows that path: beginning with linear oscillators, layering in nonlinearity, forcing, and damping, and arriving at the strange world of **period doubling** and the **route to chaos**.  
This project set out to explore that transformation: from **linear oscillators** with predictable sinusoidal motion, to **nonlinear systems** exhibiting bifurcations, period doubling, and finally **chaos**.

The goal was not to rely on black-box solvers, but to simulate each system inside **GNU Octave** and the **Unreal Engine (UDK)**, making the physics visible.

Why does this matter?
- **Engineering:** Nonlinearities appear in suspension systems, aircraft, and bridges. Predicting when stable oscillations destabilize is essential for safety.
- **Everyday life:** Amusement rides like the **Skymaster** or the **Apocalypse** are real pendulums whose motion borders on chaos under forcing. 
- **Science:** Period doubling is not just a curiosity; it is the universal route to chaos observed in fluids, lasers, circuits, and biology.

To study these phenomena, I used two complementary tools:
- **GNU Octave** for controlled, mathematical simulations where every equation is explicit.
- **UDK Unreal Engine 3** for immersive, real-time environments that make chaos *visible* and relatable.

By running these models side by side, I could both **demonstrate the mathematics** of chaos and **ground them in tangible scenarios**. What follows is a journey through oscillators, bifurcations, and rides — from the serene to the unpredictable.


---

## Case Study: Fairground Ride Collapse, Saudi Arabia (July 2025)

In late July 2025, a rotating carousel ride in **Taif, Saudi Arabia** — known locally as *360 Degrees* — collapsed while in motion, injuring over twenty people, several critically. ([Source](https://www.cnn.com/2025/07/31/middleeast/saudi-arabia-fairground-ride-intl))  

Eyewitness accounts described structural elements snapping under load, with riders thrown from the platform. Although full technical details have not yet emerged, this incident highlights the dangers inherent in mechanical rides subjected to dynamic forcing, potentially beyond their design limits.  

This serves as a tragic, real-world analogue to the nonlinear and chaotic behaviors studied in this report. In our models, we explore how parameters like forcing amplitude, damping, and nonlinear stiffness can push a system from stable oscillation toward bifurcation, jump phenomena, and chaos. The Saudi case reminds us: when operating conditions exceed those safe thresholds, the consequences can be severe.  

---

# 2. From Linear to Nonlinear Oscillators

The study of chaos begins with the most familiar building block in physics: the **oscillator**. By gradually adding damping, forcing, and nonlinearities, we can see how simple, predictable motion evolves into complex and eventually chaotic behavior.


Before diving into chaos, I began with familiar oscillators:
- **Linear systems** behaved predictably, with smooth sinusoidal motion.
- **Nonlinear stiffness** introduced subtle distortions.
- Adding **forcing terms** created rich dynamics, leading to bifurcations.

## 2.1 Simple Harmonic Oscillator (SHO)

The simplest case is a **mass on a spring** with no damping and no forcing. Its equation of motion is:

$$
m \ddot{x} + kx = 0
$$

where  
- \(m\) = mass,  
- \(k\) = spring constant,  
- \(x\) = displacement from equilibrium.  

The solution is sinusoidal:

$$
x(t) = A \cos(\omega t + \phi), \quad \omega = \sqrt{\tfrac{k}{m}}
$$


📊 *Octave simulation:*  

```octave
% SHO: simple harmonic oscillator
m = 1; k = 1;
omega = sqrt(k/m);
t = linspace(0, 20, 1000);
x = cos(omega*t);   % amplitude A=1, phase phi=0

plot(t, x);
xlabel('Time'); ylabel('Displacement');
title('Simple Harmonic Oscillator');
```

![Simple harmonic oscillator time series]({{ site.baseurl }}/images/chaotic_timeseries.png)  
*Figure 2. Pure sinusoidal motion of a linear mass-spring system.*

---

## 2.2 Damped Harmonic Oscillator

In reality, no swing or suspension oscillates forever. Energy dissipates through friction or air resistance. Adding damping:

$m \ddot{x} + c \dot{x} + kx = 0$

produces an exponentially decaying response.

- **Light damping** → oscillations slowly fade.
- **Heavy damping** → the system returns to equilibrium without overshoot.

This mirrors how **car suspensions** are designed: enough damping to avoid endless bouncing, but not so much that the ride feels stiff.  

## 2.3 Forced Harmonic Oscillator  

Now imagine a parent periodically pushing a swing, or a road surface vibrating a suspension. A **forcing term** drives the system:  

$m \ddot{x} + c \dot{x} + kx = F \cos(\omega t)$  

This introduces resonance: when the driving frequency matches the natural frequency of the system, oscillations grow large.
This is the tipping point where oscillators start revealing nonlinear behaviors.

Here, \(\beta\) controls nonlinearity, \(c\) is damping, and \(F \cos(\omega t)\) is periodic forcing.

💡 *Insight:* Even small nonlinearities reshape phase portraits and trigger bifurcations.  

---

## 2.4 Nonlinear Oscillator (Duffing model)  

Adding cubic stiffness introduces nonlinearity:  

$m \ddot{x} + c \dot{x} + kx + \beta x^3 = F \cos(\omega t)$  

Here,  
- $\beta$ controls nonlinearity,  
- $c$ is damping,  
- $F \cos(\omega t)$ is periodic forcing.  

Nonlinear terms distort the sinusoidal response:
- Small nonlinearities → subtle frequency shifts.
- Larger nonlinearities → multiple stable states, jumps, and chaos.

This is where **real rides like the Skymaster** start behaving unpredictably: a small change in forcing can suddenly send the system into a different oscillatory regime.  

📊 *Octave simulation:*  

```octave
% Duffing oscillator with forcing
solve_DDHO_Sweep
```

*Figure 2. Duffing oscillator response showing nonlinearity and frequency distortion.*  

---

# 3. Period Doubling and the Route to Chaos  

With the groundwork of oscillators in place, we can now move into the heart of the project: **how predictable motion breaks down into chaos**.  

The most famous path is the **period-doubling route**: a system oscillates once per forcing cycle, then twice, then four times, and so on — until the motion becomes aperiodic and chaotic.  

This phenomenon is not only theoretical: it has been observed in **circuits, fluid flows, lasers, and even biological rhythms**. It provides one of the clearest experimental windows into chaos.

With linear motion understood, I increased forcing strength. The result was **period doubling**:

- At low forcing: period-1 oscillations.  
- Increasing forcing: period-2, period-4 …  
- Eventually, a cascade into chaos.

## 3.1 From Periodic to Chaotic  

Start with a driven nonlinear oscillator. At low forcing amplitudes, the response is **period-1**: one oscillation per drive cycle.  

As the forcing increases, the system undergoes a **bifurcation**: it flips into a **period-2 orbit**, repeating only every two drive cycles.  

This repeats — period-4, period-8 — until the system is no longer periodic at all. The pattern of doubling converges to a universal constant, the **Feigenbaum constant $\delta \approx 4.669$**:  

$\delta = \lim_{n \to \infty} \frac{f_{n} - f_{n-1}}{f_{n+1} - f_{n}}$

\[
\delta = \lim_{n \to \infty} \frac{f_{n} - f_{n-1}}{f_{n+1} - f_{n}} \approx 4.669
\]

Here, \(f_n\) are the parameter values where bifurcations occur.  

This universality means: whether you are studying a **pendulum, a laser, or a Skymaster ride**, the route to chaos follows the same mathematical script.  

---

## 3.2 Bifurcation Diagram  

A bifurcation diagram captures this progression visually.  

📊 *Octave simulation*:

```octave
% Generate bifurcation diagram for the Duffing oscillator
solve_DDHO_Sweep
```

![Bifurcation diagram]({{ site.baseurl }}/images/bifurcation.png)  
*Figure 3. Period doubling route to chaos in a forced Duffing oscillator.*

⚠️ *Note:* This is the Feigenbaum scenario — a universal pattern across many nonlinear systems.  

---

## 3.3 Phase Portraits  

Plotting displacement vs. velocity reveals the shape of motion.  

- Simple oscillations → ellipses.  
- Chaotic dynamics → strange attractors, folding like fractals.  

![Chaotic phase portrait](../../images/chaotic_phase.png)  
*Figure 4. Chaotic dynamics forming a strange attractor.*  

---

## 3.4 Time Series  

Chaos in the time domain:  

![Chaotic time series](../../images/chaotic_timeseries.png)  
*Figure 5. Chaotic time series of the Duffing oscillator.*  

---

# 4. Chaos in the Skymaster Ride  

Equations are powerful, but nothing beats experiencing chaos. Enter the **Skymaster**, a pendulum-style fairground ride.  

The **Skymaster ride**, a giant pendulum, provides the perfect analog to the Duffing oscillator.  

- **Swinging motion** mirrors the forced oscillator.  
- **Pivot forces** provide damping.  
- **Operator input** acts as periodic forcing.  

Inside UDK, I scripted the Skymaster as a forced nonlinear pendulum. As the driving torque was tuned, stable swings gave way to irregular, chaotic motion.  

```unrealscript
// Simplified UnrealScript fragment
simulated function Tick(float DeltaTime) {
    AngularVel += (Torque/Mass - Damping*AngularVel) * DeltaTime;
    Angle += AngularVel * DeltaTime;
}
```

![Skymaster simulation render]({{ site.baseurl }}/images/skymaster.png)
*Figure 4. Skymaster simulation in UDK showing chaotic swing dynamics.*


---

## 4.1 Why the Skymaster?  

Unlike a playground swing:  
- Driven by motors, not just gravity.  
- Nonlinear stiffness from structure and safety.  
- Operates at large amplitudes where dynamics are sensitive.  

---

## 4.2 UDK Implementation

- **`MAS14P_SkyMaster.uc`** defines the mechanics.
- **`SciencePark_Level_Projects2021.udk`** places it in a park environment.
- Motion coded manually, not left to default physics.

---

## 4.3 Results

- Low forcing → gentle swings.
- More forcing → period doubling.
- High forcing → chaotic swings, sensitive to start.

---

# 5. The Apocalypse Ride

The **Apocalypse ride**, a vertical drop-tower, resembles a **driven mass-spring-damper system**.

- **Motors and brakes** add forcing/damping.
- **Structural stiffness** is nonlinear.
- **Energy loss** is uneven.

---

## 5.1 UDK Implementation  

- **`MAS14_Apocalypse_FSM.uc`** models states: lift, pause, drop, rebound.  
- Nonlinearities mean motion is not perfectly periodic.  

![Apocalypse simulation](../../images/apocalypse_render.png)  
*Figure 7. UDK Apocalypse ride simulation — nonlinear tower dynamics.*  

---

# 6. The Jump Phenomenon  

Not all chaos hides in pendulums. In vehicle suspension systems, nonlinear resonance leads to the **jump phenomenon**: sudden amplitude shifts with small parameter changes. 

The **jump phenomenon** occurs when oscillations abruptly change amplitude as parameters shift.  

- Sweep upward → sudden jump to higher amplitude.  
- Sweep downward → hysteresis.  

📊 *Octave simulation:*  

```octave
% Demonstrate jump phenomenon
jump
```

![Jump phenomenon response curve]({{ site.baseurl }}/images/jump_phenomenon.png)
*Figure 5. Jump phenomenon: amplitude vs frequency response showing hysteresis.*

📊 *Observation:* Hysteresis emerges — on sweeping frequency up, the system “jumps” to a higher amplitude branch; sweeping down returns differently.

---

# 7. Comparison of Simulators

To ensure validity, I compared Octave simulations with Unreal Engine models. Results matched qualitatively, though numerical artifacts sometimes shifted bifurcation thresholds.  

💡 *Lesson:* Different solvers emphasize different aspects — Octave excels in clarity, Unreal in visualization.  

---

# 8. Mathematical Insights

Period doubling follows Feigenbaum’s constant \(\delta \approx 4.669\):  

$$
\delta = \lim_{n \to \infty} \frac{f_{n} - f_{n-1}}{f_{n+1} - f_{n}}
$$

This universality links pendulums, circuits, fluids, and more.

---

# 9. Discussion

Chaos is not randomness
- Chaos is **deterministic**, yet unpredictable.  
- Chaos is **universal**, across disciplines.  
- Chaos is **tangible**, in rides, suspensions, and bridges.  

Educationally, rides and suspensions make chaos relatable.  
Engineering-wise, ignoring nonlinearities risks instability.  

---

# 10. Conclusion  

This project traced the path from linear oscillators to chaos:  
- SHO → Duffing → Period Doubling → Chaos  
- Realized in both Octave and Unreal Engine  
- Visualized in rides and resonances
- Jump phenomenon shows abrupt transitions

Chaos is not just theory: it is motion we can plot, simulate, and ride.

---

[⬅ Back to Landing Page]({{ site.baseurl }}/index.html) | [🔗 Back to Repo Root](https://github.com/oospakooysa/period_doubling)
