/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
player_move();
player_sprite()
if global.game_state = GAME_STATE.PLAY {
	player_reset();
	player_switch_button();
	player_switch_direction();
}