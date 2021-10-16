//
//  File.swift
//  
//
//  Created by narumij on 2021/10/16.
//

import Foundation

extension BasicInterleave where Self: Position
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo]
    }
}

public extension BasicInterleave where Self: Position & Normal
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo, normalInfo]
    }
}

public extension BasicInterleave where Self: Position & Texcoord
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo, texcoordInfo]
    }
}

public extension BasicInterleave where Self: Position & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, colorInfo] }
}

#if false
public extension BasicInterleave where Self: Position & Normal & Texcoord
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, texcoordInfo] }
}

public extension BasicInterleave where Self: Position & Normal & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, colorInfo] }
}

public extension BasicInterleave where Self: Position & Texcoord & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, texcoordInfo, colorInfo] }
}

public extension BasicInterleave where Self: Position & Normal & Texcoord & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, normalInfo, texcoordInfo, colorInfo] }
}
#endif

