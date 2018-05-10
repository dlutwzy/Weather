//
//  ConditionCode.swift
//  Weather
//
//  Created by iMac on 2018/5/9.
//  Copyright © 2018年 iMac. All rights reserved.
//

import UIKit

enum ConditionCode: Int {

    case sunny = 100
    case cloudy = 101
    case fewCloudy = 102
    case partlyCloudy = 103
    case overcast = 104

    case windy = 200
    case calm = 201
    case lightBreeze = 202
    case moderate = 203
    case freshBreeze = 204
    case strongBreeze = 205
    case highWind = 206
    case gale = 207
    case strongGale = 208
    case storm = 209
    case violentStorm = 210
    case hurricane = 211
    case tornado = 212
    case tropicalStorm = 213

    case showerRain = 300
    case heavyShowerRain = 301
    case thunderShower = 302
    case heavyThunderStorm = 303
    case hail = 304
    case lightRain = 305
    case moderateRain = 306
    case heavyRain = 307
    case extremeRain = 308
    case drizzleRain = 309
    case stormRain = 310
    case heavyStormRain = 311
    case severeStormRain = 312
    case freezingRain = 313

    case lightSnow = 400
    case moderateSnow = 401
    case heavySnow = 402
    case snowstorm = 403
    case sleet = 404
    case rainAndSnow = 405
    case showerSnow = 406
    case snowFlurry = 407

    case mist = 500
    case foggy = 501
    case haze = 502
    case sand = 503
    case dust = 504
    case duststorm = 507
    case sandstorm = 508

    case hot = 900
    case cold = 901

    case unknown = 999

    var climacon: Climacons {
        switch self {

        case .sunny:
            return .sun
        case .cloudy:
            return .cloud
        case .fewCloudy:
            return .cloud
        case .partlyCloudy:
            return .cloud
        case .overcast:
            return .cloud
        case .windy:
            return .wind
        case .calm:
            return .sun
        case .lightBreeze:
            return .wind
        case .moderate:
            return .wind
        case .freshBreeze:
            return .wind
        case .strongBreeze:
            return .wind
        case .highWind:
            return .wind
        case .gale:
            return .wind
        case .strongGale:
            return .wind
        case .storm:
            return .wind
        case .violentStorm:
            return .wind
        case .hurricane:
            return .wind
        case .tornado:
            return .wind
        case .tropicalStorm:
            return .wind
        case .showerRain:
            return .cloudRainAlt
        case .heavyShowerRain:
            return .cloudHail
        case .thunderShower:
            return .cloudHail
        case .heavyThunderStorm:
            return .cloudHailAlt
        case .hail:
            return .cloudHail
        case .lightRain:
            return .cloudRainAlt
        case .moderateRain:
            return .cloudHail
        case .heavyRain:
            return .cloudHailAlt
        case .extremeRain:
            return .cloudHailAlt
        case .drizzleRain:
            return .cloudRainAlt
        case .stormRain:
            return .cloudHail
        case .heavyStormRain:
            return .cloudHailAlt
        case .severeStormRain:
            return .cloudHailAlt
        case .freezingRain:
            return .cloudHail
        case .lightSnow:
            return .cloudSnow
        case .moderateSnow:
            return .cloudSnow
        case .heavySnow:
            return .cloudSnow
        case .snowstorm:
            return .cloudSnow
        case .sleet:
            return .cloudHail
        case .rainAndSnow:
            return .cloudHail
        case .showerSnow:
            return .cloudSnow
        case .snowFlurry:
            return .cloudSnow
        case .mist:
            return .cloudFog
        case .foggy:
            return .cloudFogAlt
        case .haze:
            return .cloudFogAlt
        case .sand:
            return .cloudFogAlt
        case .dust:
            return .cloudFogAlt
        case .duststorm:
            return .cloudFogAlt
        case .sandstorm:
            return .cloudFogAlt
        case .hot:
            return .thermometer100
        case .cold:
            return .thermometerZero
        case .unknown:
            return .tornado
        }
    }
}

extension UIImage {
    class func conditionImage(icon: ConditionCode, completionHandler: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .default).async {

            var image: UIImage?
            do {
                let data = try Data(contentsOf: UIImage.localImagePath(icon: icon)!)
                image = UIImage(data: data)
            } catch {

                do {
                    let data = try Data(contentsOf: UIImage.remoteImagePath(icon: icon)!)
                    image = UIImage(data: data)

                    let fileManager = FileManager.default
                    fileManager.createFile(atPath: UIImage.localImagePath(icon: icon),
                                           contents: data,
                                           attributes: nil)
                } catch { }
            }

            image = image?.imageWithColor(color: UIColor.white)

            DispatchQueue.main.async {
                completionHandler(image)
            }
        }
    }

    private class func remoteImagePath(icon: ConditionCode) -> URL? {
        return URL(string: "https://cdn.heweather.com/cond_icon/\(icon.rawValue).png")
    }

    private class func localImagePath(icon: ConditionCode) -> String {
        let myPathes = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true)
        let docPath = myPathes[0]
        return NSString(string: docPath).appendingPathComponent("/conditionImage/\(icon.rawValue).png") as String
    }

    private class func localImagePath(icon: ConditionCode) -> URL? {
        return URL(string: UIImage.localImagePath(icon: icon))
    }

    private func imageWithColor(color: UIColor) -> UIImage? {

        guard let cgImage = self.cgImage else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: cgImage)
        color.setFill()
        context?.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
