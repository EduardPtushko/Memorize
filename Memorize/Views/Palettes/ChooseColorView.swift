//
//  ChooseColorView.swift
//  Memorize
//
//  Created by Eduard on 28.02.2023.
//

import SwiftUI


struct ChooseColorView: View {
    @Binding var data: Palette.Data
    let columnLayout = Array(repeating: GridItem(.adaptive(minimum: 44)), count: 1)
    let allColors: [Color] = [
        .pink,
        .red,
        .orange,
        .yellow,
        .green,
        .mint,
        .teal,
        .cyan,
        .blue,
        .indigo,
        .purple,
        .brown,
        .gray
    ]
    
    var body: some View {
        LazyVGrid(columns: columnLayout) {
            ForEach(allColors.indices, id: \.self) { index in
                RoundedRectangle(cornerRadius: 8)
                    .aspectRatio(2/3, contentMode: .fit)
                    .foregroundColor(allColors[index])
                    .onTapGesture {
                        data.color = allColors[index]
                    }
            }
            
            ColorPicker("", selection: $data.color)
                .scaleEffect(1.7)
                .labelsHidden()
        }
    }
}

struct ChooseColorView_Previews: PreviewProvider {
    struct Preview: View {
        @State  private var data = Palette.sampleData[0].data
        
        var body: some View {
            ChooseColorView(data: $data)
        }
    }
    
    static var previews: some View {
        Preview()
    }
}
