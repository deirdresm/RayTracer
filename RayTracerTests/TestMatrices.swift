//
//  TestMatrices.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 1/31/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

// swiftlint:disable file_length

// MARK: test to pass accuracy comparison down from matrix to the individual values

public func XCTAssertEqual(_ lhs: Matrix, _ rhs: Matrix, accuracy: CGFloat,
						   _ message: @autoclosure () -> String = "",
						     file: StaticString = #file, line: UInt = #line) {
    XCTAssertEqual(lhs.rows, rhs.rows)
    XCTAssertEqual(lhs.cols, rhs.cols)

    for row in 0 ..< lhs.rows {
        for col in 0 ..< lhs.cols {
            XCTAssertEqual(lhs[row,col], rhs[row,col], accuracy: accuracy)
        }
    }
}

class TestMatrices: XCTestCase {

// Scenario​: Constructing and inspecting a 4x4 matrix
//   ​Given​ the following 4x4 matrix M:
//     |  1   |  2   |  3   |  4   |
//     |  5.5 |  6.5 |  7.5 |  8.5 |
//     |  9   | 10   | 11   | 12   |
//     | 13.5 | 14.5 | 15.5 | 16.5 |
//   ​Then​ M[0,0] = 1
//     ​And​ M[0,3] = 4
//     ​And​ M[1,0] = 5.5
//     ​And​ M[1,2] = 7.5
//     ​And​ M[2,2] = 11
//     ​And​ M[3,0] = 13.5
//     ​And​ M[3,2] = 15.5

    func test4x4MatrixCreation() throws {
        let m = Matrix([[1, 2, 3, 4], [5.5, 6.5, 7.5, 8.5],
                        [9, 10, 11, 12], [13.5, 14.5, 15.5, 16.5]])

        XCTAssertEqual(m[0, 0], 1.0)
        XCTAssertEqual(m[0, 3], 4.0)
        XCTAssertEqual(m[1, 0], 5.5)
        XCTAssertEqual(m[1, 2], 7.5)
        XCTAssertEqual(m[2, 2], 11.0)
        XCTAssertEqual(m[3, 0], 13.5)
        XCTAssertEqual(m[3, 2], 15.5)

    }

// Scenario​: A 2x2 matrix ought to be representable
//​    ​Given​ the following 2x2 matrix M:
//​      | -3 |  5 |
//​      |  1 | -2 |
//​    ​Then​ M[0,0] = -3
//​      ​And​ M[0,1] = 5
//​      ​And​ M[1,0] = 1
//​      ​And​ M[1,1] = -2

    func test2x2MatrixCreation() throws {
        let m = Matrix([[-3, 5], [1, -2]])

        XCTAssertEqual(m[0, 0], -3.0)
        XCTAssertEqual(m[0, 1], 5.0)
        XCTAssertEqual(m[1, 0], 1.0)
        XCTAssertEqual(m[1, 1], -2)
    }

// Scenario​: A 3x3 matrix ought to be representable
//​    ​Given​ the following 3x3 matrix M:
//          | -3 |  5 |  0 |
//          |  1 | -2 | -7 |
//          |  0 |  1 |  1 |
//        ​Then​ M[0,0] = -3
//          ​And​ M[1,1] = -2
//          ​And​ M[2,2] = 1

    func test3x3MatrixCreation() throws {
        let m = Matrix([[-3, 5, 0], [1, -2, -7], [0, 1, 1]])

        XCTAssertEqual(m[0, 0], -3.0)
        XCTAssertEqual(m[1, 1], -2.0)
        XCTAssertEqual(m[2, 2], 1.0)
    }

// Scenario​: Matrix equality with identical matrices
//        ​Given​ the following matrix A:
//            | 1 | 2 | 3 | 4 |
//            | 5 | 6 | 7 | 8 |
//            | 9 | 8 | 7 | 6 |
//            | 5 | 4 | 3 | 2 |
//          ​And​ the following matrix B:
//            | 1 | 2 | 3 | 4 |
//            | 5 | 6 | 7 | 8 |
//            | 9 | 8 | 7 | 6 |
//            | 5 | 4 | 3 | 2 |
//        ​Then​ A = B

