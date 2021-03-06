const math = @import("std").math;
const testing = @import("std").testing;

pub const vec3 = Vec3(f32);

/// A 3 dimensional vector.
pub fn Vec3(comptime T: type) type {
    if (T != f32 and T != f64) {
        @compileError("Vec3 not implemented for " ++ @typeName(T));
    }

    return packed struct {
        x: T,
        y: T,
        z: T,

        const Self = @This();

        /// Constract vector from given 3 components.
        pub fn new(x: T, y: T, z: T) Self {
            return Self{
                .x = x,
                .y = y,
                .z = z,
            };
        }

        pub fn zeros() Self {
            return Self.new(0., 0., 0.);
        }

        /// Compute the length (magnitude) of given vector |a|.
        pub fn length(self: Self) T {
            return math.sqrt((self.x * self.x) + (self.y * self.y) + (self.z * self.z));
        }

        /// Construct new normalized vector from a given vector.
        pub fn norm(self: Self) Self {
            var l = length(self);
            return Self.new(self.x / l, self.y / l, self.z / l);
        }

        pub fn is_eq(left: *const Self, right: *const Self) bool {
            return left.x == right.x and left.y == right.y and left.z == right.z;
        }

        /// Substraction between two given vector.
        pub fn sub(left: Self, right: Self) Self {
            return Self.new(left.x - right.x, left.y - right.y, left.z - right.z);
        }

        /// Addition betwen two given vector.
        pub fn add(left: Self, right: Self) Self {
            return Self.new(left.x + right.x, left.y + right.y, left.z + right.z);
        }

        /// Multiply each components by the given scalar.
        pub fn scale(v: Self, scalar: T) Self {
            return Self.new(v.x * scalar, v.y * scalar, v.z * scalar);
        }

        /// Compute the cross product from two vector.
        pub fn cross(left: Self, right: Self) Self {
            return Self.new(
                (left.y * right.z) - (left.z * right.y),
                (left.z * right.x) - (left.x * right.z),
                (left.x * right.y) - (left.y * right.x),
            );
        }

        /// Return the dot product between two given vector.
        pub fn dot(left: Self, right: Self) T {
            return (left.x * right.x) + (left.y * right.y) + (left.z * right.z);
        }
    };
}

test "zalgebra.Vec3.init" {
    var _vec_0 = vec3.new(1.5, 2.6, 3.7);

    testing.expectEqual(_vec_0.x, 1.5);
    testing.expectEqual(_vec_0.y, 2.6);
    testing.expectEqual(_vec_0.z, 3.7);
}

test "zalgebra.Vec3.is_eq" {
    var _vec_0 = vec3.new(1., 2., 3.);
    var _vec_1 = vec3.new(1., 2., 3.);
    var _vec_2 = vec3.new(1.5, 2., 3.);
    testing.expectEqual(vec3.is_eq(&_vec_0, &_vec_1), true);
    testing.expectEqual(vec3.is_eq(&_vec_0, &_vec_2), false);
}

test "zalgebra.Vec3.length" {
    var _vec_0 = vec3.new(1.5, 2.6, 3.7);
    testing.expectEqual(_vec_0.length(), 4.7644519);
}

test "zalgebra.Vec3.normalize" {
    var _vec_0 = vec3.new(1.5, 2.6, 3.7);
    testing.expectEqual(vec3.is_eq(&_vec_0.norm(), &vec3.new(0.314831584, 0.545708060, 0.776584625)), true);
}

test "zalgebra.Vec3.sub" {
    var _vec_0 = vec3.new(1., 2., 3.);
    var _vec_1 = vec3.new(2., 2., 3.);
    testing.expectEqual(vec3.is_eq(&vec3.sub(_vec_0, _vec_1), &vec3.new(-1., 0., 0.)), true);
}

test "zalgebra.Vec3.add" {
    var _vec_0 = vec3.new(1., 2., 3.);
    var _vec_1 = vec3.new(2., 2., 3.);
    testing.expectEqual(vec3.is_eq(&vec3.add(_vec_0, _vec_1), &vec3.new(3., 4., 6.)), true);
}

test "zalgebra.Vec3.scale" {
    var _vec_0 = vec3.new(1., 2., 3.);
    testing.expectEqual(vec3.is_eq(&vec3.scale(_vec_0, 5.), &vec3.new(5., 10., 15.)), true);
}

test "zalgebra.Vec3.dot" {
    var _vec_0 = vec3.new(1.5, 2.6, 3.7);
    var _vec_1 = vec3.new(2.5, 3.45, 1.0);

    testing.expectEqual(vec3.dot(_vec_0, _vec_1), 16.42);
}

test "zalgebra.Vec3.cross" {
    var _vec_0 = vec3.new(1.5, 2.6, 3.7);
    var _vec_1 = vec3.new(2.5, 3.45, 1.0);
    var _vec_2 = vec3.new(1.5, 2.6, 3.7);

    var _cross_product_0 = vec3.cross(_vec_0, _vec_2);
    var _cross_product_1 = vec3.cross(_vec_0, _vec_1);

    testing.expectEqual(vec3.is_eq(&_cross_product_0, &vec3.new(0., 0., 0.)), true);
    testing.expectEqual(vec3.is_eq(&_cross_product_1, &vec3.new(-10.1650009, 7.75, -1.32499980)), true);
}
