import UIKit
import Alamofire
import AlamofireImage

class EventCell: UITableViewCell {
    
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var repoNameLabel: UILabel!
    @IBOutlet weak var repoUrlLabel: UILabel!
    
    var event: Event? {
        didSet {
            updateContent()
        }
    }
    
    func updateContent() {
        guard let event = event else {
            return
        }
        loginLabel.text     = event.actor.login
        repoNameLabel.text  = event.repo.name
        repoUrlLabel.text   = event.repo.url
        typeLabel.text      = event.rawType
        // Mark unsupported type
        typeLabel.textColor = event.type == .unknown ? .red : .darkGray
        
        self.actorImageView.image = nil
        Alamofire.request(event.actor.avatarUrl).responseImage { response in
            if let image = response.result.value {
                self.actorImageView.image = image
            }
        }
    }
    
    
}
