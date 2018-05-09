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
            return .cloud
        case .calm:
            return .cloud
        case .lightBreeze:
            return .cloud
        case .moderate:
            return .cloud
        case .freshBreeze:
            return .cloud
        case .strongBreeze:
            return .cloud
        case .highWind:
            return .cloud
        case .gale:
            return .cloud
        case .strongGale:
            return .cloud
        case .storm:
            return .cloud
        case .violentStorm:
            return .cloud
        case .hurricane:
            return .cloud
        case .tornado:
            return .cloud
        case .tropicalStorm:
            return .cloud
        case .showerRain:
            return .cloud
        case .heavyShowerRain:
            return .cloud
        case .thunderShower:
            return .cloud
        case .heavyThunderStorm:
            return .cloud
        case .hail:
            return .cloud
        case .lightRain:
            return .cloud
        case .moderateRain:
            return .cloud
        case .heavyRain:
            return .cloud
        case .extremeRain:
            return .cloud
        case .drizzleRain:
            return .cloud
        case .stormRain:
            return .cloud
        case .heavyStormRain:
            return .cloud
        case .severeStormRain:
            return .cloud
        case .freezingRain:
            return .cloud
        case .lightSnow:
            return .cloud
        case .moderateSnow:
            return .cloud
        case .heavySnow:
            return .cloud
        case .snowstorm:
            return .cloud
        case .sleet:
            return .cloud
        case .rainAndSnow:
            return .cloud
        case .showerSnow:
            return .cloud
        case .snowFlurry:
            return .cloud
        case .mist:
            return .cloud
        case .foggy:
            return .cloud
        case .haze:
            return .cloud
        case .sand:
            return .cloud
        case .dust:
            return .cloud
        case .duststorm:
            return .cloud
        case .sandstorm:
            return .cloud
        case .hot:
            return .cloud
        case .cold:
            return .cloud
        case .unknown:
            return .cloud
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
