import UIKit
import RxSwift
import Logging

class EventDetailsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: EventDetailsViewModel?
    var logger: Logger?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = "Event details"
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
    
}


extension EventDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return ["Actor", "Repo", "Payload"][section]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Section 1 & 2 contain single data row, section 3 containts multiple data rowd depending on payload type
        return section == 2
            ? viewModel?.event.payload?.displayableParams.count ?? 1
            : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            // Actor cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "ActorCell", for: indexPath) as! ActorCell
            cell.actor = viewModel?.event.actor
            return cell
        case 1:
            // Repo cell
            let cell = tableView.dequeueReusableCell(withIdentifier: "RepoCell", for: indexPath) as! RepoCell
            cell.repo = viewModel?.event.repo
            return cell
        default:
            let cell = UITableViewCell(style: .value1, reuseIdentifier: "PayloadCell")
            if let eventType = viewModel?.event.type, eventType == .unknown {
                cell.textLabel?.text = "Event type not supported 🤷‍♂️"
            } else {
            // Payload cells
                if let params = viewModel?.event.payload?.displayableParams {
                    let key = Array(params.keys).sorted()[indexPath.row]
                    let value = params[key]!
                    cell.textLabel?.text = key
                    cell.detailTextLabel?.text = value
                    
                }
            }
            return cell
        }
        
    }
    
}

