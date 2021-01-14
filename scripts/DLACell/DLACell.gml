function DLACell(state) constructor{
	self.state = state;
	state_requestApproval = -1;
	state_approvalTransaction = -1;
	neighbors = 0;
	diffuseRequestNumber = 0;
	diffuseTarget = 0;
	turnedToFixedAt = 0;
	
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
	
	function getNeighbors(){
		return neighbors;
	}
	
	function setTurnedToFixedAt(updateCount){
		turnedToFixedAt = updateCount;
	}
	
	function hasFixedCellNeighbor(){
		for(var i=0;i<array_length(neighbors);i++){
			if(is_struct(neighbors[i])){
				if(neighbors[i].state == State.f0)
					return true;
			}
		}
		return false;
	}
	
	function getEmptyNeighborList(){
		var list = ds_list_create();
		for(var i=0;i<array_length(neighbors);i++){
			if(is_struct(neighbors[i])){
				if(neighbors[i].state == State.e0)
					ds_list_add(list, neighbors[i]);
			}
		}
		return list;
	}
	
	function addDiffuseRequest(){
		diffuseRequestNumber++;
	}
	
	function setDiffuseTarget(diffuseTarget){
		self.diffuseTarget = diffuseTarget;
	}
	
	function toString(){
		var state = ["f0", "m0", "e0"];
		var state_requestApproval = ["f1", "f1a", "m1s", "m1d", "e1"];
		var state_approvalTransaction = ["f2", "f2a", "m2s", "m2d", "r2", "e2"];
		return state[self.state] +","+ state_requestApproval[self.state_requestApproval] +","+ state_approvalTransaction[self.state_approvalTransaction] +", request:"+string(diffuseRequestNumber);
	}
	
	function updateReset(){
		diffuseRequestNumber = 0;
		diffuseTarget = 0;
	}
}