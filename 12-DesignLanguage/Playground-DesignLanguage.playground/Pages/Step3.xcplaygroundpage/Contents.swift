import PlaygroundSupport
import Foundation
import UIKit

let text = """
Lorem ipsum dolor sit amet, te mei nulla mundi alterum, modo aperiam dolores vim ut. Ea nec sonet veniam fabellas, dico nominati eloquentiam ex mea. Mei causae moderatius ex, nominati molestiae eu qui, ex graecis feugait theophrastus duo. Ex vim veniam aliquam, quo tota laoreet tincidunt ad. Per at accusam corpora honestatis, accumsan oporteat abhorreant quo ut. Fuisset molestiae eum te. Ex nonumy everti eum, per ea quando denique noluisse, cum ea oporteat dignissim.
"""

typealias AppColors = UIColor.Pack3
typealias AppFonts = UIFont.MyFonts

class SimpleViewController : UIViewController {

    func prepareLayout() {
        
        let lblTitle = UILabel()
        //lblTitle.textColor = AppColors.onBackground.color
        //lblTitle.font = AppFonts.Styles.headingBold.rawValue
        lblTitle.layoutStyle = .title
        view.addSubview(lblTitle)
        lblTitle.text = "Title Lorem ipsum dolor"
        self.view.addSubview(lblTitle)
        lblTitle.height(50)
        lblTitle.topToSuperview(offset: 100)
        lblTitle.centerXToSuperview()
        
        let lblSubTitle = UILabel()
        //lblSubTitle.textColor = AppColors.void.color
        //lblSubTitle.font = AppFonts.Styles.paragraphMedium.rawValue
        lblSubTitle.layoutStyle = .subTitle
        view.addSubview(lblSubTitle)
        lblSubTitle.text = "Subtitle Lorem ipsum dolor"
        self.view.addSubview(lblSubTitle)
        lblSubTitle.height(50)
        lblSubTitle.topToBottom(of: lblTitle)
        lblSubTitle.centerXToSuperview()
        
        let lblText = UILabel()
        //lblText.textColor = AppColors.detail.color
        //lblText.font = AppFonts.Styles.caption.rawValue
        lblText.layoutStyle = .text
        lblText.numberOfLines = 0
        lblText.textAlignment = .justified
        view.addSubview(lblText)
        lblText.text = text
        self.view.addSubview(lblText)
        lblText.widthToSuperview(multiplier: 0.9)
        lblText.topToBottom(of: lblSubTitle, offset: 10)
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



