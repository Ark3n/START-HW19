//
//  DetailedController.swift
//  START-HW19-Arken
//
//  Created by Arken Sarsenov on 22.12.2023.
//

import UIKit

final class DetailedController: UIViewController {
    // MARK:- Properties
    let detailedView = DetailedView()
    var character: Character?
    
    override func loadView() {
        view = detailedView
    }
    
    // MARK: - ViewLifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        detailedView.fetchDetails(character: character)
    }
    
    private func setupUI() {
        view.backgroundColor = .systemBackground
    }
}
