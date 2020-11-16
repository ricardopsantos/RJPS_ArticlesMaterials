//
//  GoodToGo
//
//  Created by Ricardo Santos
//  Copyright © 2020 Ricardo P Santos. All rights reserved.
//

import Foundation
import UIKit
//
import AppResources

open class AvatarView: UIView {

    public struct ViewModel {
        public let image: UIImage?
        public let imageName: String?

        public init(image: UIImage?, imageName: String?) {
            self.image = image
            self.imageName = imageName
        }
    }
    public static let defaultSize: CGFloat = Designables.Sizes.AvatarView.defaultSize.width

    private lazy var imgAvatar: UIImageView = {
        UIKitFactory.imageView(image: Images.notFound.image)
    }()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupView()
    }

    private func setupView() {
        addSubview(imgAvatar)
        imgAvatar.edgesToSuperview()
        imgAvatar.addCorner(radius: Self.defaultSize / 2.0)
    }

    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    public func setup(viewModel: AvatarView.ViewModel) {
        if let image = viewModel.image {
            imgAvatar.image = image
        } else if let imageName = viewModel.imageName, let image = UIImage(named: imageName) {
            imgAvatar.image = image
        } else {
            imgAvatar.image = Images.notFound.image
        }
    }
}
