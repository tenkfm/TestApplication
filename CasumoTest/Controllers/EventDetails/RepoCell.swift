import UIKit

class RepoCell: UITableViewCell {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    
    
    var repo: Repo? {
        didSet {
            updateContent()
        }
    }
    
    
    
    func updateContent() {
        guard let repo = repo else {
            return
        }
        
        idLabel.text    = String(format: "ID: %d", repo.id)
        nameLabel.text  = String(format: "Name: %@", repo.name)
        urlLabel.text   = String(format: "URL: %@", repo.url)
    }
    
    
}
