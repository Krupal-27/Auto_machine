`timescale 10ns / 1ps

module auto_tb;

  reg clk;
  reg reset;
  reg door_close;
  reg start;
  reg filled;
  reg detergent_added;
  reg cycle_timeout;
  reg drained;
  reg spin_timeout;

  wire door_lock;
  wire motor_on;
  wire fill_value_on;
  wire drain_value_on;
  wire done;
  wire soap_wash;
  wire water_wash;

  auto_machine dut (
    .clk(clk),
    .reset(reset),
    .door_close(door_close),
    .start(start),
    .filled(filled),
    .detergent_added(detergent_added),
    .cycle_timeout(cycle_timeout),
    .drained(drained),
    .spin_timeout(spin_timeout),
    .door_lock(door_lock),
    .motor_on(motor_on),
    .fill_value_on(fill_value_on),
    .drain_value_on(drain_value_on),
    .done(done),
    .soap_wash(soap_wash),
    .water_wash(water_wash)
  );

  always #5 clk = ~clk;

  initial begin
    clk = 0;
    reset = 1;
    start = 0;
    door_close = 0;
    filled = 0;
    detergent_added = 0;
    cycle_timeout = 0;
    drained = 0;
    spin_timeout = 0;

    $display("----- RESETTING SYSTEM -----");
    #10 reset = 0;
    $display("----- STARTING WASHING MACHINE -----");
    #10 start = 1; door_close = 1;
    $display("----- FILLING WATER -----");
    #20 filled = 1;
    $display("----- ADDING DETERGENT -----");
    #20 detergent_added = 1;
    $display("----- RUNNING WASH CYCLE -----");
    #40 cycle_timeout = 1;
    $display("----- DRAINING WATER -----");
    #20 drained = 1;
    $display("----- SPINNING CLOTHES -----");
    #30 spin_timeout = 1;
    $display("----- WASHING COMPLETE -----");
    #20;
    $display("Simulation finished at time = %0t", $time);
    $stop;
  end

  initial begin
    $monitor(
      "Time=%0t | clk=%b | reset=%b | start=%b | door_close=%b | filled=%b | detergent_added=%b | cycle_timeout=%b | drained=%b | spin_timeout=%b || door_lock=%b | motor_on=%b | fill_valve_on=%b | drain_valve_on=%b | soap_wash=%b | water_wash=%b | done=%b",
      $time, clk, reset, start, door_close, filled, detergent_added, cycle_timeout,
      drained, spin_timeout, door_lock, motor_on, fill_value_on, drain_value_on,
      soap_wash, water_wash, done
    );
  end

endmodule
