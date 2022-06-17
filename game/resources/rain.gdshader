/*
	動的窓の雨 水滴シェーダー for Godot Engine by あるる（きのもと 結衣） @arlez80
	Procedural Window Raindrop Shader by Yui Kinomoto @arlez80

	MIT License
*/
shader_type spatial;

const float PI = 3.1415926535;

uniform float dripping_speed = 1.0;
uniform vec2 dripping_wave_size = vec2( 20.0, 4.0 );
uniform vec2 dripping_wave_freq = vec2( 47.0, 15.0 );
uniform vec2 dripping_wave_power = vec2( 0.045, 1.0 );

uniform float static_interval = 10.0;
uniform vec2 static_shift = vec2( 4.8, 0.8 );
uniform vec2 static_wave_size = vec2( 81.432143, 85.45453 );
uniform vec2 static_wave_freq = vec2( 38.0, 92.0 );
uniform vec2 static_wave_power = vec2( 1.8, 2.8 );

vec2 distance_line_point( vec2 a, vec2 b, vec2 p )
{
	vec2 v = b - a;
	vec2 vp = p - a;
	float r = clamp( dot( v, vp ) / dot( v, v ), 0.0, 1.0 );

	return mix(
		a - p
	,	b - p
	,	r
	);
}

void fragment( )
{
	vec2 uv_drip = UV * dripping_wave_size + vec2( cos( UV.y * dripping_wave_freq.x ), sin( UV.x * dripping_wave_freq.y ) ) * dripping_wave_power + vec2( 0.0, -TIME * dripping_speed );
	vec2 n = vec2( 0.5, 0.5 );

	// 動的雨粒
	vec2 v = distance_line_point( vec2( 0.5, 0.2 ), vec2( 0.5, 0.8 ), mod( uv_drip, 1.0 ) );
	n = mix( n, n - v * 10.0, float( length( v ) < mod( uv_drip.y, 1.0 ) * 0.1 ) );

	// 静的雨粒
	// n = mix( n, n )
	vec2 uv_static = static_shift + UV * static_wave_size + vec2( sin( cos( UV.y * static_wave_freq.x ) ), cos( sin( UV.x ) * static_wave_freq.y ) ) * static_wave_power;
	vec2 sv = mod( uv_static, static_interval ) - vec2( 0.5, 0.5 );
	n = mix( n, n + sv, float( length( sv ) < 0.5 ) );

	vec3 nv = normalize( vec3( n, 1.0 ) );

	ALBEDO = texture( SCREEN_TEXTURE, SCREEN_UV ).rgb;
	NORMALMAP = nv;
}