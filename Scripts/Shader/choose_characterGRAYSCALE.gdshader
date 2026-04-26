shader_type canvas_item;

uniform float grayscale_amount : hint_range(0.0, 1.0) = 1.0;

void fragment() {
    vec4 original_color = texture(TEXTURE, UV);

    float gray = dot(original_color.rgb, vec3(0.299, 0.587, 0.114));

    vec3 final_color = mix(original_color.rgb, vec3(gray), grayscale_amount);

    COLOR = vec4(final_color, original_color.a);
}