//
//  Palette+Extension.swift
//  Memorize
//
//  Created by Eduard on 02.03.2023.
//

import SwiftUI

extension Palette {
    var color: Color {
        get {
            Color(rgbaColor: self.rgbaColor)
        }
        set {
            self.rgbaColor = RGBAColor(color: newValue)
        }
    }
    
   
}

extension Palette.Data {
    var color: Color {
        get {
            Color(rgbaColor: self.rgbaColor)
        }
        set {
            self.rgbaColor = RGBAColor(color: newValue)
        }
    }
}


