# **Automatic Washing Machine Controller**

This project implements a finite state machine (FSM) for an automatic washing machine controller in Verilog, demonstrating digital control systems for home appliances.

## 🏗️ Architecture
- **6-State FSM**: Sequential state transitions for complete wash cycle
- **Combinational Logic**: Output generation based on current state
- **Sequential Logic**: State registration with clock synchronization
- **Safety Features**: Door lock mechanism and input validation

## 📋 State Transitions
1. **CHECK_DOOR** → Verifies door closure and start signal
2. **FILL_WATER** → Controls water filling process
3. **ADD_DETERGENT** → Manages soap dispensing
4. **CYCLE** → Main washing cycle with motor operation
5. **DRAIN_WATER** → Drains water from machine
6. **SPIN** → Final spin dry cycle

## 🎯 Key Features
- **Dual Wash Modes**: Soap wash and water rinse cycles
- **Safety Interlocks**: Door lock during operation
- **Process Control**: Manages motor, valves, and timers
- **State Validation**: Proper transition conditions
- **Complete Cycle**: End-to-end washing process

## 🔧 Control Signals

### Inputs
- **clk**: System clock
- **reset**: System reset
- **door_close**: Door closure status
- **start**: Start washing cycle
- **filled**: Water level reached
- **detergent_added**: Soap dispensed
- **cycle_timeout**: Wash cycle completed
- **drained**: Water drained completely
- **spin_timeout**: Spin cycle completed

### Outputs
- **door_lock**: Door lock mechanism
- **motor_on**: Motor control
- **fill_value_on**: Water inlet valve
- **drain_value_on**: Drain valve
- **done**: Cycle completion indicator
- **soap_wash**: Soap wash mode active
- **water_wash**: Water rinse mode active

## 📊 State Machine Logic

### State: CHECK_DOOR
- Waits for door closure and start signal
- Ensures safety before beginning cycle
- Transitions to FILL_WATER when ready

### State: FILL_WATER
- Controls water filling valve
- Monitors water level sensor
- Transitions based on soap wash cycle

### State: ADD_DETERGENT
- Manages detergent dispensing
- Ensures soap added before washing
- Transitions to main CYCLE

### State: CYCLE
- Activates motor for washing
- Monitors cycle timer
- Transitions to DRAIN_WATER

### State: DRAIN_WATER
- Controls drain valve
- Monitors drain completion
- Handles cycle repetition for rinse

### State: SPIN
- Final spin dry cycle
- Monitors spin timeout
- Completes with DONE signal

## 📁 Project Structure
