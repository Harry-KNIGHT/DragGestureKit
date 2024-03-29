<p align="center">
    <img src="https://github.com/Harry-KNIGHT/DragGestureKit/assets/63256761/83305589-66f2-478f-856d-b205a0177a66" width="500"/>
</p>

`DragGestureKit` is a SwiftUI library that allows you to detect the position of a drag gesture within a collection of data elements. It dynamically computes the index of the element being dragged based on the drag gesture's position and invokes a callback to handle this information.

## Table of contents

- [Usage](#usage)
  - [Installation](#installation)
  - [Example](#example)
- [Overview](#overview)
  - [Parameters](#parameters)
- [Customization](#customization)
- [Contributions](#contributions)

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

## Example

| Vertical | Horizontal |
| --------| -----------|
|<img src="https://github.com/Harry-KNIGHT/DragGestureKit/assets/63256761/715aa8a8-73cf-48fa-86f0-b36ecd088b11" width="200"> | <img src="https://github.com/Harry-KNIGHT/DragGestureKit/assets/63256761/b7c2d3e9-dc63-432c-9436-407b161ae51c" width="200"> |


Exemple of a `DraggableView` in your SwiftUI view with binded data:

```swift
import SwiftUI
import DragGestureKit

struct ContentView: View {
    @State private var items = ["Item 1", "Item 2", "Item 3"]
    @State private var itemOnDrag: String?

    var body: some View {
        DraggableView(data: $items) {
            VStack {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .background(itemOnDrag == item ? Color.purple : Color.gray)
                        .cornerRadius(8)
                }
            }
        } onDragChanged: { item in
            itemOnDrag = item
        }
    }
}
```

Exemple of a `DraggableView` in your SwiftUI view with a standard variable:

```swift
import SwiftUI
import DragGestureKit

struct ContentView: View {
    private var items = ["Item 1", "Item 2", "Item 3"]
    @State private var itemOnDrag: String?

    var body: some View {
        DraggableView(elements: items, axis: .horizontal) {
            HStack {
                ForEach(items, id: \.self) { item in
                    Text(item)
                        .padding()
                        .background(itemOnDrag == item ? Color.purple : Color.gray)
                        .cornerRadius(8)
                }
            }
        } onDragChanged: { item in
            itemOnDrag = item
        }
    }
}
```

In the projects, go to [/Sources/DragGestureKit/Exemples/](https://github.com/Harry-KNIGHT/DragGestureKit/tree/develop/Sources/DragGestureKit/Exemples) and you'll find the exemples shown above.

## Overview

`DraggableView` is a generic SwiftUI view designed to capture the position of a drag gesture within a specified collection of data elements.

### Parameters

- **data**: A binding to the collection of data where the drag gesture is detected.
- **elements**: A collection of elements where the drag gesture is detected.
- **axis**: The axis along which the drag gesture is detected, `vertical` by default.
- **content**: A closure that returns the content view to be displayed within the `DraggableView`.
- **onDragChanged**: A callback closure that receives the data of the element over which the drag gesture is positioned during dragging.

## Customization

Feel free to customize the appearance and behavior of the `DraggableView` by adjusting the provided parameters. You can modify the appearance of the content view or implement additional logic within the `onDragChanged` callback.

## Contributions

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or submit a pull request.

Enjoy using `DragGestureKit` in your SwiftUI projects!

## Aknowledgment

Many thanks to Lionel G for assisting me in achieving my objectives by providing valuable insights for calculations, and to Elyes D. for offering feedback on the code and suggesting improvements.