    func textMatrixEquality() throws {
        let a = Matrix([[1, 2, 3, 4], [5, 6, 7, 8],
                        [9, 8, 7, 6], [5, 4, 3, 2]])
        let b = Matrix([[1, 2, 3, 4], [5, 6, 7, 8],
                        [9, 8, 7, 6], [5, 4, 3, 2]])

        XCTAssertEqual(a, b)
    }

// Scenario​: Matrix equality with different matrices
//        ​Given​ the following matrix A:
//            | 1 | 2 | 3 | 4 |
//            | 5 | 6 | 7 | 8 |
//            | 9 | 8 | 7 | 6 |
//            | 5 | 4 | 3 | 2 |
//          ​And​ the following matrix B:
//            | 2 | 3 | 4 | 5 |
//            | 6 | 7 | 8 | 9 |
//            | 8 | 7 | 6 | 5 |
//            | 4 | 3 | 2 | 1 |
//        ​Then​ A != B

    func textMatrixInquality() throws {
        let a = Matrix([[1, 2, 3, 4], [5, 6, 7, 8],
                        [9, 8, 7, 6], [5, 4, 3, 2]])
        let b = Matrix([[2, 3, 4, 5], [6, 7, 8, 9],
                        [8, 7, 6, 5], [4, 3, 2, 1]])

        XCTAssertNotEqual(a, b)
    }

// Scenario​: Multiplying two matrices
//        ​Given​ the following matrix A:
//            | 1 | 2 | 3 | 4 |
//            | 5 | 6 | 7 | 8 |
//            | 9 | 8 | 7 | 6 |
//            | 5 | 4 | 3 | 2 |
//          ​And​ the following matrix B:
//            | -2 | 1 | 2 |  3 |
//            |  3 | 2 | 1 | -1 |
//            |  4 | 3 | 6 |  5 |
//            |  1 | 2 | 7 |  8 |
//        ​Then​ A * B is the following 4x4 matrix:
//            | 20|  22 |  50 |  48 |
//            | 44|  54 | 114 | 108 |
//            | 40|  58 | 110 | 102 |
//            | 16|  26 |  46 |  42 |

    func textMatrixMultiply() throws {
        let a = Matrix([[1, 2, 3, 4], [5, 6, 7, 8],
                        [9, 8, 7, 6], [5, 4, 3, 2]])
        let b = Matrix([[-2, 1, 2, 3], [3, 2, 1, -1],
                        [4, 3, 6, 5],[1, 2, 7, 8]])
        let result = Matrix([[20, 22, 50, 48], [44, 54, 114, 108],
                             [40, 58, 110, 102], [16, 26, 46, 42]])

        XCTAssertEqual(a * b, result)
    }

//​​ Scenario​: Multiplying a matrix by the identity matrix
//​   ​Given​ the following matrix A:
//​     | 0 | 1 |  2 |  4 |
//​     | 1 | 2 |  4 |  8 |
//​     | 2 | 4 |  8 | 16 |
//​     | 4 | 8 | 16 | 32 |
//​   ​Then​ A * identity_matrix = A
//
//​ Scenario​: Multiplying the identity matrix by a tuple
//​   ​Given​ a ← tuple(1, 2, 3, 4)
//​   ​Then​ identity_matrix * a = a

    func textMatrixIdentityMultiplication() throws {
        let a = Matrix([[1, 2, 3, 4], [5, 6, 7, 8],
                        [9, 8, 7, 6], [5, 4, 3, 2]])

        XCTAssertEqual(a * Matrix.identity, a)
    }

//​​ Scenario​: Transposing a matrix
//​   ​Given​ the following matrix A:
//​     | 0 | 9 | 3 | 0 |
//​     | 9 | 8 | 0 | 8 |
//​     | 1 | 8 | 5 | 3 |
//     | 0 | 0 | 5 | 8 |
//​   ​Then​ transpose(A) is the following matrix:
//​     | 0 | 9 | 1 | 0 |
//​     | 9 | 8 | 8 | 0 |
//​     | 3 | 0 | 5 | 5 |
//​     | 0 | 8 | 3 | 8 |

    func testMatrixTranspose() throws {
        let a = Matrix([[0, 9, 3, 0], [9, 8, 0, 8],
                        [1, 8, 5, 3], [0, 0, 5, 8]])
        let transposed = Matrix([[0, 9, 1, 0], [9, 8, 8, 0],
                                 [3, 0, 5, 5], [0, 8, 3, 8]])

        XCTAssertEqual(a.transpose(), transposed)
    }

