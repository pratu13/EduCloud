//
//  AlertView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 07/10/20.
//

import SwiftUI

struct AlertView: View {
    @Binding var show: Bool
    var status: Onboarding.Status
    
    var body: some View {
        VStack {
            Text(status.alertTitle)
                .font(.title)
                .bold()
                .opacity(show ? 1.0 : 0.0)
                .scaleEffect(show ? 1.0 : 0.0)
                .padding()
            
            status.image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(maxWidth: .infinity, maxHeight: screen.height/4)
                .opacity(show ? 1.0 : 0.0)
                .scaleEffect(show ? 1.0 : 0.0)
                
            
            Text(status.alertSubtitle)
                .font(.title3)
                .bold()
                .opacity(show ? 1.0 : 0.0)
                .scaleEffect(show ? 1.0 : 0.0)
                .multilineTextAlignment(.center)
                .padding(.horizontal)
                .padding()
        }
        .frame(maxWidth: .infinity)
        .background(BlurView(style: .systemThinMaterial))
        .clipShape(RoundedRectangle(cornerRadius: 30.0, style: .continuous))
        .shadow(color: Color.black.opacity(0.4), radius: 20.0, x: 0, y: 20.0)
        .opacity(show ? 1.0 : 0.0)
        .scaleEffect(show ? 1.0 : 0.0)
        .padding()
        .animation(Animation.spring(response: 0.7, dampingFraction: 0.6, blendDuration: 0.0))
        .onAppear {
            self.show = true
        }
        .frame(maxWidth:.infinity, maxHeight: .infinity)
        .background(Color.black.opacity(show ? 0.5 : 0))
        .animation(.linear(duration: 0.5))
        .edgesIgnoringSafeArea(.all)
        
    }
}

struct AlertView_Previews: PreviewProvider {
    static var previews: some View {
        AlertView(show: .constant(false), status: .failure(""))
    }
}
