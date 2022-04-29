//
//  File.swift
//  
//
//  Created by narumij on 2021/10/16.
//

import Metal
import SceneKit_util

@available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
extension Float16: BasicVertexDetail & VertexScalar { }

@available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
extension Float16: VertexFormat { }

@available(macOS 11.0, iOS 14.0, tvOS 14.0, *)
extension Float16
{
    public static var vertexFormat: MTLVertexFormat
    {
        .half
    }

    public static var vertexFormatArray: [MTLVertexFormat]
    {
        [ .half2, .half3, .half4 ]
    }
}

