---
layout: default
title: "Period Doubling and a Route to Chaos"
---

# Period Doubling and a Route to Chaos  

<p align="center">
  <img src="{{ site.baseurl }}/images/bifurcation.png"
       alt="Bifurcation Diagram"
       style="max-width:600px; width:100%; height:auto;" />
  <i>Figure 1. Bifurcation diagram illustrating the transition from periodic motion to chaos.</i>
</p>

Welcome! This project explores how simple oscillators evolve into **chaotic motion**.  
Using both **GNU Octave** and **Unreal Engine (UDK)**, I recreated nonlinear systems — from mass-spring oscillators to fairground rides — to make the **period-doubling route to chaos** visible and intuitive.  

---

## Explore the Project

- 🌍 [Popular Abstract]({{ site.baseurl }}/2025/09/26/period-doubling-summary-popular.html)  
  *An accessible overview for general readers.*  

- 📑 [Research Abstract]({{ site.baseurl }}/2025/09/26/period-doubling-summary-research.html)  
  *A concise, technical summary for a scientific audience.*

- 📘 [Full Report]({{ site.baseurl }}/2025/09/26/period-doubling-writeup.html)  
  *A complete narrative with math, simulations, and figures.*  

- 🔍 [Deep Dive: Period-Doubling and Chaos]({{ site.baseurl }}/2025/09/29/deep-dive-period-doubling.html)  
  *A detailed walkthrough with images, simulations, and extended analysis.*

- 💻 [Project Code](https://github.com/oospakooysa/period_doubling/tree/main/code)  

---

## Repository  

📂 [View the full repository on GitHub](https://github.com/oospakooysa/period_doubling)  

---

## Featured Blog Posts  

✨ Below are selected blog posts. For the full list, scroll further down.  

<ul style="list-style-type: none; padding-left: 0;">
  <li>
    🔍 <a href="{{ site.baseurl }}/2025/09/29/deep-dive-period-doubling.html">Deep Dive: Period-Doubling and Chaos</a>
    <span style="color: gray;">(2025-09-29)</span>
  </li>
</ul>

---

## All Blog Posts

<ul>
  {% for post in site.posts %}
    <li>
      <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
      <span style="color: gray;">({{ post.date | date: "%Y-%m-%d" }})</span>
    </li>
  {% endfor %}
</ul>



<!-- MathJax Support -->
<script>
  MathJax = {
    tex: {
      inlineMath: [['$', '$'], ['\\(', '\\)']],
      displayMath: [['$$','$$'], ['\\[','\\]']]
    }
  };
</script>
<script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js" async></script>
