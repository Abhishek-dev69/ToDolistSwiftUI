//
//  HeaderView.swift
//  ToDolistSwiftUI
//
//  Created by Abhishek on 02/11/25.
//

import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    let angle: Double
    let background: Color
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                RoundedRectangle(cornerRadius: 0)
                    .foregroundColor(background)
                    .frame(width: geometry.size.width * 3, height: 350)
                    .rotationEffect(Angle(degrees: angle))
                    .ignoresSafeArea()
                
                VStack {
                    Text(title)
                        .font(.system(size: 50))
                        .foregroundColor(.white)
                        .bold()
                    
                    Text(subtitle)
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                }
                .padding(.top, 50)
            }
            .frame(width: geometry.size.width, height:300)
            .offset(y:-150)
        }
    }
}
    
    
struct HeaderView_Previews: PreviewProvider {
        static var previews: some View {
        HeaderView(
            title: "Title",
            subtitle: "Subtitle",
            angle: 15,
            background: .blue)
    }
}
