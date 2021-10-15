//
//  File.swift
//  
//
//  Created by narumij on 2021/09/27.
//

import SceneKit
import Metal

public struct Internal<VertexType>: KeyPathProperty {
    let keyPath: PartialKeyPath<VertexType>
    var dataOffset: Int! { MemoryLayout<VertexType>.offset(of: keyPath) }
}

public struct Attrb<AttributeType>: MoreAttribFormat where AttributeType: VertexDetail {
    
    public init<T>(_ keyPath: PartialKeyPath<T>) {
        keyPathOffset = Internal<T>(keyPath: keyPath)
    }

    let keyPathOffset: KeyPathProperty
    
    public var dataOffset: Int! { keyPathOffset.dataOffset }
    public var usesFloatComponents: Bool { AttributeType.usesFloatComponents }
    public var componentsPerVector: Int { AttributeType.componentsPerVector }
    public var bytesPerComponent: Int { AttributeType.bytesPerComponent }
}

extension Attrb: MetalAttributeFormat where AttributeType: MetalVertexDetail {
    public var vertexFormat: MTLVertexFormat { AttributeType.vertexFormat }
}

public typealias AttributeDetail = (semantic: SCNGeometrySource.Semantic,
                                    attributeFormat: AttributeFormat)

public typealias MetalAttributeDetail = (semantic: SCNGeometrySource.Semantic,
                                         attributeFormat: MetalAttributeFormat)

// MARK: -

extension Position
{
    static var positionInfo: AttributeDetail
    {
        ( .vertex, positionFormat )
    }
    
    static var positionFormat: AttributeFormat {
        Attrb<PositionType>(positionKeyPath)
    }
    
}

extension Texcoord
{
    static var texcoordInfo: AttributeDetail
    {
        ( .texcoord, texcoordFormat )
    }
    
    static var texcoordFormat: AttributeFormat {
        Attrb<TexcoordType>(texcoordKeyPath)
    }
    
}

extension Normal
{
    static var normalInfo: AttributeDetail
    {
        ( .normal, normalFormat )
    }
    
    static var normalFormat: AttributeFormat {
        Attrb<NormalType>(normalKeyPath)
    }
    
}


// MARK: -

public extension Interleave where Self: Position
{
    static var attributeDetails: [AttributeDetail] { [positionInfo] }
}

public extension Interleave where Self: Position, Self: Normal
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo] }
}

public extension Interleave where Self: Position, Self: Texcoord
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, texcoordInfo] }
}

