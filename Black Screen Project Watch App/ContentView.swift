import SwiftUI

struct ContentView: View {
    @State private var currentTime: String = ""
    @State private var currentDate: String = ""
    @State private var textColor: Color = .black
    @State private var timer: Timer?
    @State private var colorResetTimer: Timer?
    
    var body: some View {
        ZStack {
            // Full-screen black background
            Color.black
                .ignoresSafeArea()
            
            // Centered VStack for time and date labels
            VStack(spacing: 10) {
                // Time label in big font
                Text(currentTime)
                    .font(.system(size: 60, weight: .bold, design: .monospaced))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
                // Date label in smaller font
                Text(currentDate)
                    .font(.system(size: 24, weight: .regular, design: .monospaced))
                    .lineLimit(1)
                    .minimumScaleFactor(0.5)
            }
            // Initially, text is black (invisible on the black background)
            .foregroundColor(textColor)
            // Expand to fill the screen
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        // Gesture to detect a long press (1 second)
        .gesture(
            LongPressGesture(minimumDuration: 0.8)
                .onEnded { _ in
                    // Change text color to white so they become visible
                    textColor = .white
                    // Invalidate any previous timer for resetting the color
                    colorResetTimer?.invalidate()
                    // After 10 seconds, revert text color back to black
                    colorResetTimer = Timer.scheduledTimer(withTimeInterval: 7, repeats: false) { _ in
                        textColor = .black
                    }
                }
        )
        // Start the timer when the view appears
        .onAppear(perform: startTimer)
        // Invalidate timers when the view disappears (user exits)
        .onDisappear(perform: stopTimers)
    }
    
    /// Starts a timer that updates the time and date every 60 seconds.
    func startTimer() {
        updateTimeAndDate() // Update immediately on appear
        timer = Timer.scheduledTimer(withTimeInterval: 60, repeats: true) { _ in
            updateTimeAndDate()
        }
    }
    
    /// Stops both the update timer and the color reset timer.
    func stopTimers() {
        timer?.invalidate()
        colorResetTimer?.invalidate()
    }
    
    /// Updates the current time and date strings.
    func updateTimeAndDate() {
        let now = Date()
        let timeFormatter = DateFormatter()
        timeFormatter.dateFormat = "HH:mm"
        currentTime = timeFormatter.string(from: now)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        currentDate = dateFormatter.string(from: now)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
