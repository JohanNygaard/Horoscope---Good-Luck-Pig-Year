import UIKit
class SignsCell: UICollectionViewCell {
    let imageView = UIImageView(cornerRadius: 0)
    let nameLabel = UILabel(text: "Taurus", font: .boldSystemFont(ofSize: 16))
    let dateLabel = UILabel(text: "April 20 - May 20", font: .systemFont(ofSize: 12))
    var sign: Sign! {
        didSet {
            nameLabel.text = sign.title
            imageView.image = UIImage(named: sign.image1)
            dateLabel.text = sign.description
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(white: 0.7, alpha: 0.3)
        layer.cornerRadius = 16
        layer.shadowOpacity = 0.2
        layer.shadowRadius = 10
        layer.shadowOffset = .init(width: 0, height: 10)
        nameLabel.font = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? .boldSystemFont(ofSize: 12) : .boldSystemFont(ofSize: 16)
        dateLabel.font = UIDevice.current.screenType == .iPhones_5_5s_5c_SE ? .systemFont(ofSize: 8) : .systemFont(ofSize: 12)
        imageView.image = UIImage(named: "taurus")
        imageView.constrainWidth(constant: 50)
        imageView.constrainHeight(constant: 50)
        let stackView = VerticalStackView(arrangedSubviews: [imageView, nameLabel, dateLabel], spacing: 4)
        addSubview(stackView)
        stackView.fillSuperview(padding: .init(top: 4, left: 4, bottom: 4, right: 4))
        stackView.alignment = .center
        backgroundColor = .white
    }
    override var isHighlighted: Bool {
        didSet {
            var transform: CGAffineTransform = .identity
            if isHighlighted {
                transform = .init(scaleX: 0.9, y: 0.9)
            }
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.transform = transform
            })
        }
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
