//
//  WeatherForecastBrickTests.swift
//  WeatherForecastBrickTests
//
//  Created by Jevgenijs Jefrosinins on 07/11/2021.
//

import XCTest
import SnapshotTesting
@testable import WeatherForecastBrick

fileprivate extension UIView {
    func sizeToSystemLayoutSize() {
        frame = CGRect(origin: .zero, size: systemLayoutSizeFitting(UIView.layoutFittingExpandedSize))
    }
}

class WeatherForecastBrickTests: XCTestCase {

    var sut: MainViewController!

    override func setUpWithError() throws {
        sut = UIStoryboard(name: "Main", bundle: Bundle(for: MainViewController.self)).instantiateInitialViewController()
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func test_MainViewController_DarkMode() throws {
        assertSnapshot(matching: sut, as: .image())
        assertSnapshot(matching: sut, as: .recursiveDescription())
    }

    func test_SearchView_DarkMode() throws {
        let searchView = SearchView()
        assertSnapshot(matching: searchView, as: .recursiveDescription())
    }

    func test_InfoView_DarkMode() throws {
        let infoView = InfoView()
        assertSnapshot(matching: infoView, as: .recursiveDescription())
    }

    func test_LoadingView_DarkMode() throws {
        assertSnapshot(matching: sut.loadingView, as: .recursiveDescription())
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }
}
