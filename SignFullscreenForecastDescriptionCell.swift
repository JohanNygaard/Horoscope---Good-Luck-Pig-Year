import UIKit
class SignFullscreenForecastDescriptionCell: UITableViewCell {
    let shareButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "share_button").withRenderingMode(.alwaysOriginal), for: .normal)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        button.layer.backgroundColor = SignDetailsVC.themeColor.cgColor
        button.contentEdgeInsets = UIEdgeInsets.init(top: 2, left: 16, bottom: 2, right: 16)
        return button
    }()
    var attributedText = NSMutableAttributedString(string: "\n")
    var forecastData: [String: Forecast]! {
        didSet {
            let descriptionLabel: UILabel = {
                let label = UILabel()
                if let today = forecastData["today"], let time = today.date, let horoscope = today.horoscope {
                    appendToAttributedText("Today (\(time))", horoscope)
                }
                if let week = forecastData["week"], let _ = week.week, let horoscope = week.horoscope {
                    appendToAttributedText("This week", horoscope)
                }
                if let month = forecastData["month"], let time = month.month, let horoscope = month.horoscope {
                    appendToAttributedText("This Month - \(time)", horoscope)
                }
                if let year = forecastData["year"], let time = year.year, let horoscope = year.horoscope {
                    appendToAttributedText("This Year - \(time)", horoscope)
                }
                label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
                label.attributedText = attributedText
                label.numberOfLines = 0
                return label
            }()
            let stackView = VerticalStackView(arrangedSubviews: [shareButton, descriptionLabel], spacing: 8)
            addSubview(stackView)
            stackView.alignment = .center
            shareButton.anchor(top: stackView.topAnchor, leading: nil, bottom: nil, trailing: nil, padding: .init(top: 0, left: 120, bottom: 12, right: 120), size: .init(width: 120, height: 40))
            stackView.fillSuperview(padding: .init(top: 0, left: 24, bottom: 0, right: 24))
        }
    }
    fileprivate func appendToAttributedText(_ time: String, _ horoscope: String) {
        self.appendToAttributedTextZwwUnHoro("12", "base", "123")
        attributedText.append(NSAttributedString(string: time, attributes: [.foregroundColor: UIColor.white, .font: UIFont.boldSystemFont(ofSize: 20)]))
        attributedText.append(NSAttributedString(string: "\n\n"))
        attributedText.append(NSAttributedString(string: horoscope, attributes: [.foregroundColor: UIColor.white]))
        attributedText.append(NSAttributedString(string: "\n\n"))
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)        
        backgroundColor = SignDetailsVC.themeColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
