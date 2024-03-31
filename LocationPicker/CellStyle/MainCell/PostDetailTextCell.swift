import UIKit
class PostDetailTextCell: UITableViewCell {
    
    @IBOutlet var mainTextLabel : UILabel!
    
    func configure(post : Post) {
        
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        mainTextLabel.textColor = .white
        self.backgroundColor = .clear
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        
    }
    
}

class PostTitleCell: PostDetailTextCell {
    override func awakeFromNib() {
        super.awakeFromNib()
        mainTextLabel.font = UIFont.weightSystemSizeFont(systemFontStyle: .headline, weight: .bold)
    }
    
    override func configure(post: Post) {
        self.mainTextLabel.text = post.postTitle
    }
    
    
}

class PostContentCell: PostDetailTextCell {
    
    var mainTextLabelHeightAnchor : NSLayoutConstraint!
    
    weak var postContentCellDelegate : ExtendLabelHeightTableCellDelegate!
    
    override var mainTextLabel: UILabel! { didSet {
        mainTextLabel.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(postsContentExpand))
        mainTextLabel.addGestureRecognizer(gesture)
    }}
    override func awakeFromNib() {
        super.awakeFromNib()
        mainTextLabelHeightAnchor = self.mainTextLabel.heightAnchor.constraint(equalToConstant: 0)
        mainTextLabel.font = UIFont.weightSystemSizeFont(systemFontStyle: .body, weight: .regular)
    }
    override func configure(post: Post) {
        self.mainTextLabel.text = post.postContent
    }
    
    @objc func postsContentExpand() {
        mainTextLabel.numberOfLines = 0
        
        let maxSize = CGSize(width: mainTextLabel.frame.width, height: CGFloat.greatestFiniteMagnitude)
        let actualSize = mainTextLabel.sizeThatFits(maxSize)
        if mainTextLabel.frame.height == actualSize.height {
            return
        }
        NSLayoutConstraint.activate([
            mainTextLabelHeightAnchor
        ])
        
        UIViewPropertyAnimator.runningPropertyAnimator(withDuration: 0.1, delay: 0, options: .curveEaseOut, animations:  { [self] in
            mainTextLabelHeightAnchor.constant = actualSize.height
            
            contentView.layoutIfNeeded()
            self.postContentCellDelegate.cellRowHeightSizeFit()
        })
    }
    
    
    
}

/*class PostDetailInterationCell : UITableViewCell {
    var currentPost : Post!
    
    @IBOutlet var heartButton : UIButton! {didSet {
        heartButton.addTarget(self, action: #selector(LikeToggle(_ :)), for: .touchUpInside)
    }}
    @IBOutlet var statButton : UIButton!
    @IBOutlet var shareButton : UIButton!
    
    var postDetailInterationCellDeleagte : PostDetailInterationCellDeleagte!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .clear
    }
    
    func configure(post : Post) {
        currentPost = post
        setHeartImage()
    }
    
    
    @objc func LikeToggle(_ button: UIButton) {
        self.currentPost.liked.toggle()
        setHeartImage()
    }
    func setHeartImage() {
        if currentPost.liked {
            heartButton.setImage(UIImage(systemName: "heart.fill")?.withTintColor(.red, renderingMode: .alwaysOriginal), for: .normal)
        } else {
            heartButton.setImage(UIImage(systemName: "heart")?.withTintColor(.white, renderingMode: .alwaysOriginal), for: .normal)
        }
        postDetailInterationCellDeleagte.setHeartImage()
    }
}*/




