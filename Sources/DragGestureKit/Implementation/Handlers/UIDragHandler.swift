//
//  File.swift
//  
//
//  Created by Elliot Knight on 19/03/2024.
//

import UIKit

struct UIDragHandler {
    func computeElementAtIndexFromDragGesture<T>(
        data: [T],
        axis: NSLayoutConstraint.Axis,
        translation: CGPoint,
        viewSize: CGFloat
    ) throws -> T {
        let isVertical = axis == .vertical
        let valueLocation = isVertical ? translation.y : translation.x

        guard (0.0..<viewSize).contains(valueLocation) else {
            throw IndexError.outOfBounds
        }

        let percent = valueLocation / viewSize
        let index = Int(percent * CGFloat(data.count))
        return data[index]
    }

    private enum IndexError: Error {
        case outOfBounds
    }
}
