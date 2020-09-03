//
//  Movies_View_Controller.swift
//  Flix App
//
//  Created by Eduardo Antonini on 9/1/20.
//  Copyright © 2020 Eduardo Antonini. All rights reserved.
//

import UIKit
import AlamofireImage

class Movies_View_Controller: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table_view: UITableView!

    // list of dictionaries where keys are strings, values are of any type
    var movies = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        table_view.delegate = self
        table_view.dataSource = self
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data {
              let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

            // TODO: Get the array of movies
            self.movies = dataDictionary["results"] as! [[String: Any]]
            
            // TODO: Store the movies in a property to use elsewhere
              
            // TODO: Reload your table view data
            self.table_view.reloadData()
            
           }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Movie_Cell") as! Movie_Cell
        let movie = movies[indexPath.row]
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let movie_art_url = URL(string: baseURL + (movie["poster_path"] as! String))
        
        cell.title_label.text = movie["title"] as? String
        cell.synopsis_label.text = movie["overview"] as? String
        cell.movie_art.af_setImage(withURL: movie_art_url!)
        
        return cell
    }

}
