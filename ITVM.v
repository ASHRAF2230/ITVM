
module ITVM(clk,rst,vehicleType,destination,seatType,numSeat,confirm,paymentMethod,mobileBank,tk50,tk100,tk500,tk1000,cashin,ticket,totalFare, returnMoney);
input clk, rst;
input [1:0]vehicleType; //2'b00= Bus,2'b01= Ship, 2'b10=Train, 2'b11=Aeroplane;
input destination;//1'b0=Sylhet, 1'b1= CoxBazar;
input [1:0]seatType; // Ac=2'b00, Non CA=2'b01, Business class=2'b10,economy = 2'b11; 
input [11:0]numSeat;
input confirm;
input paymentMethod;// MObileBank=1'b1,Cash=1'b1;
input mobileBank; // Done=1'b1 or Not Done=1'b0;
input tk50; //
input tk100; //
input tk500; //
input tk1000;
output reg [13:0]cashin;
output reg ticket;
output reg [13:0]returnMoney;
output reg [13:0] totalFare;
reg [13:0] noteCounter;
reg [3:0]state;


//fare set
parameter Bus_Ac_Sylhet = 600;
parameter Bus_NonAc_Cox = 500;
parameter Train_Ac_Sylhet = 400;
parameter Train_NonAc_Cox = 500;
parameter Ship_Ac_Sylhet = 400 ;
parameter Ship_NonAc_Cox = 300;
parameter Aero_Busi_Sylhet = 4000;
parameter Aero_Eco_Cox = 3000;
parameter Bus_NonAc_Sylhet = 400;
parameter Bus_Ac_Cox = 1000;
parameter Train_NonAc_Sylhet = 200;
parameter Train_Ac_Cox = 700;
parameter Ship_NonAc_Sylhet = 300;
parameter Ship_Ac_Cox = 500;
parameter Aero_Eco_Sylhet = 2000;
parameter Aero_Busi_Cox = 5000;

//states
localparam 
Start= 4'd0,
chooseVehicle= 4'd1, 
chooseDestination= 4'd2, 
chooseSeatType= 4'd3,
calculation = 4'd4,
confirmation= 4'd5,
choosePayment= 4'd6,
mobilebaking= 4'd7,
cashcount=4'd8,
ticketOut=4'd9,
returnticket=4'd10;

//cashcounter
always @(posedge clk )
begin
if(rst)
begin cashin<=0;
noteCounter<=0;end
else
begin
if(tk50) begin noteCounter<=noteCounter+50; end
else if(tk100) begin noteCounter<=noteCounter+100;end
else if(tk500) begin noteCounter<=noteCounter+500;end
else if(tk1000) begin noteCounter<=noteCounter+1000;end
else  begin noteCounter<=noteCounter;end

end
cashin<=noteCounter;
end





always @(posedge clk )
begin
if( rst==1'b1)
begin
state<= Start;
ticket<=1'b0;
returnMoney<=11'b0;
totalFare<=0;
end
else
begin
case(state)
Start: 
 begin
 state<=((vehicleType==2'b00 ||vehicleType==2'b01|| vehicleType==2'b10||vehicleType==2'b11))?chooseVehicle:Start;
 ticket<=1'b0;
 returnMoney<=11'b0;

 end
 chooseVehicle:
 begin
 state<=((destination==1'b0 ||destination==1'b1 ))?chooseDestination:Start;
 ticket<=1'b0;
  returnMoney<=11'b0;
  end
  chooseDestination:
  begin
  state<=((seatType==2'b00 ||seatType==2'b01|| seatType==2'b10||seatType==2'b11))?calculation:Start;
 ticket<=1'b0;
 returnMoney<=11'b0;
  end
  calculation:
 begin
if(vehicleType==2'b00 && destination==1'b0 && seatType==2'b00)
begin
totalFare<=Bus_Ac_Sylhet*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b00 && destination==1'b0 && seatType==2'b01)
begin
totalFare<=Bus_NonAc_Sylhet*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b00 && destination==1'b1 && seatType==2'b00)
begin
totalFare<=Bus_Ac_Cox*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b00 && destination==1'b1 && seatType==2'b01)
begin
totalFare<=Bus_NonAc_Cox*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b01 && destination==1'b0 && seatType==2'b00)
begin
totalFare<=Ship_Ac_Sylhet*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b01 && destination==1'b0 && seatType==2'b01)
begin
totalFare<=Ship_NonAc_Sylhet*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b01 && destination==1'b1 && seatType==2'b00)
begin
totalFare<=Ship_Ac_Cox*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b01 && destination==1'b1 && seatType==2'b01)
begin
totalFare<=Ship_NonAc_Cox*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b10 && destination==1'b0 && seatType==2'b00)
begin
totalFare<=Train_Ac_Sylhet*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b10 && destination==1'b0 && seatType==2'b01)
begin
totalFare<=Train_NonAc_Sylhet*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b10 && destination==1'b1 && seatType==2'b00)
begin
totalFare<=Train_Ac_Cox*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b10 && destination==1'b1 && seatType==2'b01)
begin
totalFare<=Train_NonAc_Cox*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b11 && destination==1'b0 && seatType==2'b10)
begin
totalFare<=Aero_Busi_Sylhet*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;

end
else if(vehicleType==2'b11 && destination==1'b0 && seatType==2'b11)
begin
totalFare<=Aero_Eco_Sylhet*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b11 && destination==1'b1 && seatType==2'b10)
begin
totalFare<=Aero_Busi_Cox*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
else if(vehicleType==2'b11 && destination==1'b1 && seatType==2'b11)
begin
totalFare<=Aero_Eco_Cox*numSeat;
ticket<=1'b0;
returnMoney<=11'b0;
state<=confirmation;
end
end
confirmation:
begin
state<=(confirm==1'b1)?choosePayment:Start;
ticket<=1'b0;
returnMoney<=11'b0;
end
choosePayment:
begin
state<=(paymentMethod==1'b1)?mobilebaking:((paymentMethod==1'b0)?cashcount:Start);
ticket<=1'b0;
returnMoney<=11'b0;
end
mobilebaking:
begin
state<=(mobileBank==1'b1 )?ticketOut:Start;
ticket<=1'b0;
returnMoney<=11'b0;
end
cashcount:
begin
if(cashin>totalFare)begin ticket<=1'b0; returnMoney<=0 ; state<=returnticket; end
else if(cashin==totalFare)begin ticket<=1'b0; returnMoney<=0; state<=ticketOut; end
else begin ticket=1'b0; returnMoney<=0; state<=cashcount ;end
end
ticketOut:
begin
  ticket<=1'b1;
  returnMoney<=0;
  state<=Start;
end
returnticket:
begin
  ticket<=1'b1;
  returnMoney<=cashin-totalFare;
    state<=Start;
    end
endcase
end
end

endmodule





