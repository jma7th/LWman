// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function game_control_start(){
	MAIN_SURFACE = -1;
	mysurf = -1;
	enum DRAW_MODE {
		DEFAULT,
		CUSTOM
	}
	global.drawing_mode =  DRAW_MODE.DEFAULT
	global.current_os = os_type
	enum PLAYER_STATE {
		ALIVE,
		DEAD	
	}
	
	enum ENEMY_STATE {
		ALIVE,
		DEAD	
	}
	
	enum GAME_STATE {
		MENU,
		PLAY,
		PAUSE
	}
	
	enum CAMERA_MODE {
		FIXED,
		FOLLOW
	}
	global.player_turn = 1;
	global.bgm_voice = 0;
	global.sfx_player_voice = 0;
	global.sfx_voice = 0;
	global.sfx_gui_voice = 0;
	global.sfx_enemy_voice = 0;
	
	global.bgm_volume = 0.8
	global.sfx_volume = 0.6
	
	MAIN_SURFACE = 0;
	GUI_SURFACE = 0;
	global.main_surface_left = 0;
	global.main_surface_top = 0;
	global.main_surface_right = 0;
	global.main_surface_down = 0;
	global.game_state = GAME_STATE.PLAY
	
	global.gui_android_width = display_get_gui_width()
	global.gui_android_height = display_get_gui_height()
	global.gui_xscale = 1// global.gui_android_width 
	global.gui_yscale = 1 // global.gui_android_height 
	
	global.camera_mode = CAMERA_MODE.FIXED
	_tileset_walls[20][20] = 0
	
	game_control_touch_start()
}

function game_control_view_setup(_room_x = -80, _room_y = -80) {
	camera_destroy(view_camera[0])
	view_enabled = true;
	room_set_view_enabled(0,true)
	view_set_visible(0,true)
	view_set_xport(0,0)
	view_set_yport(0,0)
	view_set_wport(0,360)
	view_set_hport(0,640)

	view_camera[0] = camera_create_view(_room_x, _room_y, view_get_wport(0), view_get_hport(0))
	camera_set_view_border(view_camera[0],200,200)
	
}

function game_control_main(){
	
	if instance_exists(obj_player) {
		if global.camera_mode = CAMERA_MODE.FOLLOW {
			if room = rm_final { camera_set_view_pos(view_camera[0],-84,obj_player.y-96) }
			else {
			camera_set_view_pos(view_camera[0],obj_player.x-184,obj_player.y-184)
			}
		}
		
		//camera_set_view_size(view_camera[0],200,200)
		if global.drawing_mode = DRAW_MODE.CUSTOM {
			if obj_player.x > 96 MAIN_SURFACE_L = obj_player.x - 96
			if obj_player.y > 96 MAIN_SURFACE_T = obj_player.y - 96
		} else {
			//if obj_player.x > 96 {
				//camera_set_view_pos(view_camera[0],camera_get_view_x(view_camera[0])+obj_player.x,
				//camera_get_view_y(view_camera[0])+obj_player.y)
			//	view_set_xport(0, obj_player.x - 96)
			//}
			//if obj_player.y > 96 {
				//camera_set_view_pos(view_camera[0],camera_get_view_x(view_camera[0]),obj_player.y - 96)
			//	view_set_yport(0, obj_player.y - 96)
			//}
		}
	}
	
	
	if vbutton_action.pressed() or vbutton_accept.pressed() or vbutton_special.pressed() 
	or vbutton_change.pressed() {
		global.sfx_gui_voice = audio_play_sound(snd_button_click,0,0,SFX_VOL)
	}
	

	if layer_exists("Walls") {
		if layer_exists("Solid") {
			//if (layer_get_depth("Walls") > layer_get_depth("Solid"))	{
				layer_depth("Walls",	layer_get_depth("Solid")-100);
			//}
		}
	}

	if layer_exists("Player") {
		if layer_exists("Ground") {
			//if (layer_get_depth("Player") < layer_get_depth("Ground"))	{
				layer_depth("Player",	layer_get_depth("Ground")-100);
			//}
		}
	}

	if layer_exists("Instances") {
		if layer_exists("Player") {
			//if  (layer_get_depth("Instances") < layer_get_depth("Player"))	{
				layer_depth("Instances",	layer_get_depth("Player")+90);
			//}
		}
	}
}

