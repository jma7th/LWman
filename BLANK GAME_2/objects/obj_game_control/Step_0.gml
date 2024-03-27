/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
game_control_main()
if (room == rm_title) or (room == rm_tutorial) {
	game_control_tutorial()
}

if !(room == rm_title) and !(room == rm_tutorial) and !(room == rm_final) {
	game_control_pause_event()
}