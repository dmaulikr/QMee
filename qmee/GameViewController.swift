import UIKit

class GameViewController : UIViewController
{
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var pointLabel: UILabel!
    @IBOutlet weak var questionImageView: UIImageView!
    @IBOutlet weak var questionLabel: UILabel!
    
    var game: QMeeGame = QMeeGame()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pointLabel.text = "--"
        let starterImage = UIImage(named: "2")
        questionImageView.image = starterImage
        questionLabel.text = "Tap the true button to start a new game!"
        
        // disable the false button when the game just started
        falseButton.isEnabled = false
    }
    
    @IBAction func trueButtonDidTap(_ sender: AnyObject)
    {
        if pointLabel.text == "--" {
            // this is when the game just starts!
            game.point = 0
            falseButton.isEnabled = true
        } else {
            game.point += 1
        }
        
        updateGame()
    }
    
    @IBAction func falseButtonDidTap(_ sender: AnyObject)
    {
        game.point -= 1
        updateGame()
    }
    
    func updateGame() {
        let nextQuestion = game.getNextQuestion()
        let questionImage = game.getQuestionImageName()
        let image = UIImage(named: questionImage)
        
        questionImageView.image = image
        questionLabel.text = nextQuestion
        pointLabel.text = "\(game.point)"
    }
}














