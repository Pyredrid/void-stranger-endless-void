 // This script is a massacared version of the https://github.com/attic-stuff/runtile-for-gamemaker runtile library.
 // It has changed in order to exclusively work with tiling edges.


/**
 * calculates which tile index should be used to blob autotile a given cell based on the status of its neighbors.
 * if you would like the tilemap to be unbound by the tilemap size, change each > comparison to !=
 * @param {id.TileMapElement} map tilemap
 * @param {real} x the x coordinate of the cell to evaluate
 * @param {real} y the y coordinate of the cell to evaluate
 */
 
global.blobtable = ds_list_create();
ds_list_add(global.blobtable,
 		-1, 255, 68, 17, 241, 124,
		31, 199, 253, 127, 223, 247,
		193, 112, 28, 7, 64, 16, 4,
		1, 95, 215, 245, 125, 87,
		213, 117, 93, 85, 221, 119,
		0, 209, 116, 29, 71, 113, 92,
		23, 197, 81, 84, 21, 69, 65,
		80, 20, 5);
		  
function get_wall(x, y, lvl) {
	static wall = global.editor_object.tile_wall;
	if x < 0 || x >= 14 || y < 0 || y >= 9
		return true;
	return lvl.tiles[y][x].tile != wall
}
		  
function runtile_fetch_blob(x, y, lvl) {
	static table = global.blobtable;
	var r = x + 1;
	var u = y - 1;
	var l = x - 1;
	var d = y + 1;
	var e = get_wall(r, y, lvl);
	var ne = get_wall(r, u, lvl);
	var n = get_wall(x, u, lvl);
	var nw = get_wall(l, u, lvl);
	var w = get_wall(l, y, lvl);
	var sw = get_wall(l, d, lvl);
	var s = get_wall(x, d, lvl)
	var se = get_wall(r, d, lvl);
	var val = (e * 1) + ((ne & e & n) * 2) + (n * 4) + ((nw & w & n) * 8) + (w * 16) + ((sw & s & w) * 32) + (s * 64) + ((se & e & s) * 128)
	if val == 255
		return 31; 
	return ds_list_find_index(table, val);
}
