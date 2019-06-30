import UIKit
class SignsVC: BaseCollectionVC, UICollectionViewDelegateFlowLayout {
    fileprivate let cellId = "CellId"
    fileprivate let signs = Sign.allSign()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupRateButtonAAGptHoro("horo-base")
        collectionView.backgroundColor = SignDetailsVC.themeColor
        collectionView.register(SignsCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.isScrollEnabled = false
        let backButton = UIBarButtonItem()
        backButton.tintColor = SignDetailsVC.themeColor
        navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = true
        view.backgroundColor = .clear
        if UIDevice.current.screenType != .iPhones_5_5s_5c_SE {
            setupRateButton()
        }
    }
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return signs.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SignsCell
        cell.sign = signs[indexPath.item]
        return cell
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = SignDetailsVC(sign: signs[indexPath.item])
        self.navigationController?.pushViewController(vc, animated: true)        
    }
    lazy var leftRightPadding = view.frame.width * 0.04
    lazy var interSpacing = view.frame.width * 0.02
    lazy var totalEmptySpace = (view.frame.width - 2 * leftRightPadding - 2 * interSpacing)
    lazy var cellWidth = totalEmptySpace / 3 - 5
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width: cellWidth, height: cellWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return interSpacing
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .init(top: 16, left: leftRightPadding, bottom: 16, right: leftRightPadding)
    }
    fileprivate func setupRateButton() {
        let edgeSpace = view.frame.width * 0.2
        let rateButtonContainerView = UIView()
        rateButtonContainerView.layer.cornerRadius = 16
        rateButtonContainerView.clipsToBounds = true
        view.addSubview(rateButtonContainerView)
        rateButtonContainerView.anchor(top: nil, leading: view.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor, padding: .init(top: 0, left: edgeSpace, bottom: 80, right: edgeSpace), size: .init(width: 0, height: 40))
        rateButtonContainerView.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        let rateButton = UIButton(title: "Rate this app !")
        rateButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 26)
        rateButton.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        rateButtonContainerView.addSubview(rateButton)
        rateButton.centerInSuperview()
        rateButton.addTarget(self, action: #selector(handleRateButtonPressed), for: .touchUpInside)
    }
    @objc fileprivate func handleRateButtonPressed() {
        let appId = "1470815004"
        let urlString = "itms-apps://itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=\(appId)"
        guard let url = URL(string: urlString) else { return }
        UIApplication.shared.open(url, options: [:])
    }
}
