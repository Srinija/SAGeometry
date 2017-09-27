//
//  ViewController.swift
//  SwiftGeometry
//
//  Created by Srinija on 09/09/17.
//  Copyright © 2017 Srinija. All rights reserved.
//

import UIKit
import SAGeometry

class ViewController: UIViewController {
    
    let geometry = SAGeometry()
    
    @IBOutlet weak var quadStatus: UILabel!
    @IBOutlet weak var pointStatus: UILabel!
    @IBOutlet weak var lineStatus: UILabel!
    let quadBorder = CAShapeLayer()
    var quadVertices = [UIView]()
    var quadLabels = [UILabel]()
    let line1 = CAShapeLayer()
    var line1labels = [UILabel]()
    var line1Vertices = [UIView]()
    var line1Length :UILabel? = nil
    var freeVertex = UIView()
    var freeLabel = UILabel()
    var selectedIndex : Int?
    var shape: String?
    var oldPoint = CGPoint(x: 0, y: 0)
    var graph:Graph!
    
    override func viewWillAppear(_ animated: Bool) {
        graph = self.view as! Graph
        
        line1.strokeColor = UIColor.black.cgColor
        quadBorder.strokeColor = UIColor.black.cgColor
        quadBorder.fillColor = nil
        
        setUpGestureRecognizer()
        addElementsToGraph()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        quadBorder.frame = self.view.bounds
        line1.frame = self.view.bounds
        
        
        plot()
    }
    
