shader_type spatial;

uniform vec4 tile_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
	// Called for every pixel the material is visible on.
	ALBEDO = tile_color.rgb;
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
