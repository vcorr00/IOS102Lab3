//
//  PosterViewController.swift
//  lab-tunley
//
//  Created by Vladimir Corrales on 10/16/23.
//

import UIKit
import Nuke

class PosterViewController: UIViewController, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var moviePosters: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        fetchTracksFromAPI()
    }
    
    func fetchTracksFromAPI() {
        let headers = [
            "accept": "application/json",
            "Authorization": "Bearer YOUR_API_KEY"  // Consider securing this!
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
                    self.moviePosters = movies
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
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
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AlbumCell", for: indexPath) as! PosterViewCell
        
        // Make sure that movies array has data
        if indexPath.item < moviePosters.count {
            cell.configure(with: moviePosters[indexPath.item])
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return moviePosters.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if let cell = sender as? UICollectionViewCell,
              let indexPath = collectionView.indexPath(for: cell),
              let detailViewController = segue.destination as? DetailViewController {
               let movie = moviePosters[indexPath.item]
               detailViewController.track = movie
           }
       }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
