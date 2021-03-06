//
//  LayoutConstraintTests.swift
//  LayoutTests
//
//  Created by Artem Belkov on 05.03.2021.
//

import XCTest
@testable import Layout

class LayoutConstraintTests: XCTestCase {

    override func setUp() {
        view = .init()
        superview = .init()
        superview.addSubview(view)
    }
    
    func testSimpleAnchors() {
        let constraints = [
            view.top.equal(to: superview.top),
            view.bottom.equal(to: superview.bottom),
            view.left.equal(to: superview.left),
            view.right.equal(to: superview.right),
            
            view.top.equal(to: superview.top, constant: 1),
            view.bottom.equal(to: superview.bottom, constant: 2),
            view.left.equal(to: superview.left, constant: 3),
            view.right.equal(to: superview.right, constant: 4)
        ]
        
        let nsConstraints = [
            view.topAnchor.constraint(equalTo: superview.topAnchor),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            view.leftAnchor.constraint(equalTo: superview.leftAnchor),
            view.rightAnchor.constraint(equalTo: superview.rightAnchor),

            view.topAnchor.constraint(equalTo: superview.topAnchor, constant: 1),
            view.bottomAnchor.constraint(equalTo: superview.bottomAnchor, constant: 2),
            view.leftAnchor.constraint(equalTo: superview.leftAnchor, constant: 3),
            view.rightAnchor.constraint(equalTo: superview.rightAnchor, constant: 4)
        ]
        
        XCTAssert(compare(lhs: view.nsConstraints(from: constraints),
                          rhs: nsConstraints))
    }
    
    func testSimpleDimensions() {
        let constraints = [
            view.height.equal(to: superview.height),
            view.width.equal(to: superview.width),

            view.height.equal(to: superview.height, multiplifier: 1),
            view.width.equal(to: superview.width, multiplifier: 2),
            
            view.height.equal(constant: 1),
            view.width.equal(constant: 2),
        ]
        
        let nsConstraints = [
            view.heightAnchor.constraint(equalTo: superview.heightAnchor),
            view.widthAnchor.constraint(equalTo: superview.widthAnchor),
            
            view.heightAnchor.constraint(equalTo: superview.heightAnchor, multiplier: 1),
            view.widthAnchor.constraint(equalTo: superview.widthAnchor, multiplier: 2),
            
            view.heightAnchor.constraint(equalToConstant: 1),
            view.widthAnchor.constraint(equalToConstant: 2)
        ]
        
        XCTAssert(compare(lhs: view.nsConstraints(from: constraints),
                          rhs: nsConstraints))
    }
    
    private var view: UIView!
    private var superview: UIView!
}

func compare(lhs: NSLayoutConstraint, rhs: NSLayoutConstraint) -> Bool {
    return lhs.firstAnchor == rhs.firstAnchor
        && lhs.secondAnchor == rhs.secondAnchor
        && lhs.relation == rhs.relation
        && lhs.multiplier == rhs.multiplier
        && lhs.constant == rhs.constant
        && lhs.priority == rhs.priority
}

func compare(lhs: [NSLayoutConstraint], rhs: [NSLayoutConstraint]) -> Bool {
    guard lhs.count == rhs.count else { return false }
    
    return zip(lhs, rhs).reduce(true) { result, constraints in
        return result && compare(lhs: constraints.0, rhs: constraints.1)
    }
}