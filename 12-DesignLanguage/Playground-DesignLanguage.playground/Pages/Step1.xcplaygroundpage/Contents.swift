import PlaygroundSupport
import Foundation
import UIKit

let text = """
Lorem ipsum dolor sit amet, te mei nulla mundi alterum, modo aperiam dolores vim ut. Ea nec sonet veniam fabellas, dico nominati eloquentiam ex mea. Mei causae moderatius ex, nominati molestiae eu qui, ex graecis feugait theophrastus duo. Ex vim veniam aliquam, quo tota laoreet tincidunt ad. Per at accusam corpora honestatis, accumsan oporteat abhorreant quo ut. Fuisset molestiae eum te. Ex nonumy everti eum, per ea quando denique noluisse, cum ea oporteat dignissim.
"""

class SimpleViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        self.view = view
        prepareLayout()
    }
    
    func prepareLayout() {
        let lblTitle = UILabel()
        lblTitle.textColor = UIColor.black
        lblTitle.font = UIFont.boldSystemFont(ofSize: 25)
        view.addSubview(lblTitle)
        lblTitle.text = "Title Lorem ipsum dolor"
        self.view.addSubview(lblTitle)
        lblTitle.height(50)
        lblTitle.topToSuperview(offset: 40)
        lblTitle.centerXToSuperview()
        
        let lblSubTitle = UILabel()
        lblSubTitle.textColor = lblTitle.textColor.withAlphaComponent(0.8)
        lblSubTitle.font = UIFont.systemFont(ofSize: 18)
        view.addSubview(lblSubTitle)
        lblSubTitle.text = "Subtitle Lorem ipsum dolor"
        self.view.addSubview(lblSubTitle)
        lblSubTitle.height(50)
        lblSubTitle.topToBottom(of: lblTitle)
        lblSubTitle.centerXToSuperview()
        
        let lblText = UILabel()
        lblText.textColor = UIColor.darkText
        lblText.numberOfLines = 0
        lblText.textAlignment = .justified
        lblText.font = UIFont.italicSystemFont(ofSize: 14)
        view.addSubview(lblText)
        lblText.text = text
        self.view.addSubview(lblText)
        lblText.widthToSuperview(multiplier: 0.9)
        lblText.topToBottom(of: lblSubTitle, offset: 10)
        lblText.centerXToSuperview()
        
    }
}

PlaygroundPage.current.liveView = SimpleViewController()



