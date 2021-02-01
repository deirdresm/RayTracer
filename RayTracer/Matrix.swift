//
//  Matrix.swift
//  RayTracer
//
//  Created by Deirdre Saoirse Moen on 1/31/21.
//  Copyright © 2021 Deirdre Saoirse Moen. All rights reserved.
//

import Foundation
import CoreGraphics

// the Swift stdlib Array is actually a @frozen struct

struct Matrix: Equatable {
    private var _matrix: [[CGFloat]]
    
    init(_ matrix: [[CGFloat]]) {
        _matrix = matrix
    }
    
    @inlinable
    public subscript(row: Int, column: Int) -> CGFloat {
      get {
        return _matrix[row][column]
      }
      set(rhs) {
        _matrix[row][column] = rhs
      }
    }

    static func * (lhs: Matrix, rhs: Matrix) -> Matrix {
        var m = Matrix([[0,0,0,0],[0,0,0,0],[0,0,0,0],[0,0,0,0]])
        
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

    static func * (lhs: Matrix, rhs: Tuple) -> Tuple {
        var m = Matrix([[0,0,0,0]])
        
        for row in 0...3 {
                m[0, row] = lhs[row, 0] * rhs.x +
                            lhs[row, 1] * rhs.y +
                            lhs[row, 2] * rhs.z +
                            lhs[row, 3] * rhs.w
        }
        return Tuple(m[0,0], m[0,1], m[0,2], m[0,4])
    }

}
