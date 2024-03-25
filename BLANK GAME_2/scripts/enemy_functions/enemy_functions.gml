// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function enemy_start() {
	hsp = 0;
	vsp = 0;
	vmove = 0;
	hmove = 1;
	direction = 270;
	movespeed = 2;
	hmovespeed = movespeed;
	vmovespeed = movespeed;
	state = ENEMY_STATE.ALIVE
	directionstart = direction
	disappear = time_source_create(time_source_game,2,time_source_units_seconds,function(){
		image_alpha = 0;
	})
	death_ringer = time_source_create(time_source_game,10,time_source_units_seconds,function(){
			x = xstart;
			y = ystart;
			direction = directionstart;
			image_alpha = 1;
			state = ENEMY_STATE.ALIVE;
		})
		
		
}
function enemy_move(){
	move_snap(movespeed,movespeed)
	hsp = hmovespeed * hmove
	vsp = vmovespeed * vmove
	
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
					direction+=90;
			break;
			case obj_button:
					direction+=90
			break;
			case obj_chest:
					direction+=90
			break;
			case obj_campfire:
				state = ENEMY_STATE.DEAD
			break;
			default:
			break;
		}

	}
	
	if state = ENEMY_STATE.ALIVE {
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
	if state = ENEMY_STATE.DEAD {
		hmove = 0;
		vmove = 0;
		var _dr = time_source_get_state(death_ringer) 
		if (_dr == time_source_state_stopped) or (_dr == time_source_state_initial) {
			time_source_start(death_ringer)
			time_source_start(disappear)
		}
	}		
}

function enemy_sprite(){
	if state = ENEMY_STATE.ALIVE {
		image_speed = PLAYER_IMAGE_SPEED_MOVE;
		switch (direction) {
			case 0: sprite_index = spr_enemy_side;
				image_xscale = 1;
			break;
			case 90: sprite_index = spr_enemy_up;
			break;
			case 180: sprite_index = spr_enemy_side;
				image_xscale = -1;
			break;
			case 270: sprite_index = spr_enemy_down;
			break;
		}
	}
	
	if state = ENEMY_STATE.DEAD {
		sprite_index = spr_enemy_death
		image_speed = PLAYER_IMAGE_SPEED_DEATH
	}
}

function enemy_draw(){
	draw_self_on_surface()
}
