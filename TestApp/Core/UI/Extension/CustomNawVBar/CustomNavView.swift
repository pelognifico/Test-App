//
//  CustomNavView.swift
//  TestApp
//
//  Created by Carlos Villamizar on 1/31/23.
//

import SwiftUI

struct CustomNavView<Content:View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    var body: some View {
        NavigationView {
            CustomNavBarContainerView {
                content
            }.navigationBarBackButtonHidden(true)
        }
    }
}

struct CustomNavView_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavView {
            Color.white
        }
    }
}
