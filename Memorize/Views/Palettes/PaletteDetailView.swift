//
//  PaletteDetailView.swift
//  Memorize
//
//  Created by Eduard on 01.03.2023.
//

import SwiftUI

struct PaletteDetailView: View {
    @Binding var data: Palette.Data
    @Binding var palette: Palette
    @Binding var isShowing: Bool
    
    var body: some View {
        NavigationStack {
            PaletteEditor(data: $data)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle(data.name)
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Done") {
                            palette.update(from: data)
                            data = Palette.Data()
                            isShowing = false
                        }
                    }
                }
        }
    }
}

//struct PaletteDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        PaletteDetailView()
//    }
//}
