//
//  BannerView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 01/10/20.
//

import SwiftUI

struct BannerView: View {
    @State var show: Bool = false
    
    var title: String = ""
    var image: String = ""
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 22, weight: .bold))
                .multilineTextAlignment(.center)
                .frame(height: 150)
                .padding([.horizontal,.top])
                .opacity(show ? 1.0 : 0.0)
                .minimumScaleFactor(0.5)
            
            Spacer()
            Image(image)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: screen.width - 40, height: screen.height/4, alignment: .center)
                .opacity(show ? 1 : 0.0)
                .padding(.bottom, 30)
            
            Spacer()
        }
        .padding()
        .frame(width: screen.width - 20, height: screen.height/2)
        .background(BlurView(style: .systemThinMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 35.0, style: .continuous))
        .shadow(color: Color.black.opacity(0.2), radius: 30, x: 0, y: 30)
        .scaleEffect(show ? 1 : 0.5)
        .animation(.spring(response: 0.5, dampingFraction: 0.6, blendDuration: 0.0))
        .onAppear {
            self.show = true
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.5 : 0))
        .edgesIgnoringSafeArea(.all)
        .animation(.linear(duration: 0.5))
    }
}

struct BannerView_Previews: PreviewProvider {
    static var previews: some View {
        BannerView()
    }
}
