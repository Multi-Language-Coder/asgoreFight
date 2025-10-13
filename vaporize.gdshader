// dissolve.gdshader
shader_type canvas_item;

// A "uniform" is a variable you can control from GDScript.
uniform float progress : hint_range(0.0, 1.0);
// This noise texture will control the pattern of the dissolve.
uniform sampler2D noise_texture : source_color;

void fragment() {
    // Get the color of the current pixel from the sprite's texture.
    vec4 color = texture(TEXTURE, UV);
    // Get the value from the noise texture for the same pixel.
    float noise_value = texture(noise_texture, UV).r;

    // Make pixels glow white just before they disappear.
    if (noise_value < progress && noise_value > progress - 0.05) {
        color = vec4(1.0, 1.0, 1.0, 1.0); // White color
    }
    // Discard (make invisible) pixels where the noise value is less than our progress.
    else if (noise_value < progress) {
        discard;
    }

    COLOR = color;
}