//
//  SubjectView.swift
//  EduCloud
//
//  Created by Pratyush Sharma on 02/10/20.
//

import SwiftUI

struct SubjectView: View {
    @EnvironmentObject var user: User
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    private struct Style {
        static let shadowRadius: CGFloat = 20.0
        static let cornerRadius: CGFloat = 30.0
        static let subTextHeight: CGFloat = 100.0
        static let scrollViewVerticalPadding: CGFloat = 100.0
        static let scrollViewWidth: CGFloat = screen.width
        static let horizontalStackPadding: CGFloat = 30.0
        static let horizontalStackSpacing: CGFloat = 20.0
        static let scrollViewYOffset: CGFloat = 40.0
        static let scrollViewLeadingOffset: CGFloat = 16.0
    }
    
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            
            ZStack(alignment: .bottom) {
                Colors.Palette.maximumBlue.color
                    .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius, style: .continuous))
                    .edgesIgnoringSafeArea(.bottom)
                
                VStack {
                    VStack {
                        Text("Choose a Subject")
                            .foregroundColor(.primary)
                            .bold()
                            .font(.title)
                            .padding(.top, 20)
                        
                        Text("Scroll through the subjects and click on the one to study and continue")
                            .foregroundColor(.secondary)
                            .font(.caption)
                            .frame(width: screen.width - 100, height: Style.subTextHeight, alignment: .top)
                            .multilineTextAlignment(.center)
                    }
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: Style.horizontalStackSpacing) {
                            ForEach(subjects) { subject in
                                GeometryReader { geometry in
                                    SubjectRow(subject: subject)
                                        .rotation3DEffect(
                                            Angle(degrees: Double(geometry.frame(in: .global).minX - 30) / -20),
                                            axis: (x: 0.0, y: 1.0, z: 0.0)
                                        )
                                        .onTapGesture {
                                            self.user.chosenSubject = subject
                                            self.presentationMode.wrappedValue.dismiss()
                                           
                                        }
                                }
                                .frame(width: Style.scrollViewWidth, alignment: .top)
                            }
                        }
                        .padding(.horizontal, Style.horizontalStackPadding)
                    }
                    .offset(y: -Style.scrollViewYOffset)
                    
                    Image("pluto-class")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity)
                        .frame(height: screen.height/4)
                }
            }
        }
    }
}

struct SubjectRow: View {
    var subject: Subject.Subjects
    
    private struct Style {
        static let shadowRadius: CGFloat = 20.0
        static let cornerRadius: CGFloat = 30.0
    }
    
    var body: some View {
        VStack {
            Spacer()
            subject.image
                .resizable()
                .frame(width: screen.height/5, height: screen.height/5)
                .aspectRatio(contentMode: .fill)
            
            Text(subject.rawValue)
                .bold()
                .font(.title)
                .foregroundColor(.white)
                .padding()
        }
        .frame(width: screen.width - 80, height: screen.height/2 - 100)
        .background(subject.color)
        .clipShape(RoundedRectangle(cornerRadius: Style.cornerRadius, style: .continuous))
        .shadow(color: subject.color.opacity(0.7), radius: Style.shadowRadius, x: 0, y: Style.shadowRadius)
    }
}


struct SubjectView_Previews: PreviewProvider {
    static var previews: some View {
        SubjectView()
    }
}
