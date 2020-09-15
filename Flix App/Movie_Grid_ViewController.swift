//
//  Movie_Grid_ViewController.swift
//  Flix App
//
//  Created by Eduardo Antonini on 9/14/20.
//  Copyright © 2020 Eduardo Antonini. All rights reserved.
//

import UIKit
import AlamofireImage

class Movie_Grid_ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var collection: UICollectionView!
    
    var movies = [[String : Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collection.delegate = self
        collection.dataSource = self
        
        let layout = collection.collectionViewLayout as! UICollectionViewFlowLayout
        
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let width = (view.frame.size.width - layout.minimumInteritemSpacing * 2)
        layout.itemSize = CGSize(width: width / 3, height: width / 2)
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        
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
                
                self.collection.reloadData()
            }
        }
        task.resume()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Movie_Grid_Cell", for: indexPath) as! Movie_Grid_Cell
        
        let movie = movies[indexPath.item]
        let baseURL = "https://image.tmdb.org/t/p/w185"
        let movie_art_url = URL(string: baseURL + (movie["poster_path"] as! String))
        
        cell.art_view.af.setImage(withURL: movie_art_url!)
        return cell
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UICollectionViewCell
        let indexPath = collection.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        
        let details_vc = segue.destination as! Movie_Details_ViewController
        details_vc.movie = movie
        
        // deselect selected cell
        collection.deselectItem(at: indexPath, animated: true)
    }
    
    // MARK: - Miscellaneous
    
    /*
     the two functions below are used to set the status bar elements, such as time and battery status,
     to a bright white color in order to better contrast with the dark navigation bar.
     
     referenced from: https://www.ioscreator.com/tutorials/change-color-status-bar-ios-tutorial
     */
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.navigationBar.barStyle = .black
    }
    
}
