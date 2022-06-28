//
//  JokesCatagories.swift
//  Chuck Norris jokes
//
//  Created by Radwan Alfakseh on 20/06/2022.
//

import SwiftUI
import Foundation
class CatagoriesViewModel: ObservableObject{
    @Published var catagories: [String] = []
    init(){
        fetchJokesCatagoreis()
    }
    func fetchJokesCatagoreis(){
        guard let url = URL(string: "https://api.chucknorris.io/jokes/categories") else{return}
        fetchAsync(fromUrl: url){ (returnedData) in
            if let data = returnedData{
                guard let catagories = try? JSONDecoder().decode([String].self, from: data) else{return}
                DispatchQueue.main.async {[weak self] in
                    self?.catagories.append(contentsOf: catagories)
                }
            }
            else{
            print("No Data")
        }
    }
}

func fetchAsync(fromUrl url: URL, completionHandler: @escaping(_ data : Data?)-> ()){
    let datatask = URLSession.shared.dataTask(with: url) { data, responce, error in
        guard let data = data, error == nil ,
        let responce = responce as? HTTPURLResponse
        ,responce.statusCode >= 200 && responce.statusCode < 300 else {
            print("error")
            completionHandler(nil)
            return
        }
      completionHandler(data)
    }
    datatask.resume()
}
}
struct JokesCatagories: View {
    @StateObject var vm = CatagoriesViewModel()
    @State var selection: String = "food"
    var body: some View {
        ZStack {
            Color.white.ignoresSafeArea()
            VStack {
                    Picker(selection: $selection, content: {
                        ForEach(vm.catagories, id: \.self){ catagory in
                        Text(catagory).tag(catagory)
                    }
                    },label: {
                        HStack(spacing:10){
                            Text("Catagory:")
                            Text(selection)
                    }.font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .padding(.horizontal)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 10)
                .frame(maxWidth:.infinity)
                    }).pickerStyle(MenuPickerStyle())
                
                    GifImage("download").frame(width: 50, height: 50)
            }
        }
    }
}

struct JokesCatagories_Previews: PreviewProvider {
    static var previews: some View {
        JokesCatagories()
    }
}
