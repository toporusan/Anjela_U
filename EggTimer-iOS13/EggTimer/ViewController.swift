
import AVFoundation
import UIKit

class ViewController: UIViewController {
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var progressBar: UIProgressView!
    var player: AVAudioPlayer!

    let eggTimes = ["Soft": 5, "Medium": 4, "Hard": 5]
    var timer: Timer?

    var totalTime = 0
    var secondPassed = 0

    @IBAction func hardnessSelected(_ sender: UIButton) {
        if let hardness = sender.currentTitle {
            if let eggTime = eggTimes[hardness] {
                totalTime = eggTime * 1
                titleLabel.text = "\(hardness) - \(eggTime) мин таймер был запущен!"
                timer?.invalidate() // Останавливаем предыдущий таймер, если он существует
                secondPassed = 0
                progressBar.progress = 0.0

                // Запускаем новый таймер
                timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                    if self.totalTime > self.secondPassed {
                        self.secondPassed += 1

                        let percentageProgress = Float(self.secondPassed) / Float(self.totalTime)
                        self.progressBar.progress = percentageProgress

                    } else {
                        self.playSound(soundName: "alarm_sound", soundExtention: "mp3")
                        timer.invalidate()
                        print("Таймер завершен!")
                        self.progressBar.progress = 0.0
                        self.titleLabel.text = "Варка яиц завершена!"
                    }
                }
            } else {
                print("Значение не найдено в eggTimes для ключа: \(hardness)")
            }
        } else {
            print("Ошибка: sender.currentTitle равно nil")
        }
    }

    func playSound(soundName: String, soundExtention: String) {
        let url = Bundle.main.url(forResource: soundName, withExtension: soundExtention)
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
