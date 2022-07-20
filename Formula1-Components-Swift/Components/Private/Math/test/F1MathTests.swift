//
//  F1MathTests.swift
//  Formula1-Components-Swift
//
//  Created by Maarten Wubs on 7/16/22.
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
        let misalignedRect: CGRect = CGRectMake(0.45, 0.78, 1.01, 5.98)
        let alignedScale1Rect: CGRect = CGRectMake(0, 0, 2, 7)
        let alignedScale2Rect: CGRect = CGRectMake(0, 0.5, 1.5, 6.5)
        let alignedScale3Rect: CGRect = CGRectMake((1.0 / 3.0), (2.0 / 3.0), (4.0 / 3.0), (19.0 / 3.0))
        
        let outputScale1Rect: CGRect = F1AlignRect(misalignedRect, toScale: 1)
        XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, outputScale1Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale1Rect, misalignedRect))
        
        let outputScale2Rect: CGRect = F1AlignRect(misalignedRect, toScale: 2)
        XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, outputScale2Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale2Rect, misalignedRect))
        
        let outputScale3Rect: CGRect = F1AlignRect(misalignedRect, toScale: 3)
        XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, outputScale3Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale3Rect, misalignedRect))
    }
    
    func testF1AlignRectScaleNegative() {
        let misalignedRect = CGRectMake(-5.01, -0.399, 8.35, 2.65)
        let alignedScale1Rect = CGRectMake(-6, -1, 10, 4)
        let alignedScale2Rect = CGRectMake(-5.5, -0.5, 9, 3)
        let alignedScale3Rect = CGRectMake((-16.0 / 3.0), (-2.0 / 3.0), 9, 3)
        
        let outputScale1Rect = F1AlignRect(misalignedRect, toScale: 1)
        XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, outputScale1Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale1Rect, misalignedRect))
        
        let outputScale2Rect = F1AlignRect(misalignedRect, toScale: 2)
        XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, outputScale2Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale2Rect, misalignedRect))
        
        let outputScale3Rect = F1AlignRect(misalignedRect, toScale: 3)
        XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, outputScale3Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale3Rect, misalignedRect))
    }
    
    func testF1AlignRectScaleNonStandard() {
        let misalignedRect = CGRectMake(17.9, -4.44, -10.10, -15.85)
        
        let alignedScale1Rect = CGRectMake(7, -21, 11, 17)
        let alignedScale2Rect = CGRectMake(7.5, -20.5, 10.5, 16.5)
        let alignedScale3Rect = CGRectMake((23.0 / 3.0), (-61.0 / 3.0), (31.0 / 3.0), 16)
        
        let outputScale1Rect = F1AlignRect(misalignedRect, toScale: 1)
        XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, outputScale1Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale1Rect, misalignedRect))
        
        let outputScale2Rect = F1AlignRect(misalignedRect, toScale: 2)
        XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, outputScale2Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale2Rect, misalignedRect))
        
        let outputScale3Rect = F1AlignRect(misalignedRect, toScale: 3)
        XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, outputScale3Rect))
        XCTAssertTrue(CGRectContainsRect(outputScale3Rect, misalignedRect))
    }
    
    func testF1AlignRectScaleIsAligned() {
        let alignedScale1Rect = CGRectMake(10, 15, 5, 10)
        let alignedScale2Rect = CGRectMake(10.5, 15.5, 5.5, 10.5)
        let alignedScale3Rect = CGRectMake((31.0 / 3.0), (47.0 / 3.0),
                                           (16.0 / 3.0), (32.0 / 3.0))
        
        let output1 = F1AlignRect(alignedScale1Rect, toScale: 1)
        XCTAssertTrue(CGRectEqualToRect(alignedScale1Rect, output1))
        XCTAssertTrue(CGRectContainsRect(output1, alignedScale1Rect))
        
        let output2 = F1AlignRect(alignedScale2Rect, toScale: 2)
        XCTAssertTrue(CGRectEqualToRect(alignedScale2Rect, output2))
        XCTAssertTrue(CGRectContainsRect(output2, alignedScale2Rect))
        
        let output3 = F1AlignRect(alignedScale3Rect, toScale: 3)
        XCTAssertTrue(CGRectEqualToRect(alignedScale3Rect, output3))
        XCTAssertTrue(CGRectContainsRect(output3, alignedScale3Rect))
    }
    
    func testF1AlignRectWithScaleNull() {
        XCTAssertTrue(CGRectIsNull(F1AlignRect(CGRect.null, toScale: 1)))
        XCTAssertTrue(CGRectIsNull(F1AlignRect(CGRect.null, toScale: 2)))
        XCTAssertTrue(CGRectIsNull(F1AlignRect(CGRect.null, toScale: 3)))
    }
    
    func testF1AlignRectWithScaleZero() {
        let zeroRect = CGRectMake(1.1, 2.2, 3.3, 4.4)
        XCTAssertTrue(CGRectEqualToRect(F1AlignRect(zeroRect, toScale: 0), F1AlignRect(zeroRect, toScale: 1)))
    }
    
    // MARK: - F1Point
    
    func testF1RoundPointWithScale() {
        let misalignedPoint = CGPointMake(0.7, -1.3)
        let alignedScale1 = CGPointMake(1, -1)
        let alignedScale2 = CGPointMake(0.5, -1.5)
        let alignedScale3 = CGPointMake((2.0 / 3.0), (-4.0 / 3.0))
        
        XCTAssertTrue(CGPointEqualToPoint(alignedScale1,
                                          F1RoundPoint(misalignedPoint, withScale: 1)))
        XCTAssertTrue(CGPointEqualToPoint(alignedScale2,
                                          F1RoundPoint(misalignedPoint, withScale: 2)))
        XCTAssertTrue(CGPointEqualToPoint(alignedScale3,
                                          F1RoundPoint(misalignedPoint, withScale: 3)))
    }
    
    func testF1RoundPointWithScaleZero() {
        XCTAssertTrue(CGPointEqualToPoint(CGPoint.zero,
                                          F1RoundPoint(CGPointMake(5.5, 13),
                                                       withScale: 0)))
    }
    
    // MARK: - F1Center
    
    func testF1RoundCenterWithBoundsAndScale() {
        let misalignedCenter = CGPointMake(0.7, -1.3)
        let bounds = CGRectMake(0, 0, 20, 21)
        
        let alignedScale1Center = CGPointMake(1, -1.5)
        let alignedScale2Center = CGPointMake(0.5, -1.5)
        let alignedScale3Center = CGPointMake((2.0 / 3.0), (-7.0 / 6.0))
        
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
        let misalignedCenter = CGPointMake(0.3, 9.99)
        let bounds = CGRectMake(0, 0, 20.1, 21.9)
        
        let alignedScale1Center = CGPointMake(0.05, 9.95)
        let alignedScale2Center = CGPointMake(0.05, 9.95)
        let alignedScale3Center = CGPointMake((0.05 + 1.0 / 3.0), 9.95)
        
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
        XCTAssertTrue(CGPointEqualToPoint(CGPoint.zero, F1RoundCenter(CGPointMake(-5, 10),
                                                                      withBounds: CGRectMake(0, 0, 20, 20),
                                                                      andScale: 0)))
    }
    
    func testF1RoundCenterWithBoundsAndScaleWithNull() {
        XCTAssertTrue(CGPointEqualToPoint(CGPoint.zero, F1RoundCenter(CGPointMake(1, 2),
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

