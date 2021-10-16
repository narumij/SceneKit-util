//
//  File.swift
//  
//
//  Created by narumij on 2021/10/16.
//

import Foundation

extension Interleave where Self: Position
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo]
    }
}

public extension Interleave where Self: Position & Normal
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo, normalInfo]
    }
}

public extension Interleave where Self: Position & Texcoord
{
    static var attributeDetails: [AttributeDetail] {
        [positionInfo, texcoordInfo]
    }
}

public extension Interleave where Self: Position & Color
{
    static var attributeDetails: [AttributeDetail] { [positionInfo, colorInfo] }
}

#if false
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
#endif

