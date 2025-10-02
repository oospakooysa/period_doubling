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

To keep things grounded, we will use:  
- **real-world analogies** (fairground rides, suspension systems),  
- **Octave code and simulations**, and  
- **plots and diagrams** that make the transition into chaos visible.

The goal is to show how a path that begins with simple, predictable motion eventually unfolds into the rich — and sometimes dangerous — dynamics of chaos.


---

## 2. Simple Systems and Verification

Before diving into chaos, we first **verify** our tools.

### 2.1 The Apocalypse Ride
A 1D dynamic system, where a car free-falls from 54 m before braking at ~6 m.
We modelled the ride in Octave, observing the velocity and displacement over time.

*Key insight:* The braking distance relates to gravitational force via:

```
h₁ = (mg / B) * h₂
```

$$
h₁ = \frac{mg}{B} \cdot h₂
$$

Graphs of velocity and acceleration confirm when braking occurs (~10.2s) and how deceleration peaks.

| ![Apocalypse Ride Velocity]({{ site.baseurl }}/images/apocalypse_velocity.png) | ![Apocalypse Ride Acceleration]({{ site.baseurl }}/images/apocalypse_accel.png) |
|---|---|
| *Velocity vs. time — steady fall, then braking.* | *Acceleration vs. time — deceleration peak.* |

---

### 2.2 Monster Truck Suspension
Here we verified solvers. Euler vs Euler-Cromer gave clear differences: Euler diverges, while Euler-Cromer preserves stable oscillations.

- **Euler method** → diverges, energy not conserved.  
- **Euler–Cromer** → stable oscillations, energy preserved. 

| ![Suspension Euler]({{ site.baseurl }}/images/suspension_euler.png) | ![Suspension Cromer]({{ site.baseurl }}/images/suspension_cromer.png) |
|---|---|
| *Euler method diverging — unstable motion.* | *Euler–Cromer method conserving energy.* |

Validation against experimental data showed errors < 10%, confirming the model.

---

### 2.3 Exact Verification (Analytical vs Numerical)
Finally, we compared numerical solutions directly against the analytical small-angle pendulum.  
For fine step sizes (Δt = 0.01), the agreement is excellent.  
But for coarser timesteps, numerical error grows dramatically — reaching about **54% error**.

| <img src="{{ site.baseurl }}/images/verification_exact.png" alt="Verification by exact measurement (error percentage)" width="80%"> |
|-----------------------------------------------------------------------------------------------------------------------------------|
| *Verification by Exact Measurement – Numerical solution shows ~54% error at large Δt compared to the analytical solution.* |

**Takeaway:** With careful solver choice and step size, our tools reproduce real physics accurately.  
This gives us confidence to apply them to nonlinear and chaotic systems in later sections.

---

## 3. Linear vs Nonlinear Oscillators

Before exploring forcing and bifurcations, it helps to compare **linear** and **nonlinear** oscillators.  
This contrast highlights why nonlinear systems can behave so differently from their linear counterparts.

---

### 3.1 General Principles (Teaching / Theory)

We can compare the governing equations directly:

- **Linear oscillator (simple harmonic motion):**  
  $$
  \ddot{x} + \omega^2 x = 0
  $$
  - Produces clean sinusoidal motion.  
  - Frequency is fixed and independent of amplitude.  

- **Nonlinear oscillator (with cubic stiffness term):**  
  $$
  \ddot{x} + \omega^2 x + \beta x^3 = 0
  $$
  - Restoring force depends on amplitude.  
  - Frequency shifts with amplitude.  
  - Motion can distort, generate harmonics, or become unstable.  

We can compare the governing equations directly:

| Linear oscillator (simple harmonic motion) | Nonlinear oscillator (with cubic stiffness) |
|--------------------------------------------|---------------------------------------------|
| $ \ddot{x} + \omega^2 x = 0 $              | $ \ddot{x} + \omega^2 x + \beta x^3 = 0 $   |
| Clean sinusoidal motion                    | Frequency depends on amplitude               |
| Fixed period, independent of amplitude     | Harmonics and distortions possible           |

**Key difference:**  
- **Linear oscillator** → guaranteed predictability, sinusoidal motion, frequency independent of amplitude.  
- **Nonlinear oscillator** → amplitude-dependent frequency, distorted oscillations, and the possibility of bifurcations and chaos.
Linearity guarantees *predictability and simplicity*. Nonlinearity breaks this, opening the door to richer — and potentially chaotic — behaviour.

---

![Placeholder: Linear vs Nonlinear equations side-by-side]({{ site.baseurl }}/images/linear_vs_nonlinear.png)

