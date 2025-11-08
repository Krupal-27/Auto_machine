`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2025 07:44:38 PM
// Design Name: 
// Module Name: auto_machine
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



`timescale 10ns / 1ps

module auto_machine(
  input clk,
  input reset,
  input door_close,
  input start,
  input filled,
  input detergent_added,
  input cycle_timeout,
  input drained,
  input spin_timeout,
  output reg door_lock,
  output reg motor_on,
  output reg fill_value_on,
  output reg drain_value_on,
  output reg done,
  output reg soap_wash,
  output reg water_wash
);

  parameter check_door = 3'b000;
  parameter fill_water = 3'b001;
  parameter add_detergent = 3'b010;
  parameter cycle = 3'b011;
  parameter drain_water = 3'b100;
  parameter spin = 3'b101;

  reg [2:0] current_state, next_state;

  always @(*) begin
    case (current_state)
      check_door: begin
        if (start == 1 && door_close == 1) begin
          next_state = fill_water;
          motor_on = 0;
          fill_value_on = 0;
          drain_value_on = 0;
          door_lock = 1;
          soap_wash = 0;
          water_wash = 0;
          done = 0;
        end else begin
          next_state = current_state;
          motor_on = 0;
          fill_value_on = 0;
          drain_value_on = 0;
          door_lock = 0;
          soap_wash = 0;
          water_wash = 0;
          done = 0;
        end
      end

      fill_water: begin
        if (filled == 1) begin
          if (soap_wash == 0) begin
            next_state = add_detergent;
            motor_on = 0;
            fill_value_on = 0;
            drain_value_on = 0;
            door_lock = 1;
            soap_wash = 1;
            water_wash = 0;
            done = 0;
          end else begin
            next_state = cycle;
            motor_on = 0;
            fill_value_on = 0;
            drain_value_on = 0;
            door_lock = 1;
            soap_wash = 1;
            water_wash = 1;
            done = 0;
          end
        end else begin
          next_state = current_state;
          motor_on = 0;
          fill_value_on = 1;
          drain_value_on = 0;
          door_lock = 1;
          done = 0;
        end
      end

      add_detergent: begin
        if (detergent_added == 1) begin
          next_state = cycle;
          motor_on = 0;
          fill_value_on = 0;
          drain_value_on = 0;
          door_lock = 1;
          soap_wash = 1;
          done = 0;
        end else begin
          next_state = current_state;
          motor_on = 0;
          fill_value_on = 0;
          drain_value_on = 0;
          door_lock = 1;
          soap_wash = 1;
          water_wash = 0;
          done = 0;
        end
      end

      cycle: begin
        if (cycle_timeout == 1) begin
          next_state = drain_water;
          motor_on = 0;
          fill_value_on = 0;
          drain_value_on = 0;
          door_lock = 1;
          done = 0;
        end else begin
          next_state = current_state;
          motor_on = 1;
          fill_value_on = 0;
          drain_value_on = 0;
          door_lock = 1;
          done = 0;
        end
      end

      drain_water: begin
        if (drained == 1) begin
          if (water_wash == 0) begin
            next_state = fill_water;
            motor_on = 0;
            fill_value_on = 0;
            drain_value_on = 0;
            door_lock = 1;
            soap_wash = 1;
            done = 0;
          end else begin
            next_state = spin;
            motor_on = 0;
            fill_value_on = 0;
            drain_value_on = 0;
            door_lock = 1;
            soap_wash = 1;
            water_wash = 1;
            done = 0;
          end
        end else begin
          next_state = current_state;
          motor_on = 0;
          fill_value_on = 0;
          drain_value_on = 1;
          door_lock = 1;
          soap_wash = 1;
          done = 0;
        end
      end

      spin: begin
        if (spin_timeout == 1) begin
          next_state = check_door;
          motor_on = 0;
          fill_value_on = 0;
          drain_value_on = 0;
          door_lock = 1;
          soap_wash = 1;
          water_wash = 1;
          done = 1;
        end else begin
          next_state = current_state;
          motor_on = 0;
          fill_value_on = 0;
          drain_value_on = 1;
          door_lock = 1;
          soap_wash = 1;
          water_wash = 1;
          done = 0;
        end
      end

      default: next_state = check_door;
    endcase
  end

  always @(posedge clk or posedge reset) begin
    if (reset)
      current_state <= check_door;
    else
      current_state <= next_state;
  end

endmodule
