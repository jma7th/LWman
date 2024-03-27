// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function player_start() {
	hsp = 0;
	vsp = 0;
	vmove = 0;
	hmove = 1;
	dir = 0;
	movespeed = 1;
	direction = 270;
	directionstart = direction;
	turndirectionvalue = 90
	turndirection = turndirectionvalue*(global.player_turn)
	state = PLAYER_STATE.ALIVE
	disappear = time_source_create(time_source_game,2,time_source_units_seconds,function(){
		image_alpha = 0;
		x = xstart;
		y = ystart;
		direction = directionstart;
	})
	death_ringer = time_source_create(time_source_game,4,time_source_units_seconds,function(){
			image_alpha = 1;
			state = PLAYER_STATE.ALIVE;
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
		
}
function player_move(){
	if state = PLAYER_STATE.ALIVE && global.game_state = GAME_STATE.PLAY {
		turndirection = turndirectionvalue*(global.player_turn)
		if movespeed>0 {
			move_snap(movespeed,movespeed)
			}
	hsp = movespeed * hmove
	vsp = movespeed * vmove
		
	
	var _objlist = []
	
	for (var i = 0; i < instance_number(obj_stairs); ++i;)
	{
	    var _add = instance_find(obj_stairs,i);
		array_push(_objlist,_add)
	}
	/*
	for (var i = 0; i < instance_number(obj_enemy); ++i;)
	{
		
	    var _add = instance_find(obj_enemy,i);
		if _add.state = ENEMY_STATE.ALIVE {
			array_push(_objlist,_add)
		}
	}*/
	
	for (var i = 0; i < instance_number(obj_pt_right); ++i;)
	{
		
	    var _add = instance_find(obj_pt_right,i);
		if _add.x < x-movespeed && !place_meeting(x,y,_add) {
			array_push(_objlist,_add)
		}
	}
	
	for (var i = 0; i < instance_number(obj_pt_down); ++i;)
	{
		
	    var _add = instance_find(obj_pt_down,i);
		//if _add.y < y-movespeed && !place_meeting(x,y,_add){
		if vmove = -1 && !place_meeting(x,y,_add){ 
			array_push(_objlist,_add)
		}
	}
	
	for (var i = 0; i < instance_number(obj_pt_left); ++i;)
	{
		
	    var _add = instance_find(obj_pt_left,i);
		if _add.x > x+movespeed && !place_meeting(x,y,_add) {
			array_push(_objlist,_add)
		}
	}
	
	for (var i = 0; i < instance_number(obj_pt_up); ++i;)
	{
		
	    var _add = instance_find(obj_pt_up,i);
		if _add.y > y+movespeed && !place_meeting(x,y,_add){
			array_push(_objlist,_add)
		}
	}
	
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
			case obj_stairs:
				if !(room == room_last) {
					global.sfx_player_voice = audio_play_sound(snd_level_complete,0,0,SFX_VOL)
					room_goto_next()
				}
				if (room == rm_final) {
					room_goto(rm_title)
					score = 0;
					x = xstart;
					y = ystart;
				}
			break;
			case obj_enemy:
				state = PLAYER_STATE.DEAD
			break;
			case obj_solid:
					direction += turndirection;
					global.sfx_player_voice = audio_play_sound(snd_bump,0,0,SFX_VOL)
			break;
			case obj_button:
				if _obj.state = 1 {
					direction+=turndirection
					global.sfx_player_voice = audio_play_sound(snd_bump,0,0,SFX_VOL)
				}
			break;
			case  obj_pt_left:
					direction+=turndirection
					global.sfx_player_voice = audio_play_sound(snd_bump,0,0,SFX_VOL)
			break;
			case  obj_pt_right:
					direction+=turndirection
					global.sfx_player_voice = audio_play_sound(snd_bump,0,0,SFX_VOL)
			break;
			case  obj_pt_up:
					direction+=turndirection
					global.sfx_player_voice = audio_play_sound(snd_bump,0,0,SFX_VOL)
			break;
			case  obj_pt_down:
					direction+=turndirection
					global.sfx_player_voice = audio_play_sound(snd_bump,0,0,SFX_VOL)
			break;
			case obj_chest:
				if _obj.state = 1 {
					direction+=turndirection
					score+=200
					global.sfx_voice = audio_play_sound(snd_chest,0,0,SFX_VOL)
					_obj.state = 0
				}
			break;
			case obj_campfire:
				state = PLAYER_STATE.DEAD
				global.sfx_player_voice = audio_play_sound(snd_player_death,0,0,SFX_VOL)
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
	if state = PLAYER_STATE.DEAD {
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

function player_sprite(){
	if global.game_state = GAME_STATE.PLAY {
		if state = PLAYER_STATE.ALIVE {
			image_speed = PLAYER_IMAGE_SPEED_MOVE;
			switch (direction) {
				case 0: 
					if !(sprite_index = spr_player_side) sprite_index = spr_player_side		
					image_xscale = 1;
				break;
				case 90:
					if !(sprite_index = spr_player_up) sprite_index = spr_player_up;
				break;
				case 180: 
					if !(sprite_index = spr_player_side) sprite_index = spr_player_side;
					image_xscale = -1;
				break;
				case 270: 
					if !(sprite_index = spr_player_down) sprite_index = spr_player_down;
				break;
			}
		}
	
		if state = PLAYER_STATE.DEAD {
			if image_alpha = 1 {
				sprite_index = spr_player_death
				image_speed = PLAYER_IMAGE_SPEED_DEATH
			} else {
				image_speed = PLAYER_IMAGE_SPEED_MOVE;
				switch (direction) {
					case 0: 
						if !(sprite_index = spr_player_side) sprite_index = spr_player_side		
						image_xscale = 1;
					break;
					case 90:
						if !(sprite_index = spr_player_up) sprite_index = spr_player_up;
					break;
					case 180: 
						if !(sprite_index = spr_player_side) sprite_index = spr_player_side;
						image_xscale = -1;
					break;
					case 270: 
						if !(sprite_index = spr_player_down) sprite_index = spr_player_down;
					break;
					default:
					break;
				}
			}
		}
		if global.game_state = GAME_STATE.PAUSE {
			image_speed = 0;
		}
	}
}

function player_draw(){
	draw_self_on_surface()
}

function player_reset() {
	if input_check_pressed("special") && state = PLAYER_STATE.ALIVE{
		state = PLAYER_STATE.DEAD
		global.sfx_player_voice = audio_play_sound(snd_player_death,0,0,SFX_VOL)
	}
}

function player_switch_direction(){
	if input_check_pressed("change") {
		global.player_turn *=-1
		global.sfx_voice = audio_play_sound(snd_change,0,0,SFX_VOL)
	}
}

function player_switch_button(){
	if input_check_pressed("action") && !place_meeting(x,y,obj_button){
		with (obj_button) {
			state =!state
		}
		global.sfx_voice = audio_play_sound(snd_switch,0,0,SFX_VOL)
	}
}