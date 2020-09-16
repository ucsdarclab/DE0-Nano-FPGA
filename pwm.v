module pwm (
input wire clk, 
input wire [12:0] in,
output wire out,
output wire dir_o,
output wire escon_enable,
input wire rst);

	wire [10:0] local_input;
	wire heart_Beat;
   reg [10:0] clk_count;
	reg out_t;
	assign local_input = in[10:0];
	assign dir_o = in[11];
	assign heartBeat = in[12];
//	assign out = out_t & output_control;
	assign out = out_t;
	assign escon_enable = output_control;
	
	
	
//	clock divider
	localparam divide_constant = 100;
	reg[32:0] divider_clk_counter;
	
	reg clk_slower;
	always@(posedge clk or posedge rst) begin
	   if(rst) begin
			divider_clk_counter <= 0;
			clk_slower <= 0;
		end
		else if(clk_count == divide_constant - 1)begin
		   divider_clk_counter <= 0;
			clk_slower = ~clk_slower;
		end
		else
			divider_clk_counter = divider_clk_counter + 1'b1;
	end
	
	always @(posedge clk)
	   clk_count <= clk_count+1'b1;
		
//	heartbeat detector
	reg previous_HB;
	reg output_control; //negedge reset signal for pwm generation
   reg[20:0] HB_counter;
	
	always@(posedge clk) begin	
		if(heartBeat != previous_HB) begin
			output_control <= 1;
			HB_counter <= 0;
			previous_HB <= heartBeat;
			end
		else
			if(HB_counter > 4000000)
				output_control <= 0;
			else begin
				HB_counter <= HB_counter + 1'b1;
				end
	end
	

//	pwm generation
	reg[10:0] pwm_counter;	


	always @(posedge clk) begin
		if(rst || !output_control) begin
			out_t <= 0;
			pwm_counter <= 0;
		end
		else if(pwm_counter>local_input) 
			out_t <=0;
		else             
			out_t <=1;
			
		pwm_counter <= pwm_counter + 1;
	end	
	
endmodule