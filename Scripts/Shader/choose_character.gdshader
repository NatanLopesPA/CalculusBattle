// Define que é um shader 2D
shader_type canvas_item;

// A cor da borda (Branco por padrão)
uniform vec4 outline_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);
// A cor da silhueta (Preto por padrão)
uniform vec4 silhouette_color : source_color = vec4(0.0, 0.0, 0.0, 1.0);
// A largura da borda
uniform float outline_width : hint_range(0.0, 10.0) = 1.0;

void fragment() {
    // Pega o alpha (transparência) do pixel atual
    float current_alpha = texture(TEXTURE, UV).a;
    
    // 1. Se o pixel atual NÃO é transparente (é o corpo do sprite)
    if (current_alpha > 0.1) {
        // Pinta ele de preto (a cor da silhueta)
        COLOR = silhouette_color;
        
    } else {
        // 2. Se o pixel atual é transparente, checamos se ele deve ser a borda
        
        // Pega o tamanho de 1 pixel
        vec2 pixel_size = 1.0 / vec2(textureSize(TEXTURE, 0));
        
        // Checa os 4 vizinhos (cima, baixo, esquerda, direita)
        float up_alpha = texture(TEXTURE, UV + vec2(0.0, pixel_size.y * outline_width)).a;
        float down_alpha = texture(TEXTURE, UV - vec2(0.0, pixel_size.y * outline_width)).a;
        float left_alpha = texture(TEXTURE, UV - vec2(pixel_size.x * outline_width, 0.0)).a;
        float right_alpha = texture(TEXTURE, UV + vec2(pixel_size.x * outline_width, 0.0)).a;
        
        // Soma a transparência dos vizinhos
        float neighbor_sum = up_alpha + down_alpha + left_alpha + right_alpha;
        
        // Se este pixel é transparente, mas algum vizinho não é...
        if (neighbor_sum > 0.1) {
            // ...então este pixel é a borda. Pinta ele de branco.
            COLOR = outline_color;
        } else {
            // Senão, é só espaço vazio (transparente)
            COLOR = vec4(0.0);
        }
    }
}