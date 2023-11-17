

import UIKit

extension UITableViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}
