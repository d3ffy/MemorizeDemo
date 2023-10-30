import SwiftUI

struct ContentView: View {
    let BUTTON_WIDTH: CGFloat = 60
    let BUTTON_HEIGHT: CGFloat = 60
    @State var halloween_emojis = ["👻", "🎃", "🕷️", "💀", "🧙", "👿", "😱", "🍭"]
    @State var christmas_emojis = ["☃️", "🎅", "🦌", "🎄", "❄️", "🎁", "🌟", "👼"]
    @State var valentine_emojis = ["♥️", "🍫", "💐", "🧸", "👩‍❤️‍👨", "💘", "🌹", "🥰"]

    @State var selectedTheme: [String] = []
    @State var cardCount = 16


    var body: some View {
        VStack {
            Text("Memorize Game!")
                .font(.largeTitle)
                .bold()
                .padding(.top, 10)
                .foregroundColor(.blue)
                .padding(.bottom, 10)

            ScrollView {
                cards
            }
            themeSelectionButtons
            
        }.padding()
    }

    var cards: some View {
        LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
            ForEach(0..<cardCount, id: \.self) { index in
                CardView(content: selectedTheme.indices.contains(index) ? selectedTheme[index] : "")
                    .aspectRatio(2/3, contentMode: .fit)
            }
        }
        .foregroundColor(.cyan)
    }

    var themeSelectionButtons: some View {
        HStack {
            Button(action: {
                self.shuffleEmoji(for: halloween_emojis)
            }) {
                VStack {
                    Image(systemName: "star.fill")
                        .resizable()
                        .frame(width: BUTTON_WIDTH, height: BUTTON_HEIGHT)
                    Text("Halloween")
                }
            }

            Button(action: {
                self.shuffleEmoji(for: christmas_emojis)
            }) {
                VStack {
                    Image(systemName: "gift.fill")
                        .resizable()
                        .frame(width: BUTTON_WIDTH, height: BUTTON_HEIGHT)
                    Text("Christmas")
                }
            }

            Button(action: {
                self.shuffleEmoji(for: valentine_emojis)
            }) {
                VStack {
                    Image(systemName: "heart.fill")
                        .resizable()
                        .frame(width: BUTTON_WIDTH, height: BUTTON_HEIGHT)
                    Text("Valentine")
                }
            }
        }
        .padding(.horizontal, 50)
    }


    private func shuffleEmoji(for theme: [String]) {
        var shuffledTheme = theme.shuffled()
        while shuffledTheme.count < cardCount {
            shuffledTheme.append(contentsOf: theme.shuffled())
        }
        selectedTheme = Array(shuffledTheme.prefix(cardCount))
    }
}

struct CardView: View {
    let content: String
    @State var isFaceUp = false

    var body: some View {
        ZStack {
            let base = RoundedRectangle(cornerRadius: 12)
            if isFaceUp {
                base.foregroundColor(.white)
                base.strokeBorder(lineWidth: 2)
                Text(content).font(.title)
            } else {
                base
            }
        }
        .onTapGesture {
            isFaceUp.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
