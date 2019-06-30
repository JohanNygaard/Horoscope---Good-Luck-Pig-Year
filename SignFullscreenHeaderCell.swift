import UIKit
class SignFullscreenHeaderCell: UITableViewCell {
    let signDetailsCelll = SignDetailsCell()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubview(signDetailsCelll)
        signDetailsCelll.fillSuperview()
        backgroundColor = SignDetailsVC.themeColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
