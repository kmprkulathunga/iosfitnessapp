//
//  HomeViewController.swift
//  FitnessApp
//
//

import UIKit


import UIKit

class HomeViewController: UIViewController {
    
    var exerciseList : [ExerciseModel] = []
    let controller  = Controller();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupViews()
        setupConstraints()
        FavouriteTableView.delegate = self
        FavouriteTableView.dataSource = self
        FavouriteTableView.register(ExerciseTableCell.self, forCellReuseIdentifier: ExerciseTableCell.reuseableId)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
        
        self.exerciseList = [];

        controller.getExercises() { (list) in
            DispatchQueue.main.async {
                self.exerciseList.append(contentsOf: list);
                self.FavouriteTableView.reloadData();
            }
        }
        
    }
    
    let heading: UILabel = {
        let lb = UILabel()
        lb.text = "Exercise List"
        lb.textColor = .blue
        lb.font = UIFont.boldSystemFont(ofSize: 24)
        lb.translatesAutoresizingMaskIntoConstraints = false
        return lb
    }()
    
    let FavouriteTableView: UITableView = {
        let list = UITableView(frame: .zero)
        list.translatesAutoresizingMaskIntoConstraints = false
        list.showsVerticalScrollIndicator = false
        list.backgroundColor = UIColor(red: 0.224, green: 0.902, blue: 0, alpha: 0.1)
        list.layer.cornerRadius = 10
        return list
    }()
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exerciseList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ExerciseTableCell.reuseableId, for: indexPath) as! ExerciseTableCell
        let item = exerciseList[indexPath.row]
        cell.setupCell(for: item)
        cell.layoutMargins = UIEdgeInsets.zero
        cell.separatorInset = UIEdgeInsets.zero
        cell.selectionStyle = .none
        cell.backgroundColor = color.lightblue
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = ExerciseViewController()
        vc.exe = exerciseList[indexPath.row];
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func setupViews() {
        view.addSubview(heading)
        view.addSubview(FavouriteTableView)
    }
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            
            heading.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            heading.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            
            FavouriteTableView.topAnchor.constraint(equalTo: heading.bottomAnchor, constant: 10),
            FavouriteTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            FavouriteTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
            FavouriteTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        
    }
    
}
