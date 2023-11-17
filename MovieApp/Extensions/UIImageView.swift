

import UIKit
import Kingfisher

extension UIImageView {
    func setImage(_ url: String, placeholder: UIImage? = UIImage(named: "Logo")) {
        self.kf.indicatorType = .activity
        let imageStr = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? url
        self.kf.setImage(with: URL(string: imageStr),
                         options: [
                            .processor(DownsamplingImageProcessor(size: self.bounds.size)),
                            .scaleFactor(UIScreen.main.scale),
                            .transition(.fade(0.2)),
                            .cacheOriginalImage
                         ],
                         completionHandler:  { result in
            switch result {
            case .success(let value):
                debugPrint("Image: \(value.source.url?.absoluteString ?? ""). Got from: \(value.cacheType)")
            case .failure(let error):
                debugPrint("Error: \(error.localizedDescription)")
                self.image = placeholder
            }
        })
    }
}
extension UIImage{
    var string : String? {
        get {
            return (self.jpegData(compressionQuality: 0.0) ?? Data()).base64EncodedString()
        }
    }
}
