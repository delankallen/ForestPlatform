shader_type canvas_item;
uniform vec3 color = vec3(0.01,0.12,0.12);
uniform vec4 color_picker : hint_color;
uniform int OCTAVES = 8;

float rand(vec2 coord) {
	return fract(sin(dot(coord.xy, vec2(12.9898,78.233)))* 43758.5453123);
}

float noise(vec2 coord) {
	vec2 i = floor(coord);
	vec2 f = fract(coord);
	
	float a = rand(i);
	float b = rand(i + vec2(1.0, 0.0));
	float c = rand(i + vec2(0.0, 1.0));
	float d = rand(i + vec2(1.0, 1.0));
	
	vec2 cubic = f * f * (3.0 - 2.0 * f);
	float value = mix(a, b, cubic.x) + (c - a) * cubic.y * (1.0 - cubic.x) + (d -b) * cubic.x * cubic.y;
	
	return value;
}

float fbm(vec2 coord) {
	float value = 0.0;
	float scale = 0.7;
	
	for(int i = 0; i < OCTAVES; i++) {
		value += noise(coord) * scale;
		coord *=2.0;
		scale *= 0.5;
	}
	
	return value;
}

void fragment() {
	vec2 coord = UV * 15.0;
	
	vec2 motion = vec2(fbm(coord + vec2(TIME *-0.2, TIME * -0.2)));
	
	vec3 final_color = vec3(color_picker.r, color_picker.g, color_picker.b);
	float final = fbm(coord + motion)*0.2;
	COLOR = vec4(final_color, final);
}