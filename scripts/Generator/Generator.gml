// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function CA_LevelGenerate(ca, roomgrid, areagrid, roomsize){
	var width = ca.gridWidth;
	var height = ca.gridHeight;
	var area = 1;
	var i = 0; repeat(width){
		var j = 0; repeat(height){
			var cell = ca.grid[# i,j];
			if(cell.state == State.f0){
				var tmp_neighbors = cell.getNeighbors();
				var tmp_neighborsBoo = neighborsBoo(tmp_neighbors);
				var x1,x2,y1,y2;
				var tmp_neighborsFloor = 0;
				var a=0; repeat(4){
					tmp_neighborsFloor+=tmp_neighborsBoo[a];
					a++;
				}
				
				if(tmp_neighborsFloor!=2){
					x1 = 1+i*roomsize;
					y1 = 1+j*roomsize;
					x2 = x1+roomsize-1;
					y2 = y1+roomsize-1;
					ds_grid_set_region(roomgrid,x1,y1,x2,y2,1);
					
					assignArea(area,areagrid,x1,y1,x2,y2);
					area++;
				} else {
					
					if(tmp_neighborsBoo[Direction.R]){
						x1 = 1+i*roomsize+floor(roomsize/2);
						y1 = 1+j*roomsize+floor(roomsize/2);
						x2 = (1+i)*roomsize;
						y2 = y1;
						ds_grid_set_region(roomgrid,x1,y1,x2,y2,1);
					}
					if(tmp_neighborsBoo[Direction.T]){
						x1 = 1+i*roomsize+floor(roomsize/2);
						y1 = 1+j*roomsize;
						x2 = x1;
						y2 = 1+j*roomsize+floor(roomsize/2);
						ds_grid_set_region(roomgrid,x1,y1,x2,y2,1);
					}
					if(tmp_neighborsBoo[Direction.L]){
						x1 = 1+i*roomsize;
						y1 = 1+j*roomsize+floor(roomsize/2);
						x2 = 1+i*roomsize+floor(roomsize/2);
						y2 = y1;
						ds_grid_set_region(roomgrid,x1,y1,x2,y2,1);
					}
					if(tmp_neighborsBoo[Direction.B]){
						x1 = 1+i*roomsize+floor(roomsize/2);
						y1 = 1+j*roomsize+floor(roomsize/2);
						x2 = x1;
						y2 = (1+j)*roomsize;
						ds_grid_set_region(roomgrid,x1,y1,x2,y2,1);
					}
					
					//if !(array_equals(tmp_neighborsBoo,[1,0,1,0]) || array_equals(tmp_neighborsBoo,[0,1,0,1])){
						
					//}
				}
			}
			j++;
		}
		i++;
	}
	Nmb_of_Room = area;
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

function neighborsBoo(neighborsArray){
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