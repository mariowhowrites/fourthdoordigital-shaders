#ifdef GL_ES
precision mediump float;
#endif

#define PI 3.14159265359

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

vec3 colorA = vec3(0.13, 0.07, 0.56);
vec3 colorB = vec3(0.98,	0.74,	0.48	);

float plot (vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

void main() {
    vec2 st = gl_FragCoord.xy/u_resolution.xy;
    vec2 mouse = u_mouse / u_resolution;
    vec3 color = vec3(0.0);

    vec3 pct = vec3(st.x + st.y) * 0.5;
    // vec3 pct = vec3(st.y);

    pct.r = pow(st.x, 0.9) * (1.0 - st.y * 0.3);
    pct.g = pow(st.x, 1.5) * (1.0 - st.y * 1.1);
    pct.b = pow(1.0 - st.x, 2.0) * (1.0 + st.y * 0.01);

    color = mix(colorA, colorB, pct);

    // Plot transition lines for each channel
    // color = mix(color,vec3(1.0,0.0,0.0),plot(st,pct.r));
    // color = mix(color,vec3(0.0,1.0,0.0),plot(st,pct.g));
    // color = mix(color,vec3(0.0,0.0,1.0),plot(st,pct.b));

    gl_FragColor = vec4(color,1.0);
}