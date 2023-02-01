//
//  CustomNavBarView.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import SwiftUI


struct CustomNavBarView: View {
    @State var showBackButton: Bool = true
    @State var title: String = "Title"
    @State var subTitle: String? = "SubTitle"
    
    var body: some View {
        HStack {
            Spacer()
            titleSection
            Spacer()
        }.font(.headline).background(Color.init(red: 92/255, green: 4/255, blue: 22/255).ignoresSafeArea(edges: .top))
    }
}

struct CustomNavBarView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            CustomNavBarView()
            Spacer()
        }
    }
}

extension CustomNavBarView {
    var titleSection: some View {
        VStack(spacing: 2){
            Image("logo.rick")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 50, height: 50).padding(.trailing )
            Text("Rick & Morty").foregroundColor(Color.white).frame(width: 200, height: 30).font(.title)
                .fontWeight(.bold).glowBorder(color: .black, lineWidth: 6)
        }
    }
}
