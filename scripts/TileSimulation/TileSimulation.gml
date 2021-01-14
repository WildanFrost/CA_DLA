// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function TileSimulation(){
	var xx, yy, gv, tv;
	TILE_SIZE = 4;

	for(yy=0; yy<Grid_Height; yy++)
	{
		for(xx=0; xx<Grid_Width; xx++)
		{
		gv = Room_Grid[# xx, yy];
		tilemap_set_at_pixel(global.Tilemap_Floor, 1, xx*TILE_SIZE, yy*TILE_SIZE);//We add a floor tile everywhere
		
			if(gv == 0) //Add a wall tile then auto-tile it.
			{
			tilemap_set_at_pixel(global.Tilemap_Wall, 1, xx*TILE_SIZE, yy*TILE_SIZE);
			}
		}
	}
}