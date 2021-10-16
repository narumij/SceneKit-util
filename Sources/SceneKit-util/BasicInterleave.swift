//
//  File.swift
//  
//
//  Created by narumij on 2021/10/16.
//

import Foundation

extension BasicInterleave where Self: Position
{
    static var basicAttributeDetails: [BasicAttribute] {
        [positionInfo]
    }
}

public extension BasicInterleave where Self: Position & Normal
{
    static var basicAttributeDetails: [BasicAttribute] {
        [positionInfo, normalInfo]
    }
}

public extension BasicInterleave where Self: Position & Texcoord
{
    static var basicAttributeDetails: [BasicAttribute] {
        [positionInfo, texcoordInfo]
    }
}

public extension BasicInterleave where Self: Position & Color
{
    static var basicAttributeDetails: [BasicAttribute] { [positionInfo, colorInfo] }
}

#if false
public extension BasicInterleave where Self: Position & Normal & Texcoord
{
    static var basicAttributeDetails: [BasicAttribute] { [positionInfo, normalInfo, texcoordInfo] }
}

public extension BasicInterleave where Self: Position & Normal & Color
{
    static var basicAttributeDetails: [BasicAttribute] { [positionInfo, normalInfo, colorInfo] }
}

public extension BasicInterleave where Self: Position & Texcoord & Color
{
    static var basicAttributeDetails: [BasicAttribute] { [positionInfo, texcoordInfo, colorInfo] }
}

public extension BasicInterleave where Self: Position & Normal & Texcoord & Color
{
    static var basicAttributeDetails: [BasicAttribute] { [positionInfo, normalInfo, texcoordInfo, colorInfo] }
}
#endif

