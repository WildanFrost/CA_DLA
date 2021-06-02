/// @description 

ca.update();
updateCount++;
show_debug_message("update: "+string(updateCount));
var continueUpdate = ca.hasMobileCell() || updateCount>200;

if(continueUpdate) alarm[0]=room_speed/4;
else {
	_stopUpdate = true;
	lvGenerator_LevelGenerate();
	TileSimulation();
	show_debug_message("Generation Complete");
}