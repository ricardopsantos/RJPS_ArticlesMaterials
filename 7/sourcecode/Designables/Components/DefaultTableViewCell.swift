//
//  GoodToGo
//
//  Created by Ricardo P Santos
//  Copyright ©  Ricardo P Santos. All rights reserved.
//

import UIKit
import Foundation
//
import RJSLibUFALayouts
import RxSwift
import RxCocoa
//
import AppResources
import AppTheme
import BaseConstants
import Extensions
import DevTools
import PointFreeFunctions

public protocol DefaultTableViewCellProtocol: GenericTableViewCellProtocol {
    var rxTitle: BehaviorRelay<String> { get set }
    var rxImage: BehaviorRelay<UIImage?> { get set }
    var rxTextColor: BehaviorRelay<UIColor> { get set }
}

//public extension V {

open class DefaultTableViewCell: UITableViewCell, DefaultTableViewCellProtocol {
    deinit {
        DevTools.Log.logDeInit("\(self.className) was killed")
        NotificationCenter.default.removeObserver(self)
    }
    
    // BehaviorRelay model a State
    public var rxTitle     = BehaviorRelay<String>(value: "")
    public var rxImage     = BehaviorRelay<UIImage?>(value: nil)
    public var rxTextColor = BehaviorRelay<UIColor>(value: ComponentColor.UILabel.lblTextColor)

    open class var cellSize: CGFloat { return Designables.Sizes.TableView.defaultHeightForCell }
    public static func prepare(tableView: UITableView) {
        tableView.register(classForCoder(), forCellReuseIdentifier: reuseIdentifier)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        prepareLayout()
    }

    // To override
    func prepareLayout() {
        self.backgroundColor = ComponentColor.onPrimary
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        rxTitle
            .asObservable()
            .subscribe(onNext: { [weak self] (some) in
                self?.lblTitle.label.text = some
            }).disposed(by: disposeBag)

        rxTextColor
            .asObservable()
            .subscribe(onNext: { [weak self] (some) in
                self?.lblTitle.label.textColor = some
            }).disposed(by: disposeBag)

        rxImage
            .asObservable()
            .subscribe(onNext: { [weak self] (some) in
                self?.imgView.image = some
                self?.setNeedsLayout()
            }).disposed(by: disposeBag)

    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private var marginH: CGFloat { return 10 }
    private var marginV: CGFloat { return marginH }
    private var imageSize: CGFloat { return DefaultTableViewCell.cellSize - 2 * marginV }
    private let disposeBag: DisposeBag = DisposeBag()
    
    private lazy var lblTitle: UILabelWithPadding = {
        let padding = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 0)
        let some = UIKitFactory.labelWithPadding(padding: padding, style: .value)
        self.addSubview(some)
        some.autoLayout.edgesToSuperview()
        return some
    }()
    
    private lazy var imgView: UIImageView = {
        let some = UIKitFactory.imageView(baseView: self)
        some.rjsALayouts.setMargin(marginH, on: .right)
        some.rjsALayouts.setMargin(marginV, on: .top)
        some.rjsALayouts.setSize(CGSize(width: imageSize, height: imageSize))
        some.layer.cornerRadius = imageSize * 0.1
        some.clipsToBounds      = true
        return some
    }()
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        set(image: nil)
    }
    
    public override func setNeedsLayout() {
        super.setNeedsLayout()
    }
}

//
// Public stuff
//

public extension DefaultTableViewCell {
    
}

//
// MARK: - DefaultTableViewCellProtocol
//

public extension DefaultTableViewCell {
    func set(title: String) { rxTitle.accept(title) }
    func set(textColor: UIColor) { rxTextColor.accept(textColor) }
    func set(image: UIImage?) { rxImage.accept(image)  }
}
