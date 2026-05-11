# Boeing 737-300 Flight Mechanics & Performance Analysis ✈️

This repository contains a comprehensive aircraft performance study of the **Boeing 737-300** commercial airliner. By integrating classic aerodynamics, turbofan engine performance modeling (CFM56-3B1), and flight mechanics equations, this project simulates the aircraft's behavior across different mission profiles, weights, and altitudes.

This project was developed within the 3rd-year Flight Mechanics (*Mecánica del Vuelo*) curriculum at the *Universidad Politécnica de Madrid (ETSIAE)*.

---

##  Key Features & Simulated Phases

* **Aerodynamic Polar Estimation:** Formulates the incompressible parasite drag coefficient ($C_{D0} = 0.0191$) and Oswald efficiency factor ($e = 0.766$), extending the model into the compressible drag-rise regime for Mach numbers beyond critical Mach ($M > M_c$).
* **Flight Envelope Solver:** Iteratively intersects the thrust required against the thrust available across 400 altitudes to plot the boundaries of stable and unstable steady level flight ($V_{min}$ and $V_{max}$).
* **Takeoff & Landing Performance:** Calculates ground roll ($S_g$) and airborne distances ($S_a$) for three distinct weight configurations under standard sea-level and ISA conditions.
* **Payload-Range Diagram:** Generates the payload-range chart mapping the maximum payload capacity ($MPL = 16,148 \text{ kg}$) to fuel capacity limits to estimate absolute range boundaries.
* **Climb Performance & Ceilings:** Models maximum rate of climb ($R/C_{max}$), time-to-climb, and determines the theoretical and service ceilings of the aircraft.
* **Sustained Coordinated Turns:** Evaluates maneuverability boundaries in the horizontal plane, analyzing load factors ($n$) and bank angles ($\phi$).

---

##  Aircraft Specifications (Boeing 737-300 Model)

The simulations are built upon the authentic geometry and power plant parameters of the Boeing 737-300:

### General Geometry
* **Wingspan ($b$):** $28.88 \text{ m}$
* **Wing Area ($S$):** $105.4 \text{ m}^2$
* **Aspect Ratio ($AR$):** $7.92$
* **Sweep Angle ($\Lambda_{c/4}$):** $25^\circ$

### Propulsion (2x CFM56-3B1 Turbofans)
* **Takeoff Thrust ($T_{max}$):** $90 \text{ kN}$ per engine
* **Cruise Specific Fuel Consumption (SFC):** $0.685 \text{ kg/kg}\cdot\text{h}$
* **Bypass Ratio (BPR):** $5:1$

### Reference Weights
* **Operating Empty Weight (OEW):** $31,479 \text{ kg}$
* **Maximum Takeoff Weight (MTOW):** $56,472 \text{ kg}$
* **Maximum Landing Weight (MLW):** $51,710 \text{ kg}$
* **Maximum Fuel Weight (MFW):** $16,141 \text{ kg}$

---

##  Simulated Scenarios & Weight Configurations

To analyze performance sensitivity, all calculations are evaluated under the Standard Atmosphere model (ISA) across three operational mass setups:

1. **Configuration 1 ($TOW_1 = \text{MTOW}$):** Maximum authorized takeoff mass ($56,472 \text{ kg}$).
2. **Configuration 2 ($TOW_2$):** Representative medium loading conditions ($46,010.1 \text{ kg}$) comprising $\text{OEW} + 60\%\text{MPL} + 30\%\text{MFW}$.
3. **Configuration 3 ($TOW_3$):** Heavy range-optimized payload distribution ($50,851 \text{ kg}$) defined by $\text{OEW} + 40\%\text{MPL} + 80\%\text{MFW}$.

---

##  Sample Results & Performance Metrics

### 1. ICAO Aircraft Classification (OACI 8168)
Using the Maximum Landing Weight (MLW) to determine the aircraft's threshold speed ($V_{at} = 1.3 \cdot V_{stall}$):
* **Stall Speed ($V_{stall}$):** $58.87 \text{ m/s} \approx 211.93 \text{ km/h}$
* **Reference Speed ($V_{at}$):** $275.51 \text{ km/h}$
* **ICAO Category:** **Category D**

### 2. Theoretical Climb Ceilings
By tracking the maximum rate of climb ($R/C_{max} = 0$) across altitudes, the theoretical ceiling was found to be:
* **For MTOW ($56,472 \text{ kg}$):** $11,608 \text{ m}$
* **For TOW2 ($46,010.1 \text{ kg}$):** $12,549 \text{ m}$

### 3. Takeoff Performance (Standard Runway, ISA Sea-Level)
* **At MTOW ($56,472 \text{ kg}$):** Ground Roll ($S_g = 2880.9 \text{ m}$) + Air Distance ($S_a = 238.9 \text{ m}$) $\implies$ **Total Takeoff Distance: $3,119.9 \text{ m}$**.
* **At TOW2 ($46,010.1 \text{ kg}$):** Ground Roll ($S_g = 1733.3 \text{ m}$) + Air Distance ($S_a = 215.9 \text{ m}$) $\implies$ **Total Takeoff Distance: $1,949.2 \text{ m}$**.

---

##  Installation & Execution

The numerical core is written in Python/MATLAB and relies on standard scientific libraries.

```bash
# Clone the repository
git clone [https://github.com/YOUR_USERNAME/boeing-737-flight-mechanics.git](https://github.com/YOUR_USERNAME/boeing-737-flight-mechanics.git)
cd boeing-737-flight-mechanics

# Install requirements (if running Python)
pip install numpy matplotlib scipy
