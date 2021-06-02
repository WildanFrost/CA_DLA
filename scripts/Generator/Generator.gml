// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information

function lvGenerator_Init(caWidth, caHeight, caRoomSize, concentration){
	CA_Grid_Width = caWidth;
	CA_Grid_Height = caHeight;
	CA_Room_Size = caRoomSize;
	Grid_Width = CA_Room_Size*CA_Grid_Width+2;
	Grid_Height = CA_Room_Size*CA_Grid_Height+2;
	Room_Grid = ds_grid_create(Grid_Width, Grid_Height);
	Area_Grid = ds_grid_create(Grid_Width, Grid_Height);
	ds_grid_clear(Room_Grid, 0);
	ds_grid_clear(Area_Grid, 0);
	Nmb_of_Room = 0;
	Area = [];
	
	var mCellConcentration = concentration;
	ca = new CA(CA_Grid_Width,CA_Grid_Height,mCellConcentration);
	ca.populate();
}

function lvGenerator_Loop(updateLimit){
	var updateCount = 0;
	do{
		ca.update();
		updateCount++;
	} until (!ca.hasMobileCell() || updateCount>updateLimit);
}

function lvGenerator_LevelGenerate(){
	var width = ca.gridWidth;
	var height = ca.gridHeight;
	var roomNumber = 1;
	
	for(var i=0;i<width;i++){
		for(var j=0;j<height;j++){
			var cell = ca.grid[# i,j];
			if(cell.state == State.f0){
				var fixedNeighborsCount = getFixedNeighborCount(cell);
				if(canMakeCorridor(fixedNeighborsCount)){
					makeCorridor(i,j,cell);
				} else {
					makeRoom(i,j, roomNumber);
					roomNumber++;
				}
			}
		}
	}
	
	for(var i=0;i<width;i++){
		for(var j=0;j<height;j++){
			var cell = ca.grid[# i,j];
			if(cell.state == State.f0){
				if(isCorridor(i,j)){
					makeDoor(i,j,cell);
				}
			}
		}
	}
	
	ca.clear();
	delete ca;
	Nmb_of_Room = roomNumber;
}

function makeRoom(_x, _y, roomNumber){
	var x1,x2,y1,y2;
	x1 = 1+_x*CA_Room_Size;
	y1 = 1+_y*CA_Room_Size;
	x2 = x1+CA_Room_Size-1;
	y2 = y1+CA_Room_Size-1;
	ds_grid_set_region(Room_Grid,x1,y1,x2,y2,1);
	assignArea(roomNumber,Area_Grid,x1,y1,x2,y2);
}
	
function makeCorridor(_x, _y, cell){
	var fixedNeighborsBooleanArray = getFixedNeighborsBooleanArray(cell.getNeighbors());
	var x1,x2,y1,y2;
	if(fixedNeighborsBooleanArray[Direction.R]){
		x1 = 1+_x*CA_Room_Size+floor(CA_Room_Size/2);
		y1 = 1+_y*CA_Room_Size+floor(CA_Room_Size/2);
		x2 = (1+_x)*CA_Room_Size;
		y2 = y1;
		ds_grid_set_region(Room_Grid,x1,y1,x2,y2,1);
	}
	if(fixedNeighborsBooleanArray[Direction.T]){
		x1 = 1+_x*CA_Room_Size+floor(CA_Room_Size/2);
		y1 = 1+_y*CA_Room_Size;
		x2 = x1;
		y2 = 1+_y*CA_Room_Size+floor(CA_Room_Size/2);
		ds_grid_set_region(Room_Grid,x1,y1,x2,y2,1);
	}
	if(fixedNeighborsBooleanArray[Direction.L]){
		x1 = 1+_x*CA_Room_Size;
		y1 = 1+_y*CA_Room_Size+floor(CA_Room_Size/2);
		x2 = 1+_x*CA_Room_Size+floor(CA_Room_Size/2);
		y2 = y1;
		ds_grid_set_region(Room_Grid,x1,y1,x2,y2,1);
	}
	if(fixedNeighborsBooleanArray[Direction.B]){
		x1 = 1+_x*CA_Room_Size+floor(CA_Room_Size/2);
		y1 = 1+_y*CA_Room_Size+floor(CA_Room_Size/2);
		x2 = x1;
		y2 = (1+_y)*CA_Room_Size;
		ds_grid_set_region(Room_Grid,x1,y1,x2,y2,1);
	}
}

function makeDoor(_x, _y, cell){
	var fixedNeighborsBooleanArray = getFixedNeighborsBooleanArray(cell.getNeighbors());
	var px,py;
	if(fixedNeighborsBooleanArray[Direction.R]){
		px = (1+_x)*CA_Room_Size;
		py = 1+_y*CA_Room_Size+floor(CA_Room_Size/2);
		if(Area_Grid[# px+1,py]!=0){
			ds_grid_set(Room_Grid,px,py,2);
		}
	}
	if(fixedNeighborsBooleanArray[Direction.T]){
		px = 1+_x*CA_Room_Size+floor(CA_Room_Size/2);
		py = 1+_y*CA_Room_Size;
		if(Area_Grid[# px,py-1]!=0){
			ds_grid_set(Room_Grid,px,py,2);
		}
	}
	if(fixedNeighborsBooleanArray[Direction.L]){
		px = 1+_x*CA_Room_Size;
		py = 1+_y*CA_Room_Size+floor(CA_Room_Size/2);
		if(Area_Grid[# px-1,py]!=0){
			ds_grid_set(Room_Grid,px,py,2);
		}
	}
	if(fixedNeighborsBooleanArray[Direction.B]){
		px = 1+_x*CA_Room_Size+floor(CA_Room_Size/2);
		py = (1+_y)*CA_Room_Size;
		if(Area_Grid[# px,py+1]!=0){
			ds_grid_set(Room_Grid,px,py,2);
		}
	}
}
	
function canMakeCorridor(fixedNeighborsCount){
	switch(fixedNeighborsCount){
		case 2: return true;
		case 3: return choose(true, false, false, false);
		default: return false;
	}
}
	
function isCorridor(_x, _y){
	var dx,dy;
	dx = 1+_x*CA_Room_Size;
	dy = 1+_y*CA_Room_Size;
	return Area_Grid[# dx,dy]==0;
}

function assignArea(area, areagrid, x1, y1, x2, y2){
	Area[area,0] = x1;
	Area[area,1] = y1;
	Area[area,2] = x2;
	Area[area,3] = y2;
	Area[area,4] = x1;
	Area[area,5] = y1;
	Area[area,6] = x2;
	Area[area,7] = y2;
	ds_grid_set_region(areagrid,x1,y1,x2,y2,area);
}

function getFixedNeighborsBooleanArray(neighborsArray){
	var neighborR = neighborsArray[Direction.R];
	var neighborT = neighborsArray[Direction.T];
	var neighborL = neighborsArray[Direction.L];
	var neighborB = neighborsArray[Direction.B];
	var booArray = [
		is_struct(neighborR)? (neighborR.state==State.f0? 1 : 0) : 0,
		is_struct(neighborT)? (neighborT.state==State.f0? 1 : 0) : 0,
		is_struct(neighborL)? (neighborL.state==State.f0? 1 : 0) : 0,
		is_struct(neighborB)? (neighborB.state==State.f0? 1 : 0) : 0
	];
	return booArray;
}

function getFixedNeighborCount(cell){
	var neighbors = cell.getNeighbors();
	var fixedNeighborsBooleanArray = getFixedNeighborsBooleanArray(neighbors);
	var count = 0;
	var a=0; repeat(array_length(fixedNeighborsBooleanArray)){
		count+=fixedNeighborsBooleanArray[a];
		a++
	}
	return count;
}