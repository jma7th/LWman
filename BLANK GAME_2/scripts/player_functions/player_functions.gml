// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function player_start() {
	hsp = 0;
	vsp = 0;
	vmove = 0;
	hmove = 1;
	dir = 0;
	movespeed = 2;
	state = PLAYER_STATE.ALIVE
	
	death_ringer = time_source_create(time_source_game,2,time_source_units_seconds,function(){
			x = xstart;
			y = ystart;
			direction = 270;
			state = PLAYER_STATE.ALIVE;
		})
		
		
}
function player_move(){
	move_snap(2,2)
	hsp = movespeed * hmove
	vsp = movespeed * vmove
	//speed = movespeed
	/*
	if place_meeting(x+lengthdir_x(movespeed,direction),y+lengthdir_y(movespeed,direction),obj_solid) {
		direction += 90
	}*/
		
	dir = direction % 360
	
	var _objlist = []
	
	for (var i = 0; i < instance_number(obj_solid); ++i;)
	{
	    var _add = instance_find(obj_solid,i);
		array_push(_objlist,_add)
	}
	
	for (var i = 0; i < instance_number(obj_button); ++i;)
	{
		
	    var _add = instance_find(obj_button,i);
		if _add.state = 1 {
			array_push(_objlist,_add)
		}
	}
	
	for (var i = 0; i < instance_number(obj_chest); ++i;)
	{
	    var _add = instance_find(obj_chest,i);
		if _add.state = 1 {
			array_push(_objlist,_add)
		}
	}
	
	for (var i = 0; i < instance_number(obj_campfire); ++i;)
	{
		
	    var _add = instance_find(obj_campfire,i);
		array_push(_objlist,_add)
	}
	
	
	var _collision = move_and_collide(hsp,vsp,_objlist)
	if array_length(_collision) > 0 {
		var _obj = array_first(_collision)
		switch (_obj.object_index) {
			case obj_solid:
					direction += 90;
			break;
			case obj_button:
				if _obj.state = 1 {
					direction+=90
				}
			break;
			case obj_chest:
				if _obj.state = 1 {
					direction+=90
					_obj.state = 0
				}
			break;
			case obj_campfire:
				state = PLAYER_STATE.DEAD
			break;
			default:
			break;
		}

	}
	
	if state = PLAYER_STATE.ALIVE {
		switch (direction) {
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
	if state = PLAYER_STATE.DEAD {
		hmove = 0;
		vmove = 0;
		var _dr = time_source_get_state(death_ringer) 
		if (_dr == time_source_state_stopped) or (_dr == time_source_state_initial) {
			time_source_start(death_ringer)
		}
	}		
}

function player_sprite(){
	if state = PLAYER_STATE.ALIVE {
		image_speed = PLAYER_IMAGE_SPEED_MOVE;
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
	
	if state = PLAYER_STATE.DEAD {
		sprite_index = spr_player_death
		image_speed = PLAYER_IMAGE_SPEED_DEATH
	}
}

function player_draw(){
	draw_self_on_surface()
}