//
//  File.swift
//  
//
//  Created by narumij on 2021/09/27.
//

import SceneKit
import Metal

// MARK: -

extension FixedWidthInteger {
    public static var usesFloatComponents: Bool { false }
}

extension FloatingPoint {
    public static var usesFloatComponents: Bool { true }
}

extension SIMD where Scalar: UsesFloatComponents {
    public static var usesFloatComponents: Bool { Scalar.usesFloatComponents }
}

// MARK: -

extension FixedWidthInteger {
    public static var bytesPerComponent: Int { MemoryLayout<Self>.size }
}

extension FloatingPoint {
    public static var bytesPerComponent: Int { MemoryLayout<Self>.size }
}

extension SIMD where Scalar: BytesPerComponent {
    public static var bytesPerComponent: Int { Scalar.bytesPerComponent }
}

// MARK: -

extension Numeric {
    public static var componentsPerVector: Int { 1 }
}

extension SIMD where Scalar: BytesPerComponent {
    public static var componentsPerVector: Int { scalarCount }
}

// MARK: -

@available(iOS 14.0, *)
@available(macOS 11.0, *)
extension Float16
{
    public static var vertexFormat: MTLVertexFormat { .half }

    public static var vertexFormatArray: [MTLVertexFormat]
    {
        [ .half2, .half3, .half4 ]
    }
}

extension Float32
{
    @available(iOS 11.0, *)
    public static var vertexFormat: MTLVertexFormat { .float }

    public static var vertexFormatArray: [MTLVertexFormat]
    {
        [ .float2, .float3, .float4 ]
    }
}

extension Int32
{
    @available(iOS 11.0, *)
    public static var vertexFormat: MTLVertexFormat { .int }

    public static var vertexFormatArray: [MTLVertexFormat]
    {
        [ .int2, .int2, .int4 ]
    }
}

extension Int16
{
    @available(iOS 11.0, *)
    public static var vertexFormat: MTLVertexFormat { .short }

    public static var vertexFormatArray: [MTLVertexFormat]
    {
            [ .short2, .short3, .short4 ]
    }
}

extension Int8
{
    @available(iOS 11.0, *)
    public static var vertexFormat: MTLVertexFormat { .char }

    public static var vertexFormatArray: [MTLVertexFormat]
    {
        [ .char2, .char3, .char4 ]
    }
}

extension UInt32
{
    @available(iOS 11.0, *)
    public static var vertexFormat: MTLVertexFormat { .uint }

    public static var vertexFormatArray: [MTLVertexFormat]
    {
        [ .uint, .uint2, .uint3, .uint4 ]
    }
}

extension UInt16
{
    @available(iOS 11.0, *)
    public static var vertexFormat: MTLVertexFormat { .ushort }

    public static var vertexFormatArray: [MTLVertexFormat]
    {
        [ .ushort2, .ushort3, .ushort4 ]
    }
}

extension UInt8
{
    @available(iOS 11.0, *)
    public static var vertexFormat: MTLVertexFormat { .uchar }
    
    public static var vertexFormatArray: [MTLVertexFormat]
    {
        [ .uchar2, .uchar3, .uchar4 ]
    }
}


// MARK: -

//extension Numeric where Self: VertexScalar {
//    public static var vertexFormat: MTLVertexFormat { vertexFormatArray[0] }
//}

extension SIMD where Scalar: VertexScalar {
    public static var vertexFormat: MTLVertexFormat { Scalar.vertexFormatArray[scalarCount] }
}


// MARK: -


extension Int8:    VertexDetail & VertexScalar { }
extension Int16:   VertexDetail & VertexScalar { }
extension Int32:   VertexDetail & VertexScalar { }
extension UInt8:   VertexDetail & VertexScalar { }
extension UInt16:  VertexDetail & VertexScalar { }
extension UInt32:  VertexDetail & VertexScalar { }
extension Float32: VertexDetail & VertexScalar { }
extension Int:     VertexDetail { }
extension Float64: VertexDetail { }
extension CGFloat: VertexDetail { }

@available(iOS 11.0, *)
extension Int8:    VertexFormat { }
@available(iOS 11.0, *)
extension Int16:   VertexFormat { }
@available(iOS 11.0, *)
extension UInt8:   VertexFormat { }
@available(iOS 11.0, *)
extension UInt16:  VertexFormat { }
@available(iOS 11.0, *)
extension UInt32:  VertexFormat { }
@available(iOS 11.0, *)
extension Int32:   VertexFormat { }
@available(iOS 11.0, *)
extension Float32: VertexFormat { }

@available(iOS 14.0, *)
@available(macOS 11.0, *)
extension Float16: VertexDetail & MetalVertexDetail & VertexScalar { }

extension SIMD2: VertexDetail & MetalVertexDetail where Scalar: VertexDetail & VertexScalar { }
extension SIMD3: VertexDetail & MetalVertexDetail where Scalar: VertexDetail & VertexScalar { }
extension SIMD4: VertexDetail & MetalVertexDetail where Scalar: VertexDetail & VertexScalar { }

extension CGPoint:    VertexDetail { }
extension SCNVector3: VertexDetail { }
extension SCNVector4: VertexDetail { }

