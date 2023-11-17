

import UIKit

extension String {
//    func localized(lang:String? = nil) ->String {
//
//        var path: String
//
//        if let lang = lang {
//            path = Bundle.main.path(forResource: lang, ofType: "lproj") ?? ""
//        } else {
//            path = Bundle.main.path(forResource: LocalStorage.shared.getLocalize(), ofType: "lproj") ?? ""
//        }
//
//        let bundle = Bundle(path: path)
//        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
//    }

    // MARK:- // Html to String
    // e.g -> descriptionTextLabel?.text = item.itemDescription.html2String
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: Data(utf8), options: convertToNSAttributedStringDocumentReadingOptionKeyDictionary([convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.documentType): convertFromNSAttributedStringDocumentType(NSAttributedString.DocumentType.html), convertFromNSAttributedStringDocumentAttributeKey(NSAttributedString.DocumentAttributeKey.characterEncoding): String.Encoding.utf8.rawValue]), documentAttributes: nil)
        } catch {
            print("error:", error)
            return nil
        }
    }
    
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
    
    var htmlToAttributedString: NSAttributedString? {
        let htmlCSSString = "<style>" +
            "html *" +
            "{" +
            "font-family: \("MavenPro"), MavenPro-Regular !important;" +
            "line-height: 1.7;" +
        "}</style> \(self)"
        guard let data = htmlCSSString.data(using: .utf8) else { return nil }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return nil
        }
    }
    
    func attributedString(lineSpacing: CGFloat, alignment: NSTextAlignment = .natural) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = alignment
        paragraphStyle.lineSpacing = lineSpacing
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        return attributedString
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToNSAttributedStringDocumentReadingOptionKeyDictionary(_ input: [String: Any]) -> [NSAttributedString.DocumentReadingOptionKey: Any] {
    return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.DocumentReadingOptionKey(rawValue: key), value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringDocumentAttributeKey(_ input: NSAttributedString.DocumentAttributeKey) -> String {
    return input.rawValue
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromNSAttributedStringDocumentType(_ input: NSAttributedString.DocumentType) -> String {
    return input.rawValue
}

extension String {
    func strikeThrough(color: UIColor? = UIColor.colorTextGray) -> NSAttributedString {
        let attributeString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(
            NSAttributedString.Key.strikethroughStyle,
               value: NSUnderlineStyle.single.rawValue,
                   range: NSMakeRange(0,attributeString.length))
        if let color = color {
            attributeString.addAttributes([NSAttributedString.Key.foregroundColor: color, NSAttributedString.Key.strikethroughColor: color], range: NSMakeRange(0,attributeString.length))
        }
        return attributeString
    }
    
//    func mandatory(fontSize: CGFloat, weight: UIFont.Weight = .regular, color: UIColor = UIColor.black) -> NSAttributedString {
//        let font = Utility.shared.getFont(fontSize: fontSize, weight: weight)
//        let star = NSMutableAttributedString(string: " *")
//        star.addAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.colorRed], range: NSMakeRange(0, star.length))
//
//        let text = NSMutableAttributedString(string: self)
//        text.addAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: color], range: NSMakeRange(0, text.length))
//        text.append(star)
//        return text
//    }
//
//    func underline(fontSize: CGFloat, weight: UIFont.Weight = .regular) -> NSAttributedString {
//        let font = Utility.shared.getFont(fontSize: fontSize, weight: weight)
//        let text = NSMutableAttributedString(string: self)
//        text.addAttributes([NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.primaryColor(), NSAttributedString.Key.underlineStyle: NSUnderlineStyle.single.rawValue, NSAttributedString.Key.underlineColor: UIColor.primaryColor()], range: NSMakeRange(0, text.length))
//        return text
//    }
    
    func sizeOfString(usingFont font: UIFont) -> CGSize {
        let fontAttributes = [NSAttributedString.Key.font: font]
        return self.size(withAttributes: fontAttributes)
    }

    func heigh(font: UIFont, width: CGFloat) -> CGFloat{
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self

        label.sizeToFit()
        return label.frame.height
    }
}
