// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
// GAME CONTROL
#macro GAME obj_game_control
#macro SFX_VOL global.sfx_volume
#macro BGM_VOL global.bgm_volume

// MISC
#macro COLOR_1 #584422
#macro COLOR_2 #5E8549
#macro COLOR_3 #78A46A
#macro COLOR_4 #d4d29b

// SURFACES
#macro MAIN_SURFACE global.main_surface
#macro GUI_SURFACE global.gui_surface

#macro OVERLAY_SPRITE spr_gb_overlay
#macro OVERLAY_W sprite_width(OVERLAY_SPRITE)
#macro OVERLAY_H sprite_height(OVERLAY_SPRITE)
#macro OVERLAY_X 0 //window_get_width()/2
#macro OVERLAY_Y 0 //window_get_height()/2

#macro MAIN_SURFACE_W 200
#macro MAIN_SURFACE_H 200
#macro MAIN_SURFACE_X 86
#macro MAIN_SURFACE_Y 80

#macro MAIN_SURFACE_L	global.main_surface_left 
#macro MAIN_SURFACE_T	global.main_surface_top
#macro MAIN_SURFACE_R	global.main_surface_right
#macro MAIN_SURFACE_D	global.main_surface_down 

#macro GUI_SURFACE_W window_get_width()
#macro GUI_SURFACE_H window_get_height()
#macro GUI_SURFACE_X 0
#macro GUI_SURFACE_Y 0



// PLAYER SETTINGS //
// PLAYER SPRITE SETTINGS
#macro PLAYER_IMAGE_SPEED_DEATH 1
#macro PLAYER_IMAGE_SPEED_MOVE 0.2
