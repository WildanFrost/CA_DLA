function CA(gridWidth, gridHeight, concentration) constructor{
	self.gridWidth = gridWidth;
	self.gridHeight = gridHeight;
	self.concentration = concentration;
	grid = ds_grid_create(self.gridWidth, self.gridHeight);
	updateCount = 0;
	
	function populate(){
		initializeCells();
		addressCellsNeighbor();
	}
	
	function initializeCells(){
		var cellTotal = gridWidth*gridHeight;
		var cellMobile = round(cellTotal*concentration);
		for(var col=0;col<gridWidth;col++){
			for(var row=0;row<gridHeight;row++){
				var state = cellMobile>0? State.m0 : State.e0;
				grid[# col,row] = new DLACell(state);
				cellMobile--;
			}
		}
		grid[# 0,0].setState(State.f0);
		ds_grid_shuffle(grid);
	}
	
	function addressCellsNeighbor(){
		for(var col=0;col<gridWidth;col++){
			for(var row=0;row<gridHeight;row++){
				var neighbors = [
					col<gridWidth-1?  grid[# col+1,row] : 0,
					row>0?			  grid[# col,row-1] : 0,
					col>0?			  grid[# col-1,row] : 0,
					row<gridHeight-1? grid[# col,row+1] : 0
				];
				grid[# col,row].setNeighbors(neighbors);
			}
		}
	}
	
	function update(){
		request();
		approval();
		transaction();
		updateCount++;
		//show_debug_message("update time: "+string(delta_time / 1000000)+" seconds, update count:"+string(updateCount));
	}
	
	function request(){
		for(var col=0;col<gridWidth;col++){
			for(var row=0;row<gridHeight;row++){
				var cell = grid[# col,row];
				switch(cell.state){
					case State.f0:
						cell.setState_requAppr(State_RequestApproval.f1);
						break;
					case State.m0:
						if(cell.hasFixedCellNeighbor()){
							cell.setState_requAppr(State_RequestApproval.f1a);
						} else {
							var emptyNeighborList = cell.getEmptyNeighborList();
							if(!ds_list_empty(emptyNeighborList)){
								var diffuseTarget = emptyNeighborList[| irandom(ds_list_size(emptyNeighborList)-1)];
								cell.setDiffuseTarget(diffuseTarget);
								diffuseTarget.addDiffuseRequest();
								cell.setState_requAppr(State_RequestApproval.m1d);
							} else {
								cell.setState_requAppr(State_RequestApproval.m1s);
							}
							ds_list_destroy(emptyNeighborList);
						}
						break;
					case State.e0:
						cell.setState_requAppr(State_RequestApproval.e1);
						break;
				}
				//show_debug_message("["+string(col)+","+string(row)+"] "+cell.toString());
			}
		}
		//show_debug_message("request");
	}
	
	function approval(){
		//show_debug_message("approval");
	}
	
	function transaction(){
		//show_debug_message("transaction");
	}
	
	function drawGrid(x,y){
		for(var col=0;col<gridWidth;col++){
			for(var row=0;row<gridHeight;row++){
				var cellState = grid[# col,row].state;
				//draw_text(x+col*32,y+row*32,grid[# col,row].state);
				draw_sprite(spr_cell,cellState,x+col*32,y+row*32);
			}
		}
	}
	
	function clear(){
		ds_grid_destroy(grid);
	}
}

