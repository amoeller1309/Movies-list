//
//  ViewController.swift
//  Movies
//
//  Created by period6 on 3/4/21.
//  Copyright © 2021 period6. All rights reserved.
//

import UIKit
import SafariServices

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var moviesTabelView: UITableView!
    
    var movies = ["Reservoir Dogs", "Ferris Bueler's Day Off", "Step Brothers", "Django Unchained", "Curious George", "Hateful 8", "Good Fellas"]

    var stars = ["4 Stars", "3 Stars", "2 Stars", "4 Stars", "3 Stars", "4 Stars", "4 Stars"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let url = URL(string: "https://www.rottentomatoes.com/m/" + movies[indexPath.row])
    let config = SFSafariViewController.Configuration()
        config.entersReaderIfAvailable = true
        
        
        
        let searchString = " "
        let replaceString = "_"
        
        var replaceOccurences = movies[indexPath.row].replacingOccurrences(of: searchString, with: replaceString).lowercased()
        let newURL = URL(string: "https://www.rottentomatoes.com/m/" + replaceOccurences)
        let nvc = SFSafariViewController(url: newURL!, configuration: config)
        print(newURL)
        
    present(nvc, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
       
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell")
        cell?.textLabel?.text = movies[indexPath.row]
        cell?.detailTextLabel?.text = stars[indexPath.row]
        return cell!
    }
    @IBAction func addMovie(_ sender: UIBarButtonItem) {
        addMovie()
    }
    func addMovie(){
        let addMovie = UIAlertController(title: "Add a Movie and Stars", message: nil, preferredStyle: .alert)

        addMovie.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak addMovie] (_) in
        let moviesTF = addMovie?.textFields?.first?.text
            let starsTF = (addMovie?.textFields?.last?.text)! + " Stars"
        self.movies.append(moviesTF!)
            self.stars.append(starsTF)
            self.moviesTabelView.reloadData()
    }


))

    addMovie.addTextField { (textField) -> Void in textField.placeholder = "Add a Movie"
    }

    
    addMovie.addTextField { (textField) -> Void in textField.placeholder = "Rating out of 4 stars"
    }
    
    
    self.present(addMovie, animated: true, completion: nil)
    }
}