    func testIdentityTranspose() throws {
        let a = Matrix.identity

        XCTAssertEqual(a.transpose(), Matrix.identity)
    }

// Scenario​: Calculating the determinant of a 2x2 matrix
//​    ​Given​ the following 2x2 matrix A:
//​      |  1 | 5 |
//​      | -3 | 2 |
//​    ​Then​ determinant(A) = 17

    func testDeterminant2x2() throws {
        let a = Matrix([[1, 5], [-3, 2]])

        XCTAssertEqual(a.determinant, 17)
    }

// cenario​: A submatrix of a 3x3 matrix is a 2x2 matrix
//       ​Given​ the following 3x3 matrix A:
//         |  1 | 5 |  0 |
//         | -3 | 2 |  7 |
//         |  0 | 6 | -3 |
//       ​Then​ submatrix(A, 0, 2) is the following 2x2 matrix:
//         | -3 | 2 |
//         |  0 | 6 |
//
//​ Scenario​: A submatrix of a 4x4 matrix is a 3x3 matrix
//​   ​Given​ the following 4x4 matrix A:
//​     | -6 |  1 |  1 |  6 |
//​     | -8 |  5 |  8 |  6 |
//​     | -1 |  0 |  8 |  2 |
//​     | -7 |  1 | -1 |  1 |
//​   ​Then​ submatrix(A, 2, 1) is the following 3x3 matrix:
//​     | -6 |  1 | 6 |
//​     | -8 |  8 | 6 |
//​     | -7 | -1 | 1 |

    func testSubmatrix3x3() throws {
        let a = Matrix([[1,5,0],[-3,2,7],[0,6,3]])
        let aResult = Matrix([[-3,2],[0,6]])
        XCTAssertEqual(a.submatrix(row: 0, col: 2), aResult)
    }

    func testSubmatrix4x4() throws {
        let a = Matrix([[-6, 1, 1, 6], [-8, 5, 8, 6], [-1, 0, 8, 2], [-7, 1, -1, 1]])
        let aResult = Matrix([[-6, 1, 6], [-8, 8, 6], [-7, -1, 1]])
        XCTAssertEqual(a.submatrix(row: 2, col: 1), aResult)
    }

// Scenario​: Calculating a minor of a 3x3 matrix
//​    ​Given​ the following 3x3 matrix A:
//​        |  3 |  5 |  0 |
//​        |  2 | -1 | -7 |
//​        |  6 | -1 |  5 |
//​      ​And​ B ← submatrix(A, 1, 0)
//​    ​Then​ determinant(B) = 25
//​      ​And​ minor(A, 1, 0) = 25

    func test3x3minor() throws {
        let a = Matrix([[3, 5, 0], [-2, 1, -7], [6, -1, 5]])
        XCTAssertEqual(a.minor(row: 1, col: 0), 25)
    }

// Scenario​: Calculating a cofactor of a 3x3 matrix
//        ​Given​ the following 3x3 matrix A:
//            |  3 |  5 |  0 |
//            |  2 | -1 | -7 |
//            |  6 | -1 |  5 |
//        ​Then​ minor(A, 0, 0) = -12
//          ​And​ cofactor(A, 0, 0) = -12
//          ​And​ minor(A, 1, 0) = 25
//          ​And​ cofactor(A, 1, 0) = -25

    func test3x3cofactor() throws {
        let a = Matrix([[3, 5, 0], [2, -1, -7], [6, -1, 5]])
        XCTAssertEqual(a.minor(row: 0, col: 0), -12)
        XCTAssertEqual(a.cofactor(row: 0, col: 0), -12)
        XCTAssertEqual(a.minor(row: 0, col: 1), 52)
        XCTAssertEqual(a.cofactor(row: 0, col: 1), -52)
        XCTAssertEqual(a.minor(row: 1, col: 0), 25)
        XCTAssertEqual(a.cofactor(row: 1, col: 0), -25)
        XCTAssertEqual(a.minor(row: 1, col: 1), 15)
        XCTAssertEqual(a.cofactor(row: 1, col: 1), 15)
    }

// Scenario​: Calculating the determinant of a 3x3 matrix
//​    ​Given​ the following 3x3 matrix A:
//​      |  1 |  2 |  6 |
//​      | -5 |  8 | -4 |
//​      |  2 |  6 |  4 |
//​    ​Then​ cofactor(A, 0, 0) = 56
//​      ​And​ cofactor(A, 0, 1) = 12
//​      ​And​ cofactor(A, 0, 2) = -46
//​      ​And​ determinant(A) = -196

