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
        ( .vertex, Attrb<PositionType>(positionKeyPath) )
    }
}

extension Position where PositionType: MetalVertexDetail, Self: MetalTraits
{
    static var positionInfo: AttributeDetail
    {
        metalPositionInfo
    }
    
    static var metalPositionInfo: MetalAttributeDetail
    {
        ( .vertex, Attrb<PositionType>(positionKeyPath) )
    }
}

extension Texcoord where Self: BasicTraits
{
    static var texcoordInfo: AttributeDetail
    {
        ( .vertex, Attrb<TexcoordType>(texcoordKeyPath) )
    }
}

extension Texcoord where TexcoordType: MetalVertexDetail, Self: BasicTraits & MetalTraits
{
    static var texcoordInfo: AttributeDetail
    {
        metalTexcoordInfo
    }

    static var metalTexcoordInfo: MetalAttributeDetail
    {
        ( .vertex, Attrb<TexcoordType>(texcoordKeyPath) )
    }
}


extension Normal where Self: BasicTraits
{
    static var normalInfo: AttributeDetail
    {
        ( .normal, Attrb<NormalType>(normalKeyPath) )
    }
    
}

extension Normal where NormalType: MetalVertexDetail, Self: BasicTraits & MetalTraits
{
    static var normalInfo: AttributeDetail
    {
        metalNormalInfo
    }

    static var metalNormalInfo: MetalAttributeDetail
    {
        ( .vertex, Attrb<NormalType>(normalKeyPath) )
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

extension Interleave where Self: Position
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo]
    }
}

extension MetalInterleave where Self: Position, Self.PositionType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttributeDetail] {
        [metalPositionInfo]
    }
}

public extension Interleave where Self: Position & Normal
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo, normalInfo]
    }
}

public extension MetalInterleave
    where Self: Position & Normal, Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttributeDetail] {
        [metalPositionInfo, metalNormalInfo]
    }
}

public extension Interleave where Self: Position & Texcoord
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo, texcoordInfo]
    }
}

public extension MetalInterleave
    where Self: Position & Texcoord, Self.PositionType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttributeDetail] {
        [metalPositionInfo, metalTexcoordInfo]
    }
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


