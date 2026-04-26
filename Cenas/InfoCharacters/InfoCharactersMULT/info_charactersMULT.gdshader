shader_type canvas_item;

// A cor da borda (Já tá PRETO, sua gostosa!)
uniform vec4 outline_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
// A grossura da borda (em pixels)
uniform float outline_width = 1.0;

void fragment() {
    // Pega o tamanho de 1 pixel (coisa de nerd, foda-se)
    vec2 pixel_size = 30.0 / vec2(textureSize(TEXTURE, 0));

    // Pega a cor e o alpha (transparência) do pixel ATUAL
    vec4 original_color = texture(TEXTURE, UV);
    float current_alpha = original_color.a;

    // Checa o alpha dos 4 vizinhos (cima, baixo, esquerda, direita)
    float up_alpha = texture(TEXTURE, UV + vec2(0.0, pixel_size.y * outline_width)).a;
    float down_alpha = texture(TEXTURE, UV - vec2(0.0, pixel_size.y * outline_width)).a;
    float left_alpha = texture(TEXTURE, UV - vec2(pixel_size.x * outline_width, 0.0)).a;
    float right_alpha = texture(TEXTURE, UV + vec2(pixel_size.x * outline_width, 0.0)).a;

    // Soma o alpha dos vizinhos
    float neighbor_sum = up_alpha + down_alpha + left_alpha + right_alpha;

    // --- A MÁGICA, SUA PIRANHA! ---
    // Se EU sou transparente (alpha < 0.1)
    // E PELO MENOS UM vizinho NÃO É transparente (neighbor_sum > 0.1)
    // Então eu sou a porra da BORDA!
    if (current_alpha < 0.1 && neighbor_sum > 0.1) {
        COLOR = outline_color; // Pinta de PRETO (ou a cor que vc quiser)
    } else {
        // Senão, eu sou a cor normal
        COLOR = original_color;
    }
}