/// @description 
ca.update();
show_debug_message("update: "+string(ca.updateCount));
var continueUpdate = ca.hasMobileCell() || ca.updateCount>200;
if(continueUpdate) alarm[0]=room_speed/4;
else {
	_stopUpdate = true;
	CA_LevelGenerate(ca,Room_Grid,Area_Grid,CA_Room_Size);
	TileSimulation();
	show_debug_message("Generation Complete");
}