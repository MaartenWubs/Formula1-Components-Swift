//
//  F1MathTest.swift
//  Formula1_Components_SwiftTests
//
//  Created by Maarten Wubs on 7/20/22.
//

import XCTest
import Formula1_Components_Swift

final class F1MathTests: XCTestCase {
    
    // MARK: - Ceil and FloorScaled
    
    func testF1FloorScaled() {
        let inputNumber: CGFloat = 1.3
        let scale: CGFloat = 4
        let expectedOutcome:CGFloat = 1.25
        XCTAssertEqual(F1FloorValue(inputNumber, forScale: scale),
                       expectedOutcome,
                       accuracy: CGFloat(0.001))
    }
    
    func testF1FloorScaledWhenScaleIsZero() {
        let inputNumber: CGFloat = 0.3
        let scale: CGFloat = 0
        let expectedOutputNumber: CGFloat = 0
        XCTAssertEqual(F1FloorValue(inputNumber, forScale: scale),
                       expectedOutputNumber,
                       accuracy: CGFloat(0.001))
    }
    
    func testF1FloorScaledWhenScaleIsNegative() {
        let inputNumber: CGFloat = 1.3
        let scale: CGFloat = -2
        let expectedOutputNumber: CGFloat = 1.5
        XCTAssertEqual(F1FloorValue(inputNumber, forScale: scale),
                       expectedOutputNumber,
                       accuracy: CGFloat(0.001))
    }
    
    func testF1CeilScaled() {
        let inputNumber: CGFloat = 1.3
        let scale: CGFloat = 4
        let expectedOutcome: CGFloat = 1.5
        XCTAssertEqual(F1Ceil(inputNumber, forScale: scale),
                       expectedOutcome,
                       accuracy: CGFloat(0.001))
    }
    
    func testF1CeilScaledWhenScaledIsZero() {
        let inputNumber: CGFloat = 1.3
        let scale: CGFloat = 0
        let expectedOutcome: CGFloat = 0
        XCTAssertEqual(F1Ceil(inputNumber, forScale: scale),
                       expectedOutcome,
                       accuracy: CGFloat(0.001))
    }
    
    func testF1CeilScaledWhenScaleIsNegative() {
        let inputNumber: CGFloat = 1.3
        let scale: CGFloat = -2
        let expectedOutcome: CGFloat = 1
        XCTAssertEqual(F1Ceil(inputNumber, forScale: scale),
                       expectedOutcome,
                       accuracy: CGFloat(0.001))
    }
    
    // MARK: - F1Rect
    
    func testF1AlignRectScale() {
        let misalignedRect: CGRect = CGRect.init(x: 0.45, y: 0.78, width: 1.01, height: 5.98)
        let alignedScale1Rect: CGRect = CGRect.init(x: 0, y: 0, width: 2, height: 7)
        let alignedScale2Rect: CGRect = CGRect.init(x: 0, y: 0.5, width: 1.5, height: 6.5)
        let alignedScale3Rect: CGRect = CGRect.init(x: (1.0 / 3.0), y: (2.0 / 3.0), width: (4.0 / 3.0), height: (19.0 / 3.0))
        
        let outputScale1Rect: CGRect = F1AlignRect(misalignedRect, toScale: 1)
        XCTAssertTrue(alignedScale1Rect.equalTo(outputScale1Rect))
        XCTAssertTrue(outputScale1Rect.contains(misalignedRect))
        
        let outputScale2Rect: CGRect = F1AlignRect(misalignedRect, toScale: 2)
        XCTAssertTrue(alignedScale2Rect.equalTo(outputScale2Rect))
        XCTAssertTrue(outputScale2Rect.contains(misalignedRect))
        
        let outputScale3Rect: CGRect = F1AlignRect(misalignedRect, toScale: 3)
        XCTAssertTrue(alignedScale3Rect.equalTo(outputScale3Rect))
        XCTAssertTrue(outputScale3Rect.contains(misalignedRect))
    }
    
