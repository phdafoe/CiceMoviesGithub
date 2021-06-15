//
//  WalkthroughView.swift
//  CiceMovies
//
//  Created by cice on 15/06/2021.
//

import SwiftUI

var totalPages = 3

struct WalkthroughView: View {
    
    @AppStorage("currentPage") var currentPage = 1
    
    var body: some View {
        ZStack{
            if currentPage == 1{
                ScreenView(image: "lottie1", title: "Paso 1", detail: "Bienvenidos al Curso de SwiftUI + Combine y programación reactiva", bgColor: Color.white).transition(.scale)
            }
            if currentPage == 2{
                ScreenView(image: "lottie2", title: "Paso 2", detail: "Bienvenidos al Curso de SwiftUI + Combine y programación", bgColor: Color.red).transition(.scale)
            }
            if currentPage == 3{
                ScreenView(image: "lottie3", title: "Paso 3", detail: "Bienvenidos al Curso de SwiftUI + Combine", bgColor: Color.blue).transition(.scale)
            }
        }
        .overlay(
            Button(action: {
                //Aqui cambio la pagina actual
                withAnimation(.easeInOut) {
                    if currentPage <= totalPages {
                        currentPage += 1
                    } else {
                        currentPage = 1
                    }
                }
            }, label: {
                Image(systemName: "chevron.right").font(.system(size: 20, weight: .semibold)).foregroundColor(.black).frame(width: 30, height: 30)
                    .background(Color.gray)
                    .clipShape(Circle())
                    .overlay(
                        ZStack{
                            Circle().stroke(Color.black.opacity(0.2), lineWidth: 2)
                            Circle().trim(from: 0, to: CGFloat(currentPage) / CGFloat(totalPages)).stroke(Color.black, lineWidth: 3).rotationEffect(.degrees(-90))
                        }
                        .padding(-15)
                    )
            })
            .padding(.bottom, 20), alignment: .bottom
        )
    }
}

struct ScreenView: View {
    
    var image: String
    var title: String
    var detail: String
    var bgColor: Color
    
    @AppStorage("currentPage") var currrentPage = 1
    
    var body: some View {
        VStack(spacing: 20){
            HStack{
                //se muestra si solo es la primera pagina
                if currrentPage == 1 {
                    Text("Bienvenidos Cice Movies")
                        .font(.title)
                        .fontWeight(.semibold)
                        .kerning(1.4)
                } else {
                    Button(action: {
                        withAnimation(.easeInOut){
                            currrentPage -= 1
                        }
                    }, label: {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.black)
                            .padding(.vertical, 10)
                            .padding(.horizontal)
                            .background(Color.black.opacity(0.2))
                            .clipShape(Circle())
                    })
                }
                
                Spacer()
                
                Button(action: {
                    withAnimation(.easeInOut){
                        currrentPage = 4
                    }
                }, label: {
                    Text("Skip")
                        .fontWeight(.semibold)
                        .kerning(1.4)
                })
            }
            .foregroundColor(.black)
            .padding()
            
            Spacer()
            
            Image(image).resizable().aspectRatio(contentMode: .fit)
            Text(title).font(.title).fontWeight(.bold).foregroundColor(.black).padding(.top)
            Text(detail).fontWeight(.semibold).kerning(1.4).multilineTextAlignment(.center)
            
            Spacer(minLength: 120)
        }
        .background(bgColor.ignoresSafeArea())
    }
}


struct WalkthroughView_Previews: PreviewProvider {
    static var previews: some View {
        WalkthroughView()
        //ScreenView(image: "lottie1", title: "Bienvenidos", detail: "Bienvenidos al Curso de SwiftUI + Combine y programación reactiva", bgColor: Color.white)
    }
}
