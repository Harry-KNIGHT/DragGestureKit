//
//  VerticalDraggableView.swift
//
//
//  Created by Elliot Knight on 15/02/2024.
//

import SwiftUI

struct VerticalDraggableView: View {
    let elements = ["1", "2", "3", "4", "5", "6"]
    @State private var letterOnDrag: String?
    var body: some View {
        VStack {
            DraggableView(elements: elements, axis: .vertical) {
                VStack {
                    ForEach(elements, id: \.self) { letter in
                        Text(letter)
                            .padding(40)
                            .font(letter == letterOnDrag ? .title2 : .title3)
                            .background(letter == letterOnDrag ? Color.purple: Color.secondary)
                            .cornerRadius(10)
                            .scaleEffect(letter == letterOnDrag ? 1.2 : 0.9)
                            .shadow(radius: 10)
                            .animation(.easeInOut, value: letterOnDrag)
                    }
                }
            } onDragChanged: { value in
                letterOnDrag = value
            }
        }
    }
}

#Preview {
    VerticalDraggableView()
}
