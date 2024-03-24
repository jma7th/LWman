// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function player_start() {
	hsp = 0;
	vsp = 0;
	vmove = 0;
	hmove = 1;
	dir = 0;
	movespeed = 2;
}
function player_move(){
	hsp = movespeed * hmove
	vsp = movespeed * vmove
	var _collision = move_and_collide(hsp,vsp,obj_solid)
	if array_length(_collision) > 0 {
		dir += 90;
	}
	if (dir < 0) dir = abs(dir)
	if (dir > 360) dir = 0
	
	switch (dir) {
			case 0: 
				hmove = 1;
				vmove = 0;
			break;
			case 90:
				hmove = 0;
				vmove = -1;
			break;
			case 180:
				hmove = -1;
				vmove = 0;
			break;
			case 270:
				hmove = 0;
				vmove = 1;
			break;
			default:
				hmove = 0;
				vmove = 0;
		}
	
}

function player_sprite(){
	image_speed = PLAYER_SPRITE_SPEED_MOVE;
	switch (dir) {
		case 0: sprite_index = spr_player_side;
			image_xscale = 1;
		break;
		case 90: sprite_index = spr_player_up;
		break;
		case 180: sprite_index = spr_player_side;
			image_xscale = -1;
		break;
		case 270: sprite_index = spr_player_down;
		break;
	}
}

function player_draw(){
	draw_self_on_surface()
}