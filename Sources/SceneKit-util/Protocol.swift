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


//public protocol BasicTraits: CommonTraits {
//    typealias AttributeDetail = (semantic: SCNGeometrySource.Semantic,
//                                 attributeFormat: BasicAttributeFormatTraits)
//    typealias BasicAttribute = BasicAttributeFormatTraits
//}

//public protocol MetalTraits: CommonTraits {
//    typealias MetalAttributeDetail = (semantic: SCNGeometrySource.Semantic,
//                                      attributeFormat: MetalAttributeFormatTraits)
//    typealias MetalAttribute = MetalAttributeFormatTraits
//}


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

public typealias BasicVertexDetail = CommonTraits & UsesFloatComponents & BytesPerComponent & ComponentsPerVecotr

public typealias MetalVertexDetail = BasicVertexDetail & VertexFormat


// MARK: -

public protocol KeyPathProperty {
    var dataOffset: Int! { get }
}

public protocol AttributeFormatTraits {
    typealias Semantic = SCNGeometrySource.Semantic
    var semantic: Semantic { get }
}

public protocol BasicAttribute: AttributeFormatTraits
{
    var usesFloatComponents: Bool { get }
    var componentsPerVector: Int { get }
    var bytesPerComponent: Int { get }
    var dataOffset: Int! { get }
}

public protocol MetalAttribute: AttributeFormatTraits
{
    var vertexFormat: MTLVertexFormat { get }
    var dataOffset: Int! { get }
}

// MARK: -

public protocol AttrbFormat {
    associatedtype AttributeType
}

public protocol BasicAttrbFormat: AttrbFormat & BasicAttribute
    where AttributeType: BasicVertexDetail { }

public protocol MetalAttrbFormat: AttrbFormat & MetalAttribute
    where AttributeType: MetalVertexDetail { }


// MARK: -

public protocol Interleave { }

public protocol BasicInterleave: Interleave
{
    static var basicAttributeDetails: [BasicAttribute] { get }
}

public protocol MetalInterleave: Interleave
{
    static var metalAttributeDetails: [MetalAttribute] { get }
}

public protocol FullInterleave: BasicInterleave & MetalInterleave { }

// MARK: -

public protocol Position: CommonTraits
{
    associatedtype PositionType: BasicVertexDetail, SIMD
    var position: PositionType { get }
    static var positionKeyPath: AttrbKeyPath { get }
}

public protocol Normal: CommonTraits
{
    associatedtype NormalType: BasicVertexDetail, SIMD
    var normal: NormalType { get }
    static var normalKeyPath: AttrbKeyPath { get }
}

public protocol Texcoord: CommonTraits
{
    associatedtype TexcoordType: BasicVertexDetail
    var texcoord: TexcoordType { get }
    static var texcoordKeyPath: AttrbKeyPath { get }
}

public protocol Color: CommonTraits
{
    associatedtype ColorType: BasicVertexDetail
    var color: ColorType { get }
    static var colorKeyPath: PartialKeyPath<Self> { get }
}

