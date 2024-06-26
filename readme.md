# 🌡️ Thermal Mixing System README 🌡️

Welcome to the **Thermal Mixing System** repository. This document provides comprehensive information on our advanced thermal mixing system, designed for precise temperature control and efficient thermal management.

## 📚 Overview

This system incorporates:
- 🔥 **One hot stream**
- ❄️ **One cold stream**
- 🔄 **A single outlet stream**

These streams are introduced into a mixing chamber where they combine to reach a target temperature. Our design focuses on achieving optimal performance and efficiency.

## ⚙️ How It Works

1. **Hot Stream Inlet**: Introduces the heated fluid into the system.
2. **Cold Stream Inlet**: Introduces the cooled fluid into the system.
3. **Mixing Chamber**: The area where hot and cold streams mix to achieve the desired temperature.
4. **Outlet Stream**: The mixed fluid exits the system at the target temperature.

## 🔑 Key Parameters

The performance of our thermal mixing system is influenced by several critical parameters:

- 🌡️ **Temperature of Hot Stream**
- 🌡️ **Temperature of Cold Stream**
- 🚰 **Flow Rates of Both Streams**
- 🛠️ **Design of the Mixing Chamber**
- 🎛️ **Control Mechanisms**

Understanding and adjusting these parameters allows for precise control of the outlet temperature.

## 🚀 Getting Started

To begin using the thermal mixing system, follow these steps:

1. **Clone the Repository**:
   ```bash
   git clone [https://github.com/yourusername/thermal-mixing-system.git
   cd thermal-mixing-system](https://github.com/poorani-muthu/Thermal_Mixing)
   ```
2. **Explore the Code**: Key files to review in the `src` folder:
   - `TM_openloop.m`
   - `State_space.m`
   - `PIDtune.m`
   - `PID_TM.m`
   - 'MPC_Thermal_mixing.m'

3. **Run the Simulation**:
   ```bash
   python main.py
   ```

## 🔬 Experiment and Tweak

This system is designed for experimentation. Adjust parameters and configurations to achieve the desired thermal output. Modify the temperatures of the hot and cold streams or alter the flow rates to see how these changes affect the output.

## 📖 **Variables and Parameter Explanations**
wh-- hot stream flow rate kg/s 
wc-- cold stream flow rate kg/s

T-- outlet stream temperature (K)
h-- height of fluid in tank (m)

g = 9.81; %m/s^2
 
A = 1; %m^2 cross sec area
Th = 350; %K hot stream temperature
Tc = 273; %K cold stream temperature
rho = 1; % kg/m3 density of all stream fluids assumed to be constant 

wh=4;
wc=6;

## 🤝 Contributing

We welcome contributions. To contribute:

1. Fork the repository.
2. Make your changes.
3. Submit a pull request.

Your contributions help improve the system.

## 🛠️ Support

For support, open an issue or contact us at [rsmpoorani@gmail.com](mailto:rsmpoorani@gmail.com).

## 🙏 Acknowledgments

Thank you to our contributors and supporters for their continuous efforts and dedication.

---

Optimize your thermal management with precision and efficiency using our Thermal Mixing System.

Best regards,  
Poorani
