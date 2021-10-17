//
//  File.swift
//  
//
//  Created by narumij on 2021/10/01.
//

import SceneKit

public struct TypedBuffer<T> {
    
    public typealias Element = T
    
    let buffer: MTLBuffer
    let vertexFormat: MTLVertexFormat?
    
    public init(_ b: MTLBuffer, vertexFormat vf: MTLVertexFormat? = nil) {
        
        buffer = b
        vertexFormat = vf
    }
}

extension TypedBuffer where Element: FixedWidthInteger {
    
    func geometryElement(primitiveType type: SCNGeometryPrimitiveType) -> SCNGeometryElement
    {
        Array<Element>.geometryElement( of: buffer, primitiveType: type )
    }
}

extension TypedBuffer where Element: MetalVertexDetail {
    
    func geometrySource(semantic s: SCNGeometrySource.Semantic) -> SCNGeometrySource {
        
        Array<Element>.geometrySource(of: buffer, semantic: s, vertexFormat: vertexFormat)
    }
}

extension TypedBuffer where Element: MetalInterleave {
    
    func geometrySources() -> [SCNGeometrySource] {
        
        Array<Element>.geometrySources(of: buffer)
    }
}

extension TypedBuffer {
    
    var count: Int { Array<Element>.count(of: buffer) }
    
    func geometryElement(primitiveType type: PrimitiveType) -> SCNGeometryElement {
        
        _geometryElement(count: count, primitiveType: type)
    }
}

