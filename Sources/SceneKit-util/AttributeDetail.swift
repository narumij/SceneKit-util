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
    var dataOffset: Int! { MemoryLayout<VertexType>.offset(of: keyPath) }
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

extension Position
{
    static var positionInfo: AttributeDetail
    {
        ( .vertex, positionFormat )
    }
    
    static var positionFormat: BasicAttributeFormatTraits {
        Attrb<PositionType>(positionKeyPath)
    }
    
}

extension Texcoord
{
    static var texcoordInfo: AttributeDetail
    {
        ( .texcoord, texcoordFormat )
    }
    
    static var texcoordFormat: BasicAttributeFormatTraits {
        Attrb<TexcoordType>(texcoordKeyPath)
    }
    
}

extension Normal
{
    static var normalInfo: AttributeDetail
    {
        ( .normal, normalFormat )
    }
    
    static var normalFormat: BasicAttributeFormatTraits {
        Attrb<NormalType>(normalKeyPath)
    }
    
}

extension Color
{
    static var colorInfo: AttributeDetail
    {
        ( .normal, colorFormat )
    }
    
    static var colorFormat: BasicAttributeFormatTraits {
        Attrb<ColorType>(colorKeyPath)
    }
    
}


// MARK: -

public extension Interleave where Self: Position
{
    static var attributeDetails: [AttributeDetail] { [positionInfo] }
}

public extension Interleave where Self: Position & Normal
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo] }
}

public extension Interleave where Self: Position & Texcoord
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, texcoordInfo] }
}

public extension Interleave where Self: Position & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, colorInfo] }
}

public extension Interleave where Self: Position & Normal & Texcoord
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, texcoordInfo] }
}

public extension Interleave where Self: Position & Normal & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, colorInfo] }
}

public extension Interleave where Self: Position & Texcoord & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, texcoordInfo, colorInfo] }
}

public extension Interleave where Self: Position & Normal & Texcoord & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, texcoordInfo, colorInfo] }
}


