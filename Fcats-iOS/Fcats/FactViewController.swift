import UIKit

class FactViewController: UIViewController {
    
    @IBOutlet weak var factLabel: UILabel!
    
    var facts: [String]!
    
    override func viewDidLoad() {
        randomFact()
    }
    
    @IBAction func randomFact() {
        if !facts.isEmpty {
            let index = Int(arc4random_uniform(UInt32(facts.count)))
            factLabel.text = facts[index]
        } else {
            factLabel.text = "Little is known about these cats."
        }
    }
}
