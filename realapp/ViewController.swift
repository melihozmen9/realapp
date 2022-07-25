//
//  ViewController.swift
//  realapp
//
//  Created by Kullanici on 21.07.2022.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    @IBOutlet weak var tableview: UITableView!
    var photos = [photo]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadlogo()
        getPhotos()
        tableview.separatorStyle = .none
        
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
            
            let row = photos[indexPath.row]
            
            cell.myTitle.text = row.title
        cell.myImage.load(url: URL(string: row.url)!)
            
            
            return cell
            
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = photos[indexPath.row]
        performSegue(withIdentifier: "todetail", sender: row)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "todetail" {
            let desVC = segue.destination as! detailViewController
            desVC.foto = sender as! photo
        }
    }
    
    func loadlogo () {
        if let logo = UIImage(named:"1.png"){
            let newlogo = Util.app.resizeImageWithAspect(image: logo, scaledToMaxWidth: 200, maxHeight: 50)
            let imageview = UIImageView(image: newlogo)
            self.navigationItem.titleView = imageview
        }
        
        
    }
    func getPhotos() {
        
        photos = []
        
        let url = URL(string : "https://jsonplaceholder.typicode.com/photos")!
        let task = URLSession.shared.dataTask(with: url) {(data,response,error) in
            if let error = error {
                print("error : \(error)")
            } else {
                if let response = response as? HTTPURLResponse{
                    print("statuscode: \(response.statusCode)")
                }
                
                do {
                    if let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]]{
                        //print(json)
                        for dic in json{
                            self.photos.append(photo(dic))
                        }
                        self.photos = Array(self.photos.prefix(10))
                        DispatchQueue.main.async {
                            self.tableview.reloadData()
                        }
                    }
                    
                } catch  let error as NSError{
                    print("error: \(error.localizedDescription)")
                }
            }
            
        }
        task.resume()
    }

}
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
