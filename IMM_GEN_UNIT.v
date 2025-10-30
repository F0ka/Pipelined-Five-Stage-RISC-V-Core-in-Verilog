
module IMM_GEN_UNIT(In,Out);

input [31:0]In;
output reg [31:0]Out;


always @ (In)
begin
if(In[6:4] == 3'b000 || In[6:4] == 2'b001)Out <= {{20{In[31]}},In[31:20]}; //LW I-TYPE
else if (In[6:4] == 3'b010)Out <= {{20{In[31]}},In[31:25],In[11:7]};  //s-type
else if (In[6:4] == 3'b110)Out <= {{20{In[31]}},In[31],In[7],In[30:25],In[11:8],1'b0}; //B-TYPE


end
endmodule
//010) 0011 store op
//000) 0011 load op
//011) 0011 r-type op , not used
//110) 0011 beq op