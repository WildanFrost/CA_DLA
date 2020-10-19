/// @description 
ca.update();
var continueUpdate = ca.countCellMobile();
if(continueUpdate) alarm[0]=room_speed;
else show_debug_message("Generation Complete");