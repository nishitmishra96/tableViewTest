import UIKit

class viewimageViewController: UIViewController {

    @IBOutlet weak var productimg: UIImageView!
    @IBOutlet weak var albumIdkey: UILabel!
    @IBOutlet weak var idKey: UILabel!
    @IBOutlet weak var titleKey: UILabel!
    @IBOutlet weak var albumIdValue: UILabel!
    @IBOutlet weak var idValue: UILabel!
    @IBOutlet weak var titleValue: UILabel!
    
    var idv = Int()
    var ttlv =  String()
    var albv = Int()
    var image : UIImage?

    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleValue.text = ttlv
        idValue.text = String(idv)
        albumIdValue.text = String(albv)
        productimg.image = image
        // Do any additional setup after loading the view.
    }
}
