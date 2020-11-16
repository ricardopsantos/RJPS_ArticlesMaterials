//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
//
import RxSwift
//
import BaseDomain

public class APIRequestOperation<T: ResponseDtoProtocol>: OperationBase {

    private var block: Observable<T>?
    private var blockList: Observable<[T]>?
    private var disposeBag = DisposeBag()

    public var result: T?
    public var resultList: [T]?
    
    public init(block: Observable<T>) {
      self.block = block
    }

    public init(blockList: Observable<[T]>) {
      self.blockList = blockList
    }

    public var noResultAvailable: Bool {
        return result == nil && resultList == nil
    }

    public override func main() {
        guard isCancelled == false else {
            finish(true)
            return
        }
        executing(true)

        if let block = block {
            block.asObservable().bind { (some) in
                self.result = some
                self.executing(false)
                self.finish(true)
            }.disposed(by: disposeBag)
        }

        if let blockList = blockList {
            blockList.asObservable().bind { (some) in
                self.resultList = some
                self.executing(false)
                self.finish(true)
            }.disposed(by: disposeBag)
        }
    }
}
