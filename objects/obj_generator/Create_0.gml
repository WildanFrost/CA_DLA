/// @description 

//global.time = current_time;

randomize();
//show_debug_overlay(true);

lvGenerator_Init(20,5,5,0.5);
//CA_Grid_Width = 20;
//CA_Grid_Height = 5;
//CA_Room_Size = 5;
//Grid_Width = CA_Room_Size*CA_Grid_Width+2;
//Grid_Height = CA_Room_Size*CA_Grid_Height+2;
//global.width = Grid_Width;
//global.height = Grid_Height;
//Room_Grid = ds_grid_create(Grid_Width, Grid_Height);
//Area_Grid = ds_grid_create(Grid_Width, Grid_Height);
//ds_grid_clear(Room_Grid, 0);
//ds_grid_clear(Area_Grid, 0);
//Area = 0; //Will be an array

global.Layer_Floor = layer_create(0);
global.Layer_Wall = layer_create(-50);

global.Tilemap_Floor = layer_tilemap_create(global.Layer_Floor, 0, 0, tile_floor, room_width, room_height);
global.Tilemap_Wall = layer_tilemap_create(global.Layer_Wall, 0, 0, tile_wall, room_width, room_height);

updateCount = 0;
_stopUpdate = false;

//ca = new CA(CA_Grid_Width,CA_Grid_Height,0.5);
//ca.populate();
alarm[0]=room_speed;