function game_set_surface(){
	if !surface_exists(MAIN_SURFACE) MAIN_SURFACE = surface_create(360,640)
	if !surface_exists(GUI_SURFACE) GUI_SURFACE = surface_create(GUI_SURFACE_W,GUI_SURFACE_H)
	if application_surface_is_enabled() {
		application_surface_enable(false)
		application_surface_draw_enable(false)
	}
}

function game_control_tutorial(){
	if input_check_pressed("accept") {
		room_goto_next()
	}
}

function game_control_draw() {
	if (room == rm_title) {
		
		draw_set_alpha(1)
		draw_set_color(COLOR_4)
		draw_rectangle(-4,40,MAIN_SURFACE_W,80,0)

		draw_set_color(COLOR_1)
		draw_set_font(fnt_title)
		draw_set_halign(fa_center)
		draw_text_scribble(MAIN_SURFACE_W/2,48,"Maddie Rush")
			draw_set_alpha(0.5)
		draw_set_color(COLOR_3)
		draw_rectangle(-4,42,MAIN_SURFACE_W,64,0)
		draw_set_color(COLOR_2)
		draw_rectangle(-4,64,MAIN_SURFACE_W,80,0)
		draw_set_alpha(1)

	}
	
	if (room == rm_tutorial) {

		draw_set_color(COLOR_1)
		draw_set_font(fnt_default)
		draw_set_halign(fa_left)
		draw_text_scribble_ext(32,8," Help Maddie climb the tower of Manga while collecting the treasures scattered along the way.\n\nShe loves to run! Maybe a little too much.\n\nGuide her by unlocking the gates at the right time with the space bar or screen buttons, and sealing them again to keep her safe from enemies!",152)

	}
	
	if (room == rm_final) {

		draw_set_color(COLOR_1)
		draw_set_font(fnt_default)
		draw_set_halign(fa_left)
		draw_text_scribble_ext(32,8," Congratulations!\nYou've helped Maddie reach the top of the tower of Manga.\n\n\n\n\nThis is a demo made for the GameVita 3.0 game jam, that ran from March 22nd 2024 at 12:30 AM to March 26th 2024 at 12:30 AM.\n\n\nResources used:\n-Super Gameboy Quest by Toadzilla\n-2bit character generator by 0x72\n-512 sounds By Juhani Junkala\n-EARLY GAMEBOY FONT by JIMMY CAMPBELL\n-Alagard font by Hewett Tsoi\n-BGM samples provided by the jam host\n\nMade by jma7th\n\n\n\n\n\n\nYour final score is: "+string(score)+"\n\n\n\n\nThank you for playing!",152)

	}
}

function game_control_draw_gui() {
	draw_set_font(fnt_default)
		draw_set_halign(fa_left)
		if (room == rm_tutorial) {
		draw_set_color(COLOR_4)
		draw_rectangle(MAIN_SURFACE_X,282-16,400,290,0)
		draw_set_color(COLOR_1)
		draw_text(MAIN_SURFACE_X,282-16,$"Press start to continue.")
		} else {
			if !(room == rm_title) and !(room == rm_final){
				draw_set_color(COLOR_4)
				draw_rectangle(MAIN_SURFACE_X,282-16,400,290,0)
				draw_set_color(COLOR_1)
				if global.game_state = GAME_STATE.PLAY {
					draw_text(MAIN_SURFACE_X,282-16,$"Score: {score}")
				} else {
					draw_text(MAIN_SURFACE_X,282-16,$"PAUSED!")
				}
			}
		}
		
		draw_sprite_ext(OVERLAY_SPRITE,0,OVERLAY_X,OVERLAY_Y,1,1,0,c_white,1)
		
		if vbutton_action.check() {draw_sprite(spr_button_b,-1,258,448)}
		if vbutton_change.check() {draw_sprite(spr_button_b,-1,318,418)}
		if vbutton_accept.check() {draw_sprite(spr_button_c,-1,194,533)}
		if vbutton_special.check() {draw_sprite(spr_button_c,-1,132,532)}

}

