//
//  File.swift
//  
//
//  Created by narumij on 2021/10/16.
//

import Foundation

public extension MetalInterleave where Self: Position, Self.PositionType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttributeDetail] {
        [metalPositionInfo]
    }
}

public extension MetalInterleave where Self: Position & Normal, Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttributeDetail] {
        [metalPositionInfo, metalNormalInfo]
    }
}

public extension MetalInterleave where Self: Position & Texcoord, Self.PositionType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttributeDetail] {
        [metalPositionInfo, metalTexcoordInfo]
    }
}

public extension MetalInterleave where Self: Position & Color, Self.PositionType: MetalVertexDetail, Self.ColorType: MetalVertexDetail
{
    static var metalAttributeDetails: [MetalAttributeDetail] { [metalPositionInfo, metalColorInfo] }
}

#if false
public extension BasicInterleave
    where Self: Position & Normal & Texcoord,
          Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, texcoordInfo] }
}

public extension BasicInterleave
    where Self: Position & Normal & Color,
          Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail, Self.ColorType: MetalVertexDetail
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, colorInfo] }
}

public extension BasicInterleave
    where Self: Position & Texcoord & Color,
          Self.PositionType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail, Self.ColorType: MetalVertexDetail
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, texcoordInfo, colorInfo] }
}

public extension BasicInterleave
    where Self: Position & Normal & Texcoord & Color,
          Self.PositionType: MetalVertexDetail, Self.NormalType: MetalVertexDetail, Self.TexcoordType: MetalVertexDetail, Self.ColorType: MetalVertexDetail
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, texcoordInfo, colorInfo] }
}
#endif

