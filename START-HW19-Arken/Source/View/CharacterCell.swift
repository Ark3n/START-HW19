//
//  CharacterCell.swift
//  START-HW19-Arken
//
//  Created by Arken Sarsenov on 22.12.2023.
//

import UIKit
import SnapKit

final class CharacterCell: UITableViewCell {
    // MARK: - Properties
    static let identifier = "character-cell"
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "TEST"
        return label
    }()

    // MARK: - ViewLifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func configureCell(character: Character) {
        nameLabel.text = character.name
        
        }
        
    // MARK: - SetupUI
    private func setupUI() {
        addSubview(nameLabel)
    }
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(10)
        }

    }
}

