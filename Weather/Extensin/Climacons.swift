//
//  ClimaconsIcon.swift
//  Weather
//
//  Created by iMac on 2018/5/7.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

enum Climacons: String {

    case cloudDrizzleAlt = "\u{e900}"
    case cloudDrizzleMoon = "\u{e901}"
    case cloudDrizzleSunAlt = "\u{e902}"
    case cloudDrizzleSun = "\u{e903}"
    case cloudDrizzle = "\u{e904}"
    case cloudFogAlt = "\u{e905}"
    case cloudFogMoonAlt = "\u{e906}"
    case cloudFogMoon = "\u{e907}"
    case cloudFogSunAlt = "\u{e908}"
    case cloudFogSun = "\u{e909}"
    case cloudFog = "\u{e90a}"
    case cloudHailAlt = "\u{e90b}"
    case cloudHailMoon = "\u{e90c}"
    case cloudHailSun = "\u{e90d}"
    case cloudHail = "\u{e90e}"
    case cloudLightningMoon = "\u{e90f}"
    case cloudLightningSun = "\u{e910}"
    case cloudLightning = "\u{e911}"
    case cloudMoon = "\u{e912}"
    case cloudRainAlt = "\u{e913}"
    case cloudRainMoonAlt = "\u{e914}"
    case cloudRainMoon = "\u{e915}"
    case cloudRainSunAlt = "\u{e916}"
    case cloudRainSun = "\u{e917}"
    case cloudRefresh = "\u{e918}"
    case cloudSnowMoonAlt = "\u{e919}"
    case cloudSnowMoon = "\u{e91a}"
    case cloudSnowSunAlt = "\u{e91b}"
    case cloudSnowSun = "\u{e91c}"
    case cloudSnow = "\u{e91d}"
    case cloudSun = "\u{e91e}"
    case cloudUpload = "\u{e91f}"
    case cloudWindMoon = "\u{e920}"
    case cloudWindSun = "\u{e921}"
    case cloudWind = "\u{e922}"
    case cloud = "\u{e923}"
    case compassNorth = "\u{e924}"
    case compassWest = "\u{e925}"
    case compass = "\u{e926}"
    case cegreesCelcius = "\u{e927}"
    case cegreesFahrenheit = "\u{e928}"
    case moonFirstQuarter = "\u{e929}"
    case moonFull = "\u{e92a}"
    case moonLastQuarter = "\u{e92b}"
    case moonNew = "\u{e92c}"
    case moonWaningCrescent = "\u{e92d}"
    case moonWaningGibbous = "\u{e92e}"
    case moonWaxingCrescent = "\u{e92f}"
    case moonWaxingGibbous = "\u{e930}"
    case moon = "\u{e931}"
    case shades = "\u{e932}"
    case snowflake = "\u{e933}"
    case sunLow = "\u{e934}"
    case sunLower = "\u{e935}"
    case sun = "\u{e936}"
    case sunrise = "\u{e937}"
    case sunset = "\u{e938}"
    case thermometer25 = "\u{e939}"
    case thermometer50 = "\u{e93a}"
    case thermometer75 = "\u{e93b}"
    case thermometer100 = "\u{e93c}"
    case thermometerZero = "\u{e93d}"
    case thermometer = "\u{e93e}"
    case tornado = "\u{e93f}"
    case umbrella = "\u{e940}"
    case wind = "\u{e941}"
}

extension String {

    init(climacons: Climacons) {
        self.init(climacons.rawValue)
    }
}
