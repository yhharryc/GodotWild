shader_type canvas_item;
uniform vec2 player_position;
uniform vec4 color : hint_color = vec4(0.305, 0.298, 0.341,1);

uniform float MULTIPLIER = 0.56;
uniform float SCALE = 0.5;
uniform float SOFTNESS = 0.65;
uniform bool IS_MOVING;
uniform float u_time;
uniform float move_modifier;
float circle(vec2 position, float radius, float feather)
{
	return smoothstep(radius, radius + feather, dot(position, position ) * 8.0);
}

float vigTypeB(vec2 dude){
	float tempx;
	float tempy;
	if(IS_MOVING)
	{
		
		tempx = (sin(u_time) +cos(u_time*2.1))*move_modifier;
		
		tempy = cos(u_time) +sin(u_time*1.6)*move_modifier;
	}
	float vignette = circle(dude - vec2(player_position.x+tempx,player_position.y+tempy ), 0.1, 0.5);

	return vignette;
}

float vigTypeA(vec2 dude){
	float tempx;
	float tempy;
	if(IS_MOVING)
	{
		
		tempx = (sin(u_time) +cos(u_time*2.1))*move_modifier;
		
		tempy = cos(u_time) +sin(u_time*1.6)*move_modifier;
	}
	float val = distance(vec2(dude.x , dude.y * MULTIPLIER), vec2(player_position.x +tempx, player_position.y+tempy * MULTIPLIER));
	val = val / SCALE;
	float vignette = smoothstep(0.2, SOFTNESS, val);
	return vignette;
}

void fragment(){
	COLOR = vec4(color.rgb , vigTypeA(UV));
}


