//
//  FilterSelectViewController.swift
//  Ghibli_Films
//
//  Created by Elfa Andika on 14/04/21.
//

import UIKit
import RxSwift
import RxCocoa

final class FilterSelectViewController: UIViewController {
    
    
    private let disposeBag = DisposeBag()
    lazy var popupView = UIView()
    lazy var viewLabel = UILabel()
    lazy var viewPicker = UIPickerView()
    
    let selectedFilter = BehaviorRelay<String>.init(value: "")
    private var years = Observable<[String]>.empty()
    
    
    init(years: Observable<[String]>) {
        super.init(nibName: nil, bundle: nil)
        self.years = years
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPopupUIView()
        
        years.bind(to: viewPicker.rx.itemTitles) { row, element in
            return element
            
        }.disposed(by: disposeBag)
        
        
        viewPicker.rx.itemSelected
            .subscribe { (event) in
                switch event {
                case .next(let selected):
                    
                    self.years
                        .subscribe { (years) in
                            self.selectedFilter.accept(years[selected.row])
                            
                        }.disposed(by: self.disposeBag)
                    
                default:
                    break
                }
            }.disposed(by: disposeBag)
        
    }
    
}

// MARK:- Small Pop up UIView
extension FilterSelectViewController {
    
    func setupPopupUIView() {
        //Transparent UIView
        self.view = UIView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        //Small new view
        view.addSubview(popupView)
        
        popupView.backgroundColor = .darkGray
        popupView.alpha = 0.98
        popupView.layer.cornerRadius = 20
        
        popupView.translatesAutoresizingMaskIntoConstraints = false
        popupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        popupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        popupView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3).isActive = true
        popupView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20).isActive = true
        
        //Dismiss tap gesture
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        self.view.addGestureRecognizer(tap)
        
        setupLabel()
        setupPicker()
    }
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        dismiss(animated: true, completion: nil)
    }
    
}

// MARK:- UILabel View tag
extension FilterSelectViewController {
    func setupLabel() {
        popupView.addSubview(viewLabel)
        
        viewLabel.text = "Filter by year"
        viewLabel.textColor = .white
        viewLabel.font = .boldSystemFont(ofSize: 17)
        //        viewLabel.backgroundColor = .yellow
        
        viewLabel.translatesAutoresizingMaskIntoConstraints = false
        viewLabel.heightAnchor.constraint(equalTo: popupView.widthAnchor, multiplier: 0.1).isActive = true
        viewLabel.widthAnchor.constraint(equalTo: popupView.widthAnchor, multiplier: 0.5).isActive = true
        viewLabel.topAnchor.constraint(equalTo: popupView.topAnchor).isActive = true
        viewLabel.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 10).isActive = true
        
    }
    
}

// MARK:- UIPicker View
extension FilterSelectViewController {
    func setupPicker() {
        popupView.addSubview(viewPicker)
        
        viewPicker.setValue(UIColor.white, forKey: "textColor")
        
        viewPicker.translatesAutoresizingMaskIntoConstraints = false
        viewPicker.widthAnchor.constraint(equalTo: popupView.widthAnchor).isActive = true
        viewPicker.heightAnchor.constraint(equalTo: popupView.widthAnchor, multiplier: 0.3).isActive = true
        viewPicker.topAnchor.constraint(equalTo: viewLabel.bottomAnchor, constant: 1).isActive = true
        viewPicker.leadingAnchor.constraint(equalTo: popupView.leadingAnchor, constant: 1).isActive = true
    }
}
