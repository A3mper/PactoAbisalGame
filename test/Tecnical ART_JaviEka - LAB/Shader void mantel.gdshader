shader_type canvas_item;


// =====================================================
// COLOR DEL VOID
// =====================================================

// Color principal que puedes elegir desde el Inspector
uniform vec4 void_color : source_color = vec4(0.45, 0.15, 0.65, 1.0);


// =====================================================
// INTENSIDAD DEL CAMBIO
// =====================================================

// 0.0 = textura original
// 1.0 = completamente Void
uniform float color_strength : hint_range(0.0, 1.0) = 1.0;


// =====================================================
// SATURACIÓN
// =====================================================

// 0.0 = gris
// 1.0 = normal
// 2.0 = muy saturado
uniform float saturation : hint_range(0.0, 2.0) = 1.0;


// =====================================================
// BRILLO
// =====================================================

// 0.0 = negro
// 1.0 = normal
// 2.0 = muy brillante
uniform float brightness : hint_range(0.0, 2.0) = 1.0;


// =====================================================
// MAIN
// =====================================================

void fragment()
{
    // -------------------------------------------------
    // TEXTURA ORIGINAL
    // -------------------------------------------------

    vec4 tex = texture(TEXTURE, UV);


    // -------------------------------------------------
    // LUMINOSIDAD
    // -------------------------------------------------

    float luminance = dot(
        tex.rgb,
        vec3(
            0.299,
            0.587,
            0.114
        )
    );


    // -------------------------------------------------
    // CREAR COLOR VOID
    // -------------------------------------------------

    vec3 void_rgb = void_color.rgb;


    // Mantener luces y sombras de la textura
    void_rgb *= luminance;


    // -------------------------------------------------
    // SATURACIÓN
    // -------------------------------------------------

    float gray = dot(
        void_rgb,
        vec3(
            0.299,
            0.587,
            0.114
        )
    );


    void_rgb = mix(
        vec3(gray),
        void_rgb,
        saturation
    );


    // -------------------------------------------------
    // BRILLO
    // -------------------------------------------------

    void_rgb *= brightness;


    // -------------------------------------------------
    // MEZCLAR CON LA TEXTURA ORIGINAL
    // -------------------------------------------------

    vec3 final_color = mix(
        tex.rgb,
        void_rgb,
        color_strength
    );


    // -------------------------------------------------
    // RESULTADO
    // -------------------------------------------------

    COLOR = vec4(
        final_color,
        tex.a
    );
}
