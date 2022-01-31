//
//  Matrix.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/31/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation
import CoreGraphics

public struct Matrix: Equatable {
    private var _matrix: [[CGFloat]]

    init(_ matrix: [[CGFloat]]) {
        _matrix = matrix
    }

    // MARK: variables

    static var identity: Matrix = {
        return Matrix([[1, 0, 0, 0], [0, 1, 0, 0],
                       [0, 0, 1, 0], [0, 0, 0, 1]])
    }()

    // number of rows. You'll note this is the top-level count of the array of arrays
    var rows: Int {
		return _matrix.count
    }

    // number of columns
    var cols: Int {
		return _matrix[0].count
    }

    var invertible: Bool {
		return self.determinant != 0
    }

    var inverse: Matrix {
		assert(self.invertible, "Only supports invertible matrices")
		var m = Matrix(self._matrix)
		let d = self.determinant

		for row in 0 ..< rows {
			for col in 0 ..< cols {
				let c = cofactor(row: row, col: col)
				m[col,row] = c/d
			}
		}
		return m
    }

    // MARK: subscript sauce

    // from this, we get the ability to use array-like subscripts
    // without actually being an array, e.g.:
    // let m = Matrix([[1,2],[3,4]])
    // m[0,1] // returns 2

    public subscript(row: Int, column: Int) -> CGFloat {
        get {
            return _matrix[row][column]
        }
        set(rhs) {
            _matrix[row][column] = rhs
        }
    }

    // MARK: Description

    var description: String {
        var result = ""

        for i in 0 ..< rows {
            if i == 0 { // no prepending a line break
                result.append("\(_matrix[i])")
            } else {
                result.append("\n\(_matrix[i])")
            }
        }
        return result
    }

    // MARK: Multiply

    // multiplies one array by another, like it says on the tin
    // Note: this assumes 4x4

    static func * (lhs: Matrix, rhs: Matrix) -> Matrix {
        assert(lhs.rows == 4 && lhs.cols == 4, "Only supports 4x4 matrices (lhs)")
        assert(rhs.rows == 4 && rhs.cols == 4, "Only supports 4x4 matrices (rhs)")

        var m = Matrix([[0, 0, 0, 0], [0, 0, 0, 0],
                        [0, 0, 0, 0], [0, 0, 0, 0]])

        for row in 0...3 {
            for col in 0...3 {
                m[row, col] = lhs[row, 0] * rhs[0, col] +
                    lhs[row, 1] * rhs[1, col] +
                    lhs[row, 2] * rhs[2, col] +
                    lhs[row, 3] * rhs[3, col]
            }
        }
        return m
    }

    // multiplies an array by a tuple, like it says on the tin
    // Note: this assumes 4x4

    static func * (lhs: Matrix, rhs: Tuple) -> Tuple {
        assert(lhs.rows == 4 && lhs.cols == 4, "Only supports 4x4 matrices (lhs)")

        var m = Matrix([[0, 0, 0, 0]])

        for row in 0...3 {
            m[0, row] = lhs[row, 0] * rhs.x +
                lhs[row, 1] * rhs.y +
                lhs[row, 2] * rhs.z +
                lhs[row, 3] * rhs.w
        }
        return Tuple(m[0, 0], m[0, 1], m[0, 2], m[0, 3])
    }

    // multiplies an array by a point

    static func * (lhs: Matrix, rhs: Point) -> Point {
        assert(lhs.rows == 4 && lhs.cols == 4, "Only supports 4x4 matrices (lhs)")

        var m = Matrix([[0, 0, 0, 0]])

        for row in 0...3 {
            m[0, row] = lhs[row, 0] * rhs.x +
                lhs[row, 1] * rhs.y +
                lhs[row, 2] * rhs.z +
                lhs[row, 3] * rhs.w
        }
        return Point(m[0, 0], m[0, 1], m[0, 2])
    }

    // multiplies an array by a vector

    static func * (lhs: Matrix, rhs: Vector) -> Vector {
        assert(lhs.rows == 4 && lhs.cols == 4, "Only supports 4x4 matrices (lhs)")

        var m = Matrix([[0, 0, 0, 0]])

        for row in 0...3 {
            m[0, row] = lhs[row, 0] * rhs.x +
                lhs[row, 1] * rhs.y +
                lhs[row, 2] * rhs.z +
                lhs[row, 3] * rhs.w
        }
        return Vector(m[0, 0], m[0, 1], m[0, 2])
    }

    // MARK: Transpose

