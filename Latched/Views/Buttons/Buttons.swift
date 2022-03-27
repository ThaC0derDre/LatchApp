//
//  Buttons.swift
//  Latched
//
//  Created by Andres Gutierrez on 3/27/22.
//

import SwiftUI

struct UnanimatedButton: View {
    var body: some View {
        Button(""){}
        .padding(65)
        .background(.green)
        .foregroundColor(.white)
        .clipShape(Circle())
    }
}

struct AnimatedButton: View{
    @State private var aanimationNumb = 1.0
    
    var body: some View {
        Button("") {}
        .padding(65)
        .background(.red)
        .foregroundColor(.white)
        .clipShape(Circle())
        // add overlay effect.
        .overlay(
            Circle()
                .stroke(.blue)
                .scaleEffect(aanimationNumb)
                .opacity(2 - aanimationNumb)
                .animation(.easeInOut(duration: 1).repeatForever(autoreverses: false), value: aanimationNumb)
            )
        // use on appear to trigger effect
        .onAppear {
            aanimationNumb += 1
        }
        .onDisappear {
            aanimationNumb = 1.0
        }
    }
        
}




struct UnanimatedButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack{
            UnanimatedButton()
            AnimatedButton()
        }
    }
}
