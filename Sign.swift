import UIKit
public struct Sign {
    enum CellType: String {
        case forecast, normal, compatibility
    }
    let type: SignType
    let title: String
    let image1: String
    let image2: String?
    var description: String
    var trait: String?
    let cellType: CellType
}
enum SignType: String, CaseIterable {
    case Taurus, Aries, Scorpio, Sagittarius, Virgo, Leo, Libra, Aquarius, Pisces, Gemini, Capricorn, Cancer
}
extension Sign {
    public static func allSign() -> [Sign] {
        let signs = [
            Sign(type: .Aries, title: SignType.Aries.rawValue, image1: "aries", image2: nil,  description: "Mar 21 - Apr 19", trait: nil, cellType: .normal),
            Sign(type: .Taurus, title: SignType.Taurus.rawValue, image1: "taurus", image2: nil,  description: "Apr 20 - May 20", trait: nil, cellType: .normal),
            Sign(type: .Gemini, title: SignType.Gemini.rawValue, image1: "gemini", image2: nil,  description: "May 21 - Jun 20", trait: nil, cellType: .normal),
            Sign(type: .Cancer, title: SignType.Cancer.rawValue, image1: "cancer", image2: nil,  description: "Jun 21 - Jul 22", trait: nil, cellType: .normal),
            Sign(type: .Leo, title: SignType.Leo.rawValue, image1: "leo", image2: nil,  description: "Jul 23 - Aug 22", trait: nil, cellType: .normal),
            Sign(type: .Virgo, title: SignType.Virgo.rawValue, image1: "virgo", image2: nil,  description: "Aug 23 - Sep 22", trait: nil, cellType: .normal),
            Sign(type: .Libra, title: SignType.Libra.rawValue, image1: "libra", image2: nil,  description: "Sep 23 - Oct 22", trait: nil, cellType: .normal),
            Sign(type: .Scorpio, title: SignType.Scorpio.rawValue, image1: "scorpio", image2: nil,  description: "Oct 23 - Nov 21", trait: nil, cellType: .normal),
            Sign(type: .Sagittarius, title: SignType.Sagittarius.rawValue, image1: "sagittarius", image2: nil,  description: "Nov 22 - Dec 21", trait: nil, cellType: .normal),
            Sign(type: .Capricorn, title: SignType.Capricorn.rawValue, image1: "capricorn", image2: nil,  description: "Dec 22 - Jan 19", trait: nil, cellType: .normal),
            Sign(type: .Aquarius, title: SignType.Aquarius.rawValue, image1: "aquarius", image2: nil,  description: "Jan 20 - Feb 18", trait: nil, cellType: .normal),
            Sign(type: .Pisces, title: SignType.Pisces.rawValue, image1: "pisces", image2: nil,  description: "Feb 19 - Mar 20", trait: nil, cellType: .normal),
            ]
        return signs
    }    
}
extension Sign {
    func matchDescription(with sign: SignType) -> String {
        switch (self.type, sign) {
        case (.Taurus, .Taurus) : return Compatibility.taurus_taurus
        case (.Taurus, .Aries), (.Aries, .Taurus) : return Compatibility.taurus_aries
        case (.Taurus, .Gemini), (.Gemini, .Taurus): return Compatibility.taurus_gemini
        case (.Taurus, .Leo), (.Leo, .Taurus): return Compatibility.taurus_leo
        case (.Taurus, .Capricorn), (.Capricorn, .Taurus): return Compatibility.taurus_capricorn
        case (.Taurus, .Sagittarius), (.Sagittarius, .Taurus): return Compatibility.taurus_sagittarius
        case (.Taurus, .Aquarius), (.Aquarius, .Taurus): return Compatibility.taurus_aquarius
        case (.Taurus, .Pisces), (.Pisces, .Taurus): return Compatibility.taurus_pisces
        case (.Taurus, .Cancer), (.Cancer, .Taurus): return Compatibility.taurus_cancer
        case (.Taurus, .Libra), (.Libra, .Taurus): return Compatibility.taurus_libra
        case (.Taurus, .Virgo), (.Virgo, .Taurus): return Compatibility.taurus_virgo
        case (.Taurus, .Scorpio), (.Scorpio, .Taurus): return Compatibility.taurus_scorpio
        case (.Aries, .Aries): return Compatibility.aries_aries
        case (.Aries, .Gemini), (.Gemini, .Aries): return Compatibility.aries_gemini
        case (.Aries, .Cancer), (.Cancer, .Aries): return Compatibility.aries_cancer
        case (.Aries, .Leo), (.Leo, .Aries): return Compatibility.aries_leo
        case (.Aries, .Virgo), (.Virgo, .Aries): return Compatibility.aries_virgo
        case (.Aries, .Libra), (.Libra, .Aries): return Compatibility.aries_libra
        case (.Aries, .Scorpio), (.Scorpio, .Aries): return Compatibility.aries_scorpio
        case (.Aries, .Sagittarius), (.Sagittarius, .Aries): return Compatibility.aries_sagittarius
        case (.Aries, .Capricorn), (.Capricorn, .Aries): return Compatibility.aries_capricorn
        case (.Aries, .Aquarius), (.Aquarius, .Aries): return Compatibility.aries_aquarius
        case (.Aries, .Pisces), (.Pisces, .Aries): return Compatibility.aries_pisces
        case (.Gemini, .Gemini): return Compatibility.gemini_gemini
        case (.Gemini, .Cancer), (.Cancer, .Gemini): return Compatibility.gemini_cancer
        case (.Gemini, .Leo), (.Leo, .Gemini): return Compatibility.gemini_leo
        case (.Gemini, .Virgo), (.Virgo, .Gemini): return Compatibility.gemini_virgo
        case (.Gemini, .Libra), (.Libra, .Gemini): return Compatibility.gemini_libra
        case (.Gemini, .Scorpio), (.Scorpio, .Gemini): return Compatibility.gemini_scorpio
        case (.Gemini, .Sagittarius), (.Sagittarius, .Gemini): return Compatibility.gemini_sagittarius
        case (.Gemini, .Capricorn), (.Capricorn, .Gemini): return Compatibility.gemini_capricorn
        case (.Gemini, .Aquarius), (.Aquarius, .Gemini): return Compatibility.gemini_aquarius
        case (.Gemini, .Pisces), (.Pisces, .Gemini): return Compatibility.gemini_pisces
        case (.Cancer, .Cancer): return Compatibility.cancer_cancer
        case (.Cancer, .Leo), (.Leo, .Cancer): return Compatibility.cancer_leo
        case (.Cancer, .Virgo), (.Virgo, .Cancer): return Compatibility.cancer_virgo
        case (.Cancer, .Libra), (.Libra, .Cancer): return Compatibility.cancer_libra
        case (.Cancer, .Scorpio), (.Scorpio, .Cancer): return Compatibility.cancer_scorpio
        case (.Cancer, .Sagittarius), (.Sagittarius, .Cancer): return Compatibility.cancer_sagittarius
        case (.Cancer, .Capricorn), (.Capricorn, .Cancer): return Compatibility.cancer_capricorn
        case (.Cancer, .Aquarius), (.Aquarius, .Cancer): return Compatibility.cancer_aquarius
        case (.Cancer, .Pisces), (.Pisces, .Cancer): return Compatibility.cancer_pisces
        case (.Leo, .Leo): return Compatibility.leo_leo
        case (.Leo, .Virgo), (.Virgo, .Leo): return Compatibility.leo_virgo
        case (.Leo, .Libra), (.Libra, .Leo): return Compatibility.leo_libra
        case (.Leo, .Scorpio), (.Scorpio, .Leo): return Compatibility.leo_scorpio
        case (.Leo, .Sagittarius), (.Sagittarius, .Leo): return Compatibility.leo_sagittarius
        case (.Leo, .Capricorn), (.Capricorn, .Leo): return Compatibility.leo_capricorn
        case (.Leo, .Aquarius), (.Aquarius, .Leo): return Compatibility.leo_aquarius
        case (.Leo, .Pisces), (.Pisces, .Leo): return Compatibility.leo_pisces
        case (.Virgo, .Virgo): return Compatibility.virgo_virgo
        case (.Virgo, .Libra), (.Libra, .Virgo): return Compatibility.virgo_libra
        case (.Virgo, .Scorpio), (.Scorpio, .Virgo): return Compatibility.virgo_scorpio
        case (.Virgo, .Sagittarius), (.Sagittarius, .Virgo): return Compatibility.virgo_sagittarius
        case (.Virgo, .Capricorn), (.Capricorn, .Virgo): return Compatibility.virgo_capricorn
        case (.Virgo, .Aquarius), (.Aquarius, .Virgo): return Compatibility.virgo_aquarius
        case (.Virgo, .Pisces), (.Pisces, .Virgo): return Compatibility.virgo_pisces
        case (.Libra, .Libra): return Compatibility.libra_libra
        case (.Libra, .Scorpio), (.Scorpio, .Libra): return Compatibility.libra_scorpio
        case (.Libra, .Sagittarius), (.Sagittarius, .Libra): return Compatibility.libra_sagittarius
        case (.Libra, .Capricorn), (.Capricorn, .Libra): return Compatibility.libra_capricorn
        case (.Libra, .Aquarius), (.Aquarius, .Libra): return Compatibility.libra_aquarius
        case (.Libra, .Pisces), (.Pisces, .Libra): return Compatibility.libra_pisces
        case (.Scorpio, .Scorpio): return Compatibility.scorpio_scorpio
        case (.Scorpio, .Sagittarius), (.Sagittarius, .Scorpio): return Compatibility.scorpio_sagittarius
        case (.Scorpio, .Capricorn), (.Capricorn, .Scorpio): return Compatibility.scorpio_capricorn
        case (.Scorpio, .Aquarius), (.Aquarius, .Scorpio): return Compatibility.scorpio_aquarius
        case (.Scorpio, .Pisces), (.Pisces, .Scorpio): return Compatibility.scorpio_pisces
        case (.Sagittarius, .Sagittarius): return Compatibility.sagittarius_sagittarius
        case (.Sagittarius, .Capricorn), (.Capricorn, .Sagittarius): return Compatibility.sagittarius_capricorn
        case (.Sagittarius, .Aquarius), (.Aquarius, .Sagittarius): return Compatibility.sagittarius_aquarius
        case (.Sagittarius, .Pisces), (.Pisces, .Sagittarius): return Compatibility.sagittarius_pisces
        case (.Capricorn, .Capricorn): return Compatibility.capricorn_capricorn
        case (.Capricorn, .Aquarius), (.Aquarius, .Capricorn): return Compatibility.capricorn_aquarius
        case (.Capricorn, .Pisces), (.Pisces, .Capricorn): return Compatibility.capricorn_pisces
        case (.Aquarius, .Aquarius): return Compatibility.aquarius_aquarius
        case (.Aquarius, .Pisces), (.Pisces, .Aquarius): return Compatibility.aquarius_pisces
        case (.Pisces, .Pisces): return Compatibility.pisces_pisces
        }
    }
    func getCompatibilityGroup(_ signType: SignType) -> [Sign] {
        var signs = [Sign]()
        let _ = SignType.allCases.map { (eachType) in
            let title = "\(type.rawValue) - \(eachType.rawValue)"
            let image1 = "\(type.rawValue.lowercased())2"
            let image2 = "\(eachType.rawValue.lowercased())2"
            let sign = Sign(type: type, title: title, image1: image1, image2: image2, description: matchDescription(with: eachType), trait: nil, cellType: .compatibility)
            signs.append(sign)
        }
        return signs
    }
    func getNormalGroup(_ signType: SignType) -> [Sign] {
        var allInfo: [String: String]
        switch signType {
        case (.Taurus): allInfo = Taurus.all()
        case (.Cancer): allInfo = Cancer.all()
        case (.Aries):  allInfo = Aries.all()
        case (.Pisces): allInfo = Pisces.all()
        case (.Aquarius): allInfo = Aquarius.all()
        case (.Capricorn): allInfo = Capricorn.all()
        case (.Sagittarius): allInfo = Sagittarius.all()
        case (.Scorpio): allInfo = Scorpio.all()
        case (.Virgo): allInfo = Virgo.all()
        case (.Leo): allInfo = Leo.all()
        case (.Gemini): allInfo = Gemini.all()
        case (.Libra): allInfo = Libra.all()
        }
        let general = Sign(type: signType, title: "\(signType)", image1: "\(signType.rawValue.lowercased())2", image2: nil, description: allInfo["general"] ?? "", trait: allInfo["trait"] ?? "", cellType: .normal)
        let forecast = Sign(type: signType, title: "2019", image1: "pig_\(signType.rawValue.lowercased())", image2: nil, description: "Love | Career\nDaily | Weekly | Monthly | Yearly", trait: nil, cellType: .forecast)
        let man = Sign(type: signType, title: "\(signType) Man", image1: "\(signType.rawValue.lowercased())_man", image2: nil, description: allInfo["man"] ?? "", trait: nil, cellType: .normal)
        let woman = Sign(type: signType, title: "\(signType) Woman", image1: "\(signType.rawValue.lowercased())_woman", image2: nil, description: allInfo["woman"] ?? "", trait: nil, cellType: .normal)
        let child = Sign(type: signType, title: "\(signType) Child", image1: "\(signType.rawValue.lowercased())_child", image2: nil, description: allInfo["child"] ?? "", trait: nil, cellType: .normal)
        let famous = Sign(type: signType, title: "Famous \(signType)", image1: "famous", image2: nil, description: allInfo["famous"] ?? "", trait: nil, cellType: .normal)
        let planet = Sign(type: signType, title: "\(signType) Ruling Planet", image1: "\(signType.rawValue.lowercased())_planet", image2: nil, description: allInfo["planet"] ?? "", trait: nil, cellType: .normal)
        return [general, forecast, man, woman, child, famous, planet]
    }
    func getGroup() -> [Sign] {
        var signGroup = [Sign]()
        getNormalGroup(type).forEach({ signGroup.append($0)})
        getCompatibilityGroup(type).forEach({ signGroup.append($0)})
        return signGroup
    }
}
