//
//  UIDraggableView.swift
//
//
//  Created by Elliot Knight on 19/03/2024.
//

import UIKit

class UIDraggableView<Content: UIView, T: Hashable>: UIView {
    private var data: [T]
    private let elements: [T]
    private let axis: NSLayoutConstraint.Axis
    private let content: Content
    private let onDragChanged: (T?) -> Void
    private var viewSize: CGFloat = 0.0
    private var dragHandler = UIDragHandler()

    init(
        elements: [T],
        axis: NSLayoutConstraint.Axis = .vertical,
        content: () -> Content,
        onDragChanged: @escaping (T?) -> Void
    ) {
        self.data = []
        self.elements = elements
        self.axis = axis
        self.content = content()
        self.onDragChanged = onDragChanged
        super.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func commonInit() {
        addSubview(content)
        content.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            content.leadingAnchor.constraint(equalTo: leadingAnchor),
            content.trailingAnchor.constraint(equalTo: trailingAnchor),
            content.topAnchor.constraint(equalTo: topAnchor),
            content.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        addGestureRecognizer(panGestureRecognizer)
    }

    @objc private func handlePan(_ gestureRecognizer: UIPanGestureRecognizer) {
        let translation = gestureRecognizer.translation(in: self)

        switch gestureRecognizer.state {
        case .changed:
            do {
                let element = try dragHandler.computeElementAtIndexFromDragGesture(
                    data: data.isEmpty ? elements : data,
                    axis: axis,
                    translation: translation,
                    viewSize: viewSize
                )
                onDragChanged(element)
            } catch {
                print("-- Drag gesture out of bounds --")
            }
        case .ended:
            onDragChanged(nil)
        default:
            break
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        viewSize = axis == .vertical ? frame.height : frame.width
    }
}
