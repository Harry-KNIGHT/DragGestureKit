# DragGestureKit

`DragGestureKit` is a SwiftUI library that allows you to detect the position of a drag gesture within a collection of data elements. It dynamically computes the index of the element being dragged based on the drag gesture's position and invokes a callback to handle this information.

## Usage

### Installation

Add the following dependency to your `Package.swift` file:

```swift
.package(url: "https://github.com/Harry-KNIGHT/DragGestureKit", from: "1.0.0")
```

### Import

Import the library into your Swift file:

```swift
import DragGestureKit
```

### Example

Create a `DraggableView` in your SwiftUI view:

```swift
import SwiftUI
import DragGestureKit

struct ContentView: View {
    @State private var items = ["Item 1", "Item 2", "Item 3"]
    @State private var itemOnDrag: String?

    var body: some View {
        DraggableView(data: $items, axis: .vertical) {
            VStack {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(8)
                }
            }
        } onDragChanged: { item in
            itemOnDrag = item
        }
    }
}
```

## Parameters

- **data**: A binding to the collection of data where the drag gesture is detected.
- **axis**: The axis along which the drag gesture is detected (`horizontal` or `vertical`).
- **content**: A closure that returns the content view to be displayed within the `DraggableView`.
- **onDragChanged**: A callback closure that receives the data of the element over which the drag gesture is positioned during dragging.

## Overview

`DraggableView` is a generic SwiftUI view designed to capture the position of a drag gesture within a specified collection of data elements.

## Customization

Feel free to customize the appearance and behavior of the `DraggableView` by adjusting the provided parameters. You can modify the appearance of the content view or implement additional logic within the `onDragChanged` callback.

## Contributions

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.

Enjoy using `DragGestureKit` in your SwiftUI projects!
