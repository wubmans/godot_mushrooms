shader_type canvas_item;

uniform float flash = 0.0; // 0..1
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 0.0, 1.0);

void fragment() {
	vec4 c = texture(TEXTURE, UV);
	COLOR = mix(c, flash_color * c.a, flash);
}