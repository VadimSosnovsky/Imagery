//
//  PinterestLayout.swift
//  Imagery
//
//  Created by Вадим Сосновский on 29.10.2022.
//

import UIKit

import UIKit

class PinterestLayout: UICollectionViewLayout {

    public let cellPadding: CGFloat = Constants.cellPadding
    public let columnsCount = Constants.numberOfColumns
    public var width: CGFloat = 0

    var cachedAttributes = [UICollectionViewLayoutAttributes]()
    var contentSize: CGSize = .zero
    public weak var delegate: PinterestLayoutDelegate?

    var contentWidthWithoutPadding: CGFloat {
        return contentSize.width - 2 * cellPadding
    }

    override public var collectionViewContentSize: CGSize {
        return contentSize
    }

    override public func prepare() {
        super.prepare()

        cachedAttributes.removeAll()
        calculateCollectionViewFrames()
    }

    override public func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cachedAttributes.filter { $0.frame.intersects(rect) }
    }

    public func calculateCollectionViewFrames() {
        guard columnsCount > 0 else {
            fatalError("Value must be greater than zero")
        }

        guard let collectionView = collectionView, let delegate = delegate else {
            return
        }

        contentSize.width = collectionView.frame.size.width

        let cellsPaddingWidth = CGFloat(columnsCount - 1) * cellPadding
        let cellWidth = (contentWidthWithoutPadding - cellsPaddingWidth) / CGFloat(columnsCount)
        width = cellWidth
        var yOffsets = [CGFloat](repeating: cellPadding, count: columnsCount)

        for section in 0..<collectionView.numberOfSections {
            let itemsCount = collectionView.numberOfItems(inSection: section)

            for item in 0 ..< itemsCount {
                let isLastItem = item == itemsCount - 1
                let indexPath = IndexPath(item: item, section: section)

                let cellhHeight = delegate.cellSize(indexPath: indexPath).height
                let cellSize = CGSize(width: cellWidth, height: cellhHeight)

                let y = yOffsets.min()!
                let column = yOffsets.firstIndex(of: y)!
                let x = CGFloat(column) * (cellWidth + cellPadding) + cellPadding
                let origin = CGPoint(x: x, y: y)

                let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
                attributes.frame = CGRect(origin: origin, size: cellSize)
                cachedAttributes.append(attributes)

                yOffsets[column] += cellhHeight + cellPadding

                if isLastItem {
                    let y = yOffsets.max()!
                    for index in 0..<yOffsets.count {
                        yOffsets[index] = y
                    }
                }
            }
        }

        contentSize.height = yOffsets.max()!
    }
}
