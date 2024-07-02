import UIKit

class ViewController: UIViewController {
    @IBOutlet var storyLabel: UILabel!
    @IBOutlet var choice1Button: UIButton!
    @IBOutlet var choice2Button: UIButton!

    var storys = Storry()
    var tt = String()

    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
    }

    @IBAction func choiceMade(_ sender: UIButton) {
        if storys.rightButtonTitle() == sender.currentTitle! {
            storys.storyId += 1
            storys.storryIdChanger()
            
        } else {
            storys.storyId += 2
            storys.storryIdChanger()
            
        }

        updateUI()
    }

    func updateUI() {
        storyLabel.text = storys.getTitle()
        choice1Button.setTitle(storys.rightButtonTitle(), for: .normal)
        choice2Button.setTitle(storys.leftButtonTitle(), for: .normal)
    }
}
