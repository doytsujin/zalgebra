# zalgebra
Linear algebra library written in Zig for games and real-time computer graphics.


## Current progress
- [x] vec2
- [x] vec3
- [x] vec4
- [x] mat4 (need more tests)
- [ ] quaternion

## Examples

```zig
const za = @import("zalgebra");
const vec3 = za.vec3;
const mat4 = za.mat4;

pub fn main () void {
  var projection = za.perspective(45.0, 800.0 / 600.0, 0.1, 100.0);
  var view = za.look_at(&vec3.new(0., 0., -3.), &vec3.new(0., 0., 0.), &vec3.new(0., 1., 0.));
  var model = mat4.from_translation(&vec3.new(0.2, 0.5, 0.0));
  
  var mvp = mat4.mult(projection, view.mult(model));
}
```

## Documentation

### Aliases

Type | Description
------------ | -------------
vec2 | Two dimensional vector for `f32`
vec3 | Three dimensional vector for `f32`
vec4 | Four dimensional vector for `f32`
mat4 | 4x4 matrix for `f32`
perspective | Perspective function for `f32` 4x4 mat4
orthographic | Orthographic function for `f32` 4x4 mat4
look_at | LookAt function for `f32` 4x4 mat4

### Vectors

Methods | Description
------------ | -------------
new | Construct a vector from 2-4 given components
zeros | A vector with all components equals to zero
length | Return the magnitude of the current vector
norm | Construct a new normalized vector based on the given one
is_eq | Return `true` if two vectors are equals
sub | Construct new vector resulting from the substraction between two vectors
add | Construct new vector resulting from the addition between two vectors
scale | Construct new vector after multiplying each components by the given scalar
cross | Construct the cross product (as vector) from two vectors (only for vec3)
dot | Return the dot product between two vector

### Matrices
Note: All matrices are column-major.

Methods | Description
------------ | -------------
identity | Construct an identity matrix
get_data | Return a pointer to the inner data
is_eq | Return `true` if two matrices are equals
mult_by_vec4 | Multiply a given vec4 by matrix (only for mat4)
from_translate | Construct a translation matrix from identity matrix
translate | Construct a translation from the given matrix according to given axis (vec3)
from_rotate | Construct a rotation matrix from identity matrix
rotate | Construct a rotation from the given matrix according to given axis (vec3)
from_scale | Construct a scale matrix from identity matrix
scale | Construct a scale from the given matrix according to given axis (vec3)
perspective | Construct a perspective matrix from given fovy, aspect ratio, near/far inputs
orthographic| Construct an orthographic matrix from given left, right, bottom, top, near/far inputs
look_at | Construct a right-handed look_at matrix from given position (eye) and target
mult | Multiply two matrices
inv | Inverse the given matrix
fmt | Display the matrix components for debug purpose

### Utilities

Methods | Description
------------ | -------------
to_radians | Convert degrees to radians
to_degrees | Convert radians to degrees


## Contributing to the project

Don’t be shy about shooting any questions you may have. If you are a beginner/junior, don’t hesitate, I will always encourage you. It’s a safe place here. Also, I would be very happy to receive any kind of pull requests, you will have (at least) some feedback/guidance rapidly.

Behind screens, there are human beings, living any sort of story. So be always kind and respectful, because we all sheer to learn new things.


## Thanks
This project is inspired by [Handmade Math](https://github.com/HandmadeMath/Handmade-Math) and [nalgebra](https://nalgebra.org/).
