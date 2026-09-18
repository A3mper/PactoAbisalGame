shader_type canvas_item;

uniform float hover_alpha : hint_range(0.0, 1.0) = 0.35;

void fragment() {
    vec4 tex = texture(TEXTURE, UV);

    tex.a *= hover_alpha;

    COLOR = tex;
}