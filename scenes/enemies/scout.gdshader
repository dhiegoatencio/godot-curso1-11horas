shader_type canvas_item;

// deixa acessivel a variavel dentro de "Shader Parameters" no Inspector
instance uniform vec3 color: source_color = vec3(1); // é o mesmo que vec3(1,1,1) (total cor) branco
instance uniform float progress: hint_range(0.0, 1.0, 0.1) = 0; // aqui deixa o progresso da cor disponivel

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	float current_a = texture(TEXTURE, UV).a; // pega a transparencia atual
	
	// mistura a COR atual que é capturado por texture(TEXTURE, UV)
	// com a cor recebi via parametro documentado no UNIFORM acima
	// desse modo a imagem que não tem transparencia perfeita fica com a transparencia perfeita
	vec4 target_color = mix(texture(TEXTURE, UV), vec4(color, current_a), progress);

	// atribui a nova cor	
	COLOR = target_color;
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
