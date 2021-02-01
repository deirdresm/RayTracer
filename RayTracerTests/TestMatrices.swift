//
//  TestMatrices.swift
//  RayTracerTests
//
//  Created by Deirdre Saoirse Moen on 1/31/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import XCTest
@testable import RayTracer

class TestMatrices: XCTestCase {
    
    let epsilon : CGFloat = 0.00001

//    ​     ​Scenario​: Constructing and inspecting a 4x4 matrix
//    ​       ​Given​ the following 4x4 matrix M:
//    ​         |  1   |  2   |  3   |  4   |
//    ​         |  5.5 |  6.5 |  7.5 |  8.5 |
//    ​         |  9   | 10   | 11   | 12   |
//    ​         | 13.5 | 14.5 | 15.5 | 16.5 |
//    ​       ​Then​ M[0,0] = 1
//    ​         ​And​ M[0,3] = 4
//    ​         ​And​ M[1,0] = 5.5
//    ​         ​And​ M[1,2] = 7.5
//    ​         ​And​ M[2,2] = 11
//    ​         ​And​ M[3,0] = 13.5
//    ​         ​And​ M[3,2] = 15.5

    func test4x4MatrixCreation() throws {
        let m = Matrix([[1,2,3,4],[5.5,6.5,7.5,8.5],
                        [9,10,11,12],[13.5,14.5,15.5,16.5]])
        
        XCTAssertEqual(m[0,0], 1.0)
        XCTAssertEqual(m[0,3], 4.0)
        XCTAssertEqual(m[1,0], 5.5)
        XCTAssertEqual(m[1,2], 7.5)
        XCTAssertEqual(m[2,2], 11.0)
        XCTAssertEqual(m[3,0], 13.5)
        XCTAssertEqual(m[3,2], 15.5)

    }
    
//    ​​Scenario​: A 2x2 matrix ought to be representable
//​       ​Given​ the following 2x2 matrix M:
//​         | -3 |  5 |
//​         |  1 | -2 |
//​       ​Then​ M[0,0] = -3
//​         ​And​ M[0,1] = 5
//​         ​And​ M[1,0] = 1
//​         ​And​ M[1,1] = -2

    func test2x2MatrixCreation() throws {
        let m = Matrix([[-3,5],[1,-2]])
        
        XCTAssertEqual(m[0,0], -3.0)
        XCTAssertEqual(m[0,1], 5.0)
        XCTAssertEqual(m[1,0], 1.0)
        XCTAssertEqual(m[1,1], -2)
    }

//    ​​Scenario​: A 3x3 matrix ought to be representable
//​       ​Given​ the following 3x3 matrix M:
//    ​         | -3 |  5 |  0 |
//    ​         |  1 | -2 | -7 |
//    ​         |  0 |  1 |  1 |
//    ​       ​Then​ M[0,0] = -3
//    ​         ​And​ M[1,1] = -2
//    ​         ​And​ M[2,2] = 1

    func test3x3MatrixCreation() throws {
        let m = Matrix([[-3,5,0],[1,-2,-7],[0,1,1]])
        
        XCTAssertEqual(m[0,0], -3.0)
        XCTAssertEqual(m[1,1], -2.0)
        XCTAssertEqual(m[2,2], 1.0)
    }
    
//    Scenario​: Matrix equality with identical matrices
//    ​       ​Given​ the following matrix A:
//    ​           | 1 | 2 | 3 | 4 |
//    ​           | 5 | 6 | 7 | 8 |
//    ​           | 9 | 8 | 7 | 6 |
//    ​           | 5 | 4 | 3 | 2 |
//    ​         ​And​ the following matrix B:
//    ​           | 1 | 2 | 3 | 4 |
//    ​           | 5 | 6 | 7 | 8 |
//    ​           | 9 | 8 | 7 | 6 |
//    ​           | 5 | 4 | 3 | 2 |
//    ​       ​Then​ A = B
    
    func textMatrixEquality() throws {
        let a = Matrix([[1,2,3,4],[5,6,7,8],
                        [9,8,7,6],[5,4,3,2]])
        let b = Matrix([[1,2,3,4],[5,6,7,8],
                        [9,8,7,6],[5,4,3,2]])

        XCTAssertEqual(a, b)
    }
    
//    Scenario​: Matrix equality with different matrices
//    ​       ​Given​ the following matrix A:
//    ​           | 1 | 2 | 3 | 4 |
//    ​           | 5 | 6 | 7 | 8 |
//    ​           | 9 | 8 | 7 | 6 |
//    ​           | 5 | 4 | 3 | 2 |
//    ​         ​And​ the following matrix B:
//    ​           | 2 | 3 | 4 | 5 |
//    ​           | 6 | 7 | 8 | 9 |
//    ​           | 8 | 7 | 6 | 5 |
//    ​           | 4 | 3 | 2 | 1 |
//    ​       ​Then​ A != B

    func textMatrixInquality() throws {
        let a = Matrix([[1,2,3,4],[5,6,7,8],
                        [9,8,7,6],[5,4,3,2]])
        let b = Matrix([[2,3,4,5],[6,7,8,9],
                        [8,7,6,5],[4,3,2,1]])

        XCTAssertNotEqual(a, b)
    }
    
//    Scenario​: Multiplying two matrices
//    ​       ​Given​ the following matrix A:
//    ​           | 1 | 2 | 3 | 4 |
//    ​           | 5 | 6 | 7 | 8 |
//    ​           | 9 | 8 | 7 | 6 |
//    ​           | 5 | 4 | 3 | 2 |
//    ​         ​And​ the following matrix B:
//    ​           | -2 | 1 | 2 |  3 |
//    ​           |  3 | 2 | 1 | -1 |
//    ​           |  4 | 3 | 6 |  5 |
//    ​           |  1 | 2 | 7 |  8 |
//    ​       ​Then​ A * B is the following 4x4 matrix:
//    ​           | 20|  22 |  50 |  48 |
//    ​           | 44|  54 | 114 | 108 |
//    ​           | 40|  58 | 110 | 102 |
//    ​           | 16|  26 |  46 |  42 |

    func textMatrixMultiply() throws {
        let a = Matrix([[1,2,3,4],[5,6,7,8],
                        [9,8,7,6],[5,4,3,2]])
        let b = Matrix([[-2,1,2,3],[3,2,1,-1],
                        [4,3,6,5],[1,2,7,8]])
        let result = Matrix([[20,22,50,48],[44,54,114,108],
                             [40,58,110,102],[16,26,46,42]])

        XCTAssertEqual(a * b, result)
    }

    
}
