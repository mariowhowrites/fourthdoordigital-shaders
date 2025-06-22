#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float pct) {
  return smoothstep(pct - 0.01, pct, st.y) -
    smoothstep(pct, pct + 0.01, st.y);
}

float double_polynomial_sigmoid(float x, float a, float b, float n) {
  float y = 0.0;

  if(n - (2.0 * floor(n / 2.0)) == 0.0) {
    // even polynomial
    if(x <= 0.5) {
      y = pow(2.0 * x, n) / 2.0;
    } else {
      y = 1.0 - pow(2.0 * (x - 1.0), n) / 2.0;
    }
  }

  else {
    // odd polynomial
    if (x <= 0.5) {
      y = pow(2.0 * x, n) / 2.0;
    } else {
      y = 1.0 + pow(2.0 * (x - 1.0), n) / 2.0;
    }
  }

  return y;
}

void main() {
  vec2 st = gl_FragCoord.xy / u_resolution;
  vec2 mouse = u_mouse / u_resolution;

  float y = double_polynomial_sigmoid(st.x, mouse.x, mouse.y, 3.0);

  vec3 color = vec3(y);

  float pct = plot(st, y);
  color = mix(color, vec3(0.0, 1.0, 0.0), pct);

  gl_FragColor = vec4(color, 1.0);
}