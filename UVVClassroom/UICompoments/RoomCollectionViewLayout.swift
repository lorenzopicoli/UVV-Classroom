//
//  RoomCollectionViewLayout.swift
//  UVVClassroom
//
//  Created by lorenzopicoli on 29/03/17.
//  Copyright © 2017 Lorenzo Piccoli. All rights reserved.
//

// ================================================================================================
// SOURCE: https://www.raywenderlich.com/99087/swift-expanding-cells-ios-collection-views
// ================================================================================================

import UIKit

/* The heights are declared as constants outside of the class so they can be easily referenced elsewhere */
struct RoomsCollectionViewConstants {
    struct Cell {
        /* The height of the non-featured cell */
        static let standardHeight: CGFloat = 100
        /* The height of the first visible cell */
        static let featuredHeight: CGFloat = 280
    }
}

class RoomsCollectionViewLayout: UICollectionViewLayout {
    // MARK: Properties and Variables
    
    /* The amount the user needs to scroll before the featured cell changes */
    let dragOffset: CGFloat = 180.0
    
    var cache = [UICollectionViewLayoutAttributes]()
    
    var featuredItemIndex: Int {
        get {
            guard let collectionView = collectionView else { return 0 }
            return max(0, Int(collectionView.contentOffset.y / dragOffset))
        }
    }
    
    var nextItemPercentageOffset: CGFloat {
        get {
            guard let collectionView = collectionView else { return 0 }
            return (collectionView.contentOffset.y / dragOffset) - CGFloat(featuredItemIndex)
        }
    }
    
    var width: CGFloat {
        get {
            guard let collectionView = collectionView else { return 0 }
            return collectionView.bounds.width
        }
    }
    
    var height: CGFloat {
        get {
            guard let collectionView = collectionView else { return 0 }
            return collectionView.bounds.height
        }
    }
    
    var numberOfItems: Int {
        get {
            guard let collectionView = collectionView else { return 0 }
            return collectionView.numberOfItems(inSection: 0)
        }
    }
    
    // MARK: UICollectionViewLayout
    
    override var collectionViewContentSize: CGSize {
        get {
            let contentHeight = CGFloat(numberOfItems) * dragOffset + (height - dragOffset)
            return CGSize(width: width, height: contentHeight)
        }
    }
    
    override func prepare() {
        cache.removeAll(keepingCapacity: false)
        
        let standardHeight = RoomsCollectionViewConstants.Cell.standardHeight
        let featuredHeight = RoomsCollectionViewConstants.Cell.featuredHeight
        
        var frame = CGRect.zero
        var y: CGFloat = 0
        
        for item in 0..<numberOfItems {
            let indexPath = IndexPath(item: item, section: 0)
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            attributes.zIndex = item
            var height = standardHeight
            
            if indexPath.item == featuredItemIndex {
                let yOffset = standardHeight * nextItemPercentageOffset
                y = collectionView!.contentOffset.y - yOffset
                height = featuredHeight
            } else if indexPath.item == (featuredItemIndex + 1) && indexPath.item != numberOfItems {
                let maxY = y + standardHeight
                height = standardHeight + max((featuredHeight - standardHeight) * nextItemPercentageOffset, 0)
                y = maxY - height
            }
            
            frame = CGRect(x: 0, y: y, width: width, height: height)
            attributes.frame = frame
            cache.append(attributes)
            y = frame.maxY
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var layoutAttributes = [UICollectionViewLayoutAttributes]()
        for attributes in cache {
            if attributes.frame.intersects(rect) {
                layoutAttributes.append(attributes)
            }
        }
        return layoutAttributes
    }
    
    /* Return true so that the layout is continuously invalidated as the user scrolls */
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.row]
    }
}
