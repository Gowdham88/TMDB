//
//  ViewController.swift
//  The movies
//
//  Created by Mac on 13/08/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
//import DGElasticPullToRefresh
import SVProgressHUD


class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,  UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet var movies: UITableView!
    
    let ary = ["New in Theatres","Popular"," Highest Rated This year"]
    let collectionary = ["1", "2","3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        self.movies.delegate   = self
        self.movies.dataSource = self
                print("fetchmovies:\(fetchNewMovies())")
        
        callQueues()
        
       //
//        let loadingView = DGElasticPullToRefreshLoadingViewCircle()
//        loadingView.tintColor = UIColor(red: 78/255.0, green: 221/255.0, blue: 200/255.0, alpha: 1.0)
//        movies.dg_addPullToRefreshWithActionHandler({ [weak self] () -> Void in
//            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(1.5 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
//                
//                
//            })
//            }, loadingView: loadingView)
//        movies.dg_setPullToRefreshFillColor(UIColor(red: 57/255.0, green: 67/255.0, blue: 89/255.0, alpha: 1.0))
//        movies.dg_setPullToRefreshBackgroundColor(movies.backgroundColor!)

        

    }

    
    func callQueues() {
    
        let queue = DispatchQueue(label: "myQueue")
        let queue1 = DispatchQueue(label: "myQueue1")
        let queue2 = DispatchQueue(label: "myQueue2")
        
        queue.async {
            
            self.fetchNewMovies()
        }
        
        queue1.async {
            
            self.fetchhighratedMovies()
        }
        
        queue2.async {
            
            self.fetchPopularMovies()
            
        }
        

    }
    
    
    func fetchNewMovies() {
        
        print("Fetch movies called")
        

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=9c429db8cf311a3b089ec3354cc7b645&language=en-US&page=1")!
        
        SVProgressHUD.show()
        let request = URLRequest(url: url)
        moviess.removeAll()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                
                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {

                    print("NewMovies reponse: \(String(describing: responseDictionary))")
                    
                    
                    let results = (responseDictionary?["results"] as AnyObject) as! [NSDictionary]
                    
                    for item in results.enumerated() {
                        
                        let newmovie = MovieModel(dictionary: item.element)
                        
                        moviess.append(newmovie)
                        
                    }
                    
                    baseUrl1 = "http://image.tmdb.org/t/p/w500"
                    DispatchQueue.main.async {

                    self.movies.reloadData()
                    }
                    
                    

                    
                    
                    
                }
            }
        }

        task.resume()
        
    }
    
    
    func fetchPopularMovies() {
        
        print("fetchPopularMovies")

        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=9c429db8cf311a3b089ec3354cc7b645&language=en-US&page=1")!
        let request = URLRequest(url: url)
        
        popularmoviess.removeAll()
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {

                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    print ("popular movie reponse: \(String(describing: responseDictionary))")

                    let results = (responseDictionary?["results"] as AnyObject) as! [NSDictionary]
                    
                    for item in results.enumerated() {
                        
                        let popularmovie = MovieModel(dictionary: item.element)

                        popularmoviess.append(popularmovie)
                        
                    }

                     baseUrl1 = "http://image.tmdb.org/t/p/w500"
                    DispatchQueue.main.async {

                    self.movies.reloadData()
                    }
                    
                }
            }
        }
        
        task.resume()
        
    }
    
    func fetchhighratedMovies() {
        
        print("fetchhighratedMovies")

        
        let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=9c429db8cf311a3b089ec3354cc7b645&language=en-US&page=1")!
        let request = URLRequest(url: url)
        
        highestratedmoviess.removeAll()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {

                if let responseDictionary = try? JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                    
                    
                    let results = (responseDictionary?["results"] as AnyObject) as! [NSDictionary]
                    
                    for item in results.enumerated() {
                        
                        let highratedmovie = MovieModel(dictionary: item.element)
                        
                        highestratedmoviess.append(highratedmovie)
                        
                    }
                    
                    baseUrl1 = "http://image.tmdb.org/t/p/w500"
                    
                    SVProgressHUD.dismiss()
                    
                    DispatchQueue.main.async {
                        
                    self.movies.reloadData()
                        
                    }
//                self.movies.dg_stopLoading()

                }
            }
        }
        
        task.resume()
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            print("movieList Tableview cellfor row")
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieList") as! movieTableViewCell
            
            cell.NewMovies.text = ary[indexPath.row]
            
            let collectiontype = "\(0)\(indexPath.row)"
            
            print("collectiontype:\(collectiontype)")
            
            cell.setCollectionViewDataSourceDelegate(self, forRow: Int(collectiontype)!)
        
            print("row: \(indexPath.row)")
            cell.movieCollection.reloadData()
            return cell
            
        }
            
        else if indexPath.row == 1 {
            
            print("popularTableViewCell for row")
            
            let cell1 = tableView.dequeueReusableCell(withIdentifier: "popular") as! popularTableViewCell
            
            cell1.popularTitle.text = ary[indexPath.row]
            //      let obj = ary[indexPath.row]
            //      cell1.NewMovies.text = "row: \(indexPath.row)"
            
             var collectiontype = "\(1)\(indexPath.row)"
            
            print("collectiontype:\(collectiontype)")
            
            cell1.setCollectionViewDataSourceDelegate(self, forRow: Int(collectiontype)!)
 
            cell1.popularCollection.reloadData()
            
            return cell1
            
        } else {
        
            print("TopratedTableViewCell for row")
            
            let cell2 = tableView.dequeueReusableCell(withIdentifier: "toprated") as! TopratedTableViewCell
            
//            cell12.popularTitle.text = ary[indexPath.row]
            
             let collectiontype = "\(2)\(indexPath.row)"
            
            print("collectiontype:\(collectiontype)")
            
            cell2.topRatedTitle.text = ary[indexPath.row]
            
            cell2.setCollectionViewDataSourceDelegate(self, forRow: Int(collectiontype)!)
            
            return cell2
            
        }
       
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
        
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        var collectiontype = String(collectionView.tag)
        var count = Int(collectiontype)

        print("Collectiontype numberOfItemsInSection: \(collectiontype)")
        print("collectiontype.characters.first: \(collectiontype.characters.first)")

        
        if collectiontype.characters.first == "0" {
            
            collectiontype.remove(at: collectiontype.startIndex)
             count = Int(collectiontype)
            
            print("numberOfItemsInSection popularmoviess.count \(popularmoviess.count)")
            
            return moviess.count
            
        } else if collectiontype.characters.first == "1" {
            
            collectiontype.remove(at: collectiontype.startIndex)
            
            return popularmoviess.count
            
        } else if collectiontype.characters.first == "2" {
            
            collectiontype.remove(at: collectiontype.startIndex)
             count = Int(collectiontype)
            
            return highestratedmoviess.count
            
        } else {
        
            collectiontype.remove(at: collectiontype.startIndex)
             count = Int(collectiontype)
            
            return moviess.count
        
        }

    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var collectiontype = String(collectionView.tag)
        var count = Int(collectiontype)
        
        print("collectiontype: \(collectiontype)")
        print("collectiontype.characters.first: \(collectiontype.characters.first)")
        
        print("Cell for ITEM -> View controller")
        
        print("collectionview cell indexPath.row\(indexPath.row)")

        
        
        if collectiontype.characters.first == "0" {
       
            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "newmovies", for: indexPath) as! newMovieCollectionViewCell
            
            collectiontype.remove(at: collectiontype.startIndex)
            count = Int(collectiontype)
            
            
            cell0.movieTitle.text = moviess[indexPath.row].title
            
            let dataDecoded : Data = Data(base64Encoded: moviess[indexPath.row].strBase64, options: .ignoreUnknownCharacters)!
            
            cell0.newMovieImage.image = UIImage(data: dataDecoded)
            
            print("1. moviess[indexPath.row].title: \(moviess[indexPath.row].title)")
            print("moviess.count: \(moviess.count)")

            return cell0
            
        } else if collectiontype.characters.first == "1" {
        
            collectiontype.remove(at: collectiontype.startIndex)
            count = Int(collectiontype)
            
            let cell1 = collectionView.dequeueReusableCell(withReuseIdentifier: "popularCollection", for: indexPath) as! popularCollectionViewCell
            print("popularmoviess[indexPath.row].title: \(popularmoviess[indexPath.row].title)")
            
            cell1.popularLabel.text = popularmoviess[indexPath.row].title
            
            let dataDecoded : Data = Data(base64Encoded: popularmoviess[indexPath.row].strBase64, options: .ignoreUnknownCharacters)!
            
            cell1.popularImage.image = UIImage(data: dataDecoded)
            
            return cell1
            
            
        } else if collectiontype.characters.first == "2" {
            
            collectiontype.remove(at: collectiontype.startIndex)
             count = Int(collectiontype)
            
        
            let cell2 = collectionView.dequeueReusableCell(withReuseIdentifier: "toprated", for: indexPath) as! TopratedCollectionViewCell
            print("highestratedmoviess[indexPath.row].title: \(highestratedmoviess[indexPath.row].title)")
            
            cell2.topratedCollectionTitle.text = highestratedmoviess[indexPath.row].title
            
            let dataDecoded : Data = Data(base64Encoded: highestratedmoviess[indexPath.row].strBase64, options: .ignoreUnknownCharacters)!
            
            cell2.topratedCollectionimage.image = UIImage(data: dataDecoded)
            
            return cell2
            
        } else {
            
            let cell0 = collectionView.dequeueReusableCell(withReuseIdentifier: "newmovies", for: indexPath) as! newMovieCollectionViewCell
            
            collectiontype.remove(at: collectiontype.startIndex)
            count = Int(collectiontype)
            
            print("2. popularmoviess[indexPath.row].title: \(moviess[indexPath.row].title)")
            
            cell0.movieTitle.text = moviess[indexPath.row].title
            
            let dataDecoded : Data = Data(base64Encoded: moviess[indexPath.row].strBase64, options: .ignoreUnknownCharacters)!
            
            cell0.newMovieImage.image = UIImage(data: dataDecoded)
            
            return cell0
        
        }
        
    }
    
}
