//
//  File.swift
//  
//
//  Created by narumij on 2021/10/14.
//

import SceneKit

public protocol CommonTraits {
    typealias AttrbKeyPath = PartialKeyPath<Self>
}

public protocol BasicTraits: CommonTraits {
    typealias AttributeDetail = (semantic: SCNGeometrySource.Semantic,
                                 attributeFormat: BasicAttributeFormatTraits)
}

public protocol MetalTraits: CommonTraits {
    typealias MetalAttributeDetail = (semantic: SCNGeometrySource.Semantic,
                                      attributeFormat: MetalAttributeFormatTraits)
}


// MARK: -

public protocol UsesFloatComponents {
    static var usesFloatComponents: Bool { get }
}

public protocol BytesPerComponent {
    static var bytesPerComponent: Int { get }
}

public protocol ComponentsPerVecotr {
    static var componentsPerVector: Int { get }
}

public protocol VertexFormat: BasicVertexDetail {
    static var vertexFormat: MTLVertexFormat { get }
}

public protocol VertexScalar {
    static var vertexFormatArray: [MTLVertexFormat] { get }
}

public typealias BasicVertexDetail = CommonTraits & BasicTraits & UsesFloatComponents & BytesPerComponent & ComponentsPerVecotr

public typealias MetalVertexDetail = MetalTraits & BasicVertexDetail & VertexFormat


// MARK: -

protocol KeyPathProperty {
    var dataOffset: Int! { get }
}

public protocol AttributeFormatTraits { }

public protocol BasicAttributeFormatTraits: AttributeFormatTraits
{
    var dataOffset: Int! { get }
    var usesFloatComponents: Bool { get }
    var componentsPerVector: Int { get }
    var bytesPerComponent: Int { get }
}

public protocol MetalAttributeFormatTraits: BasicAttributeFormatTraits & MetalTraits
{
    var vertexFormat: MTLVertexFormat { get }
}


// MARK: -

public protocol AttrbFormat {
    associatedtype AttributeType
}

public protocol BasicAttrbFormat: AttrbFormat & BasicAttributeFormatTraits & BasicTraits
    where AttributeType: BasicVertexDetail { }

public protocol MetalAttrbFormat: AttrbFormat & MetalAttributeFormatTraits & MetalTraits
    where AttributeType: MetalVertexDetail { }


// MARK: -

public protocol I: BasicTraits
{
    static var attributeDetails: [AttributeDetail] { get }
}

public protocol M: BasicTraits & MetalTraits
{
    static var attributeDetails: [AttributeDetail] { get }
    static var metalAttributeDetails: [MetalAttributeDetail] { get }
}

extension I where Self: P, Self.PositionType: BasicVertexDetail
{
    static var attributeDetails: [AttributeDetail] { [positionInfo] }
}

extension M where Self: P, Self.PositionType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttributeDetail] { [metalPositionInfo] }
}

protocol P
{
    associatedtype PositionType: SIMD
    var position: PositionType { get }
    static var positionKeyPath: PartialKeyPath<Self> { get }
}

extension P where PositionType: BasicVertexDetail, Self: BasicTraits
{
    static var positionInfo: AttributeDetail
    {
        ( .vertex, Attrb<PositionType>(positionKeyPath) )
    }
}

extension P where PositionType: MetalVertexDetail, Self: MetalTraits
{
    static var metalPositionInfo: MetalAttributeDetail
    {
        ( .vertex, Attrb<PositionType>(positionKeyPath) )
    }
}

public protocol Interleave: BasicTraits
{
    static var attributeDetails: [AttributeDetail] { get }
}

public protocol MetalInterleave: BasicTraits & MetalTraits
{
    static var metalAttributeDetails: [MetalAttributeDetail] { get }
}

// MARK: -

public protocol Position: Interleave
{
    associatedtype PositionType: SIMD
    var position: PositionType { get }
    static var positionKeyPath: AttrbKeyPath { get }
}

public protocol Normal
{
    associatedtype NormalType: SIMD
    var normal: NormalType { get }
    static var normalKeyPath: PartialKeyPath<Self> { get }
}

public protocol Texcoord
{
    associatedtype TexcoordType: BasicVertexDetail
    var texcoord: TexcoordType { get }
    static var texcoordKeyPath: PartialKeyPath<Self> { get }
}

public protocol Color
{
    associatedtype ColorType: BasicVertexDetail
    var color: ColorType { get }
    static var colorKeyPath: PartialKeyPath<Self> { get }
}





