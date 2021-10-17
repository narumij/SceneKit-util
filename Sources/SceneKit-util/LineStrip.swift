//
//  File.swift
//  
//
//  Created by narumij on 2021/10/01.
//

import SceneKit

struct LineStrip {
    
    let count: Int
    
    func idx(_ n: Int) -> Int {
        
        n / 2 + n % 2
    }
    
    var lineStripIndices: [Int] {
        
        count == 0 ? [] : Array<Int>( 0 ..< (count-1)*2).map{ idx($0) }
    }
    
    func geometryElement() -> SCNGeometryElement {
        
        lineStripIndices
            .map({UInt32($0)})
            .geometryElement(primitiveType: .line)
    }
}
