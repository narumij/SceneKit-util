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
    public init<T>(_ sm: Semantic,
                   _ keyPath: PartialKeyPath<T>,
                   usesFloatComponents ufc: Bool,
                   componentsPerVector cpv: Int,
                   bytesPerComponent bpc: Int)
    {
        semantic = sm
        vertexKeyPath = VertexKeyPath(keyPath: keyPath)
        usesFloatComponents = ufc
        componentsPerVector = cpv
        bytesPerComponent = bpc
    }
    public let semantic: Semantic
    let vertexKeyPath: KeyPathProperty
    public let usesFloatComponents: Bool
    public let componentsPerVector: Int
    public let bytesPerComponent: Int
    public var dataOffset: Int! { vertexKeyPath.dataOffset }
}


public struct MetalAttrb: MetalAttributeFormatTraits {
    public init<T>(_ sm: Semantic,
                   _ vs: MTLVertexFormat,
                   _ keyPath: PartialKeyPath<T>)
    {
        semantic = sm
        vertexKeyPath = VertexKeyPath(keyPath: keyPath)
        vertexFormat = vs
    }
    public let semantic: Semantic
    let vertexKeyPath: KeyPathProperty
    public let vertexFormat: MTLVertexFormat
    public var dataOffset: Int! { vertexKeyPath.dataOffset }
}


public struct Attrb<AttributeType>: BasicAttrbFormat where AttributeType: BasicVertexDetail {
    
    public init<T>(_ sm: Semantic,_ keyPath: PartialKeyPath<T>) {
        semantic = sm
        keyPathOffset = VertexKeyPath<T>(keyPath: keyPath)
    }

    public let semantic: Semantic
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

extension Position where Self: BasicTraits
{
    static var positionInfo: AttributeDetail
    {
        Attrb<PositionType>(.vertex, positionKeyPath)
    }
}

extension Position where PositionType: MetalVertexDetail, Self: MetalInterleave
{
    static var metalPositionInfo: MetalAttributeDetail
    {
         Attrb<PositionType>(.vertex, positionKeyPath)
    }
}

//extension Position where PositionType: MetalVertexDetail, Self: MetalInterleave { }


extension Normal where Self: BasicTraits
{
    static var normalInfo: AttributeDetail
    {
        Attrb<NormalType>(.normal, normalKeyPath)
    }
    
}

extension Normal where NormalType: MetalVertexDetail, Self: MetalTraits
{
    static var metalNormalInfo: MetalAttributeDetail
    {
        Attrb<NormalType>(.normal, normalKeyPath)
    }
}

extension Texcoord where Self: BasicTraits
{
    static var texcoordInfo: AttributeDetail
    {
        Attrb<TexcoordType>(.texcoord, texcoordKeyPath)
    }
}

extension Texcoord where TexcoordType: MetalVertexDetail, Self: MetalTraits
{
    static var metalTexcoordInfo: MetalAttributeDetail
    {
        Attrb<TexcoordType>(.texcoord, texcoordKeyPath)
    }
}

extension Color where Self: BasicTraits
{
    static var colorInfo: AttributeDetail
    {
        Attrb<ColorType>(.color, colorKeyPath)
    }
}

extension Color where ColorType: MetalVertexDetail, Self: MetalTraits
{
    static var metalColorInfo: MetalAttributeDetail
    {
        Attrb<ColorType>(.color, colorKeyPath)
    }
}

