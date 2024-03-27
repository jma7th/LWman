/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor
if other.state = ENEMY_STATE.ALIVE && state = PLAYER_STATE.ALIVE{
	state = PLAYER_STATE.DEAD
	global.sfx_player_voice = audio_play_sound(snd_player_death,0,0,SFX_VOL)
}
