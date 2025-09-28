# UDK Code for Period Doubling Project

This folder contains Unreal Development Kit (UDK) scripts and level files used in the **Period Doubling and a Route to Chaos** project. These assets reproduce the ride simulations described in the writeup.

## Included Files

| Filename | Purpose / Description |
|---|------------------------------|
| `MAS14P_SkyMaster.uc` | UnrealScript file implementing the **Skymaster ride** dynamics and control logic. |
| `MAS14_Apocalypse_FSM.uc` | UnrealScript finite-state machine for the **Apocalypse ride**. |
| `SciencePark_Level_Projects2021.udk` | UDK level file that integrates the Skymaster and Apocalypse rides into a virtual environment. |

## Usage Instructions

1. Download and install **UDK (2015-01 release)**:  
   👉 [UDKInstall-2015-02.exe (archive.org)](https://archive.org/download/udkinstall-2015-02)

   The default installation path will look like:
C:\UDK\UDK-2015-01


2. Copy the `.uc` files into the **Classes folder**:
C:\UDK\UDK-2015-01\Development\Src\MAS14\classes


3. Copy the `.udk` level file into the **Content folder**:
C:\UDK\UDK-2015-01\UDKGame\Content\MAS_SciencePark

4. Rebuild scripts inside the UDK editor so the new classes compile.  

5. Open **SciencePark_Level_Projects2021.udk** in the UDK editor.  

6. Run the simulation to view the Skymaster and Apocalypse rides in action.

## Notes

- These UDK assets complement the Octave simulations. Where Octave demonstrated the *mathematical dynamics* (period doubling, bifurcations, jump phenomenon), the UDK files place those same dynamics into an **immersive, interactive environment**.
- Small differences may appear between UDK physics and Octave results, which is discussed in the writeup under simulator comparisons.

---

## Related Links

- [Octave Scripts](../octave) — numerical models and bifurcation diagrams.  
- [Project Writeup](https://oospakooysa.github.io/period_doubling/2025/09/26/period-doubling-writeup.html)  



