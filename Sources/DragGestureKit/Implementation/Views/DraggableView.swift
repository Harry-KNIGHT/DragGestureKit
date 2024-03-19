//
//  DraggableView.swift
//
//
//  Created by Elliot Knight on 14/02/2024.
//

import SwiftUI

/// Detects the position of a drag gesture within a collection of data elements.
public struct DraggableView<Content: View, T: Hashable>: View {
    @Binding private var data: [T]
    private let elements: [T]

    private let axis: Axis.Set
    private let content: Content
    private let onDragChanged: (T?) -> Void

    @State private var viewSize: Double = 0.0
    private var dragHandler = DragHandler()

    public var body: some View {
        content
            .background(
                GeometryReader { proxy in
                    Color.clear
                        .onAppear {
                            viewSize = axis == .horizontal ? proxy.size.width : proxy.size.height
                        }
                }
            )
            .gesture(
                DragGesture()
                    .onChanged { value in
                        do {
                            let element = try dragHandler.computeElementAtIndexFromDragGesture(
                                data: data.isEmpty ? elements : data,
                                axis: axis,
                                value: value,
                                viewSize: viewSize
                            )
                            self.onDragChanged(element)
                        } catch {
                            print("-- Drag gesture out of bounds --")
                        }
                    }
                    .onEnded { _ in
                        self.onDragChanged(nil)
                    }
            )
    }
}

// MARK: - Extensions

extension DraggableView {
    /// Initializes the DraggableView with a bindable data source.
    ///
    /// - Parameters:
    ///   - data: A binding to an array of elements.
    ///   - axis: The axis along which the drag is allowed (horizontal or vertical).
    ///   - content: A closure returning the content of the view.
    ///   - onDragChanged: A closure to be called when the drag state changes, providing the dragged element.
    public init(
        data: Binding<[T]>,
        axis: Axis.Set = .vertical,
        @ViewBuilder content: () -> Content,
        onDragChanged: @escaping (T?) -> Void
    ) {
        self._data = data
        self.axis = axis
        self.content = content()
        self.onDragChanged = onDragChanged
        self.elements = []
    }
}

extension DraggableView {
    /// Initializes the DraggableView with a non-bindable array of elements.
    ///
    /// - Parameters:
    ///   - elements: An array of elements to be reordered.
    ///   - axis: The axis along which the drag  is allowed (horizontal or vertical).
    ///   - content: A closure returning the content of the view.
    ///   - onDragChanged: A closure to be called when the drag state changes, providing the dragged element.
    public init(
        elements: [T],
        axis: Axis.Set = .vertical,
        @ViewBuilder content: () -> Content,
        onDragChanged: @escaping (T?) -> Void
    ) {
        self._data = .constant([])
        self.elements = elements
        self.axis = axis
        self.content = content()
        self.onDragChanged = onDragChanged
    }
}
