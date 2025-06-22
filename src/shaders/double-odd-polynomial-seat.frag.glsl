#ifdef GL_ES
precision mediump float;
#endif

uniform vec2 u_resolution;
uniform vec2 u_mouse;
uniform float u_time;

float plot(vec2 st, float pct){
  return  smoothstep( pct-0.01, pct, st.y) -
          smoothstep( pct, pct+0.01, st.y);
}

float double_odd_polynomial_seat(float x, float a, float b) {
  const float n = 2.0;

  float epsilon = 0.00001;
  float min_param_a = 0.0 + epsilon;
  float max_param_a = 1.0 - epsilon;
  float min_param_b = 0.0;
  float max_param_b = 1.0;

  a = min(max_param_a, max(min_param_a, a));
  b = min(max_param_b, max(min_param_b, b));

  float p = 2.0 * n + 1.0;
  float y = 0.0;

  if (x <= a) {
    y = b - b * pow(1.0-x/a, p);
  } else {
    y = b + (1.0-b) * pow((x-a)/(1.0-a), p);
  }
  return y;
}

void main() {
  vec2 st = gl_FragCoord.xy / u_resolution;
  vec2 mouse = u_mouse / u_resolution;

  float y = double_odd_polynomial_seat(st.x, mouse.x, mouse.y);

  vec3 color = vec3(y);

  float pct = plot(st,y);
  color = (1.0-pct)*color+pct*vec3(0.0,1.0,0.0);

  gl_FragColor = vec4(color,1.0);
}