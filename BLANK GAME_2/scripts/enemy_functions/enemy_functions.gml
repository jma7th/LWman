// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function enemy_start() {
	hsp = 0;
	vsp = 0;
	vmove = 1;
	hmove = 0;
	direction = 270;
	movespeed = 1;
	hmovespeed = movespeed;
	vmovespeed = movespeed;
	state = ENEMY_STATE.ALIVE
	directionstart = direction
	turndirectionvalue = 90
	turnwithplayer = 1;
	turndirection = turndirectionvalue * (global.player_turn*turnwithplayer)
	disappear = time_source_create(time_source_game,2,time_source_units_seconds,function(){
		x = xstart;
		y = ystart;
		direction = directionstart;
		image_alpha = 0;
	})
	death_ringer = time_source_create(time_source_game,10,time_source_units_seconds,function(){
			image_alpha = 1;
			state = ENEMY_STATE.ALIVE;
		})
	respawn = time_source_create(time_source_game,4,time_source_units_frames,function(){
		switch (image_alpha) {
			case 0:
				image_alpha = 0.2
			case 0.2:
				image_alpha = 0.7
			break;
			case 0.7:
				image_alpha = 0.2
			break;
			default:
			break;
		}
	})
		
	step_sound = time_source_create(time_source_game,.8,time_source_units_seconds,function(){
		global.sfx_enemy_voice = audio_play_sound(snd_enemy_footsteps,0,0,SFX_VOL)
	})
}
function enemy_move(){
	if state = ENEMY_STATE.ALIVE  && global.game_state = GAME_STATE.PLAY {
		turndirection = turndirectionvalue * (global.player_turn*turnwithplayer)
		if instance_exists(obj_player) && (distance_to_object(obj_player) < 200) {
			if !audio_is_playing(global.sfx_enemy_voice) {
				global.sfx_enemy_voice = audio_play_sound(snd_enemy_footsteps,1,0,SFX_VOL)
			}
			/*var _ts = time_source_get_state(step_sound)
			if (_ts = time_source_state_initial) or (_ts == time_source_state_stopped) {
				time_source_start(step_sound)
			}*/
		} else {
			if audio_is_playing(global.sfx_enemy_voice) {
				audio_stop_sound(global.sfx_enemy_voice)
			}
		}
	
		move_snap(movespeed,movespeed)
		hsp = hmovespeed * hmove
		vsp = vmovespeed * vmove
	
		var _objlist = []
	
		for (var i = 0; i < instance_number(obj_solid); ++i;)
		{
		    var _add = instance_find(obj_solid,i);
			array_push(_objlist,_add)
		}
	
			for (var i = 0; i < instance_number(obj_pt_right); ++i;)
		{
		
		    var _add = instance_find(obj_pt_right,i);
			if _add.x < x && !place_meeting(x,y,_add) {
				array_push(_objlist,_add)
			}
		}
	
		for (var i = 0; i < instance_number(obj_pt_down); ++i;)
		{
		
		    var _add = instance_find(obj_pt_down,i);
			if _add.y < y && !place_meeting(x,y,_add){
				array_push(_objlist,_add)
			}
		}
	
		for (var i = 0; i < instance_number(obj_pt_left); ++i;)
		{
		
		    var _add = instance_find(obj_pt_left,i);
			if _add.x > x && !place_meeting(x,y,_add) {
				array_push(_objlist,_add)
			}
		}
	
		for (var i = 0; i < instance_number(obj_pt_up); ++i;)
		{
		
		    var _add = instance_find(obj_pt_up,i);
			if _add.y > y && !place_meeting(x,y,_add){
				array_push(_objlist,_add)
			}
		}
	
		for (var i = 0; i < instance_number(obj_button); ++i;)
		{
		
		    var _add = instance_find(obj_button,i);
			if _add.state = 1 && !place_meeting(x,y,_add){
				array_push(_objlist,_add)
			}
			if _add.state = 1 && place_meeting(x,y,_add){
				state = ENEMY_STATE.DEAD
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
						direction+=turndirection
				break;
				case obj_button:
						direction+=turndirection
				break;
				case obj_chest:
						direction+=turndirection
				break;
				case obj_pt_left:
						direction+=turndirection
				break;
				case obj_pt_right:
						direction+=turndirection
				break;
				case obj_pt_up:
						direction+=turndirection
				break;
				case obj_pt_down:
						direction+=turndirection
				break;
				case obj_campfire:
					state = ENEMY_STATE.DEAD
				break;
				default:
				break;
			}

		}
	
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
		var _dp = time_source_get_state(disappear)
		var _rp = time_source_get_state(respawn)
		if (_dr == time_source_state_stopped) or (_dr == time_source_state_initial) {
			time_source_start(death_ringer)
			time_source_start(disappear)
		}
		if (_dp == time_source_state_stopped) or (_dp == time_source_state_initial) {
			var _remain = time_source_get_time_remaining(death_ringer)
			if _remain < 3 {
				if (_rp == time_source_state_stopped) or (_rp == time_source_state_initial) {
					time_source_start(respawn)
				}
			}
		}
	}		
}

function enemy_sprite(){
	if global.game_state = GAME_STATE.PLAY {
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
			if image_alpha = 1 {
				sprite_index = spr_enemy_death
			image_speed = PLAYER_IMAGE_SPEED_DEATH
			} else {
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
					default:
					break;
				}
			}
		}
	}
	
	if global.game_state = GAME_STATE.PAUSE {
		image_speed = 0;	
	}
	
}

function enemy_draw(){
	draw_self_on_surface()
}
