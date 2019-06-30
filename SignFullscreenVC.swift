import UIKit
class SignFullscreenVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let tableView = UITableView(frame: .zero, style: .plain)
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "close_button"), for: .normal)
        button.tintColor = .white
        return button
    }()
    var sign: Sign?
    var dismissHandler: (() -> Void)?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCloseButtonQTiuHoro("horo:baoind")
        tableView.backgroundColor = SignDetailsVC.themeColor
        view.clipsToBounds = true
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.allowsSelection = false
        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.contentInsetAdjustmentBehavior = .never
        let height = UIApplication.shared.statusBarFrame.height + 50
        tableView.contentInset = .init(top: 0, left: 0, bottom: height, right: 0)
        setupCloseButton()
    }
    fileprivate func parseForecastData(for forecastData: [String: Forecast]) -> [String] {
        guard let sign = sign else { return [] }
        var items: [String] = [sign.type.rawValue + "\n\n"]
        forecastData.forEach { (key, forecast) in
            if let horoscope = forecast.horoscope {
                if let date = forecast.date {
                    items.append("Today, \(date)\n\n\(horoscope)\n\n")
                }
                if let _ = forecast.week {
                    items.append("This week\n\n\(horoscope)\n\n")
                }
                if let month = forecast.month {
                    items.append("This month, \(month)\n\n\(horoscope)\n\n")
                }
                if let year = forecast.year {
                    items.append("This year, \(year)\n\n\(horoscope)\n\n")
                }
            }
        }
        return items
    }
    @objc func handleShare(gesture: UITapGestureRecognizer) {
        guard let sign = sign else { return }
        guard let signsVC = navigationController?.viewControllers[0] as? SignsVC else { return }
        var items: [String] = []
        if sign.cellType == .forecast {
            items = parseForecastData(for: self.forecastData)
        } else {
            items = [sign.title + "\n\n" + ((sign.trait == nil) ? (sign.description) : (sign.trait! + "\n\n" + sign.description))]
        }
        let ac = UIActivityViewController(activityItems: items, applicationActivities: nil)
        ac.completionWithItemsHandler = {(_,_,_,_) in
        }
        present(ac, animated: true)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 {
            scrollView.isScrollEnabled = false
            scrollView.isScrollEnabled = true
        }
    }
    fileprivate func setupCloseButton() {
        view.addSubview(closeButton)
        closeButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: nil, bottom: nil, trailing: view.trailingAnchor, padding: .init(top: 12, left: 0, bottom: 0, right: 0), size: .init(width: 80, height: 40))
        closeButton.addTarget(self, action: #selector(handleDismiss(button:)), for: .touchUpInside)
    }
    @objc fileprivate func handleDismiss(button: UIButton) {
        button.isHidden = true
        dismissHandler?()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let sign = sign else { return 0 }
        if indexPath.row == 0 {
            switch sign.cellType {
            case .normal: return SignDetailsVC.normalSize
            case .compatibility: return SignDetailsVC.compatibilitySize
            case .forecast: return SignDetailsVC.forecastSize
            }
        }
        return UITableView.automaticDimension
    }
    var forecastData: [String: Forecast] = [:]
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let sign = sign else { return UITableViewCell() }
        if indexPath.item == 0 {
            if sign.cellType == .compatibility {
                let headerCell = CompatibilityFullscreenHeaderCell()
                headerCell.compatibilityCell.sign = self.sign
                headerCell.compatibilityCell.backgroundView = nil
                headerCell.compatibilityCell.descriptionLabel.isHidden = true
                return headerCell
            } else {
                let headerCell = SignFullscreenHeaderCell()
                headerCell.signDetailsCelll.sign = self.sign
                headerCell.signDetailsCelll.backgroundView = nil
                headerCell.signDetailsCelll.descriptionLabel.isHidden = true
                return headerCell
            }
        }
        if sign.cellType == .forecast && !forecastData.isEmpty {
            let cell = SignFullscreenForecastDescriptionCell()
            cell.forecastData = self.forecastData
            cell.shareButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShare(gesture:))))
            return cell
        } else {
            let cell = SignFullscreenDescriptionCell()
            cell.sign = self.sign
            cell.shareButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleShare(gesture:))))
            return cell
        }
    }
    deinit {
        print("Deinitialization SignFullscreenVC")
    }
}
