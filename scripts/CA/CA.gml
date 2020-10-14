// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function CA(gridWidth, gridHeight, concentration) constructor{
	self.gridWidth = gridWidth;
	self.gridHeight = gridHeight;
	self.concentration = concentration;
	grid = ds_grid_create(self.gridWidth, self.gridHeight);
	
	function populate(){
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
	
	function update(){
		request();
		approval();
		transaction();
	}
	
	function request(){
	}
	
	function approval(){
	}
	
	function transaction(){
	}
	
	function drawGrid(x,y){
		for(var col=0;col<gridWidth;col++){
			for(var row=0;row<gridHeight;row++){
				draw_text(x+col*32,y+row*32,grid[# col,row].state)
			}
		}
	}
	
	function clear(){
		ds_grid_destroy(grid);
	}
}