    func test3x3determinant() throws {
        let a = Matrix([[1, 2, 6], [-5, 8, -4], [2, 6, 4]])
        XCTAssertEqual(a.cofactor(row: 0, col: 0), 56)
        XCTAssertEqual(a.cofactor(row: 0, col: 1), 12)
        XCTAssertEqual(a.cofactor(row: 0, col: 2), -46)
        XCTAssertEqual(a.determinant, -196)
    }

//​ Scenario​: Calculating the determinant of a 4x4 matrix
//​   ​Given​ the following 4x4 matrix A:
//​     | -2 | -8 |  3 |  5 |
//​     | -3 |  1 |  7 |  3 |
//​     |  1 |  2 | -9 |  6 |
//​     | -6 |  7 |  7 | -9 |
//​   ​Then​ cofactor(A, 0, 0) = 690
//​     ​And​ cofactor(A, 0, 1) = 447
//​     ​And​ cofactor(A, 0, 2) = 210
//​     ​And​ cofactor(A, 0, 3) = 51
//​     ​And​ determinant(A) = -4071

    func test4x4determinant() throws {
        let a = Matrix([[-2, -8, 3, 5], [-3, 1, 7, 3], [1, 2, -9, 6], [-6, 7, 7, -9]])
        XCTAssertEqual(a.cofactor(row: 0, col: 0), 690)
        XCTAssertEqual(a.cofactor(row: 0, col: 1), 447)
        XCTAssertEqual(a.cofactor(row: 0, col: 2), 210)
        XCTAssertEqual(a.cofactor(row: 0, col: 3), 51)
        XCTAssertEqual(a.determinant, -4071)
    }

// Scenario: Testing an invertible matrix for invertibility
//   Given the following 4x4 matrix A:
//     |  6 |  4 |  4 |  4 |
//     |  5 |  5 |  7 |  6 |
//     |  4 | -9 |  3 | -7 |
//     |  9 |  1 |  7 | -6 |
//   Then determinant(A) = -2120
//     And A is invertible

    func testForInvertibility() throws {
        let a = Matrix([[6, 4, 4, 4], [5, 5, 7, 6], [4, -9, 3, -7], [9, 1, 7, -6]])
        XCTAssertEqual(a.determinant, -2120)
        XCTAssertTrue(a.invertible)
    }

// Scenario​: Testing a noninvertible matrix for invertibility
//        ​Given​ the following 4x4 matrix A:
//          | -4 |  2 | -2 | -3 |
//          |  9 |  6 |  2 |  6 |
//          |  0 | -5 |  1 | -5 |
//          |  0 |  0 |  0 |  0 |
//        ​Then​ determinant(A) = 0
//          ​And​ A is not invertible

    func testForNonInvertibility() throws {
        let a = Matrix([[-4, 2, -2, -3], [9, 6, 2, 6], [0, -5, 1, -5], [0, 0, 0, 0]])
        XCTAssertEqual(a.determinant, 0)
        XCTAssertFalse(a.invertible)
    }

// Scenario​: Calculating the inverse of a matrix
//        ​Given​ the following 4x4 matrix A:
//            | -5 |  2 |  6 | -8 |
//            |  1 | -5 |  1 |  8 |
//            |  7 |  7 | -6 | -7 |
//            |  1 | -3 |  7 |  4 |
//          ​And​ B ← inverse(A)
//        ​Then​ determinant(A) = 532
//          ​And​ cofactor(A, 2, 3) = -160
//          ​And​ B[3,2] = -160/532
//          ​And​ cofactor(A, 3, 2) = 105
//          ​And​ B[2,3] = 105/532
//          ​And​ B is the following 4x4 matrix:
//            |  0.21805 |  0.45113 |  0.24060 | -0.04511 |
//            | -0.80827 | -1.45677 | -0.44361 |  0.52068 |
//            | -0.07895 | -0.22368 | -0.05263 |  0.19737 |
//            | -0.52256 | -0.81391 | -0.30075 |  0.30639 |

