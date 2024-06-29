import AVFoundation
import UIKit

class ViewController: UIViewController {
    var player: AVAudioPlayer!

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func keyPressed(_ sender: UIButton) {
        let optionalString: String? = sender.currentTitle

        if let titleName = optionalString {
            playSound(titleName)
        } else {
            print("no such title in button")
        }

        // Устанавливаем начальную прозрачность перед анимацией
        sender.alpha = 0.5

        // Анимация изменения прозрачности с продолжительностью 0.2 секунды
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            // Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0
        }
    }

    func playSound(_ soundName: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: "wav")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
