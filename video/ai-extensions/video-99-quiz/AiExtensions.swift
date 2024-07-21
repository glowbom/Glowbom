import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "San Francisco Quiz"

    @State private var currentQuestion = 0
    @State private var score = 0
    @State private var selectedAnswer: Int?
    @State private var showResult = false

    let questions = [
        QuizQuestion(text: "What is the famous cable car system in San Francisco called?",
                 options: ["Golden Gate Transit", "BART", "Muni", "CalTrain"],
                 correctAnswer: 2),
        QuizQuestion(text: "Which famous prison is located on an island in San Francisco Bay?",
                 options: ["San Quentin", "Folsom", "Alcatraz", "Rikers Island"],
                 correctAnswer: 2),
        QuizQuestion(text: "What is the name of San Francisco's Chinatown?",
                 options: ["Little Italy", "Japantown", "North Beach", "Chinatown"],
                 correctAnswer: 3)
    ]

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    if !showResult {
                        Text("San Francisco Quiz")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding(.bottom)

                        AsyncImage(url: URL(string: "https://picsum.photos/400/200?random=\(currentQuestion)")) { image in
                            image.resizable()
                        } placeholder: {
                            ProgressView()
                        }
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 200)
                        .cornerRadius(8)

                        Text(questions[currentQuestion].text)
                            .font(.headline)
                            .padding()

                        ForEach(0..<4) { index in
                            Button(action: {
                                selectedAnswer = index
                            }) {
                                Text(questions[currentQuestion].options[index])
                                    .padding()
                                    .frame(maxWidth: .infinity)
                                    .background(selectedAnswer == index ? Color.blue : Color.gray.opacity(0.2))
                                    .foregroundColor(selectedAnswer == index ? .white : .black)
                                    .cornerRadius(8)
                            }
                            .padding(.horizontal)
                        }

                        Button(action: checkAnswer) {
                            Text("Submit")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                        .disabled(selectedAnswer == nil)
                    } else {
                        Text("Quiz Completed!")
                            .font(.title)
                            .fontWeight(.bold)
                            .padding()

                        Text("You scored \(score) out of \(questions.count)!")
                            .font(.headline)
                            .padding()

                        Button(action: resetQuiz) {
                            Text("Restart Quiz")
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        .padding()
                    }
                }
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
    }

    func checkAnswer() {
        if let selectedAnswer = selectedAnswer {
            if selectedAnswer == questions[currentQuestion].correctAnswer {
                score += 1
            }
            if currentQuestion < questions.count - 1 {
                currentQuestion += 1
                self.selectedAnswer = nil
            } else {
                showResult = true
            }
        }
    }

    func resetQuiz() {
        currentQuestion = 0
        score = 0
        selectedAnswer = nil
        showResult = false
    }
}

struct QuizQuestion {
    let text: String
    let options: [String]
    let correctAnswer: Int
}