import UIKit
import Alamofire
import AlamofireImage

class ActorCell: UITableViewCell {

    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var displayLoginLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    var actor: Actor? {
        didSet {
            updateContent()
        }
    }
    
    func updateContent() {
        guard let actor = actor else {
            return
        }
        idLabel.text            = String(format: "ID: %d", actor.id)
        loginLabel.text         = String(format: "Login: %@", actor.login)
        displayLoginLabel.text  = String(format: "Display login: %@", actor.displayLogin)
        urlLabel.text           = String(format: "URL: %@", actor.url)

        Alamofire.request(actor.avatarUrl).responseImage { response in
            if let image = response.result.value {
                self.avatarImageView.image = image
            }
        }
    }
    
    
}
