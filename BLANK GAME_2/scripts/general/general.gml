// Os recursos de script mudaram para a v2.3.0; veja
// https://help.yoyogames.com/hc/en-us/articles/360005277377 para obter mais informações
function draw_self_on_surface(_surface = MAIN_SURFACE,
_sprite = sprite_index,
_image = image_index,
_x = x,
_y = y,
_xscale = image_xscale,
_yscale = image_yscale,
_angle = image_angle,
_blend = image_blend,
_alpha = image_alpha
) {
	if surface_exists(MAIN_SURFACE) {
		surface_set_target(MAIN_SURFACE)
		draw_sprite_ext(_sprite,_image,_x,_y,_xscale,_yscale,_angle,_blend,_alpha)
		surface_reset_target();
	}
}