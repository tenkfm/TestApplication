import UIKit
import RxSwift
import Logging
import ESPullToRefresh

class EventsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var viewModel: EventsViewModel?
    var logger: Logger?
    let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        _ = loadData()?.subscribe()
        
        tableView.es.addPullToRefresh {
            _ = self.loadData()?.subscribe({ (_) in
                self.tableView.es.stopPullToRefresh()
            })
        }
    }
    
    func loadData() -> Completable? {
        title = "Please wait, I do my best..."
        return viewModel?.fetchEvents().do(onError: { (error) in
            self.logger?.error("Ooops: \(error.localizedDescription)")
            
            let alert = UIAlertController(title: "Ooops", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            self.title = "Events"
        }, onCompleted: {
            self.tableView.reloadData()
            self.title = "Events"
        })
    }
    
    @IBAction func actionFilter(_ sender: Any) {
        let alert = UIAlertController(title: "Filter", message: "It was too lazy day to make a full filter 🥴", preferredStyle: .actionSheet)
        
        EventType.allCases.forEach({ (type) in
            let name = type.rawValue
            alert.addAction(UIAlertAction(title: name, style: .default, handler: { (_) in
                self.viewModel?.filter(type: type)
                self.tableView.reloadData()
            }))
        })
        
        alert.addAction(UIAlertAction(title: "Remove", style: .destructive, handler: { (_) in
            self.viewModel?.filter(type: nil)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}


extension EventsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.filteredEvents?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell", for: indexPath) as! EventCell
        let event = viewModel?.filteredEvents?[indexPath.row]
        cell.event = event
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let viewModel = viewModel,
            let event = viewModel.filteredEvents?[indexPath.row] else {
                return
        }
        let detailsViewController = Injection.shared.getEventDetailsView(event: event)
        show(detailsViewController, sender: nil)
    }    
    
}

