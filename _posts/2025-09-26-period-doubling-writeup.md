---
layout: post
title: "Period Doubling and a Route to Chaos"
date: 2025-09-26
tags: [chaos, nonlinear dynamics, simulation, octave, unreal-engine]
---

![Hero Image: Bifurcation Diagram](images/bifurcation.png)

> Exploring nonlinear oscillators and chaos through simulation in **UDK Unreal Engine 3** and **GNU Octave**.

# Introduction  

Nonlinear dynamics sits at a fascinating intersection of mathematics and physics: the moment simple models stop being simple.  

In this project, I recreated fairground rides and suspension systems inside simulation environments. By gradually increasing forcing terms, I observed how stable oscillations transition through **period doubling** into **chaos** — the classic Feigenbaum route.  

📌 All simulations were coded manually, rather than relying on built-in physics, to ensure clarity of the underlying math.

---

<details open>
<summary><strong>Table of Contents</strong></summary>

- [Introduction](#introduction)  
- [Modeling the System](#modeling-the-system)  
- [Simulation in UDK](#simulation-in-udk)  
- [Period Doubling Cascade](#period-doubling-cascade)  
- [Chaos and Strange Attractors](#chaos-and-strange-attractors)  
- [The Jump Phenomenon](#the-jump-phenomenon)  
- [Conclusion](#conclusion)  
- [Code and Assets](#code-and-assets)  
- [Appendix – Simulator Comparison](#appendix--simulator-comparison)  

</details>

---

# Modeling the System  

The governing equation is the **damped driven harmonic oscillator (DDHO):**

\[
\ddot{x} + \gamma \dot{x} + \omega_0^2 x = F \cos(\omega t)
\]

In Octave, this is implemented as:

```matlab
% rhs_ddho.m
function dx = rhs_ddho(t, x, params)
  dx = zeros(2,1);
  dx(1) = x(2);   % velocity
  dx(2) = -params.gamma * x(2) ...
           - params.omega0^2 * x(1) ...
           + params.F * cos(params.omega * t);
end
```

---

# Simulation in UDK  

The *SkyMaster* pendulum ride was implemented with custom physics code:  

```uc
// MAS14P_SkyMaster.uc
function Tick(float DeltaTime)
{
    local float torque;
    torque = -Gravity * sin(angle)
             - Damping * angularVelocity
             + DriveAmp * cos(DriveFreq * WorldInfo.TimeSeconds);

    angularVelocity += torque * DeltaTime;
    angle += angularVelocity * DeltaTime;

    logDataRecord(WorldInfo.TimeSeconds, angle, angularVelocity);
}
```

📷 ![SkyMaster pendulum simulation in UDK](images/skymaster_udk.png)

---

# Period Doubling Cascade  

By sweeping the forcing amplitude, oscillations double in period before entering chaos:  

```matlab
% solve_DDHO_Sweep.m (excerpt)
for F = 1:0.01:2
  [t, x] = ode45(@(t,x) rhs_ddho(t,x,params), [0 200], [0;0]);
  peaks = findpeaks(x(:,1));
  plot(F, peaks, '.k');   % build bifurcation diagram
end
```

📷 ![Bifurcation diagram showing period doubling route to chaos](images/bifurcation.png)

---

# Chaos and Strange Attractors  

At certain parameter values, the oscillator enters chaos. This appears in the time series as irregular oscillations:  

📷 ![Chaotic Time Series](images/chaotic_timeseries.png)  

And in the phase plane as a folded chaotic attractor:  

📷 ![Chaotic Phase Portrait](images/chaotic_phase.png)  

Even small changes to the starting angle in UDK produced wildly different ride behavior, directly visualizing **chaos in action**.  

---

# The Jump Phenomenon  

Nonlinear systems can also exhibit sudden “jumps” between stable and unstable regions. This was captured using the `jump.m` script:  

```matlab
% jump.m
plot(driveAmp, peakPeriods, 'o-');
xlabel('Driving Amplitude');
ylabel('Oscillation Period');
title('Jump Phenomenon in Nonlinear Oscillator');
```

📷 ![Jump Phenomenon in Nonlinear Oscillator](images/jump_phenomenon.png)

---

# Conclusion  

Through simulation and analysis, I demonstrated:  

- **Period doubling** as a universal route to chaos  
- **Chaotic attractors** emerging from simple pendulum models  
- **Real-world implications** (e.g. unsafe g-forces in rides)

This project bridges theory, simulation, and engineering safety, showing how mathematics of chaos plays out in physical systems.  

---

# Code and Assets  

All supporting files are available in this repository:

- Octave scripts for solvers, sweeps, and plots
- UnrealScript classes for UDK simulations
- Level assets for the Science Park demo

👉 [View the repository here](#)

---

# Appendix – Simulator Comparison  

*(Optional, moved here for focus in the main article)*

- **UDK** provided immersive 3D simulations, but required custom physics.
- **Webots** offered easier integration with Octave but was limited to robotics-focused assets.

📷 ![Side-by-side comparison of UDK vs Webots](images/simulator_comparison.png)
