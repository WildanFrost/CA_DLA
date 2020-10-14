// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function DLACell(state) constructor{
	self.state = state;
	state_requestApproval = -1;
	state_approvalTransaction = -1;
	
	function setState(state){
		self.state = state;
	}
}