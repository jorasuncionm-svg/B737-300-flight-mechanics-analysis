# Boeing 737-300 Flight Mechanics & Performance Simulator (MATLAB) ✈️

This repository contains a flight mechanics simulator for the **Boeing 737-300** airliner. Developed in **MATLAB**, the suite models the aerodynamic polar, ISA atmosphere, and turbofan engine performance (2x CFM56-3B1) to evaluate flight envelopes, climb rates, glides, ceilings, and coordinated turn limits across multiple weight configurations.

This project was developed for the 3rd-year Flight Mechanics (*Mecánica del Vuelo*) course at the *Universidad Politécnica de Madrid (ETSIAE)*.

---

##  Key Features & Physical Modeling

* **Standard Atmosphere Model:** Evaluates density ($\rho$) and temperature ($T$) up to and beyond the tropopause ($11,000\text{ m}$) using exact hydrostatic relations (`calculadoradensidad.m`).
* **Compressible Aerodynamic Polar:** Formulates incompressible parasite drag and models compressible drag-rise (wave drag $C_{D,\text{wave}}$) for Mach numbers exceeding $M_c = 0.8$ (`calculadora_empuje_necesario_mio.m`).
* **Flight Envelope Boundaries:** Computes the minimum and maximum steady level flight speeds ($V_{\min}$, $V_{\max}$) by intersecting thrust required against available turbofan thrust (`Archivoprincipal_V1.m`).
* **Climb & Glide Mechanics:** Simulates rates of climb (`velocidadascensional.m`) and glide angles (`velocidadplaneo.m`) across altitudes and configurations to determine the aircraft's physical service ceilings.
* **Maneuverability Limits:** Resolves sustained coordinated turns in the horizontal plane by limiting the load factor ($n$) via both maximum engine thrust and stall margins (`calculadora_nmax_empuje.m`, `calculadora_nmax_vstall.m`).

---

##  Aircraft Parameter Specifications

The simulator uses the official physical and mass properties of the Boeing 737-300:

### Mass Configurations (from `Archivoprincipal_V1.m`)
* **Maximum Takeoff Weight (MTOW):** $56,472 \text{ kg}$
* **Maximum Landing Weight (MLW):** $51,710 \text{ kg}$
* **Operating Empty Weight (OEW):** $31,479 \text{ kg}$
* **Maximum Payload Weight (MPLW):** $16,148 \text{ kg}$
* **Usable Fuel Weight (UFW):** $16,141 \text{ kg}$
* **Evaluated Weight Cases:**
  * **Config 1 (Heavy / MTOW):** $56,472 \text{ kg}$
  * **Config 2 (Medium / Mixed):** $46,010.1 \text{ kg}$
  * **Config 3 (Alternate Heavy):** $50,851 \text{ kg}$

### Propulsion (2x CFM56-3B1 Turbofans)
* **Sea Level Thrust ($T_{\text{SL}}$):** $2 \times 82.29 \text{ kN}$ (`empujedisponible.m`).
* **Thrust Lapse Model:** Accounts for velocity effects ($\text{Mach}$) and atmospheric density ratio ($\sigma = \rho/\rho_0$) matching high-bypass engine thermodynamics.

---

##  Mathematical Formulation

### 1. Drag and Wave Drag Penalty ($M \ge M_c$)
When the flight speed reaches transonic regimes, compressibility is modeled with a wave drag exponent dependent on the effective aspect ratio ($AR_{\text{eff}}$) and the wing sweep angle ($\Lambda_{\text{LE}} = 28^\circ$):

$$C_{D} = C_{D0} + k \cdot C_L^2 + C_{D,\text{wave}}$$

$$C_{D,\text{wave}} = 0.35 \times 10^{-3} \left( \frac{10(M - M_c)}{\frac{1}{\cos(\Lambda_{\text{LE}})} - M_c} \right)^n \quad \text{where} \quad n = \frac{3}{1 + \frac{1}{AR_{\text{eff}}}}$$

### 2. Turn Mechanics (Load Factor $n$)
The maximum load factor in a sustained turn is constrained by two physical boundaries:
* **Stall Limit:** $n_{\text{stall}} = \frac{V^2 \cdot \rho \cdot C_{L,\max}}{2 \cdot (W/S)}$
* **Propulsion Limit:** $n_{\text{thrust}} = \sqrt{ \left(\frac{q}{k \cdot (W/S)}\right) \left( \frac{T}{W} - q \cdot \frac{C_{D0}}{W/S} \right) }$

---

##  Codebase Architecture

The repository is organized as follows:

```text
├── Archivoprincipal_V1.m            # Main script running the simulator & plotting envelopes
├── calculadoradensidad.m           # 1976 Standard Atmosphere model solver (rho, Temp)
├── calculadoramach.m               # Converts true airspeed (TAS) to Mach number
├── empujedisponible.m              # CFM56-3B1 altitude & velocity thrust lapse model
├── calculadora_empuje_necesario_mio.m # Solves total drag (incompressible & transonic wave drag)
├── velocidadascensional.m          # Analyzes rate of climb (R/C) and ceilings
├── velocidadplaneo.m               # Evaluates glide performance and descent slopes
├── vperdida.m                      # Simulates stall speed limits for Takeoff and Landing
├── calculadora_nmax_empuje.m       # Computes load factor turn limit based on thrust
└── calculadora_nmax_vstall.m       # Computes load factor turn limit based on airfoil stall
