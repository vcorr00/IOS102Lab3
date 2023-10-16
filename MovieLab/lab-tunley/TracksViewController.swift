//
//  ViewController.swift
//  lab-tunley
//
//  Created by Charlie Hieger on 12/1/22.
//
import UIKit

class TracksViewController: UIViewController, UITableViewDataSource {
    var tracks: [Movie] = []
    @IBOutlet var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        fetchTracksFromAPI()
    }

    func fetchTracksFromAPI() {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIxYTAzY2I3NzgwYjczYmQxYjMzM2JlZjRhNWJlNDI1NyIsInN1YiI6IjY1MjMzYzE3MGNiMzM1MTZmODdlZDAyZiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.jTHCsDKaCp_kwNbzFFizbq52pUtVvA8KG3LaMEJDJqc"
        ]

        let url = URL(string: "https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.allHTTPHeaderFields = headers

        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                return
            }

            if let data = data {
                if let movies = self.decodeJSONData(data: data) {
                    self.tracks = movies
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                } else {
                    print("Failed to decode JSON data.")
                }
            }
        }

        dataTask.resume()
    }
    func decodeJSONData(data: Data) -> [Movie]? {
        do {
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            return movieResponse.results
        } catch {
            print("Error decoding JSON data: \(error)")
            return nil
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackCell", for: indexPath) as! TrackCell
        let track = tracks[indexPath.row]
        cell.configure(with: track)
        return cell
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cell = sender as? UITableViewCell,
           let indexPath = tableView.indexPath(for: cell),
           let detailViewController = segue.destination as? DetailViewController {
            let track = tracks[indexPath.row]
            detailViewController.track = track
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}
