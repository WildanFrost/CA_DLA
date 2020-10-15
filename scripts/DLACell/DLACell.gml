function DLACell(state) constructor{
	self.state = state;
	state_requestApproval = -1;
	state_approvalTransaction = -1;
	neighbors = 0;
	
	function setState(state){
		self.state = state;
	}
	
	function setState_requAppr(state_requestApproval){
		self.state_requestApproval = state_requestApproval;
	}
	
	function setState_apprTran(state_approvalTransaction){
		self.state_approvalTransaction = state_approvalTransaction;
	}
	
	function setNeighbors(neighbors){
		self.neighbors = neighbors;
	}
}