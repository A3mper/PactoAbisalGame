shader_type canvas_item;

// ============================================================
// HOVER
// ============================================================

uniform bool hover_enabled = false;


// ============================================================
// COLOR
// ============================================================

uniform vec4 hover_color : source_color = vec4(0.25, 1.0, 0.85, 1.0);

uniform float color_strength : hint_range(0.0, 1.0) = 0.35;


// ============================================================
// GLOW
// ============================================================

uniform vec4 glow_color : source_color = vec4(0.25, 1.0, 0.85, 1.0);

uniform float glow_strength : hint_range(0.0, 3.0) = 1.5;

uniform float glow_size : hint_range(0.0, 0.05) = 0.015;


// ============================================================
// TITILEO
// ============================================================

uniform float flicker_speed : hint_range(0.1, 20.0) = 5.0;

uniform float flicker_min : hint_range(0.0, 1.0) = 0.5;

uniform float flicker_max : hint_range(0.0, 1.0) = 1.0;


void fragment() {

    // --------------------------------------------------------
    // TEXTURA ORIGINAL
    // --------------------------------------------------------

    vec4 tex = texture(TEXTURE, UV);

    // Variables que utilizaremos para el resultado
    vec3 final_color = tex.rgb;
    float final_alpha = tex.a;


    // --------------------------------------------------------
    // EFECTOS SOLO CUANDO HAY HOVER
    // --------------------------------------------------------

    if (hover_enabled) {

        // ----------------------------------------------------
        // TITILEO DE OPACIDAD
        // Oscila entre 50% y 100%
        // ----------------------------------------------------

        float flicker = sin(TIME * flicker_speed);

        flicker = (flicker + 1.0) * 0.5;

        float alpha_effect = mix(
            flicker_min,
            flicker_max,
            flicker
        );

        final_alpha = tex.a * alpha_effect;


        // ----------------------------------------------------
        // CAMBIO DE COLOR
        // ----------------------------------------------------

        final_color = mix(
            tex.rgb,
            hover_color.rgb,
            color_strength
        );


        // ----------------------------------------------------
        // GLOW
        // ----------------------------------------------------

        float glow_alpha = 0.0;

        // Arriba
        glow_alpha += texture(
            TEXTURE,
            UV + vec2(0.0, -glow_size)
        ).a;

        // Abajo
        glow_alpha += texture(
            TEXTURE,
            UV + vec2(0.0, glow_size)
        ).a;

        // Izquierda
        glow_alpha += texture(
            TEXTURE,
            UV + vec2(-glow_size, 0.0)
        ).a;

        // Derecha
        glow_alpha += texture(
            TEXTURE,
            UV + vec2(glow_size, 0.0)
        ).a;

        // Diagonal superior izquierda
        glow_alpha += texture(
            TEXTURE,
            UV + vec2(-glow_size, -glow_size)
        ).a;

        // Diagonal superior derecha
        glow_alpha += texture(
            TEXTURE,
            UV + vec2(glow_size, -glow_size)
        ).a;

        // Diagonal inferior izquierda
        glow_alpha += texture(
            TEXTURE,
            UV + vec2(-glow_size, glow_size)
        ).a;

        // Diagonal inferior derecha
        glow_alpha += texture(
            TEXTURE,
            UV + vec2(glow_size, glow_size)
        ).a;


        // Promedio
        glow_alpha /= 8.0;


        // Evitamos que el glow tape demasiado la textura
        float glow = glow_alpha * glow_strength;

        final_color += glow_color.rgb * glow;
    }


    // --------------------------------------------------------
    // RESULTADO
    // --------------------------------------------------------

    COLOR = vec4(
        final_color,
        final_alpha
    );
}
