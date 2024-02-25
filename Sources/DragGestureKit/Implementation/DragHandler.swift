//
//  DragHandler.swift
//
//
//  Created by Elliot Knight on 14/02/2024.
//

import SwiftUI

struct DragHandler {
    func computeElementAtIndexFromDragGesture<T>(
        data: [T],
        axis: Axis.Set,
        value: DragGesture.Value,
        viewSize: Double
    ) throws -> T {
        let isVertical = axis == .vertical
        let valueLocation = isVertical ? value.location.y : value.location.x
        let startLocation = isVertical ? value.startLocation.y : value.startLocation.x
        let translation = isVertical ? value.translation.height : value.translation.width

        guard (0..<viewSize).contains(valueLocation) else {
            throw IndexError.outOfBounds
        }

        let percent = (startLocation + translation) / viewSize
        let index = Int(percent * CGFloat(data.count))
        return data[index]
    }

    func calculViewSize(axis: Axis.Set, proxy: GeometryProxy) -> Double {
        axis == .horizontal ? proxy.size.width : proxy.size.height
    }

    private enum IndexError: Error {
        case outOfBounds
    }
}
