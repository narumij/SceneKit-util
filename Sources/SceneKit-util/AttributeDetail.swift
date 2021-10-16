//
//  File.swift
//  
//
//  Created by narumij on 2021/09/27.
//

import SceneKit
import Metal

public struct VertexKeyPath<VertexType>: KeyPathProperty {
    let keyPath: PartialKeyPath<VertexType>
    public var dataOffset: Int!
    {
        MemoryLayout<VertexType>.offset(of: keyPath)
    }
}

public struct BasicAttrb: BasicAttributeFormatTraits {
    public let vertexKeyPath: KeyPathProperty
    public var dataOffset: Int! { vertexKeyPath.dataOffset }
    public let usesFloatComponents: Bool
    public let componentsPerVector: Int
    public let bytesPerComponent: Int
}

public struct MetalAttrb: MetalAttributeFormatTraits {
    public let vertexKeyPath: KeyPathProperty
    public let vertexFormat: MTLVertexFormat
    public var dataOffset: Int! { vertexKeyPath.dataOffset }
}

public struct Attrb<AttributeType>: BasicAttrbFormat where AttributeType: BasicVertexDetail {
    
    public init<T>(_ keyPath: PartialKeyPath<T>) {
        keyPathOffset = VertexKeyPath<T>(keyPath: keyPath)
    }

    let keyPathOffset: KeyPathProperty
    
    public var dataOffset: Int! { keyPathOffset.dataOffset }
    public var usesFloatComponents: Bool { AttributeType.usesFloatComponents }
    public var componentsPerVector: Int { AttributeType.componentsPerVector }
    public var bytesPerComponent: Int { AttributeType.bytesPerComponent }
    
}

extension Attrb: MetalTraits where AttributeType: MetalVertexDetail {
    public var vertexFormat: MTLVertexFormat { AttributeType.vertexFormat }
}

extension Attrb: MetalAttributeFormatTraits where AttributeType: MetalVertexDetail {
}

extension Attrb: MetalAttrbFormat where AttributeType: MetalVertexDetail {
}


// MARK: -

extension Position where PositionType: BasicVertexDetail
{
    static var positionInfo: AttributeDetail
    {
        ( .vertex, Attrb<PositionType>(positionKeyPath) )
    }
}

extension Position where PositionType: MetalVertexDetail, Self: MetalTraits
{
    static var metalPositionInfo: MetalAttributeDetail
    {
        ( .vertex, Attrb<PositionType>(positionKeyPath) )
    }
}

extension Normal where NormalType: BasicVertexDetail, Self: BasicTraits
{
    static var normalInfo: AttributeDetail
    {
        ( .normal, Attrb<NormalType>(normalKeyPath) )
    }
    
}

extension Normal where NormalType: MetalVertexDetail, Self: MetalTraits
{
    static var metalNormalInfo: MetalAttributeDetail
    {
        ( .vertex, Attrb<NormalType>(normalKeyPath) )
    }
}

extension Texcoord where Self: BasicTraits
{
    static var texcoordInfo: AttributeDetail
    {
        ( .vertex, Attrb<TexcoordType>(texcoordKeyPath) )
    }
}

extension Texcoord where TexcoordType: MetalVertexDetail, Self: MetalTraits
{
    static var metalTexcoordInfo: MetalAttributeDetail
    {
        ( .vertex, Attrb<TexcoordType>(texcoordKeyPath) )
    }
}

extension Color where Self: BasicTraits
{
    static var colorInfo: AttributeDetail
    {
        ( .normal, Attrb<ColorType>(colorKeyPath) )
    }
}

extension Color where ColorType: MetalVertexDetail, Self: MetalTraits
{
    static var metalColorInfo: MetalAttributeDetail
    {
        ( .normal, Attrb<ColorType>(colorKeyPath) )
    }
}