    func testF1AlignRectScaleNegative() {
        let misalignedRect = CGRect.init(x: -5.01, y: -0.399, width: 8.35, height: 2.65)
        let alignedScale1Rect = CGRect.init(x: -6, y: -1, width: 10, height: 4)
        let alignedScale2Rect = CGRect.init(x: -5.5, y: -0.5, width: 9, height: 3)
        let alignedScale3Rect = CGRect.init(x: (-16.0 / 3.0), y: (-2.0 / 3.0), width: 9, height: 3)
        
        let outputScale1Rect = F1AlignRect(misalignedRect, toScale: 1)
        XCTAssertTrue(alignedScale1Rect.equalTo(outputScale1Rect))
        XCTAssertTrue(outputScale1Rect.contains(misalignedRect))
        
        let outputScale2Rect = F1AlignRect(misalignedRect, toScale: 2)
        XCTAssertTrue(alignedScale2Rect.equalTo(outputScale2Rect))
        XCTAssertTrue(outputScale2Rect.contains(misalignedRect))
        
        let outputScale3Rect = F1AlignRect(misalignedRect, toScale: 3)
        XCTAssertTrue(alignedScale3Rect.equalTo(outputScale3Rect))
        XCTAssertTrue(outputScale3Rect.contains(misalignedRect))
    }
    
    func testF1AlignRectScaleNonStandard() {
        let misalignedRect = CGRect.init(x: 17.9, y: -4.44, width: -10.10, height: -15.85)
        
        let alignedScale1Rect = CGRect.init(x: 7, y: -21, width: 11, height: 17)
        let alignedScale2Rect = CGRect.init(x: 7.5, y: -20.5, width: 10.5, height: 16.5)
        let alignedScale3Rect = CGRect.init(x: (23.0 / 3.0), y: (-61.0 / 3.0), width: (31.0 / 3.0), height: 16)
        
        let outputScale1Rect = F1AlignRect(misalignedRect, toScale: 1)
        XCTAssertTrue(alignedScale1Rect.equalTo(outputScale1Rect))
        XCTAssertTrue(outputScale1Rect.contains(misalignedRect))
        
        let outputScale2Rect = F1AlignRect(misalignedRect, toScale: 2)
        XCTAssertTrue(alignedScale2Rect.equalTo(outputScale2Rect))
        XCTAssertTrue(outputScale2Rect.contains(misalignedRect))
        
        let outputScale3Rect = F1AlignRect(misalignedRect, toScale: 3)
        XCTAssertTrue(alignedScale3Rect.equalTo(outputScale3Rect))
        XCTAssertTrue(outputScale3Rect.contains(misalignedRect))
    }
    
    func testF1AlignRectScaleIsAligned() {
        let alignedScale1Rect = CGRect.init(x: 10, y: 15, width: 5, height: 10)
        let alignedScale2Rect = CGRect.init(x: 10.5, y: 15.5, width: 5.5, height: 10.5)
        let alignedScale3Rect = CGRect.init(x: (31.0 / 3.0), y: (47.0 / 3.0),
                                            width: (16.0 / 3.0), height: (32.0 / 3.0))
        
        let output1 = F1AlignRect(alignedScale1Rect, toScale: 1)
        XCTAssertTrue(alignedScale1Rect.equalTo(output1))
        XCTAssertTrue(output1.contains(alignedScale1Rect))
        
        let output2 = F1AlignRect(alignedScale2Rect, toScale: 2)
        XCTAssertTrue(alignedScale2Rect.equalTo(output2))
        XCTAssertTrue(output2.contains(alignedScale2Rect))
        
        let output3 = F1AlignRect(alignedScale3Rect, toScale: 3)
        XCTAssertTrue(alignedScale3Rect.equalTo(output3))
        XCTAssertTrue(output3.contains(alignedScale3Rect))
    }
    
    func testF1AlignRectWithScaleNull() {
        XCTAssertTrue(F1AlignRect(CGRect.null, toScale: 1).isNull)
        XCTAssertTrue(F1AlignRect(CGRect.null, toScale: 2).isNull)
        XCTAssertTrue(F1AlignRect(CGRect.null, toScale: 3).isNull)
    }
    
    func testF1AlignRectWithScaleZero() {
        let zeroRect = CGRect.init(x: 1.1, y: 2.2, width: 3.3, height: 4.4)
        XCTAssertTrue(F1AlignRect(zeroRect, toScale: 0).equalTo(F1AlignRect(zeroRect, toScale: 1)))
    }
    
    // MARK: - F1Point
    
    func testF1RoundPointWithScale() {
        let misalignedPoint = CGPoint.init(x: 0.7, y: -1.3)
        let alignedScale1 = CGPoint.init(x: 1, y: -1)
        let alignedScale2 = CGPoint.init(x: 0.5, y: -1.5)
        let alignedScale3 = CGPoint.init(x: (2.0 / 3.0), y: (-4.0 / 3.0))
        
        XCTAssertTrue(alignedScale1.equalTo(F1RoundPoint(misalignedPoint, withScale: 1)))
        XCTAssertTrue(alignedScale2.equalTo(F1RoundPoint(misalignedPoint, withScale: 2)))
        XCTAssertTrue(alignedScale3.equalTo(F1RoundPoint(misalignedPoint, withScale: 3)))
    }
    
