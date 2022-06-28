//
//  MainView.swift
//  Chuck Norris jokes
//
//  Created by Radwan Alfakseh on 20/06/2022.
//
import Foundation
import SwiftUI

class JokeViewModel: ObservableObject{
    @Published var joke: Joke?
    init(){
        fetchRandomJoke()
    }
    func fetchRandomJoke(){
        guard let url = URL(string: "https://api.chucknorris.io/jokes/random") else{return}
        fetchAsync(fromUrl: url){ (returnedData) in
            if let data = returnedData{
                guard let newjoke = try? JSONDecoder().decode(Joke.self, from: data) else{return}
                DispatchQueue.main.async {[weak self] in
                    self?.joke = newjoke
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
struct MainView: View {
    @State var backgroundColor:Color = Color.yellow
    @State var Animated : Bool = false
    @StateObject var jokeViewModel = JokeViewModel()
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()

            //contentLayer
            VStack {
                Text(jokeViewModel.joke?.value ?? "")
                    .font(.largeTitle)
                    .foregroundColor(RandomColor())
                    .padding()
                Spacer()
                Button {
                    jokeViewModel.fetchRandomJoke()
                    withAnimation(Animation.default.repeatCount(1, autoreverses: false)) {
                        Animated.toggle()
                    }
                     
                } label: {
                    VStack(spacing: 10) {
                    
                        Image("Image")
                        .rotationEffect(Angle(degrees: Animated ? 360 : 0))
                    }
                }
            }
            }
        }
    

    func RandomColor() -> Color {
        return Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1))
    }
}
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
