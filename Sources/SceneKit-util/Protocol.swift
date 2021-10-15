//
//  File.swift
//  
//
//  Created by narumij on 2021/10/14.
//

//import Metal
import SceneKit

public protocol UsesFloatComponents {
    static var usesFloatComponents: Bool { get }
}

public protocol BytesPerComponent {
    static var bytesPerComponent: Int { get }
}

public protocol ComponentsPerVecotr {
    static var componentsPerVector: Int { get }
}

public protocol VertexFormat: VertexDetail {
    static var vertexFormat: MTLVertexFormat { get }
}

public protocol VertexScalar {
    static var vertexFormatArray: [MTLVertexFormat] { get }
}

public typealias VertexDetail = UsesFloatComponents & BytesPerComponent & ComponentsPerVecotr

public typealias MetalVertexDetail = VertexFormat & VertexDetail

// MARK: -

protocol KeyPathProperty {
    var dataOffset: Int! { get }
}

public protocol AttributeFormat {
    var dataOffset: Int! { get }
    var usesFloatComponents: Bool { get }
    var componentsPerVector: Int { get }
    var bytesPerComponent: Int { get }
}

public protocol MetalAttributeFormat: AttributeFormat {
    var vertexFormat: MTLVertexFormat { get }
}

public protocol MoreAttribFormat: AttributeFormat {
    associatedtype AttributeType
}

// MARK: -

public protocol Interleave
{
    static var attributeDetails: [AttributeDetail] { get }
    typealias AttrbKeyPath = PartialKeyPath<Self>
}

public protocol MetalInterleave
{
    static var metalAttributeDetails: [MetalAttributeDetail] { get }
}

// MARK: -

public protocol Position: Interleave
{
    associatedtype PositionType: MetalVertexDetail, SIMD
    var position: PositionType { get }
    static var positionKeyPath: AttrbKeyPath { get }
}

public protocol Normal: Interleave
{
    associatedtype NormalType: MetalVertexDetail, SIMD
    var normal: NormalType { get }
    static var normalKeyPath: AttrbKeyPath { get }
}

public protocol Texcoord: Interleave
{
    associatedtype TexcoordType: MetalVertexDetail
    var texcoord: TexcoordType { get }
    static var texcoordKeyPath: AttrbKeyPath { get }
}

public protocol Color: Interleave
{
    associatedtype ColorType: MetalVertexDetail
    var color: ColorType { get }
    static var colorKeyPath: AttrbKeyPath { get }
}





