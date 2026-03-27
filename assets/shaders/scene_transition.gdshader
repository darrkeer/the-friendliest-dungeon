shader_type canvas_item;

uniform float size = 4000;

const vec4 BLACK = vec4(0, 0, 0, 1);
const vec4 TRANSPARENT = vec4(0, 0, 0, 0);

void fragment() {
	vec2 xy = FRAGCOORD.xy;
	vec2 mid = 1.0 / SCREEN_PIXEL_SIZE * 0.5;
	if (distance(xy, mid) >= size) {
		COLOR = BLACK;
	} else {
		COLOR = TRANSPARENT;
	}
}
