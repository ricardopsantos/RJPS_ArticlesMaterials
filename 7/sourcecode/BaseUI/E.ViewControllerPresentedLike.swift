//
//  ViewControllerPresentedLike.swift
//  UIBase
//
//  Created by Ricardo Santos on 20/05/2020.
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation

// When we show a ViewController, we pick the style.
// Latter the Router knows how to dismiss it
public enum ViewControllerPresentedLike {
    case modal
    case push
    case unknown
}
