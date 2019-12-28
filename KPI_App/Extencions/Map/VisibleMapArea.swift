//
//  VisibleMapArea.swift
//  KPI_App
//
//  Created by Paul Solyanikov on 7/25/19.
//  Copyright © 2019 Paul Solyanikov. All rights reserved.
//

import Foundation
import MapKit

extension MapViewController {
    func getNECoordinate(_ mRect: MKMapRect) -> CLLocationCoordinate2D {
        return getCoordinateFromMapRectanglePoint(mRect.maxX, y: mRect.origin.y)
    }
    
    func getNWCoordinate(_ mRect: MKMapRect) -> CLLocationCoordinate2D {
        return getCoordinateFromMapRectanglePoint(mRect.minX, y: mRect.origin.y)
    }
    
    func getSECoordinate(_ mRect: MKMapRect) -> CLLocationCoordinate2D {
        return getCoordinateFromMapRectanglePoint(mRect.maxX, y: mRect.maxY)
    }
    
    func getSWCoordinate(_ mRect: MKMapRect) -> CLLocationCoordinate2D {
        return getCoordinateFromMapRectanglePoint(mRect.origin.x, y: mRect.maxY)
    }
    func getCoordinateFromMapRectanglePoint(_ x: Double, y: Double) -> CLLocationCoordinate2D {
        let swMapPoint = MKMapPoint(x: x, y: y)
        return swMapPoint.coordinate
    }
    func getBoundingBox(_ mRect: MKMapRect) -> [Any]? {
        let bottomLeft = getSWCoordinate(mRect)
        let topRight = getNECoordinate(mRect)
        return [
            NSNumber(value: bottomLeft.latitude),
            NSNumber(value: bottomLeft.longitude),
            NSNumber(value: topRight.latitude),
            NSNumber(value: topRight.longitude)
        ]
    }
    
    func getMapBounds(_ mRect: MKMapRect) -> BoundsLocation{
        let bottomLeft = getSWCoordinate(mRect)
        let topRight = getNECoordinate(mRect)
        
        return BoundsLocation(leftBottomLatitude: bottomLeft.latitude, leftBottomLongitude: bottomLeft.longitude, rightTopLatitude: topRight.latitude, rightTopLongitude: topRight.longitude)
    }
    
    func mapViewRegionDidChangeFromUserInteraction() -> Bool {
        let view = self.mapView.subviews[0]
        //  Look through gesture recognizers to determine whether this region change is from user interaction
        if let gestureRecognizers = view.gestureRecognizers {
            for recognizer in gestureRecognizers {
                if( recognizer.state == UIGestureRecognizer.State.began || recognizer.state == UIGestureRecognizer.State.ended ) {
                    return true
                }
            }
        }
        return false
    }
}


