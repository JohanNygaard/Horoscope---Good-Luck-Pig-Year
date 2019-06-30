import UIKit
import AVFoundation
class SignDetailsVC: BaseCollectionVC, UICollectionViewDelegateFlowLayout, UIGestureRecognizerDelegate {
    var sign: Sign
    var player: AVAudioPlayer?
    static var themeColor: UIColor = #colorLiteral(red: 0.4745098054, green: 0.8392156959, blue: 0.9764705896, alpha: 1)
    var pressCount: Int = 0
    init(sign: Sign) {
        self.sign = sign
        super.init()
    }
    fileprivate func showInterstitialAds() {
        print("press count ",pressCount)
        if pressCount == 3 {
            pressCount = 0
        } else {
            pressCount += 1
        }
    }
    let blurVisualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .regular))
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = .clear
        fetchForecastData()
        self.beginAnimationAppFullscreenKfvPkHoro("people")
    }
    let activityIndicatorView: UIActivityIndicatorView = {
        let aiv = UIActivityIndicatorView(style: .whiteLarge)
        aiv.color = .black
        aiv.startAnimating()
        aiv.hidesWhenStopped = true
        return aiv
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(blurVisualEffectView)
        blurVisualEffectView.fillSuperview()
        blurVisualEffectView.alpha = 0
        collectionView.register(SignDetailsCell.self, forCellWithReuseIdentifier: Sign.CellType.normal.rawValue)
        collectionView.register(CompatibilityCell.self, forCellWithReuseIdentifier: Sign.CellType.compatibility.rawValue)
        collectionView.register(ForecastCell.self, forCellWithReuseIdentifier: Sign.CellType.forecast.rawValue)
        collectionView.backgroundColor = .white
        fetchForecastData()
    }
    var forecastData: [String: Forecast] = [:]
    fileprivate func fetchForecastData() {
        forecastData.removeAll()
        var todayData: Forecast?
        var weekData: Forecast?
        var monthData: Forecast?
        var yearData: Forecast?
        let dispatchGroup = DispatchGroup()
        dispatchGroup.enter()
        Service.shared.fetchTodayForecast(for: self.sign.type) { (data, error) in
            if let error = error {
                print("Failed to fetch today forecast data", error)
                return
            }
            dispatchGroup.leave()
            todayData = data!
        }
        dispatchGroup.enter()
        Service.shared.fetchWeekForecast(for: sign.type) { (data, error) in
            if let error = error {
                print("Failed to fetch weekly forecast data", error)
                return
            }
            dispatchGroup.leave()
            weekData = data!
        }
        dispatchGroup.enter()
        Service.shared.fetchMonthForecast(for: sign.type) { (data, error) in
            if let error = error {
                print("Failed to fetch monthly forecast data", error)
                return
            }
            dispatchGroup.leave()
            monthData = data!
        }
        dispatchGroup.enter()
        Service.shared.fetchYearForecast(for: sign.type) { (data, error) in
            if let error = error {
                print("Failed to fetch yearly forecast data", error)
                return
            }
            dispatchGroup.leave()
            yearData = data!
        }
        dispatchGroup.notify(queue: .main) {
            if let todayData = todayData {
                self.forecastData["today"] = todayData
            }
            if let weekData = weekData {
                self.forecastData["week"] = weekData
            }
            if let monthData = monthData {
                self.forecastData["month"] = monthData
            }
            if let yearData = yearData {
                self.forecastData["year"] = yearData
            }
            self.collectionView.reloadData()
            self.activityIndicatorView.stopAnimating()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.sign.getGroup().count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellType = self.sign.getGroup()[indexPath.item].cellType
        let cellId = cellType.rawValue
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! BaseCollectionCell
        cell.sign = self.sign.getGroup()[indexPath.item]
        if cellType == .forecast {
            cell.addSubview(activityIndicatorView)
            activityIndicatorView.fillSuperview()
            cell.isUserInteractionEnabled = !activityIndicatorView.isAnimating
        }
        return cell        
    }
    static let normalSize: CGFloat = 500
    static let compatibilitySize: CGFloat = 300
    static let forecastSize: CGFloat = 480
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellType = self.sign.getGroup()[indexPath.item].cellType
        var height: CGFloat = 0
        switch cellType {
            case .normal: height = SignDetailsVC.normalSize
            case .compatibility: height = SignDetailsVC.compatibilitySize
            case .forecast: height = SignDetailsVC.forecastSize
        }
        return .init(width: view.frame.width - 50, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 32, right: 0)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        showInterstitialAds()
        showSingleAppFullScreen(indexPath: indexPath)
    }
    fileprivate func showSingleAppFullScreen(indexPath: IndexPath) {
        setupSingleAppFullscreenController(indexPath)
        setupAppFullscreenStartingPosition(indexPath)
        beginAnimationAppFullscreen()
    }
    fileprivate func setupSingleAppFullscreenController(_ indexPath: IndexPath) {
        let signFullscreenVC =  SignFullscreenVC()
        signFullscreenVC.forecastData = self.forecastData
        signFullscreenVC.sign = self.sign.getGroup()[indexPath.item]
        signFullscreenVC.dismissHandler = {
            self.handleAppFullscreenDismissal()
        }
        self.signFullscreenVC = signFullscreenVC
        signFullscreenVC.view.layer.cornerRadius = 16
        addChild(signFullscreenVC)
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handleDrag))
        gesture.delegate = self
        signFullscreenVC.view.addGestureRecognizer(gesture)
    }
    var anchoredConstraint: AnchoredConstraints?
    var startingFrame: CGRect?
    var selectedCell: BaseCollectionCell?
    fileprivate func setupStartingCellFrame(_ indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return }
        guard let startingFrame = cell.superview?.convert(cell.frame, to: nil) else { return }
        self.startingFrame = startingFrame
        self.selectedCell = cell as? BaseCollectionCell
        self.selectedCell?.alpha = 0
    }
    fileprivate func setupAppFullscreenStartingPosition(_ indexPath: IndexPath) {
        self.collectionView.isUserInteractionEnabled = false
        let fullscreenView = self.signFullscreenVC.view!
        view.addSubview(fullscreenView)
        setupStartingCellFrame(indexPath)
        guard let startingFrame = self.startingFrame else { return }
        self.anchoredConstraint = fullscreenView.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: nil, padding: UIEdgeInsets.init(top: startingFrame.origin.y, left: startingFrame.origin.x, bottom: 0, right: 0), size: .init(width: startingFrame.width, height: startingFrame.height))
        self.view.layoutIfNeeded()
    }
    fileprivate func beginAnimationAppFullscreen() {
        navigationController?.isNavigationBarHidden = true
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.blurVisualEffectView.alpha = 1
            self.anchoredConstraint?.top?.constant = 0
            self.anchoredConstraint?.leading?.constant = 0
            self.anchoredConstraint?.width?.constant = self.view.frame.width
            self.anchoredConstraint?.height?.constant = self.view.frame.height
            self.view.layoutIfNeeded() 
            self.tabBarController?.tabBar.transform = CGAffineTransform(translationX: 0, y: 100)
            guard let cell = self.signFullscreenVC.tableView.cellForRow(at: [0,0]) as? SignFullscreenHeaderCell else { return }
            cell.signDetailsCelll.topConstraint.constant = 48
            cell.layoutIfNeeded()
        }, completion: nil)
    }
    var signFullscreenBeginOffset: CGFloat = 0
    @objc fileprivate func handleDrag(gesture: UIPanGestureRecognizer) {
        if gesture.state == .began {
            signFullscreenBeginOffset = signFullscreenVC.tableView.contentOffset.y
        }
        if signFullscreenVC.tableView.contentOffset.y > 0 { return }
        let translationY = gesture.translation(in: signFullscreenVC.view).y
        if gesture.state == .changed {
            if translationY > 0 {
                let trueOffset = translationY - signFullscreenBeginOffset
                var scale = 1 - trueOffset / 1000
                scale = min(1, scale)
                scale = max(0.5, scale)
                let transform: CGAffineTransform = .init(scaleX: scale, y: scale)
                self.signFullscreenVC.view.transform = transform
            }
        } else if gesture.state == .ended {
            if translationY > 0 {
                handleAppFullscreenDismissal()
            }
        }
    }
    var signFullscreenVC: SignFullscreenVC!
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
    @objc fileprivate func handleAppFullscreenDismissal() {
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.7, options: .curveEaseOut, animations: {
            self.signFullscreenVC.tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableView.ScrollPosition.top, animated: true)
            self.navigationController?.isNavigationBarHidden = false
            guard let startingFrame = self.startingFrame else { return }
            self.anchoredConstraint?.width?.constant = startingFrame.width
            self.anchoredConstraint?.height?.constant = startingFrame.height
            self.signFullscreenVC.view.transform = CGAffineTransform(translationX: startingFrame.origin.x, y: startingFrame.origin.y)
            self.view.layoutIfNeeded()
            self.tabBarController?.tabBar.transform = .identity
            self.signFullscreenVC.closeButton.alpha = 0
            self.blurVisualEffectView.alpha = 0
            self.view.layoutIfNeeded()
            if let cell = self.signFullscreenVC.tableView.cellForRow(at: [0,0]) as? SignFullscreenHeaderCell {
                cell.signDetailsCelll.descriptionLabel.isHidden = false
                cell.signDetailsCelll.topConstraint.constant = 24
                cell.layoutIfNeeded()
            } else if let cell = self.signFullscreenVC.tableView.cellForRow(at: [0,0]) as? CompatibilityFullscreenHeaderCell  {
                cell.compatibilityCell.descriptionLabel.isHidden = false
                cell.compatibilityCell.topConstraint.constant = 24
                cell.layoutIfNeeded()
            }
        }, completion: { _ in
            self.selectedCell?.alpha = 1
            self.signFullscreenVC.view.removeFromSuperview()
            self.signFullscreenVC.removeFromParent()
            self.collectionView.isUserInteractionEnabled = true
        })
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    deinit {
        print("Deinitialization SignDetailsVC")
    }
}
