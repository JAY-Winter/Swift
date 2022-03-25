import UIKit


class PayTableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    private let main = MainModel.shared
    private let cellIdentifier: String = "cell"
    
    private var delegate: PayTableDelegate?
    
    // MARK: - User actions
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var display: UILabel!
    @IBOutlet weak var orderButton: UIButton!
    // MARK: - User actions
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.navigationItem.title = "Pay"
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        display.text = String(main.accumlator)
        
        let footer = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.size.width, height: 150))
        
        footer.backgroundColor = .systemRed
        
    }
    
    // MARK: - User actions
    
    
    @IBAction func orderAddedMenus(_ sender: UIButton) {
        
    }
    
    // MARK: - User actions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if main.addedMenuList.count == 0 {
            tableView.setEmptyView(title: "현재 담긴 메뉴가 없습니다!", message: "")
        } else {
            tableView.restore()
        }
        return main.addedMenuList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CustomCell
        
        let addedMenu = main.addedMenuList[indexPath.row]
        
        cell.nameLabel.text = addedMenu.name
        cell.optionLabel.text = "\(addedMenu.getWay!)⎜\(addedMenu.temp!)"
        cell.priceLabel.text = "\(addedMenu.price.description)원"
        
        if let menuImage = UIImage(named: addedMenu.name) {
            cell.menuImageView.image = menuImage
        } else {
            cell.menuImageView.image = UIImage(named: "Sorry :(")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            main.addedMenuList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
            
            // view reload 
            main.accumlator -= 1000
            
            
            print("endUpdates 후 addMenuList : \(main.addedMenuList)")
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "THIS IS FOOTER SECTION"
    }
    
    
    

    
    
}
// MARK: - Extension
extension UITableView {
    
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.black
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        
        messageLabel.textColor = UIColor.lightGray
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        emptyView.addSubview(titleLabel)
        emptyView.addSubview(messageLabel)
        
        titleLabel.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        
        messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20).isActive = true
        messageLabel.leftAnchor.constraint(equalTo: emptyView.leftAnchor, constant: 20).isActive = true
        messageLabel.rightAnchor.constraint(equalTo: emptyView.rightAnchor, constant: -20).isActive = true
        
        titleLabel.text = title
        messageLabel.text = message
        
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        
        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }
}

// MARK: - CustomCell

class CustomCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var optionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var menuImageView: UIImageView!
}