function game_control_draw_surface() {
	if application_surface_is_enabled() {
		application_surface_enable(false)
		application_surface_draw_enable(false)
	}
	

	
	if !surface_exists(MAIN_SURFACE) {
		MAIN_SURFACE = surface_create(360,640)
	}
	
	if (room == rm_title) {
		surface_set_target(MAIN_SURFACE)
		draw_set_alpha(1)
		draw_set_color(COLOR_4)
		draw_rectangle(-4,40,MAIN_SURFACE_W,80,0)

		draw_set_color(COLOR_1)
		draw_set_font(fnt_title)
		draw_set_halign(fa_center)
		draw_text_scribble(MAIN_SURFACE_W/2,48,"Maddie Rush")
			draw_set_alpha(0.5)
		draw_set_color(COLOR_3)
		draw_rectangle(-4,42,MAIN_SURFACE_W,64,0)
		draw_set_color(COLOR_2)
		draw_rectangle(-4,64,MAIN_SURFACE_W,80,0)
		draw_set_alpha(1)
		surface_reset_target()
	}
	
	if (room == rm_tutorial) {
		surface_set_target(MAIN_SURFACE)
		draw_set_color(COLOR_1)
		draw_set_font(fnt_default)
		draw_set_halign(fa_left)
		draw_text_scribble_ext(32,8," Help Maddie climb the tower of Manga while collecting the treasures scattered along the way.\n\nShe loves to run! Maybe a little too much.\n\nGuide her by unlocking the gates at the right time with the space bar or screen buttons, and sealing them again to keep her safe from enemies!",152)
		surface_reset_target()
	}
	
	if (room == rm_final) {
		surface_set_target(MAIN_SURFACE)
		draw_set_color(COLOR_1)
		draw_set_font(fnt_default)
		draw_set_halign(fa_left)
		draw_text_scribble_ext(32,8," Congratulations!\nYou've helped Maddie reach the top of the tower of Manga.\n\n\n\n\nThis is a demo made for the GameVita 3.0 game jam, that ran from March 22nd 2024 at 12:30 AM to March 26th 2024 at 12:30 AM.\n\n\nResources used:\n-Super Gameboy Quest by Toadzilla\n-2bit character generator by 0x72\n-512 sounds By Juhani Junkala\n-EARLY GAMEBOY FONT by JIMMY CAMPBELL\n-Alagard font by Hewett Tsoi\n-BGM samples provided by the jam host\n\nMade by jma7th\n\n\n\n\n\n\nYour final score is: "+string(score)+"\n\n\n\n\nThank you for playing!",152)
		surface_reset_target()
	}

	/*
	if layer_exists("Walls") {
		layer_set
	}/*
		var lay_id = layer_get_id("Walls");
		var map_id = layer_tilemap_get_id(lay_id);
		layer_set_visible(lay_id,false)
		
		for (var i = 0; i < tilemap_get_width(map_id); i++;)
		{
			for (var j = 0; j < tilemap_get_height(map_id); j++;)
			{
				var data = tilemap_get(map_id, i, j);
				if !tile_get_empty(data)
				{
					var _arr = []
					array_insert(_arr,j,data)
				    array_insert(_tileset_walls,i,_arr)
					//data = tile_set_empty(data)
				    //tilemap_set(map_id, data, i, j);
				}
			}
		}
		
		for (var k = 0; k < array_length(_tileset_walls); k++) 
		{	
			for (var l = 0; l < array_length(_tileset_walls[k]); l++) 
			{
				surface_set_target(MAIN_SURFACE)
				draw_tile(tl_walls,_tileset_walls[k][l],0,MAIN_SURFACE_X+(16*k),MAIN_SURFACE_Y+(16*l))
				surface_reset_target();
			}
		}
	}*/
	/*mysurf = sprite_create_from_surface(MAIN_SURFACE,0,0,surface_get_width(MAIN_SURFACE),surface_get_height(MAIN_SURFACE),0,0,0,0)
	/*draw_sprite_general(mysurf,
								-1,
								MAIN_SURFACE_L,
								MAIN_SURFACE_T,
								MAIN_SURFACE_W,
								MAIN_SURFACE_H,
								MAIN_SURFACE_X,
								MAIN_SURFACE_Y,
								1,
								1,
								0,
								c_white,
								c_white,
								c_white,
								c_white,
								1
								)*/
	
	draw_surface_general(	MAIN_SURFACE,
															MAIN_SURFACE_L,
															MAIN_SURFACE_T,
															MAIN_SURFACE_W,
															MAIN_SURFACE_H,
															MAIN_SURFACE_X,
															MAIN_SURFACE_Y,
															1,
															1,
															0,
															#9a783c,
															c_white,
															c_white,
															c_white,
															1
															)
	
	surface_set_target(MAIN_SURFACE)
	draw_clear_alpha(c_black,0)
	surface_reset_target();
	
	if !surface_exists(GUI_SURFACE) {
		GUI_SURFACE = surface_create(GUI_SURFACE_W,GUI_SURFACE_H)
		}
		
	surface_set_target(GUI_SURFACE)
		draw_set_font(fnt_default)
		draw_set_halign(fa_left)
		if (room == rm_tutorial) {
		draw_set_color(COLOR_4)
		draw_rectangle(MAIN_SURFACE_X,282-16,400,290,0)
		draw_set_color(COLOR_1)
		draw_text(MAIN_SURFACE_X,282-16,$"Press start to continue.")
		} else {
			if (room == rm_title) or (room == rm_final){
				draw_clear_alpha(c_black,0)
			} else {
				draw_set_color(COLOR_4)
				draw_rectangle(MAIN_SURFACE_X,282-16,400,290,0)
				draw_set_color(COLOR_1)
				if global.game_state = GAME_STATE.PLAY {
					draw_text(MAIN_SURFACE_X,282-16,$"Score: {score}")
				} else {
					draw_text(MAIN_SURFACE_X,282-16,$"PAUSED!")
				}
			}
		}
		
		draw_sprite_ext(OVERLAY_SPRITE,0,OVERLAY_X,OVERLAY_Y,1,1,0,c_white,1)
		
		if vbutton_action.check() {draw_sprite(spr_button_b,-1,258,448)}
		if vbutton_change.check() {draw_sprite(spr_button_b,-1,318,418)}
		if vbutton_accept.check() {draw_sprite(spr_button_c,-1,194,533)}
		if vbutton_special.check() {draw_sprite(spr_button_c,-1,132,532)}
		//input_virtual_debug_draw();
		surface_reset_target()
		/*if (os_type == os_android) {
			draw_surface_general(	GUI_SURFACE,
									0,
									0,
									view_get_xport(0),
									view_get_yport(0),
									display_get_gui_width(),
									display_get_gui_height(),
									global.gui_xscale,
									global.gui_yscale,
									0,
									c_white,
									c_white,
									c_white,
									c_white,
									1
									)
		}
		else {*/
			draw_surface(	GUI_SURFACE,
									view_get_xport(0)+GUI_SURFACE_X,
									view_get_yport(0)+GUI_SURFACE_Y
									)
		
	surface_set_target(GUI_SURFACE)
	//draw_clear_alpha(c_black,0)
	surface_reset_target();
}



