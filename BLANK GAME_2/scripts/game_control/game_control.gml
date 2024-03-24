// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function game_control_start(){
	MAIN_SURFACE = 0;
	GUI_SURFACE = 0;
	game_set_camera()
}

function game_control_main(){
	if instance_exists(obj_player) {
		camera_set_view_target(0,obj_player)
	}
	game_set_surface();
}

function game_set_surface(){
	if !surface_exists(MAIN_SURFACE) MAIN_SURFACE = surface_create(MAIN_SURFACE_W,MAIN_SURFACE_H)
	if !surface_exists(GUI_SURFACE) GUI_SURFACE = surface_create(GUI_SURFACE_W,GUI_SURFACE_H)
	if application_surface_is_enabled() {
		application_surface_enable(false)
		application_surface_draw_enable(false)
	}
}

function game_control_draw_gui(){
	if surface_exists(GUI_SURFACE) {
		surface_set_target(GUI_SURFACE)
		draw_sprite_ext(OVERLAY_SPRITE,-1,OVERLAY_X,OVERLAY_Y,1,1,0,c_white,1)	
		surface_reset_target()
	}
}

function game_control_post_draw(){
	if surface_exists(MAIN_SURFACE) surface_free(MAIN_SURFACE)
	if surface_exists(GUI_SURFACE)	surface_free(GUI_SURFACE)
}

function game_control_draw_end(){
	shader_set(shader_scanlines2x)
	if surface_exists(MAIN_SURFACE) draw_surface(MAIN_SURFACE,MAIN_SURFACE_X,MAIN_SURFACE_Y)
	shader_reset();

	if surface_exists(GUI_SURFACE) draw_surface(GUI_SURFACE,view_get_xport(0)+GUI_SURFACE_X,view_get_yport(0)+GUI_SURFACE_Y)
}

function game_control_draw(){
	if surface_exists(MAIN_SURFACE) {
	//draw_sprite_ext(OVERLAY_SPRITE,-1,OVERLAY_X,OVERLAY_Y,1,1,0,c_white,1)	
	}
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