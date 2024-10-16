#version 440

#extension GL_GOOGLE_include_directive : enable
#include "common.glsl"

layout(location = 0) in vec2 in_position;
layout(location = 1) in vec4 in_color;
layout(location = 2) in vec4 in_circle_edge;

layout(location = 0) noperspective out vec4 out_circle_edge;
layout(location = 1) noperspective out vec4 out_color;

layout(std140, binding = 0) uniform buf {
    mat4  qt_Matrix;
    float qt_Opacity;
};

void main() {
    out_circle_edge = in_circle_edge;
    out_color       = in_color;
    gl_Position     = qt_Matrix * vec4(in_position, 0.0, 1.0);
}
