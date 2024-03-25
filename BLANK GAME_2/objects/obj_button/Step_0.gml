/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
switch (state) {
	case 0:
		if image_index = 2 {
			image_speed =-.5
		}
		if image_index = 0 {
			image_speed = 0;
		}
	break;
	case 1:
		if image_index = 0 {
			image_speed =.5
		}
		if image_index = 2 {
			image_speed = 0;
		}
	break;
}

if keyboard_check_pressed(vk_space) {
	state =!state
}