function game_control_first_room(){
	if room = rm_initialize {
		room_goto_next()
	}
}

function game_control_pause_event(){
	if input_check_pressed("accept") {
		switch (global.game_state){
			case GAME_STATE.PLAY:
				global.game_state = GAME_STATE.PAUSE
			break;
			case GAME_STATE.PAUSE:
				global.game_state = GAME_STATE.PLAY
			break;
			default:
				global.game_state = GAME_STATE.PLAY
			break;
		}
	}
}

function game_control_touch_start() {
	var _xscale = 1;
	var _yscale = 1;
	if (display_get_gui_height() > 360) {
		_xscale = display_get_gui_width() / 360
		_yscale = display_get_gui_height() / 640
	}
	vbutton_action = input_virtual_create().button("action").circle(258*_xscale,448*_yscale,35*_xscale);
	vbutton_change = input_virtual_create().button("change").circle(318*_xscale,418*_yscale,35*_xscale);
	vbutton_accept = input_virtual_create().button("accept").circle(196*_xscale,532*_yscale,28*_xscale);
	vbutton_special = input_virtual_create().button("special").circle(132*_xscale,532*_yscale,28*_xscale);
	//display_get_gui_width() / 360 
	/*
	vbutton_action = input_virtual_create().button("action").circle(448*_yscale,258*_xscale,35*_yscale);
	vbutton_change = input_virtual_create().button("change").circle(418*_yscale,318*_xscale,35*_yscale);
	vbutton_accept = input_virtual_create().button("accept").circle(532*_yscale,196*_xscale,28*_yscale);
	vbutton_special = input_virtual_create().button("special").circle(532*_yscale,132*_xscale,28*_yscale);
	*/
	/*
	vbutton_action = input_virtual_create().button("action").circle(258*_yscale,448*_xscale,35*_yscale);
	vbutton_change = input_virtual_create().button("change").circle(318*_yscale,418*_xscale,35*_yscale);
	vbutton_accept = input_virtual_create().button("accept").circle(196*_yscale,532*_xscale,28*_yscale);
	vbutton_special = input_virtual_create().button("special").circle(132*_yscale,532*_xscale,28*_yscale);
	*/
}

