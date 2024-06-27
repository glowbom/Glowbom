import SwiftUI

struct GlowbyScreen: View {
    static let enabled = true
    static let title = "Messenger"

    @State private var messages: [Message] = [Message(text: "Welcome to the messenger app!", sent: false)]
    @State private var newMessage: String = ""
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?

    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                VStack {
                    ScrollView {
                        LazyVStack(spacing: 10) {
                            ForEach(messages) { message in
                                MessageBubble(message: message)
                            }
                        }
                        .padding()
                    }
                    .frame(maxWidth: 360, maxHeight: .infinity)

                    HStack {
                        TextField("Start a new message", text: $newMessage)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                        
                        Button(action: {
                            showingImagePicker = true
                        }) {
                            Image(systemName: "photo")
                        }
                        
                        Button(action: sendMessage) {
                            Text("Send")
                        }
                    }
                    .padding()
                }
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .frame(maxWidth: 360)
                Spacer()
            }
            Spacer()
        }
        .sheet(isPresented: $showingImagePicker, onDismiss: loadImage) {
            ImagePicker(image: $inputImage)
        }
    }

    func sendMessage() {
        if !newMessage.isEmpty {
            messages.append(Message(text: newMessage, sent: true))
            newMessage = ""
            simulateBotResponse()
        }
    }

    func loadImage() {
        guard let inputImage = inputImage else { return }
        messages.append(Message(image: inputImage, sent: true))
        simulateBotResponse()
    }

    func simulateBotResponse() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            let responses = [
                "That's interesting! Tell me more.",
                "I see. How does that make you feel?",
                "Fascinating! What led you to that conclusion?",
                "I understand. What do you think about that?",
                "Interesting perspective. Can you elaborate?"
            ]
            let randomResponse = responses.randomElement() ?? "Interesting!"
            messages.append(Message(text: randomResponse, sent: false))
        }
    }
}

struct Message: Identifiable {
    let id = UUID()
    let text: String?
    let image: UIImage?
    let sent: Bool
    let timestamp = Date()

    init(text: String? = nil, image: UIImage? = nil, sent: Bool) {
        self.text = text
        self.image = image
        self.sent = sent
    }
}

struct MessageBubble: View {
    let message: Message

    var body: some View {
        HStack {
            if message.sent { Spacer() }
            VStack(alignment: message.sent ? .trailing : .leading) {
                if let text = message.text {
                    Text(text)
                        .padding(10)
                        .background(message.sent ? Color.blue : Color.gray.opacity(0.2))
                        .foregroundColor(message.sent ? .white : .black)
                        .cornerRadius(10)
                }
                if let image = message.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxWidth: 200, maxHeight: 200)
                        .cornerRadius(10)
                }
                Text(message.timestamp, style: .time)
                    .font(.caption2)
                    .foregroundColor(.gray)
            }
            if !message.sent { Spacer() }
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}