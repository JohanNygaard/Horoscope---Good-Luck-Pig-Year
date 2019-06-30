import UIKit
class CompatibilityCell: BaseCollectionCell {
    override var sign: Sign! {
        didSet {
            titleLabel.text = sign.title
            imageView1.image = UIImage(named: sign.image1)
            imageView2.image = UIImage(named: sign.image2 ?? "")
            descriptionLabel.text = sign.trait ?? sign.description
        }
    }
    var topConstraint: NSLayoutConstraint!
    var stackView: VerticalStackView!
    var imageStackView: UIStackView!
    let titleLabel = UILabel(text: "", font: .boldSystemFont(ofSize: 24), numberOfLines: 2)
    let imageView1 = UIImageView(cornerRadius: 16)
    let imageView2 = UIImageView(cornerRadius: 16)
    let descriptionLabel = UILabel(text: "", font: .systemFont(ofSize: 16), numberOfLines: 2)
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 16
        imageView1.contentMode = .scaleAspectFit
        imageView2.contentMode = .scaleAspectFit
        imageStackView = UIStackView(arrangedSubviews: [imageView1, imageView2])
        imageStackView.spacing = 16
        imageStackView.distribution = .fillEqually
        imageStackView.centerInSuperview(size: .init(width: 250, height: 140))
        stackView = VerticalStackView(arrangedSubviews: [titleLabel, imageStackView, descriptionLabel], spacing: 4)
        addSubview(stackView)
        stackView.alignment = .center
        stackView.anchor(top: nil, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 24, bottom: 24, right: 24))
        self.topConstraint = stackView.topAnchor.constraint(equalTo: topAnchor, constant: 24)
        self.topConstraint.isActive = true
        titleLabel.textColor = .white
        descriptionLabel.textColor = .white
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
