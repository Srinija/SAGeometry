# SAGeometry

[![CI Status](http://img.shields.io/travis/srinija/SAGeometry.svg?style=flat)](https://travis-ci.org/srinija/SAGeometry)
[![Version](https://img.shields.io/cocoapods/v/SAGeometry.svg?style=flat)](http://cocoapods.org/pods/SAGeometry)
[![License](https://img.shields.io/cocoapods/l/SAGeometry.svg?style=flat)](http://cocoapods.org/pods/SAGeometry)
[![Platform](https://img.shields.io/cocoapods/p/SAGeometry.svg?style=flat)](http://cocoapods.org/pods/SAGeometry)


## Usage
These are the functions availabe right now:

#### Lines and Points:
```swift
distanceBetweenPoints(point1: CGPoint, point2: CGPoint) -> CGFloat
getAngleBetweenPoints(p1:CGPoint, p2: CGPoint, p3:CGPoint) -> Double
getAngleBetweenPointsInDegrees(p1:CGPoint, p2: CGPoint, p3:CGPoint) -> Double
arePointsCollinear(points:[CGPoint]) -> Bool
shortestDistanceBetweenLineAndPoint(point:CGPoint, l1:CGPoint, l2:CGPoint) -> CGFloat
isPointOnLine(point:CGPoint, l1:CGPoint, l2:CGPoint) -> Bool
doLineSegmentsIntersect(l1:CGPoint, l2:CGPoint, m1:CGPoint, m2:CGPoint) -> Bool
```

#### Qudrilaterals:

```swift
isQuadrilateral(points:[CGPoint])
reorderToConvexQuadrilateral(corners:[CGPoint]) -> [CGPoint]?
getCGRectFromPoints(topLeft: CGPoint,topRight: CGPoint,bottomRight: CGPoint,bottomLeft: CGPoint) -> CGRect?
isConvex(corners:[CGPoint]) -> Bool
isConcave(corners:[CGPoint]) -> Bool
isQuadrilateralRectangle(corners:[CGPoint]) -> Bool
isQuadrilateralSquare(corners:[CGPoint]) -> Bool
isQuadrilateralRhombus(corners:[CGPoint]) -> Bool
```

#### Circles:

```swift
isPointInsideCircle(point:CGPoint, center:CGPoint, radius:CGFloat) -> Bool
isPointOnCircle(point:CGPoint, center:CGPoint, radius:CGFloat) -> Bool
```

#### Polygons:

```swift
isPointOnPolygon(point:CGPoint, polygon:[CGPoint]) -> Bool
isPointInsidePolygon(point:CGPoint, polygon:[CGPoint]) -> Bool
```

More functions on the way!


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

Move the different points in the example around to see various functions being used.

# ![Demo GIF](https://github.com/Srinija/SAGeometry/blob/master/Example/SAGeometry/SAGeometry.gif)

## Installation

### CocoaPods
To install with [CocoaPods](http://cocoapods.org), simply add the following line to your Podfile:
```ruby
pod 'SAGeometry'
```

### Manual
Add the 'SAGeometry.swift file into your project

## Author

Srinija Ammapalli

## License

SAGeometry is available under the MIT license. See the LICENSE file for more info.
