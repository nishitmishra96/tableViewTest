import UIKit
import Alamofire
import  AlamofireImage
import SVProgressHUD


class SampleData {
    var albumId : Int
    var id : Int
    var title : String
    var url : String
    var thumbnailURL : String
    var image : UIImage?
    var thumbnail : UIImage?
    init(data:[String:Any] )
    {        id = data["id"] as? Int ?? -1
        albumId = data["albumId"] as? Int ?? -1
        title = data["title"] as? String ?? ""
        url = data["url"] as? String ?? ""
        thumbnailURL = data["thumbnailUrl"] as? String ?? ""
        print(thumbnailURL,"THUMBNAIL URL GIVEN")
        
    }
    
}

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    var dataClass = [SampleData]()
    var start = 0
    var limit = 10
    
    @IBOutlet weak var tableview: UITableView!
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataClass.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! mycustomcell

            cell.lbl.text = dataClass[indexPath.row].title
            cell.img?.image = dataClass[indexPath.row].thumbnail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         // performSegue(withIdentifier: "segue", sender: self)
        self.downloadRealImage(ofCell: dataClass[indexPath.row])
        {(result) -> (Void) in
            print("Image Downloaded")
            let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "viewimageViewController") as? viewimageViewController
            vc?.ttlv = self.dataClass[indexPath.row].title
            vc?.idv = self.dataClass[indexPath.row].id
            vc?.albv  = self.dataClass[indexPath.row].albumId
            vc?.image = self.dataClass[indexPath.row].image
            self.navigationController?.pushViewController(vc!, animated: true)
        }
        
        }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if indexPath.row < dataClass.count
        {
            downloadThumbnail(ofCell: dataClass[indexPath.row])
        }
        
        if indexPath.row == dataClass.count-1
        {
            performGetRequest()
        }
    }
    override func viewDidLoad()
    {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource  = self
        tableview.register(UINib(nibName: "mycustomcell", bundle: nil),
                           forCellReuseIdentifier: "cell")
        
        performGetRequest()
        tableview.reloadData()
        
    }
    func performGetRequest(){
        let url = "https://jsonplaceholder.typicode.com/photos?_start=\(start)&_limit=\(limit)"
        
        self.getRequestAPICall(url: url)
        
        start = start + limit
    }
    
    func getRequestAPICall(url: String)
    {
        Alamofire.request(url, method: .get, encoding: JSONEncoding.default)
            .responseJSON
            { response in
                if let data = response.result.value as? [[String:Any]]
                {
                    //        your json converted into array of Dictonary
             //       self.dataoftable.append(contentsOf: data)
                    self.tableview.reloadData()
                    for singleResponse in data
                    {
                        print(singleResponse)
                        let newdata = SampleData(data: singleResponse)
                        self.dataClass.append(newdata)
                        print(self.dataClass.count)
                    }
                }
                
                self.tableview.reloadData()
            }
    }
    
    func downloadThumbnail(ofCell: SampleData)
    {

        if ofCell.thumbnail == nil
        {
            Alamofire.request(ofCell.thumbnailURL).responseImage(completionHandler:
                { (response) in
                print(response)
                var thumbnailshape = response.result.value
                thumbnailshape = thumbnailshape?.af_imageRoundedIntoCircle()
                ofCell.thumbnail = thumbnailshape
                }
                )
        }
    }
    
    
    func downloadRealImage(ofCell: SampleData,handler: @escaping ((Bool)->(Void)) )
    {
        if ofCell.image == nil
        {
            Alamofire.request(ofCell.url).responseImage(completionHandler:
                { (response) in
                    ofCell.image = response.result.value
                    SVProgressHUD.dismiss()
                    handler(true)
            }
            )
                .downloadProgress { (progress) in
                    let per = (Double(progress.completedUnitCount)/Double(progress.totalUnitCount))*100
                    SVProgressHUD.showProgress(Float(per))
            }
        }else{
            handler(false)
        }
    }
}
