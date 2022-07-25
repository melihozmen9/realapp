//
//  detailViewController.swift
//  realapp
//
//  Created by Kullanici on 25.07.2022.
//

import UIKit

class detailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! detailTableViewCell
        let row = comments[indexPath.row]
        cell.name.text = row.name
        cell.email.text = row.email
        return cell
    }
    
   
   
    @IBOutlet weak var detailtitle: UILabel!
    
    
    @IBOutlet weak var tableview: UITableView!
    
    @IBOutlet weak var image: UIImageView!
    
    
    var foto = photo([:])
    var comments = [Comment]()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        detailtitle.text = foto.title
        if let url = URL(string : foto.url){
            image.load(url: url)
            loadlogo ()
            getComments()
        }
        func loadlogo () {
            if let logo = UIImage(named:"1.png"){
                let newlogo = Util.app.resizeImageWithAspect(image: logo, scaledToMaxWidth: 200, maxHeight: 50)
                let imageview = UIImageView(image: newlogo)
                self.navigationItem.titleView = imageview
            }
        }
        
        func getComments() {
            
            comments = []
            
            let url = URL(string : "https://jsonplaceholder.typicode.com/posts/1/comments")!
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
                                self.comments.append(Comment(dic))
                            }
                            self.comments = Array(self.comments.prefix(5))
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
}
