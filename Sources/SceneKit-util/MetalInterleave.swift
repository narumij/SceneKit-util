//
//  File.swift
//  
//
//  Created by narumij on 2021/10/16.
//

import Foundation

extension MetalInterleave {
    typealias VertexAttrib = MetalAttrb
}

public extension MetalInterleave where Self: Position, Self.PositionType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttribute] {
        [metalPositionInfo]
    }
}

public extension MetalInterleave where Self: Position & Normal, Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttribute] {
        [metalPositionInfo, metalNormalInfo]
    }
}

public extension MetalInterleave where Self: Position & Texcoord, Self.PositionType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttribute] {
        [metalPositionInfo, metalTexcoordInfo]
    }
}

public extension MetalInterleave where Self: Position & Color, Self.PositionType: MetalVertexDetail, Self.ColorType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttribute] { [metalPositionInfo, metalColorInfo] }
}

#if false
public extension MetalInterleave
    where Self: Position & Normal & Texcoord,
          Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail
{
    static var metalAttributeDetails: [BasicAttribute] { [positionInfo, normalInfo, texcoordInfo] }
}

public extension MetalInterleave
    where Self: Position & Normal & Color,
          Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail, Self.ColorType: MetalVertexDetail
{
    static var metalAttributeDetails: [BasicAttribute] { [positionInfo, normalInfo, colorInfo] }
}

public extension MetalInterleave
    where Self: Position & Texcoord & Color,
          Self.PositionType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail, Self.ColorType: MetalVertexDetail
{
    static var metalAttributeDetails: [BasicAttribute] { [positionInfo, texcoordInfo, colorInfo] }
}

public extension MetalInterleave
    where Self: Position & Normal & Texcoord & Color,
          Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail, Self.ColorType: MetalVertexDetail
{
    static var metalAttributeDetails: [BasicAttribute] { [positionInfo, normalInfo, texcoordInfo, colorInfo] }
}
#endif