    func addElementsToGraph(){
        view.layer.addSublayer(quadBorder)
        view.layer.addSublayer(line1)
        view.addSubview(freeVertex)
        
        for i in 0...6{
            let vertex = UIView()
            vertex.alpha = 0.65
            vertex.layer.cornerRadius = 10
            vertex.frame.size = CGSize(width: 20, height: 20)
            vertex.layer.borderWidth = 1
            vertex.layer.borderColor = UIColor.white.cgColor
            vertex.backgroundColor = UIColor.black
            
            let label = UILabel()
            label.textColor = UIColor.blue
            label.font = label.font.withSize(10)
            label.sizeToFit()
            label.translatesAutoresizingMaskIntoConstraints = false
            
            var quadPoints = [CGPoint(x: 10, y: 140), CGPoint(x:60,y:140), CGPoint(x: 60, y: 90), CGPoint(x: 10, y: 90)]
            var linePoints = [CGPoint(x:20, y:30), CGPoint(x:80, y:70)]
            var freePoint = CGPoint(x: 50, y: 50)
            switch i{
            case 0:
                freePoint = freePoint.applying(graph.chartTransform!)
                vertex.center = freePoint
                freeVertex = vertex
                freeLabel = label
                label.text = "P"
                
            case 1:
                linePoints[0] = linePoints[0].applying(graph.chartTransform!)
                vertex.center = linePoints[0]
                line1Vertices.append(vertex)
                line1labels.append(label)
                label.text = "L"
                
                
            case 2:
                linePoints[1] = linePoints[1].applying(graph.chartTransform!)
                vertex.center = linePoints[1]
                line1Vertices.append(vertex)
                line1labels.append(label)
                label.text = "M"
                
            case 3:
                quadPoints[0] = quadPoints[0].applying(graph.chartTransform!)
                vertex.center = quadPoints[0]
                quadVertices.append(vertex)
                quadLabels.append(label)
                label.text = "A"
                
            case 4:
                quadPoints[1] = quadPoints[1].applying(graph.chartTransform!)
                vertex.center = quadPoints[1]
                quadVertices.append(vertex)
                quadLabels.append(label)
                label.text = "B"
                
                
            case 5:
                quadPoints[2] = quadPoints[2].applying(graph.chartTransform!)
                vertex.center = quadPoints[2]
                quadVertices.append(vertex)
                quadLabels.append(label)
                label.text = "C"
                
                
            default:
                quadPoints[3] = quadPoints[3].applying(graph.chartTransform!)
                vertex.center = quadPoints[3]
                quadVertices.append(vertex)
                quadLabels.append(label)
                label.text = "D"
            }
            view.addSubview(vertex)
            let trans = vertex.center.applying(graph.chartTransform!.inverted())
            //            label.text = "(\(Int(trans.x)),\(Int(trans.y)))"
            label.text = "\(label.text ?? "")(\(Int(trans.x)),\(Int(trans.y)))"
            view.addSubview(label)
            let verticalSpace = NSLayoutConstraint(item: label, attribute: .top, relatedBy: .equal, toItem: vertex, attribute: .bottom, multiplier: 1, constant: 5)
            let leading = NSLayoutConstraint(item: label, attribute: .leading, relatedBy: .equal, toItem: vertex, attribute: .leading, multiplier: 1, constant: 0)
            NSLayoutConstraint.activate([verticalSpace, leading])
        }
        
    }
    
    
 func setUpGestureRecognizer(){
        let gestureRecognizer = UIPanGestureRecognizer.init(target: self, action: #selector(ViewController.panGesture))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func panGesture(gesture : UIPanGestureRecognizer){
        let point = gesture.location(in: view)
        if(gesture.state == UIGestureRecognizerState.began){
            selectedIndex = nil
            var minDistance = CGFloat.greatestFiniteMagnitude
            for i in 0...3{
                let distance = geometry.distanceBetweenPoints(point1: point, point2: quadVertices[i].center)
                if(distance < minDistance){
                    minDistance = distance
                    shape = "quad"
                    selectedIndex = i
                }
                
            }
            for i in 0...1{
                let distance = geometry.distanceBetweenPoints(point1: point, point2: line1Vertices[i].center)
                if(distance < minDistance){
                    minDistance = distance
                    shape = "line1"
                    selectedIndex = i
                }
                
            }
            let distance = geometry.distanceBetweenPoints(point1: point, point2: freeVertex.center)
            if(distance < minDistance){
                minDistance = distance
                shape = "point"
                selectedIndex = 0
                
            }
            oldPoint = point
            
            
        }
        if let selectedIndex = selectedIndex {
            var current = CGPoint()
            
            switch shape!{
            case "quad":
                current = quadVertices[selectedIndex].center
            case "line1":
                current = line1Vertices[selectedIndex].center
            default:
                current = freeVertex.center
            }
            
            
            
            let newPoint = CGPoint(x: current.x + (point.x - oldPoint.x) , y: current.y + (point.y - oldPoint.y) )
            oldPoint = point
            let inverted = round(newPoint.applying(graph.chartTransform!.inverted()))
            
            switch shape!{
            case "quad":
                quadVertices[selectedIndex].center = newPoint
                let str = quadLabels[selectedIndex].text!
                let index = str.index(str.startIndex, offsetBy: 1)
                quadLabels[selectedIndex].text = "\(str.substring(to: index))(\(inverted.x),\(inverted.y))"
                plot(border: quadBorder, vertices: quadVertices)
                setStatusLabels()
            case "line1":
                line1Vertices[selectedIndex].center = newPoint
                let str = line1labels[selectedIndex].text!
                let index = str.index(str.startIndex, offsetBy: 1)
                line1labels[selectedIndex].text = "\(str.substring(to: index))(\(inverted.x),\(inverted.y))"
                plot(border: line1, vertices: line1Vertices)
                setStatusLabels()
            default:
                freeVertex.center = newPoint
                let str = freeLabel.text!
                let index = str.index(str.startIndex, offsetBy: 1)
                freeLabel.text = "\(str.substring(to: index))(\(inverted.x),\(inverted.y))"
                setPointStatus()
            }
            
        }
        
        //TODO: change colors while moving
        
        
        
    }
    
    func setStatusLabels(){
        setQuadStatus()
        setLineStatus()
        setPointStatus()
    }
    
    func setQuadStatus(){
        let corners = getQuadCoordinates()
        if(!geometry.isQuadrilateral(points: corners)){
            quadStatus.text = "ABCD is not a quadrilateral!"
            return
        }
        if(geometry.isConcave(corners: corners)){
            quadStatus.text = "ABCD is concave"
            return
        }
        if(!geometry.isConvex(corners: corners)){
            quadStatus.text = "ABCD is complex"
            return
        }
        if(geometry.isQuadrilateralRhombus(corners: corners)){
            if(geometry.isQuadrilateralRectangle(corners: corners)){
                quadStatus.text = "ABCD is a square"
            }else{
                quadStatus.text = "ABCD is a rhombus"
            }
        }else if(geometry.isQuadrilateralRectangle(corners: corners)){
            quadStatus.text = "ABCD is a rectangle"
        }else{
            quadStatus.text = "ABCD is convex"
        }
    }
    
    func setPointStatus(){
        let point = getRoundedPoint(freeVertex.center)
        let quad = getQuadCoordinates()
        if(geometry.isPointOnPolygon(point: point, polygon: quad) == true){
            pointStatus.text = "P is on ABCD"
        }
            
        else if(geometry.isPointInsidePolygon(point: point, polygon: quad) == true){
            pointStatus.text = "P is inside ABCD"
        }
        else{
            pointStatus.text = "P is outside ABCD"
        }
        
        let distance = geometry.shortestDistanceBetweenLineAndPoint(point: round(point), l1: getRoundedPoint(line1Vertices[0].center), l2: getRoundedPoint(line1Vertices[1].center))
        
        if(distance > 0){
            pointStatus.text = pointStatus.text! + " & \(distance.rounded(toPlaces: 2)) units from LM"
        }else{
            pointStatus.text = pointStatus.text! + " & lies on LM"
        }
        
    }
    
    func setLineStatus(){
        let line = [getRoundedPoint(line1Vertices[0].center), getRoundedPoint(line1Vertices[1].center)]
        let quad = getQuadCoordinates()
        var status = ""
        if(geometry.doLineSegmentsIntersect(l1: line[0], l2: line[1], m1: quad[0], m2: quad[1])){
            status = "AB"
        }
        if(geometry.doLineSegmentsIntersect(l1: line[0], l2: line[1], m1: quad[1], m2: quad[2])){
            status = status == "" ? "BC" : "\(status), BC"
        }
        if(geometry.doLineSegmentsIntersect(l1: line[0], l2: line[1], m1: quad[2], m2: quad[3])){
            status = status == "" ? "CD" : "\(status), CD"
        }
        if(geometry.doLineSegmentsIntersect(l1: line[0], l2: line[1], m1: quad[3], m2: quad[0])){
            status = status == "" ? "AD" : "\(status), AD"
        }
        if(status == ""){
            let length = geometry.distanceBetweenPoints(point1: line[0], point2: line[1])
            status = "Length of LM : \(length.rounded(toPlaces: 2))"
            lineStatus.text = status
            return
        }
        let range = status.range(of: ",", options:String.CompareOptions.backwards)
        if let range = range{
        status = status.replacingCharacters(in: range, with: " and")
        }
        status = "LM intersects with \(status)"
        lineStatus.text = status
        
    }
    
    func getRoundedPoint(_ point:CGPoint) -> CGPoint {
        return round(point.applying(graph.chartTransform!.inverted()))
    }
    
    func getQuadCoordinates() -> [CGPoint]{
        return [round(quadVertices[0].center.applying(graph.chartTransform!.inverted())), round(quadVertices[1].center.applying(graph.chartTransform!.inverted())), round(quadVertices[2].center.applying(graph.chartTransform!.inverted())), round(quadVertices[3].center.applying(graph.chartTransform!.inverted()))]
    }
    
    func round(_ point: CGPoint) -> CGPoint{
        return CGPoint(x: point.x.rounded(), y: point.y.rounded())
    }
    
    
    
    func plot(){
        if graph.chartTransform == nil {
            graph.setAxisRange()
        }
        
        plot(border: quadBorder, vertices: quadVertices)
        plot(border: line1, vertices: line1Vertices)
        
        setStatusLabels()
        
    }
    
    func plot(border:CAShapeLayer?,vertices:[UIView]){
        var points = [CGPoint]()
        
        for vertex in vertices {
            points.append(vertex.center)
        }
        if(vertices.count > 2){
            points.append(vertices[0].center)
        }
        border?.path = nil
        let linePath = CGMutablePath()
        linePath.addLines(between: points)
        
        border?.path = linePath
        
    }
    
    
    
    
}


extension String {
    
    
    func size(withSystemFontSize pointSize: CGFloat) -> CGSize {
        return (self as NSString).size(withAttributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: pointSize)])
    }
    
    
}
extension CGFloat {
    /// Rounds the double to decimal places value
    func rounded(toPlaces places:Int) -> CGFloat {
        let divisor = CGFloat(pow(10.0, Double(places)))
        return (self * divisor).rounded() / divisor
    }
}

extension CGPoint {
    func adding(x: CGFloat) -> CGPoint { return CGPoint(x: self.x + x, y: self.y) }
    func adding(y: CGFloat) -> CGPoint { return CGPoint(x: self.x, y: self.y + y) }
}
