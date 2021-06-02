
/// @description 

if(is_struct(ca)){
	ca.clear();
	delete ca;
}
ds_grid_destroy(Room_Grid);
ds_grid_destroy(Area_Grid);