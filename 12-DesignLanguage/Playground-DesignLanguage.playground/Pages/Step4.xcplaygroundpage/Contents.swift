import PlaygroundSupport
import Foundation
import UIKit

let text = """
Lorem ipsum dolor sit amet, te mei nulla mundi alterum, modo aperiam dolores vim ut. Ea nec sonet veniam fabellas, dico nominati eloquentiam ex mea. Mei causae moderatius ex, nominati molestiae eu qui, ex graecis feugait theophrastus duo. Ex vim veniam aliquam, quo tota laoreet tincidunt ad. Per at accusam corpora honestatis, accumsan oporteat abhorreant quo ut. Fuisset molestiae eum te. Ex nonumy everti eum, per ea quando denique noluisse, cum ea oporteat dignissim.
"""

typealias AppColors = UIColor.Pack3
typealias AppFonts = UIFont.MyFonts

struct AppSizes {
    private init() { }
    static let size_1: CGFloat = 1.0
    static let size_2: CGFloat = 2.0
    static let size_3: CGFloat = 3.0
    static let size_5: CGFloat = 5.0
    static let size_6: CGFloat = 8.0
    static let size_7: CGFloat = 12.0
    static let size_8: CGFloat = 20.0
    static let size_9: CGFloat = 32.0
}


class SimpleViewController : UIViewController {

    func prepareLayout() {
        
        let lblTitle = UIKitFactory.labelWith(text: "Title Lorem ipsum dolor",
                                              style: .title,
                                              textAlignment: .center)
        view.addSubview(lblTitle)
        lblTitle.topToSuperview(offset: AppSizes.size_8)
        lblTitle.centerXToSuperview()
        
        let lblSubTitle = UIKitFactory.labelWith(text: "Subtitle Lorem ipsum dolor",
                                              style: .subTitle,
                                              textAlignment: .center)
        view.addSubview(lblSubTitle)
        lblSubTitle.topToBottom(of: lblTitle, offset: AppSizes.size_8)
        lblSubTitle.centerXToSuperview()
        
        let lblText = UIKitFactory.labelWith(text: text,
                                              style: .text,
                                              textAlignment: .justified)
        lblText.numberOfLines = 0
        view.addSubview(lblText)
        lblText.widthToSuperview(multiplier: 0.9)
        lblText.topToBottom(of: lblSubTitle, offset: AppSizes.size_8)
        lblText.centerXToSuperview()
        
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = AppColors.background.color
        self.view = view
        prepareLayout()
    }
}

PlaygroundPage.current.liveView = SimpleViewController()