    func testInversion() throws {
        let a = Matrix([[-5, 2, 6, -8], [1, -5, 1, 8], [7, 7, -6, -7], [1, -3, 7, 4]])
        let b = a.inverse
        let bExpected = Matrix([[ 0.21805,  0.45113,  0.24060, -0.04511],
                                [-0.80827, -1.45677, -0.44361, 0.52068],
                                [-0.07895, -0.22368, -0.05263, 0.19737],
                                [-0.52256, -0.81391, -0.30075, 0.30639]])
        XCTAssertEqual(a.determinant, 532)
        XCTAssertEqual(a.cofactor(row: 2, col: 3), -160)
        XCTAssertEqual(b[3,2], -160.0 / 532.0)
        XCTAssertEqual(a.cofactor(row: 3, col: 2), 105)
        XCTAssertEqual(b[2,3], 105.0 / 532.0)

        XCTAssertEqual(b, bExpected, accuracy: 0.00001)
    }

// Scenario​: Calculating the inverse of another matrix
//        ​Given​ the following 4x4 matrix A:
//          |  8 | -5 |  9 |  2 |
//          |  7 |  5 |  6 |  1 |
//          | -6 |  0 |  9 |  6 |
//          | -3 |  0 | -9 | -4 |
//        ​Then​ inverse(A) is the following 4x4 matrix:
//          | -0.15385 | -0.15385 | -0.28205 | -0.53846 |
//          | -0.07692 |  0.12308 |  0.02564 |  0.03077 |
//          |  0.35897 |  0.35897 |  0.43590 |  0.92308 |
//          | -0.69231 | -0.69231 | -0.76923 | -1.92308 |

    func testInversion2() throws {
        let a = Matrix([[8, -5, 9, 2], [7, 5, 6, 1], [-6 , 0, 9, 6], [-3, 0, -9, -4]])
        let b = a.inverse
        let bExpected = Matrix([[-0.15385, -0.15385, -0.28205, -0.53846],
                                [-0.07692,  0.12308,  0.02564,  0.03077],
                                [ 0.35897,  0.35897,  0.43590,  0.92308],
                                [-0.69231, -0.69231, -0.76923, -1.92308]])
        XCTAssertEqual(b, bExpected, accuracy: 0.00001)
    }

//​ Scenario​: Calculating the inverse of a third matrix
//​   ​Given​ the following 4x4 matrix A:
//​     |  9 |  3 |  0 |  9 |
//​     | -5 | -2 | -6 | -3 |
//​     | -4 |  9 |  6 |  4 |
//​     | -7 |  6 |  6 |  2 |
//​   ​Then​ inverse(A) is the following 4x4 matrix:
//​     | -0.04074 | -0.07778 |  0.14444 | -0.22222 |
//​     | -0.07778 |  0.03333 |  0.36667 | -0.33333 |
//​     | -0.02901 | -0.14630 | -0.10926 |  0.12963 |
//​     |  0.17778 |  0.06667 | -0.26667 |  0.33333 |

    func testInversion3() throws {
        let a = Matrix([[9, 3, 0, 9], [-5, -2, -6, -3], [-4, 9, 6, 4], [-7, 6, 6, 2]])
        let b = a.inverse
        let bExpected = Matrix([[-0.04074, -0.07778,  0.14444, -0.22222],
                                [-0.07778,  0.03333,  0.36667, -0.33333],
                                [-0.02901, -0.14630, -0.10926,  0.12963],
                                [ 0.17778,  0.06667, -0.26667,  0.33333]])

        XCTAssertEqual(b, bExpected, accuracy: 0.00001)
    }

// Scenario​: Multiplying a product by its inverse
//        ​Given​ the following 4x4 matrix A:
//            |  3 | -9 |  7 |  3 |
//            |  3 | -8 |  2 | -9 |
//            | -4 |  4 |  4 |  1 |
//            | -6 |  5 | -1 |  1 |
//          ​And​ the following 4x4 matrix B:
//            |  8 |  2 |  2 |  2 |
//            |  3 | -1 |  7 |  0 |
//            |  7 |  0 |  5 |  4 |
//            |  6 | -2 |  0 |  5 |
//          ​And​ C ← A * B
//        ​Then​ C * inverse(B) = A

    func testInversionReverse() throws {
        let a = Matrix([[3, -9, 7, 3], [3, -8, 2, -9], [-4, 4, 4, 1], [-6, 5, -1, 1]])
        let b = Matrix([[8, 2, 2, 2], [3, -1, 7, 0], [7, 0, 5, 4], [6, -2, 0, 5]])

        let c = a * b
        XCTAssertEqual(a, c * b.inverse, accuracy: 0.00001)
    }
}
