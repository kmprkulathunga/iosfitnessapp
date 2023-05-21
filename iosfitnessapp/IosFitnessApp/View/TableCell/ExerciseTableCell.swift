//
//  ExerciseCell.swift
//  FitnessApp
//
//

import Foundation
import Foundation
import UIKit
import Kingfisher

class ExerciseTableCell: UITableViewCell {
    static let reuseableId:String = "ExerciseTableCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: ExerciseTableCell.reuseableId)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
  
    
    let imageExe : UIImageView = {
        var iv = UIImageView()
        iv.backgroundColor = .gray
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerCurve = .continuous
        iv.layer.cornerRadius = 15
        iv.clipsToBounds = true
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    let titleLabel: UILabel = {
        let lb = UILabel()
        lb.textColor = .black
        lb.translatesAutoresizingMaskIntoConstraints = false
        lb.numberOfLines = 1
        lb.font = UIFont.boldSystemFont(ofSize: 15)
        return lb
    }()
    
    let detailContainer: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        sv.spacing = 5.0
        sv.alignment = .leading
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()

    
    func setupViews() {
        [imageExe,detailContainer].forEach {
            contentView.addSubview($0)
        }
        [titleLabel].forEach { item in
            detailContainer.addArrangedSubview(item)
        }
    }
    
    func setupConstraints(){
       
        NSLayoutConstraint.activate([
            
            imageExe.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 18),
            imageExe.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageExe.widthAnchor.constraint(equalToConstant: 68),
            imageExe.heightAnchor.constraint(equalTo: imageExe.widthAnchor),
            
            detailContainer.centerYAnchor.constraint(equalTo: imageExe.centerYAnchor),
            detailContainer.leadingAnchor.constraint(equalTo: imageExe.trailingAnchor, constant: 10),
   
        ])
    }
    
    func setupCell(for item: ExerciseModel){
        imageExe.kf.setImage(with: URL(string: item.img))
        titleLabel.text = item.name
    }
    

}
