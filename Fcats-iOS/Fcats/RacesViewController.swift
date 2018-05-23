import UIKit

class RacesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private let kitura = KituraService()
    
    private var races: [Race] = []
    
    override func viewDidLoad() {
        kitura.getRaces(from: 0, limitedTo: 10) {
            races in
            self.races = races
            self.tableView.reloadData()
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let fvc = segue.destination as! FactViewController
        let race = races[tableView.indexPathForSelectedRow!.row]
        fvc.facts = race.facts
        tableView.deselectRow(at: tableView.indexPathForSelectedRow!, animated: true)
    }
}

extension RacesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return races.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "raceCell", for: indexPath)
        let race = races[indexPath.row]
        cell.textLabel?.text = race.name
        if let imageURL = URL(string: kitura.url + "/public/img/\(race.image)"),
           let data = try? Data(contentsOf: imageURL) {
            cell.imageView?.image = UIImage(data: data)
        }
        return cell
    }
}