function game_control_room_start(){

	//if global.drawing_mode = DRAW_MODE.DEFAULT {
	//	game_control_view_setup() 
		//show_message_async(camera_get_view_x(view_camera[0]))
	//}

	if global.drawing_mode = DRAW_MODE.CUSTOM {
	MAIN_SURFACE_T = 0;
	MAIN_SURFACE_L = 0;
	
	

	if layer_exists("Walls") {

		layer_script_begin("Walls",layer_shader_start)
		layer_script_end("Walls",layer_shader_end)
	}
	if layer_exists("Ground") {

		layer_script_begin("Ground",layer_shader_start)
		layer_script_end("Ground",layer_shader_end)
	}
	if layer_exists("Surground") {
		layer_script_begin("Surground",layer_shader_start)
		layer_script_end("Surground",layer_shader_end)
	}
	if layer_exists("Solid") {
		layer_script_begin("Solid",layer_shader_start)
		layer_script_end("Solid",layer_shader_end)
	}
	if layer_exists("Instances") {
		layer_script_begin("Instances",layer_shader_start)
		layer_script_end("Instances",layer_shader_end)
	}
	if layer_exists("Player") {
		layer_script_begin("Player",layer_shader_start)
		layer_script_end("Player",layer_shader_end)
	}
	}
	
	switch (room) {
		case rm_title:
			global.camera_mode = CAMERA_MODE.FIXED
			game_control_view_setup(-80,-80)
			
			audio_stop_sound(global.bgm_voice)
			global.bgm_voice = audio_play_sound(snd_title,0,1,BGM_VOL)
		break;
		case rm_tutorial:
			game_control_view_setup(-80,-80)
			if !(global.game_state = GAME_STATE.PLAY) {
				global.game_state = GAME_STATE.PLAY
			}
		break;
		case rm_stage:
			global.camera_mode = CAMERA_MODE.FOLLOW
			game_control_view_setup(-80,-80)
			audio_stop_sound(global.bgm_voice)
			global.bgm_voice = audio_play_sound(snd_stages,0,1,BGM_VOL)
		break;
		case rm_stage_2:
			game_control_view_setup(-80,-80)
			break;
		case rm_stage_3:
			game_control_view_setup(-80,-80)
			break;
		case rm_final:
			game_control_view_setup(-80,-80)
			global.camera_mode = CAMERA_MODE.FOLLOW
			audio_stop_sound(global.bgm_voice)
			global.bgm_voice = audio_play_sound(snd_final,0,1,BGM_VOL)
		break;
		default:
			
		break;
	}
	
}

function layer_shader_start()
{
    if event_type == ev_draw
    {
		if surface_exists(MAIN_SURFACE)
		surface_set_target(MAIN_SURFACE)
	}
}

function layer_shader_end()
{
    if event_type == ev_draw
    {
		surface_reset_target()
	}
}