//
//  Movie_Details_ViewController.swift
//  Flix App
//
//  Created by Eduardo Antonini on 9/14/20.
//  Copyright © 2020 Eduardo Antonini. All rights reserved.
//

import UIKit
import AlamofireImage

class Movie_Details_ViewController: UIViewController {
    
    @IBOutlet weak var big_art: UIImageView!
    @IBOutlet weak var small_art: UIImageView!
    @IBOutlet weak var title_label: UILabel!
    @IBOutlet weak var synopsis_label: UILabel!
    
    // dictionary of string-keys, with any-types
    var movie: [String : Any]!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let movie_art_url = URL(string: "https://image.tmdb.org/t/p/w185" + (movie["poster_path"] as! String))
        let big_art_url = URL(string: "https://image.tmdb.org/t/p/w780" + (movie["backdrop_path"] as! String))
        
        title_label.text = movie["title"] as? String
        title_label.sizeToFit()
        synopsis_label.text = movie["overview"] as? String
        synopsis_label.sizeToFit()
        small_art.af_setImage(withURL: movie_art_url!)
        big_art.af_setImage(withURL: big_art_url!)
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
