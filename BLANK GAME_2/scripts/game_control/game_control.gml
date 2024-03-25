// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function game_control_start(){
	MAIN_SURFACE = -1;
	surf = 0;
	enum PLAYER_STATE {
		ALIVE,
		DEAD	
	}
	
	enum GAME_STATE {
		MENU,
		PLAY,
		PAUSE
	}
	
	MAIN_SURFACE = 0;
	GUI_SURFACE = 0;
	global.main_surface_left = 0;
	global.main_surface_top = 0;
	global.main_surface_right = 0;
	global.main_surface_down = 0;
	global.game_state = GAME_STATE.MENU
	//game_set_camera(0,0)
}

function game_control_main(){
	if instance_exists(obj_player) {
		if obj_player.x > 96 MAIN_SURFACE_L = obj_player.x - 96
		if obj_player.y > 96 MAIN_SURFACE_T = obj_player.y - 96
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

function game_control_post_draw(){

}

function game_control_draw_surface() {
	if application_surface_is_enabled() {
		application_surface_enable(false)
		application_surface_draw_enable(false)
	}
	
	if !surface_exists(MAIN_SURFACE) {
		MAIN_SURFACE = surface_create(360,640)
	}
	
/*
	surf = sprite_create_from_surface(MAIN_SURFACE,
								MAIN_SURFACE_X,
								MAIN_SURFACE_Y,
								MAIN_SURFACE_W,
								MAIN_SURFACE_H,
								1,
								0,
								0,
								0)
	
	*/
									
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
		surface_set_target(GUI_SURFACE)
		draw_sprite_ext(OVERLAY_SPRITE,0,OVERLAY_X,OVERLAY_Y,1,1,0,c_white,1)	
		surface_reset_target()
		}
	 draw_surface(GUI_SURFACE,view_get_xport(0)+GUI_SURFACE_X,view_get_yport(0)+GUI_SURFACE_Y)
}

function game_control_draw(){
	game_set_surface();
	if surface_exists(MAIN_SURFACE) {
		surface_set_target(MAIN_SURFACE)
		surface_reset_target()	
	}
}

function game_control_draw_gui(){
	if surface_exists(GUI_SURFACE) {
		surface_set_target(GUI_SURFACE)
		draw_sprite_ext(OVERLAY_SPRITE,0,OVERLAY_X,OVERLAY_Y,1,1,0,c_white,1)	
		surface_reset_target()
	}
}

function game_control_pre_draw(){
 //	if surface_exists(MAIN_SURFACE) surface_free(MAIN_SURFACE)
//	if surface_exists(GUI_SURFACE)	surface_free(GUI_SURFACE)
}

function game_control_draw_end(){
	draw_clear(c_black)
	if surface_exists(MAIN_SURFACE) {
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

	}
	if surface_exists(GUI_SURFACE) draw_surface(GUI_SURFACE,view_get_xport(0)+GUI_SURFACE_X,view_get_yport(0)+GUI_SURFACE_Y)
}



function game_set_camera(_view = 0,_camera = 0){
	view_set_xport(_view,MAIN_SURFACE_X)
	view_set_yport(_view,MAIN_SURFACE_Y)
	view_set_wport(_view,MAIN_SURFACE_W)
	view_set_hport(_view,MAIN_SURFACE_H)
	view_set_visible(_view,true)
	view_set_camera(_view,_camera)
}

function game_control_first_room(){
	if room = rm_initialize {
		room_goto_next()
	}
}