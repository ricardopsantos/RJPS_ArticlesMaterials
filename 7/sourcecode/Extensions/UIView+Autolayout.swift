import Foundation
import UIKit
//
import TinyConstraints
//
import DevTools

public extension UIView {
    var autoLayout: AutoLayout {
        return AutoLayout(target: self)
    }
}

public struct AutoLayout {
    let target: UIView
}

extension AutoLayout {
    @available(tvOS 10.0, iOS 10.0, *)
    @discardableResult
    public func edgesToSuperview(excluding excludedEdge: TinyConstraints.LayoutEdge = .none,
                                 insets: TinyConstraints.TinyEdgeInsets = .zero) -> TinyConstraints.Constraints {
        return target.edgesToSuperview(excluding: excludedEdge, insets: insets)
    }

    @available(tvOS 10.0, iOS 10.0, *)
    @discardableResult
    public func leadingToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                   offset: CGFloat = 0,
                                   relation: TinyConstraints.ConstraintRelation = .equal,
                                   priority: TinyConstraints.LayoutPriority = .required,
                                   isActive: Bool = true,
                                   usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.leadingToSuperview(anchor,
                                         offset: offset,
                                         relation: relation,
                                         priority: priority,
                                         isActive: isActive,
                                         usingSafeArea: usingSafeArea)
    }

    @available(tvOS 10.0, iOS 10.0, *)
    @discardableResult
    public func marginToSuperVerticalStackView(trailing: CGFloat, leading: CGFloat) -> TinyConstraints.Constraints? {
        guard let maybeStackView = target.superview as? UIStackView, maybeStackView.axis == .vertical else {
            DevTools.Log.warning("Invalid supper view [target.superview]")
            return nil
        }
        let insets: TinyEdgeInsets = TinyEdgeInsets(top: 0, left: trailing, bottom: 0, right: leading)
        return target.autoLayout.edgesToSuperview(excluding: .init([.top, .bottom]), insets: insets)
    }

    @discardableResult
    public func marginToSuperHorizontalStackView(top: CGFloat, bottom: CGFloat) -> TinyConstraints.Constraints? {
        guard let maybeStackView = target.superview as? UIStackView, maybeStackView.axis == .horizontal else {
            DevTools.Log.warning("Invalid supper view [target.superview]")
            return nil
        }
        let insets: TinyEdgeInsets = TinyEdgeInsets(top: top, left: 0, bottom: bottom, right: 0)
        return target.autoLayout.edgesToSuperview(excluding: .init([.leading, .trailing]), insets: insets)
    }

    @available(tvOS 10.0, iOS 10.0, *)
    @discardableResult
    public func trailingToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                    offset: CGFloat = 0,
                                    relation: TinyConstraints.ConstraintRelation = .equal,
                                    priority: TinyConstraints.LayoutPriority = .required,
                                    isActive: Bool = true,
                                    usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.trailingToSuperview(anchor,
                                          offset: offset,
                                          relation: relation,
                                          priority: priority,
                                          isActive: isActive,
                                          usingSafeArea: usingSafeArea)
    }

    @available(tvOS 10.0, iOS 10.0, *)
    @discardableResult
    public func horizontalToSuperview(insets: TinyConstraints.TinyEdgeInsets = .zero,
                                      relation: TinyConstraints.ConstraintRelation = .equal,
                                      priority: TinyConstraints.LayoutPriority = .required,
                                      isActive: Bool = true,
                                      usingSafeArea: Bool = false) -> TinyConstraints.Constraints {
        return target.horizontalToSuperview(insets: insets, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @available(tvOS 10.0, iOS 10.0, *)
    @discardableResult
    public func verticalToSuperview(insets: TinyConstraints.TinyEdgeInsets = .zero,
                                    relation: TinyConstraints.ConstraintRelation = .equal,
                                    priority: TinyConstraints.LayoutPriority = .required,
                                    isActive: Bool = true,
                                    usingSafeArea: Bool = false) -> TinyConstraints.Constraints {
        return target.verticalToSuperview(insets: insets, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }
}

extension AutoLayout {
    @discardableResult
    public func centerInSuperview(offset: CGPoint = .zero,
                                  priority: TinyConstraints.LayoutPriority = .required,
                                  isActive: Bool = true,
                                  usingSafeArea: Bool = false) -> TinyConstraints.Constraints {
        return target.centerInSuperview(offset: offset, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func originToSuperview(insets: TinyConstraints.TinyEdgeInsets = .zero,
                                  relation: TinyConstraints.ConstraintRelation = .equal,
                                  priority: TinyConstraints.LayoutPriority = .required,
                                  isActive: Bool = true,
                                  usingSafeArea: Bool = false) -> TinyConstraints.Constraints {
        return target.originToSuperview(insets: insets, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func widthToSuperview(_ dimension: NSLayoutDimension? = nil,
                                 multiplier: CGFloat = 1,
                                 offset: CGFloat = 0,
                                 relation: TinyConstraints.ConstraintRelation = .equal,
                                 priority: TinyConstraints.LayoutPriority = .required,
                                 isActive: Bool = true,
                                 usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.widthToSuperview(dimension,
                                       multiplier: multiplier,
                                       offset: offset,
                                       relation: relation,
                                       priority: priority,
                                       isActive: isActive,
                                       usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func heightToSuperview(_ dimension: NSLayoutDimension? = nil,
                                  multiplier: CGFloat = 1,
                                  offset: CGFloat = 0,
                                  relation: TinyConstraints.ConstraintRelation = .equal,
                                  priority: TinyConstraints.LayoutPriority = .required,
                                  isActive: Bool = true,
                                  usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.heightToSuperview(dimension,
                                        multiplier: multiplier,
                                        offset: offset,
                                        relation: relation,
                                        priority: priority,
                                        isActive: isActive,
                                        usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func leftToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                offset: CGFloat = 0,
                                relation: TinyConstraints.ConstraintRelation = .equal,
                                priority: TinyConstraints.LayoutPriority = .required,
                                isActive: Bool = true,
                                usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.leftToSuperview(anchor,
                                      offset: offset,
                                      relation: relation,
                                      priority: priority,
                                      isActive: isActive,
                                      usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func rightToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                 offset: CGFloat = 0,
                                 relation: TinyConstraints.ConstraintRelation = .equal,
                                 priority: TinyConstraints.LayoutPriority = .required,
                                 isActive: Bool = true,
                                 usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.rightToSuperview(anchor,
                                       offset: offset,
                                       relation: relation,
                                       priority: priority,
                                       isActive: isActive,
                                       usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func topToSuperview(_ anchor: NSLayoutYAxisAnchor? = nil,
                               offset: CGFloat = 0,
                               relation: TinyConstraints.ConstraintRelation = .equal,
                               priority: TinyConstraints.LayoutPriority = .required,
                               isActive: Bool = true,
                               usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        // [usingSafeArea=false] will make the view go up and use space on the safe area
        return target.topToSuperview(anchor, offset: offset, relation: relation, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func bottomToSuperview(_ anchor: NSLayoutYAxisAnchor? = nil,
                                  offset: CGFloat = 0,
                                  relation: TinyConstraints.ConstraintRelation = .equal,
                                  priority: TinyConstraints.LayoutPriority = .required,
                                  isActive: Bool = true,
                                  usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.bottomToSuperview(anchor,
                                        offset: offset,
                                        relation: relation,
                                        priority: priority,
                                        isActive: isActive,
                                        usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func centerXToSuperview(_ anchor: NSLayoutXAxisAnchor? = nil,
                                   offset: CGFloat = 0,
                                   priority: TinyConstraints.LayoutPriority = .required,
                                   isActive: Bool = true,
                                   usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.centerXToSuperview(anchor, offset: offset, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }

    @discardableResult
    public func centerYToSuperview(_ anchor: NSLayoutYAxisAnchor? = nil,
                                   offset: CGFloat = 0,
                                   priority: TinyConstraints.LayoutPriority = .required,
                                   isActive: Bool = true,
                                   usingSafeArea: Bool = false) -> TinyConstraints.Constraint {
        return target.centerYToSuperview(anchor, offset: offset, priority: priority, isActive: isActive, usingSafeArea: usingSafeArea)
    }
}

extension AutoLayout: Constrainable {
    public var topAnchor: NSLayoutYAxisAnchor { return target.topAnchor }
    public var bottomAnchor: NSLayoutYAxisAnchor { return target.topAnchor }
    public var leftAnchor: NSLayoutXAxisAnchor { return target.leftAnchor }
    public var rightAnchor: NSLayoutXAxisAnchor { return target.rightAnchor }
    public var leadingAnchor: NSLayoutXAxisAnchor { return target.leadingAnchor }
    public var trailingAnchor: NSLayoutXAxisAnchor { return target.trailingAnchor }
    public var centerXAnchor: NSLayoutXAxisAnchor { return target.centerXAnchor }
    public var centerYAnchor: NSLayoutYAxisAnchor { return target.centerYAnchor }
    public var widthAnchor: NSLayoutDimension { return target.widthAnchor }
    public var heightAnchor: NSLayoutDimension { return target.heightAnchor }

    @discardableResult
    public func prepareForLayout() -> Self { return AutoLayout(target: target.prepareForLayout()) }

    @discardableResult
    public func center(in view: TinyConstraints.Constrainable,
                       offset: CGPoint = .zero,
                       priority: TinyConstraints.LayoutPriority = .required,
                       isActive: Bool = true) -> TinyConstraints.Constraints {
        return target.center(in: view, offset: offset, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func edges(to view: TinyConstraints.Constrainable,
                      insets: TinyConstraints.TinyEdgeInsets = .zero,
                      priority: TinyConstraints.LayoutPriority = .required,
                      isActive: Bool = true) -> TinyConstraints.Constraints {
        return target.edges(to: view, insets: insets, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func size(_ size: CGSize, priority: TinyConstraints.LayoutPriority = .required, isActive: Bool = true) -> TinyConstraints.Constraints {
        return target.size(size, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func size(to view: TinyConstraints.Constrainable,
                     multiplier: CGFloat = 1,
                     insets: CGSize = .zero,
                     relation: TinyConstraints.ConstraintRelation = .equal,
                     priority: TinyConstraints.LayoutPriority = .required,
                     isActive: Bool = true) -> TinyConstraints.Constraints {
        return target.size(to: view, multiplier: multiplier, insets: insets, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func origin(to view: TinyConstraints.Constrainable,
                       insets: TinyConstraints.TinyEdgeInsets = .zero,
                       relation: TinyConstraints.ConstraintRelation = .equal,
                       priority: TinyConstraints.LayoutPriority = .required,
                       isActive: Bool = true) -> TinyConstraints.Constraints {
        return target.origin(to: view, insets: insets, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func width(_ width: CGFloat,
                      relation: TinyConstraints.ConstraintRelation = .equal,
                      priority: TinyConstraints.LayoutPriority = .required,
                      isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.width(width, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func width(to view: TinyConstraints.Constrainable,
                      _ dimension: NSLayoutDimension? = nil,
                      multiplier: CGFloat = 1,
                      offset: CGFloat = 0,
                      relation: TinyConstraints.ConstraintRelation = .equal,
                      priority: TinyConstraints.LayoutPriority = .required,
                      isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.width(to: view, dimension, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func widthToHeight(of view: TinyConstraints.Constrainable,
                              multiplier: CGFloat = 1,
                              offset: CGFloat = 0,
                              relation: TinyConstraints.ConstraintRelation = .equal,
                              priority: TinyConstraints.LayoutPriority = .required,
                              isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.widthToHeight(of: view, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func width(min: CGFloat? = nil,
                      max: CGFloat? = nil,
                      priority: TinyConstraints.LayoutPriority = .required,
                      isActive: Bool = true) -> TinyConstraints.Constraints {
        return target.width(min: min, max: max, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func height(_ height: CGFloat,
                       relation: TinyConstraints.ConstraintRelation = .equal,
                       priority: TinyConstraints.LayoutPriority = .required,
                       isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.height(height, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func height(to view: TinyConstraints.Constrainable,
                       _ dimension: NSLayoutDimension? = nil,
                       multiplier: CGFloat = 1,
                       offset: CGFloat = 0,
                       relation: TinyConstraints.ConstraintRelation = .equal,
                       priority: TinyConstraints.LayoutPriority = .required,
                       isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.height(to: view, dimension, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func heightToWidth(of view: TinyConstraints.Constrainable,
                              multiplier: CGFloat = 1,
                              offset: CGFloat = 0,
                              relation: TinyConstraints.ConstraintRelation = .equal,
                              priority: TinyConstraints.LayoutPriority = .required,
                              isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.heightToWidth(of: view, multiplier: multiplier, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func height(min: CGFloat? = nil,
                       max: CGFloat? = nil,
                       priority: TinyConstraints.LayoutPriority = .required,
                       isActive: Bool = true) -> TinyConstraints.Constraints {
        return target.height(min: min, max: max, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func aspectRatio(_ ratio: CGFloat,
                            relation: TinyConstraints.ConstraintRelation = .equal,
                            priority: TinyConstraints.LayoutPriority = .required,
                            isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.aspectRatio(ratio, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func leadingToTrailing(of view: TinyConstraints.Constrainable,
                                  offset: CGFloat = 0,
                                  relation: TinyConstraints.ConstraintRelation = .equal,
                                  priority: TinyConstraints.LayoutPriority = .required,
                                  isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.leadingToTrailing(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func leading(to view: TinyConstraints.Constrainable,
                        _ anchor: NSLayoutXAxisAnchor? = nil,
                        offset: CGFloat = 0,
                        relation: TinyConstraints.ConstraintRelation = .equal,
                        priority: TinyConstraints.LayoutPriority = .required,
                        isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.leading(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func leftToRight(of view: TinyConstraints.Constrainable,
                            offset: CGFloat = 0,
                            relation: TinyConstraints.ConstraintRelation = .equal,
                            priority: TinyConstraints.LayoutPriority = .required,
                            isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.leftToRight(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func left(to view: TinyConstraints.Constrainable,
                     _ anchor: NSLayoutXAxisAnchor? = nil,
                     offset: CGFloat = 0,
                     relation: TinyConstraints.ConstraintRelation = .equal,
                     priority: TinyConstraints.LayoutPriority = .required,
                     isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.left(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func trailingToLeading(of view: TinyConstraints.Constrainable,
                                  offset: CGFloat = 0,
                                  relation: TinyConstraints.ConstraintRelation = .equal,
                                  priority: TinyConstraints.LayoutPriority = .required,
                                  isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.trailingToLeading(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func trailing(to view: TinyConstraints.Constrainable,
                         _ anchor: NSLayoutXAxisAnchor? = nil,
                         offset: CGFloat = 0,
                         relation: TinyConstraints.ConstraintRelation = .equal,
                         priority: TinyConstraints.LayoutPriority = .required,
                         isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.trailing(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func rightToLeft(of view: TinyConstraints.Constrainable,
                            offset: CGFloat = 0,
                            relation: TinyConstraints.ConstraintRelation = .equal,
                            priority: TinyConstraints.LayoutPriority = .required,
                            isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.rightToLeft(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func right(to view: TinyConstraints.Constrainable,
                      _ anchor: NSLayoutXAxisAnchor? = nil,
                      offset: CGFloat = 0,
                      relation: TinyConstraints.ConstraintRelation = .equal,
                      priority: TinyConstraints.LayoutPriority = .required,
                      isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.right(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func topToBottom(of view: TinyConstraints.Constrainable,
                            offset: CGFloat = 0,
                            relation: TinyConstraints.ConstraintRelation = .equal,
                            priority: TinyConstraints.LayoutPriority = .required,
                            isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.topToBottom(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func top(to view: TinyConstraints.Constrainable,
                    _ anchor: NSLayoutYAxisAnchor? = nil,
                    offset: CGFloat = 0,
                    relation: TinyConstraints.ConstraintRelation = .equal,
                    priority: TinyConstraints.LayoutPriority = .required,
                    isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.top(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func bottomToTop(of view: TinyConstraints.Constrainable,
                            offset: CGFloat = 0,
                            relation: TinyConstraints.ConstraintRelation = .equal,
                            priority: TinyConstraints.LayoutPriority = .required,
                            isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.bottomToTop(of: view, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func bottom(to view: TinyConstraints.Constrainable,
                       _ anchor: NSLayoutYAxisAnchor? = nil,
                       offset: CGFloat = 0,
                       relation: TinyConstraints.ConstraintRelation = .equal,
                       priority: TinyConstraints.LayoutPriority = .required,
                       isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.bottom(to: view, anchor, offset: offset, relation: relation, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func centerX(to view: TinyConstraints.Constrainable,
                        _ anchor: NSLayoutXAxisAnchor? = nil,
                        offset: CGFloat = 0,
                        priority: TinyConstraints.LayoutPriority = .required,
                        isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.centerX(to: view, anchor, offset: offset, priority: priority, isActive: isActive)
    }

    @discardableResult
    public func centerY(to view: TinyConstraints.Constrainable,
                        _ anchor: NSLayoutYAxisAnchor? = nil,
                        offset: CGFloat = 0,
                        priority: TinyConstraints.LayoutPriority = .required,
                        isActive: Bool = true) -> TinyConstraints.Constraint {
        return target.centerY(to: view, anchor, offset: offset, priority: priority, isActive: isActive)
    }
}