    func testF1RoundPointWithScaleZero() {
        XCTAssertTrue(CGPoint.zero.equalTo(F1RoundPoint(CGPoint.init(x: 5.5, y: 13),
                                                       withScale: 0)))
    }
    
    // MARK: - F1Center
    
    func testF1RoundCenterWithBoundsAndScale() {
        let misalignedCenter = CGPoint.init(x: 0.7, y: -1.3)
        let bounds = CGRect.init(x: 0, y: 0, width: 20, height: 21)
        
        let alignedScale1Center = CGPoint.init(x: 1, y: -1.5)
        let alignedScale2Center = CGPoint.init(x: 0.5, y: -1.5)
        let alignedScale3Center = CGPoint.init(x: (2.0 / 3.0), y: (-7.0 / 6.0))
        
        let output1 = F1RoundCenter(misalignedCenter, withBounds: bounds, andScale: 1)
        XCTAssertTrue(F1CGFloatEquals(alignedScale1Center.x, output1.x))
        XCTAssertTrue(F1CGFloatEquals(alignedScale1Center.y, output1.y))
        
        let output2 = F1RoundCenter(misalignedCenter, withBounds: bounds, andScale: 2)
        XCTAssertTrue(F1CGFloatEquals(alignedScale2Center.x, output2.x))
        XCTAssertTrue(F1CGFloatEquals(alignedScale2Center.y, output2.y))
        
        let output3 = F1RoundCenter(misalignedCenter, withBounds: bounds, andScale: 3)
        XCTAssertTrue(F1CGFloatEquals(alignedScale3Center.x, output3.x))
        XCTAssertTrue(F1CGFloatEquals(alignedScale3Center.y, output3.y))
    }
    
    func testF1RoundCenterWithBoundsAndScaleWithErrors() {
        let acceptableRoundingError: CGFloat = 5e-15
        let misalignedCenter = CGPoint.init(x: 0.3, y: 9.99)
        let bounds = CGRect.init(x: 0, y: 0, width: 20.1, height: 21.9)
        
        let alignedScale1Center = CGPoint.init(x: 0.05, y: 9.95)
        let alignedScale2Center = CGPoint.init(x: 0.05, y: 9.95)
        let alignedScale3Center = CGPoint.init(x: (0.05 + 1.0 / 3.0), y: 9.95)
        
        let output1 = F1RoundCenter(misalignedCenter, withBounds: bounds, andScale: 1)
        XCTAssertLessThan(abs(alignedScale1Center.x - output1.x), acceptableRoundingError)
        XCTAssertLessThan(abs(alignedScale1Center.y - output1.y), acceptableRoundingError)
        
        let output2 = F1RoundCenter(misalignedCenter, withBounds: bounds, andScale: 2)
        XCTAssertLessThan(abs(alignedScale2Center.x - output2.x), acceptableRoundingError)
        XCTAssertLessThan(abs(alignedScale2Center.y - output2.y), acceptableRoundingError)
        
        let output3 = F1RoundCenter(misalignedCenter, withBounds: bounds, andScale: 3)
        XCTAssertLessThan(abs(alignedScale3Center.x - output3.x), acceptableRoundingError)
        XCTAssertLessThan(abs(alignedScale3Center.y - output3.y), acceptableRoundingError)
    }
    
    func testF1RoundCenterWithBoundsAndScaleWithZero() {
        XCTAssertTrue(CGPoint.zero.equalTo(F1RoundCenter(CGPoint.init(x: -5, y: 10),
                                                                      withBounds: CGRect.init(x: 0, y: 0, width: 20, height: 20),
                                                                      andScale: 0)))
    }
    
    func testF1RoundCenterWithBoundsAndScaleWithNull() {
        XCTAssertTrue(CGPoint.zero.equalTo(F1RoundCenter(CGPoint.init(x: 1, y: 2),
                                                                      withBounds: CGRect.null,
                                                                      andScale: 1)))
    }
    
    func testF1EdgeInsetEqualToEdgeInset() {
        let epsilon = Double.ulpOfOne
        
        let insets1 = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        let insets2 = UIEdgeInsets(top: 1 + epsilon, left: 1 + epsilon, bottom: 1 + epsilon, right: 1 + epsilon)
        
        XCTAssertFalse(insets1 == insets2)
    }

}

