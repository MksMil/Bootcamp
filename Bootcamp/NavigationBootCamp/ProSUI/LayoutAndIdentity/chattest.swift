//
//  chattest.swift
//  Bootcamp
//
//  Created by Миляев Максим on 12.03.2024.
//

import SwiftUI

struct GetMessageItemView: View {
    
    var message:String
    var currentUserMessage:Bool
    var lastMessage:Bool
    
    var body: some View {
        
        VStack{
            HStack{
                if currentUserMessage{Spacer()}
                VStack(alignment: .trailing){
                    VStack{
                        Text(message)
                            .font(.system(size: 14))
                            .foregroundColor( Color.black)
                            .padding(.top)
                            .frame(minWidth: 50,alignment: .leading)
                    }
                    VStack{
                        Text("10:30 AM")
                            .foregroundColor(.white)
                            .font(.system(size: 12))
                            .padding(.top,1)
                            .padding(.bottom)
                    }
                    
                }
                .padding(.horizontal, 10)
                .background(Color.orange)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .overlay{
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.black,lineWidth: currentUserMessage ? 0:2)
                }
                if !currentUserMessage{Spacer()}
            }
        }
            .padding(.horizontal)
            .padding(currentUserMessage ? .leading: .trailing, 75)
            
    }
}

struct TF: View{
    
    @State var message: String = ""
    
    var body: some View{
        TextField("sfdsfsdfds", text: $message, axis: .vertical)
//            .frame(width: 100)
            .padding()
            .background {
                RoundedRectangle(cornerRadius: 8).fill(.orange)
            }
            .frame(width: 300, alignment: .leading)
    }
}

struct chattest: View {
    
    let messages:[GetMessageItemView] = [GetMessageItemView(message: "sdsdasdassdadsadsadsadasdasdsadsadsadasdasdasdasdsadasdasdasddasda", currentUserMessage: true, lastMessage: true),
                                         GetMessageItemView(message: "sdsdasdassdadsadsadsadasdasdsadsadsadasdasdasdasdsadasdasdasddasdasdsadsadsadasdasdsadsdasdasdsadasdsadasdasdsadasdsadasdsadasdsadasdasdasdsadsadasdsadasdasdasdasdasdasd", currentUserMessage: false, lastMessage: true),
                                         GetMessageItemView(message: "sdd", currentUserMessage: false, lastMessage: true),
                                         GetMessageItemView(message: "sdsdasdassdadsa", currentUserMessage: true, lastMessage: true),
                                         GetMessageItemView(message: "sdsdasdassdadsadsadsadasdasdsadsadsadasdasdasdasdsadasdasdasddasdasdsadsadsadasdasdsadsdasdasdsadasdsadasdasdsadasdsadasdsadasdsadasdasdasdsadsadasdsadasdasdasdasdasdasd", currentUserMessage: false, lastMessage: true)]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10 ){
                ForEach(messages.indices, id: \.self) { ind in
                    messages[ind]
                }
            }
        }
    }
}

#Preview {
    VStack{
        chattest()
        TF()
    }
//    GetMessageItemView(message: "sdd", currentUserMessage: false, lastMessage: true)
//    GetMessageItemView(message: "sdsdasdassdadsadsadsadasdasdsadsadsadasdasdasdasdsadasdasdasddasdasdsadsadsadasdasdsadsdasdasdsadasdsadasdasdsadasdsadasdsadasdsadasdasdasdsadsadasdsadasdasdasdasdasdasdлопоппмрпмрпрасрсрасрсрсрпрпомрпсрсасрпспрмпрсрпсрасапсрсрсрсрсрсрасар", currentUserMessage: true, lastMessage: true)
}
