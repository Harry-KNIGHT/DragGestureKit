//
//  DraggableView.swift
//
//
//  Created by Elliot Knight on 14/02/2024.
//

import SwiftUI

/**
 A SwiftUI view that detects the position of a drag gesture within a collection of data elements.

 - Parameter data: A binding to the collection of data where the drag gesture is detected.
 - Parameter content: A closure that returns the content view to be displayed within the `DraggableView`.
 - Parameter onDragChanged: A callback closure that receives the data of the element over which the drag gesture is positioned during dragging.

 ## Overview

 `DraggableView` is a generic SwiftUI view designed to capture the position of a drag gesture within a specified collection of data elements. It dynamically computes the index of the element being dragged based on the drag gesture's position and invokes a callback to handle this information.

 ## Usage

 To use `DraggableView`, provide a binding to the data collection, a content view, and a callback to handle changes during dragging.

 ```swift
 struct ContentView: View {
     @Binding private var items: [String]
     @State private var itemWhenDragging: Item?

     var body: some View {
         DraggableView(data: $items, axis: .vertical) {
             VStack {
                 ForEach(items) { item in
                         Text(item)
                            .id(item)
                     }
                 }
             }) onDragChanged { item in
                  itemWhenDragging = item
         }
     }
 }
 */

public struct DraggableView<Content: View, T: Hashable>: View {
    @Binding public var data: [T]
    let axis: Axis.Set
    let content: Content
    let onDragChanged: (T) -> Void

    @State private var viewSize: Double = 0.0
    private var dragHandler = DragHandler()

    public init(
        data: Binding<[T]>,
        axis: Axis.Set,
        @ViewBuilder content: () -> Content,
        onDragChanged: @escaping (T) -> Void
    ) {
        self._data = data
        self.axis = axis
        self.content = content()
        self.onDragChanged = onDragChanged
    }

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
                                data: data,
                                axis: axis,
                                value: value,
                                viewSize: viewSize
                            )
                            self.onDragChanged(element)
                        } catch {
                            print("-- Drag gesture out of bounds --")
                        }
                    }
            )
    }
}
