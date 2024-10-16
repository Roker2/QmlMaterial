#version 440

layout(location = 0) out vec4 fragColor;

layout(location = 0) noperspective in vec3 out_shadow_params;
layout(location = 1) noperspective in vec4 out_color;
layout(binding = 1) uniform sampler2D strength_tex;

layout(std140, binding = 0) uniform buf {
    mat4  qt_Matrix;
    float qt_Opacity;
};

void main() {
    float d      = length(out_shadow_params.xy);
    vec2  uv     = vec2(out_shadow_params.z * (1.0 - d), 0.5);
    float factor = texture(strength_tex, uv, -0.475).x;
    vec4  alpha  = vec4(factor) * qt_Opacity;
    fragColor    = out_color * alpha;
}
