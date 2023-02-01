//
//  SplashScreenView.swift
//  TestApp
//
//  Created by Carlos Villamizar on 2/1/23.
//

import SwiftUI


import SwiftUI

struct SplashScreen: View {
    @State var isActive = false
    @State var size = 0.8
    @State var opacity = 0.5
    
    var body: some View {
        
        if isActive == true  {
            CharactersMainView()
            
        }else {
            
            ZStack {
                Image("background")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 100.0) {
                  
                    Image("logo.rick")
                        .resizable().padding(0.4)
                        .frame(width: 180, height: 180).background(Color.gray)
                        .clipShape(Circle()).overlay(Circle().stroke(Color.blue, lineWidth: 1)).shadow(color: Color.gray,radius: 5)
                    
                    ZStack {
                        Text("Rick y Morty")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black.opacity(0.80)).glowBorder(color: .green, lineWidth: 3)
                        
                    }.padding(-90)
                  
                        
                }
                
                  .scaleEffect(size)
                  .opacity(opacity)
                  .onAppear {
                      withAnimation(.easeIn(duration: 1.2),{
                          self.size = 0.9
                          self.opacity = 1.0
                    })
                }
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    self.isActive = true
                }
            }
        }
    }
}

struct LaunchScreen_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreen()
    }
}