*Figure: Conceptual comparison of the linear and nonlinear governing equations. The nonlinear case adds the cubic stiffness term, breaking superposition and introducing amplitude-dependent dynamics.*


---

### 3.2 Applying the Model (Your Simulations)

#### Linear Oscillator (Test A)

Simulation shows the textbook case:  
- **Time series:** pure sinusoidal motion.  
- **Phase plane:** a perfect closed ellipse.  
- **Spectrum:** one sharp peak at 0.158 Hz (period 6.28

| <img src="{{ site.baseurl }}/images/linear1.png" alt="Linear oscillator time series" width="80%"> |
|--------------------------------------------------------------------------------------------------|
| **Time series:** Clean sinusoidal motion with constant amplitude |

| <img src="{{ site.baseurl }}/images/linear2.png" alt="Linear oscillator phase plane" width="80%"> | <img src="{{ site.baseurl }}/images/linear3.png" alt="Linear oscillator spectrum" width="80%"> |
|--------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| **Phase plane:** Perfect closed ellipse — hallmark of linear harmonic motion | **Spectrum:** Single sharp frequency peak at 0.158 Hz (period = 6.28 s) — no distortion or harmonics |

- Results:  
  - **Period = 6.28 s**  
  - **Frequency = 0.158 Hz**  

> **Summary**: The linear oscillator produces clean sinusoidal motion with a fixed period, independent of amplitude.

---

#### Nonlinear Oscillator — Soft Spring (β < 0)

Here the restoring force weakens with displacement.  

| <img src="{{ site.baseurl }}/images/softspring01.png" alt="Soft spring time series" width="80%"> |
|--------------------------------------------------------------------------------------------------|
| *Time series – soft spring (longer oscillation period than linear)* |

| <img src="{{ site.baseurl }}/images/softspring03.png" alt="Soft spring phase plane" width="80%"> | <img src="{{ site.baseurl }}/images/softspring02.png" alt="Soft spring spectrum" width="80%"> |
|--------------------------------------------------------------------------------------------------|--------------------------------------------------------------------------------------------------|
| *Phase plane – elliptical orbit distorted by softening nonlinearity* | *Spectrum – harmonics and subharmonics present* |

Results:  
- **Time series:** longer oscillation period than the linear case.  
- **Phase plane:** ellipse visibly distorted.  
- Spectrum: **two harmonics** appear, indicating distortion from sinusoidal motion.
- Velocity range: **~0 to 1.4** (slightly reduced compared to linear ~0 to 1.5).  
- Lower velocity → **longer period** than the linear case.  

> **Summary**: The soft spring stretches the oscillation period and introduces harmonics.

---

#### Nonlinear Oscillator — Hard Spring (β > 0)

Here the restoring force stiffens with displacement.

| <img src="{{ site.baseurl }}/images/hardspring01.png" alt="Hard spring time series" width="80%"> |
|-------------------------------------------------------------------------------------------------|
| *Time series – hard spring (shorter oscillation period, stiff response)* |

| <img src="{{ site.baseurl }}/images/hardspring02.png" alt="Hard spring phase plane" width="80%"> | <img src="{{ site.baseurl }}/images/hardspring03.png" alt="Hard spring spectrum" width="80%"> |
|-------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------|
| *Phase plane – diamond-like orbit, showing stiffening effect* | *Spectrum – strong higher harmonics due to hardening* |

Results:  
- **Time series:** shorter period than the linear case.  
- **Phase plane:** orbit sharpens into a diamond-like shape.  
- **Spectrum:** higher harmonics appear strongly.
-  **shorter period**.
- Velocity and frequency are both **greater** than in the linear case.  

> **Summary**: The hard spring compresses the oscillation period and introduces harmonics.

#### Comparison Table

| Oscillator type | Period (s)       | Frequency (Hz) | Velocity range | Spectrum features     |
|-----------------|------------------|----------------|----------------|-----------------------|
| **Linear**      | 6.28 (fixed)     | 0.158          | ~0 to 1.5      | Single fundamental    |
| **Soft spring** | Longer than 6.28 | < 0.158        | ~0 to 1.4      | Two harmonics present |
| **Hard spring** | Shorter than 6.28| > 0.158        | > linear case  | Two harmonics present |

---

### 3.3 Lessons from Linear vs Nonlinear Oscillators

- **Linear systems**: predictable, fixed frequency, clean sinusoidal motion (6.28 s / 0.158 Hz).  
- **Soft spring systems**: longer periods, lower velocities, harmonic distortion.  
- **Hard spring systems**: shorter periods, higher velocities, harmonic distortion.  

This contrast sets the stage for later sections: once **forcing** is added (Section 4), nonlinear systems can undergo bifurcations and eventually chaos.

---

## 4. Forced Oscillators & Chaos (Ueda’s Equation)

So far we have compared linear and nonlinear oscillators under simple conditions.  
When we add **external forcing**, however, a new level of complexity emerges.  
One famous example is **Ueda’s equation**, a nonlinear forced oscillator that shows how periodic driving can create chaotic motion.

---

### 4.1 The Model (Teaching / General Case)

When external forcing is added, we model the system as a forced, damped, nonlinear oscillator:

$$
\ddot{x} = -\delta \dot{x} - \beta x^{3} + F\cos(\omega t)
$$

- \(\delta\) — damping coefficient (dissipation).  
- \(\beta\) — nonlinear stiffness coefficient (cubic restoring term).  
- \(F\) — forcing amplitude.  
- \(\omega\) — driving angular frequency.

**Why this matters:**  
- The cubic term makes the restoring force amplitude-dependent.  
- With periodic forcing, the system can:
  - lock onto the drive (period-1),
  - lock to a submultiple (subharmonic, e.g. period-2),
  - or become chaotic.

#### Detecting behaviour numerically
1. **Time series + FFT spectrum** — subharmonics appear at \(\omega/2, \omega/4,\dots\).  
2. **Poincaré map** — sample \(x(t)\) every period \(T = 2\pi/\omega\).  
   - Period-1 → one point.  
   - Period-2 → two points.  
   - Chaos → many scattered points.  
3. **Phase plane** — closed loops for periodic motion, strange attractors for chaos.  

#### Example MATLAB/Octave code (general tool)

```matlab
% Forced nonlinear oscillator (Ueda-type)
function dxdt = forced_nonlinear(t, x, delta, beta, F, omega)
  dxdt = [x(2);
          -delta*x(2) - beta*x(1)^3 + F*cos(omega*t)];
end

% Parameters (replace with your values)
delta = 0.05; beta = 1.0; F = 0.8; omega = 1.2;

% Integrate
[t, y] = ode45(@(t,x) forced_nonlinear(t,x,delta,beta,F,omega), [0 2000], [0.1;0]);

% Trim transients
cut = floor(length(t)/2);
t_ss = t(cut:end); x_ss = y(cut:end,1); xdot_ss = y(cut:end,2);

% Plots: time series, spectrum, Poincaré, phase plane
figure; plot(t_ss, x_ss); title('Time series');
N=length(x_ss); dt=t_ss(2)-t_ss(1);
Xf=abs(fft(x_ss)); freqs=(0:N-1)/(N*dt);
figure; plot(freqs(1:N/2), Xf(1:N/2)); title('Spectrum');

T = 2*pi/omega;
poincare=[]; for n=1:floor((t_ss(end)-t_ss(1))/T)
  tn=t_ss(1)+n*T; [~,i]=min(abs(t_ss-tn)); poincare(end+1)=x_ss(i);
end
figure; plot(poincare,'.'); title('Poincaré map');

figure; plot(x_ss, xdot_ss); title('Phase plane');
```

---

### 4.2 Applying the Model (Your Simulation)

Using the same equation, we performed simulations with increasing forcing amplitude \(F\).  
The results show the transition from periodic motion to subharmonics and eventually chaos.

- **At low forcing (F small):** Periodic response, system locks to the drive.  
- **At intermediate forcing:** Subharmonics appear — oscillations repeat only after 2T, 4T, …  
- **At high forcing:** Chaotic response with irregular time series and fractal Poincaré maps.

| <img src="{{ site.baseurl }}/images/ueda1a.png" width="80%"> | <img src="{{ site.baseurl }}/images/ueda1b.png" width="80%"> |
|-------------------------|-------------------------|
| *Ueda – low drive time series* | *Ueda – low drive phase plane* |

| <img src="{{ site.baseurl }}/images/ueda2a.png" width="80%"> | <img src="{{ site.baseurl }}/images/ueda2b.png" width="80%"> |
|-------------------------|-------------------------|
| *Ueda – intermediate forcing (time series)* | *Ueda – intermediate forcing (phase plane)* |

| <img src="{{ site.baseurl }}/images/ueda3a.png" width="80%"> | <img src="{{ site.baseurl }}/images/ueda3b.png" width="80%"> |
|-------------------------|-------------------------|
| *Ueda – chaotic time series* | *Ueda – chaotic phase plane* |

> **Summary:**  
> - Low forcing → clean periodic motion.  
> - Moderate forcing → subharmonics and irregular loops.  
> - High forcing → chaotic attractor, deterministic but unpredictable.

---

### 4.3 Lessons from Ueda’s Oscillator

Ueda’s equation shows how **external driving** interacts with **nonlinearity** to produce chaos.  
This transition mirrors the behaviour we later observe in real systems like the **SkyMaster ride**, where forcing from motors translates into irregular — and potentially unsafe — motion.  
In both cases, forcing is the **gateway to chaos**.

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
| **Time series:** Stable single oscillation  | **Phase plane:** Single closed loop — limit cycle  |
| ![Period 1 Spectrum]({{ site.baseurl }}/images/period1c.png) | ![Period 1 Return Map]({{ site.baseurl }}/images/period1d.png) |
| **Spectrum:** Single sharp peak — pure periodic motion     | **Return map:** One fixed point — system repeats identically   |

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
| **Time series:** Oscillation doubles its period (two distinct peaks)  | **Phase plane:** Two separate loops, showing the doubled cycle  |
| <img src="{{ site.baseurl }}/images/period2c.png" width="80%"> | <img src="{{ site.baseurl }}/images/period2d.png" width="80%">                            |
| **Spectrum:** Additional frequency components appear (subharmonic)     | **Return map:** Two distinct points — system alternates between them   |

- **Time series**: Two alternating amplitudes.  
- **Phase plane**: The trajectory alternates between two loops.  
- **Spectrum**: Peaks appear at half the fundamental frequency.  
- **Return map**: Two distinct points.  

> **Summary**: The first doubling — the system now needs two cycles to repeat.

---

### Period-4 Oscillations (γ = 1.081)

Further increase in driving strength leads to another bifurcation: **Period-4 motion**.

| <img src="{{ site.baseurl }}/images/period4a.png" width="80%"> | <img src="{{ site.baseurl }}/images/period4b.png" width="80%"> |
|---------------------------|---------------------------|
| **Time series:** Four-cycle visible in the oscillation pattern  | **Phase plane:** Four distinct loops — evidence of another bifurcation  |
| <img src="{{ site.baseurl }}/images/period4c.png" width="80%"> | <img src="{{ site.baseurl }}/images/period4d.png" width="80%">                            |
| **Spectrum:** Richer structure with more harmonics     | **Return map:** Four distinct points — system cycles through four states     |

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
| **Time series:** Eight-cycle, motion appears increasingly complex  | **Phase plane:** Eight small loops crowding together — precursor to chaos  |
| ![]({{ site.baseurl }}/images/period8c.png) | ![]({{ site.baseurl }}/images/period8d.png) |
| **Spectrum:** Broadband structure beginning to emerge     | **Return map:** Eight points converge toward a continuous band — onset of chaotic motion   |

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

![]({{ site.baseurl }}/images/skymaster1c.png) |
|------------------------------|
| *SkyMaster – g-force profile* |

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

The journey from simple oscillations to chaos reveals a universal story in nonlinear dynamics.  
Through successive bifurcations, stable motion doubles in complexity until it becomes chaotic — a process governed by the **Feigenbaum constant** (δ ≈ 4.669).  
This constant is not just a mathematical curiosity but a marker of universality: it appears in many different systems, from equations on paper to machines in motion.

In the controlled setting of simulations, period doubling highlights the elegance of nonlinear mathematics.  
But in real-world systems — like the **SkyMaster ride** — these same dynamics carry direct consequences.  
As the drive grows, oscillations amplify, g-forces spike, and motion slips into **rolling chaotic motion**.  
At this stage, prediction and control become unreliable, and what begins as an abstract route to chaos becomes a **safety challenge** for engineering.

> **Key message:** Chaos is not only a mathematical destination but also a human experience.  
> The Feigenbaum constant links theory to practice, showing how universal dynamics shape both the behaviour of equations and the safety of rides.

Ultimately, studying period doubling gives us two perspectives:  
- A **theoretical lens**, where universality and constants reveal the hidden order of chaos.  
- A **practical lens**, where oscillations and g-forces remind us that real systems — and real people — live with the consequences of nonlinear motion.


- We began with simple oscillators → added nonlinear springs → forced systems → period doubling → chaos.  
- Verification steps ensured our models matched reality.  
- Applications like the Skymaster ride show that chaos isn’t just theoretical: it has real engineering and safety implications.  

For a lighter introduction, check the [overview site](https://oospakooysa.github.io/period_doubling/). For those who want the deep dive—you just read it.

---

*Figures and data from Octave, UDK, Webots, and detailed analysis in the original Physics study.*
