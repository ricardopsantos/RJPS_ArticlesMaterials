//: Playground - noun: a place where people can play

import PlaygroundSupport
import Foundation
import UIKit
import Charts
import RxSwift

//playgroundShouldContinueIndefinitely()

//example("of") {

let disposeBag = DisposeBag()

Observable.of("🐶", "🐱", "🐭", "🐹")
    .subscribe(onNext: { element in
        print(element)
    })
//}
