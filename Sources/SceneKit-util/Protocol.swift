//
//  File.swift
//  
//
//  Created by narumij on 2021/10/14.
//

import SceneKit


public protocol VertexScalar
{
    static var vertexFormatArray: [MTLVertexFormat] { get }
}

// MARK: -

public protocol UsesFloatComponents
{
    static var usesFloatComponents: Bool { get }
}

public protocol BytesPerComponent
{
    static var bytesPerComponent: Int { get }
}

public protocol ComponentsPerVecotr
{
    static var componentsPerVector: Int { get }
}

public typealias BasicVertexDetail
    = UsesFloatComponents
    & BytesPerComponent
    & ComponentsPerVecotr

public protocol VertexFormat
{
    static var vertexFormat: MTLVertexFormat { get }
}

public typealias MetalVertexDetail
    = UsesFloatComponents
    & BytesPerComponent
    & ComponentsPerVecotr
    & VertexFormat


// MARK: -

public protocol KeyPathProperty {
    var dataOffset: Int! { get }
}

public protocol Attribute {
    typealias Semantic = SCNGeometrySource.Semantic
    var semantic: Semantic { get }
}

public protocol BasicAttribute: Attribute
{
    var usesFloatComponents: Bool { get }
    var componentsPerVector: Int  { get }
    var bytesPerComponent:   Int  { get }
    var dataOffset:          Int! { get }
}

public protocol MetalAttribute: Attribute
{
    var vertexFormat: MTLVertexFormat { get }
    var dataOffset:  Int!             { get }
}

// MARK: -

public protocol TypedAttribute {
    associatedtype AttributeType
}

public protocol TypedBasicAttribute: TypedAttribute & BasicAttribute
    where AttributeType: BasicVertexDetail { }

public protocol TypedMetalAttribute: TypedAttribute & MetalAttribute
    where AttributeType: MetalVertexDetail { }


// MARK: -

public protocol Interleave { }

public protocol BasicInterleave: Interleave
{
    static var basicAttributes: [BasicAttribute] { get }
}

public protocol MetalInterleave: Interleave
{
    static var metalAttributes: [MetalAttribute] { get }
}

public protocol FullInterleave: BasicInterleave & MetalInterleave { }

// MARK: -


public protocol CommonTraits {
    typealias AttrbKeyPath = PartialKeyPath<Self>
}


// MARK: -

public protocol Position: CommonTraits
{
    associatedtype PositionType: BasicVertexDetail, SIMD
    
           var position:        PositionType { get }
    static var positionKeyPath: AttrbKeyPath { get }
}

public protocol Normal: CommonTraits
{
    associatedtype NormalType: BasicVertexDetail, SIMD
    
           var normal:        NormalType { get }
    static var normalKeyPath: AttrbKeyPath { get }
}

public protocol Texcoord: CommonTraits
{
    associatedtype TexcoordType: BasicVertexDetail
    
           var texcoord:        TexcoordType { get }
    static var texcoordKeyPath: AttrbKeyPath { get }
}

public protocol Color: CommonTraits
{
    associatedtype ColorType: BasicVertexDetail
    
           var color:        ColorType { get }
    static var colorKeyPath: PartialKeyPath<Self> { get }
}

