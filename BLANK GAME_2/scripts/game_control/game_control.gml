// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações

function game_control_start(){
	MAIN_SURFACE = -1;
	
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
	
	MAIN_SURFACE = 0;
	GUI_SURFACE = 0;
	global.main_surface_left = 0;
	global.main_surface_top = 0;
	global.main_surface_right = 0;
	global.main_surface_down = 0;
	global.game_state = GAME_STATE.MENU
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

function game_control_tutorial(){
	if input_check_pressed("accept") {
		room_goto_next()
	}
}

function game_control_draw_surface() {
	if application_surface_is_enabled() {
		application_surface_enable(false)
		application_surface_draw_enable(false)
	}
	
	if !surface_exists(MAIN_SURFACE) {
		MAIN_SURFACE = surface_create(360,640)
	}
	
	if (room == rm_tutorial) {
		surface_set_target(MAIN_SURFACE)
		draw_set_color(COLOR_1)
		draw_set_font(fnt_default)
		draw_set_halign(fa_left)
		draw_text_scribble_ext(32,8," Help Maddie climb the tower of Tomba while collecting the treasures scattered along the way.\n\nShe loves to run! Maybe a little too much.\n\nGuide her by unlocking the gates at the right time, and sealing them again to keep her safe from enemies!",152)
		surface_reset_target()
	}
									
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
		draw_set_color(COLOR_4)
		draw_rectangle(MAIN_SURFACE_X,282-14,400,280,0)
		draw_set_color(COLOR_1)
		draw_text(MAIN_SURFACE_X,282-14,$"Score: {score}")
		draw_sprite_ext(OVERLAY_SPRITE,0,OVERLAY_X,OVERLAY_Y,1,1,0,c_white,1)	
		surface_reset_target()
	draw_surface(GUI_SURFACE,view_get_xport(0)+GUI_SURFACE_X,view_get_yport(0)+GUI_SURFACE_Y)
	
	surface_set_target(GUI_SURFACE)
	//draw_clear_alpha(c_black,0)
	surface_reset_target();
}



function game_control_first_room(){
	if room = rm_initialize {
		room_goto_next()
	}
}