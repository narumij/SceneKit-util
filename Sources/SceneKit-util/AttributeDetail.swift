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
    public init<T>(_ keyPath: PartialKeyPath<T>,
                   usesFloatComponents ufc: Bool,
                   componentsPerVector cpv: Int,
                   bytesPerComponent bpc: Int)
    {
        vertexKeyPath = VertexKeyPath(keyPath: keyPath)
        usesFloatComponents = ufc
        componentsPerVector = cpv
        bytesPerComponent = bpc
    }
    let vertexKeyPath: KeyPathProperty
    public let usesFloatComponents: Bool
    public let componentsPerVector: Int
    public let bytesPerComponent: Int
    public var dataOffset: Int! { vertexKeyPath.dataOffset }
}


public struct MetalAttrb: MetalAttributeFormatTraits {
    public init<T>(_ vs: MTLVertexFormat,
                   _ keyPath: PartialKeyPath<T>)
    {
        vertexKeyPath = VertexKeyPath(keyPath: keyPath)
        vertexFormat = vs
    }
    let vertexKeyPath: KeyPathProperty
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

extension Attrb: MetalAttributeFormatTraits where AttributeType: MetalVertexDetail { }
extension Attrb: MetalAttrbFormat           where AttributeType: MetalVertexDetail { }

// MARK: -

extension Position
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

extension Normal where Self: BasicTraits
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
        ( .normal, Attrb<NormalType>(normalKeyPath) )
    }
}

extension Texcoord where Self: BasicTraits
{
    static var texcoordInfo: AttributeDetail
    {
        ( .texcoord, Attrb<TexcoordType>(texcoordKeyPath) )
    }
}

extension Texcoord where TexcoordType: MetalVertexDetail, Self: MetalTraits
{
    static var metalTexcoordInfo: MetalAttributeDetail
    {
        ( .texcoord, Attrb<TexcoordType>(texcoordKeyPath) )
    }
}

extension Color where Self: BasicTraits
{
    static var colorInfo: AttributeDetail
    {
        ( .color, Attrb<ColorType>(colorKeyPath) )
    }
}

extension Color where ColorType: MetalVertexDetail, Self: MetalTraits
{
    static var metalColorInfo: MetalAttributeDetail
    {
        ( .color, Attrb<ColorType>(colorKeyPath) )
    }
}