    // transpose a 4x4 matrix (flip x and y)
    func transpose() -> Matrix {
        assert(self.rows == 4 && self.cols == 4, "Only supports 4x4 matrices (self)")
        var m = Matrix([[0, 0, 0, 0], [0, 0, 0, 0],
                        [0, 0, 0, 0], [0, 0, 0, 0]])

        for row in 0...3 {
            for col in 0...3 {
                m[col, row] = self[row, col]
            }
        }
        return m
    }

    // MARK: Invert

    public var determinant: CGFloat {
        var d: CGFloat = 0
        var cf: CGFloat = 0

        assert(rows == cols, "Need a matching number of rows/cols: \(rows), \(cols)")

        if rows == 2 && cols == 2 {
            d += self[0, 0] * self[1, 1]
            d -= self[0, 1] * self[1, 0]
        } else {
            for c in 0 ..< cols {
                cf = cofactor(row: 0, col: c)

                d += self[0,c] * cf
            }
        }

        return d
    }

    // MARK: submatrices

    // provide a smaller matrix, removing the stated row and column
    func submatrix(row: Int, col: Int) -> Matrix {
        var result = self._matrix

        // first, remove the row
        result.remove(at: row)

        // iterate to remove columns
        for i in 0 ..< result.count { // count is new # of rows
            result[i].remove(at: col)
        }

        return Matrix(result)
    }

    func minor(row: Int, col: Int) -> CGFloat {
        let matrix = submatrix(row: row, col: col)
        return matrix.determinant
    }

    func cofactor(row: Int, col: Int) -> CGFloat {
        var d: CGFloat = minor(row: row, col: col)

        if !(row + col).isMultiple(of: 2) {
            d = -d
        }
        return d
    }

    // MARK: translation

    static func translation(_ t: Tuple) -> Matrix {
        var matrix = Matrix.identity
        matrix[0, 3] = t.x
        matrix[1, 3] = t.y
        matrix[2, 3] = t.z

        return matrix
    }

    func translated(_ t: Tuple) -> Matrix {
        return Matrix.translation(t) * self
    }

    // MARK: scaling

    // assumes self is the scaling
    static func scaling(point: Point) -> Matrix { // a point for the x, y, z factors
        var matrix = Matrix.identity
        matrix[0, 0] = point.x
        matrix[1, 1] = point.y
        matrix[2, 2] = point.z

        return matrix
    }

    // MARK: rotation

    static func rotationX(radians: CGFloat) -> Matrix {
        let cosX = cos(radians)
        let sinX = sin(radians)
        var matrix = Matrix.identity
        matrix[1, 1] = cosX
        matrix[1, 2] = -sinX
        matrix[2, 1] = sinX
        matrix[2, 2] = cosX

        return matrix
    }

    static func rotationY(radians: CGFloat) -> Matrix {
        let cosY = cos(radians)
        let sinY = sin(radians)
        var matrix = Matrix.identity
        matrix[0, 0] = cosY
        matrix[0, 2] = sinY
        matrix[2, 0] = -sinY
        matrix[2, 2] = cosY

        return matrix
    }

    static func rotationZ(radians: CGFloat) -> Matrix {
        let cosZ = cos(radians)
        let sinZ = sin(radians)
        var matrix = Matrix.identity
        matrix[0, 0] = cosZ
        matrix[0, 1] = -sinZ
        matrix[1, 0] = sinZ
        matrix[1, 1] = cosZ

        return matrix
    }

	// swiftlint:disable function_parameter_count
    static func shearing(_ xY: CGFloat,
                         _ xZ: CGFloat,
                         _ yX: CGFloat,
                         _ yZ: CGFloat,
                         _ zX: CGFloat,
                         _ zY: CGFloat) -> Matrix {
        var matrix = Matrix.identity
        matrix[0, 1] = xY
        matrix[0, 2] = xZ
        matrix[1, 0] = yX
        matrix[1, 2] = yZ
        matrix[2, 0] = zX
        matrix[2, 1] = zY
        return matrix
    }
	// swiftlint:enable function_parameter_count

	// MARK: transformation

	static func viewTransform(from: Point, to: Point, up: Vector) -> Matrix {
		let forward = (to - from).normalize()
		let upnormal = up.normalize()

		let left = forward × upnormal
		let actualUp = left × forward

		let orientation = Matrix([[left.x,     left.y,     left.z,     0],
								  [actualUp.x, actualUp.y, actualUp.z, 0],
								  [-forward.x, -forward.y, -forward.z, 0],
								  [0,          0,          0,          1]])
		return orientation * Matrix.translation(
			Tuple(-from.x, -from.y, -from.z, 0))
	}

}
