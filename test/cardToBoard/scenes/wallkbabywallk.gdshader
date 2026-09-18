shader_type canvas_item;

uniform float tempo : hint_range(0.1, 10.0) = 4.0;
uniform float rotation_amount : hint_range(0.0, 0.25) = 0.06;
uniform float jump_amount : hint_range(0.0, 50.0) = 2.0;
uniform float wiggle_amount : hint_range(0.0, 10.0) = 1.5;

void vertex() {

    float beat = TIME * tempo * 6.283185;

    // -------------------------
    // ROTACIÓN
    // -------------------------

    float angle = sin(beat) * rotation_amount;

    float s = sin(angle);
    float c = cos(angle);

    // Centro de la geometría
    vec2 center = vec2(0.0);

    vec2 pos = VERTEX - center;

    VERTEX.x = pos.x * c - pos.y * s;
    VERTEX.y = pos.x * s + pos.y * c;


    // -------------------------
    // WIGGLE
    // -------------------------

    VERTEX.x += sin(beat * 2.0) * wiggle_amount;


    // -------------------------
    // MINI SALTITO
    // -------------------------

    VERTEX.y -= abs(sin(beat)) * jump_amount;
}