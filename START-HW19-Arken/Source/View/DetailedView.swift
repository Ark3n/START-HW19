//
//  DetailedView.swift
//  START-HW19-Arken
//
//  Created by Arken Sarsenov on 22.12.2023.
//

import UIKit
import SnapKit
import Alamofire

final class DetailedView: UIView {
    // MARK: - Properties
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1)
        return label
    }()
    lazy var herroImage: UIImageView = {
       let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var descriptioneLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .preferredFont(forTextStyle: .body)
        return label
    }()

    // MARK: - ViewLifecycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func fetchDetails(character: Character?) {
        nameLabel.text = character?.name
        descriptioneLabel.text = character?.description
        guard let httpPath = character?.thumbnail.path,
              let ext = character?.thumbnail.thumbnailExtension.rawValue else { return }
        let httpsPath = httpPath.replacingOccurrences(of: "http", with: "https")
        let urlStr = httpsPath + "." + ext
        AF.request(urlStr).responseData { response in
            guard let data = response.value else { return }
            self.herroImage.image = UIImage(data: data)
        }
    }
            
    // MARK: - SetupUI
    private func setupUI() {
        addSubview(nameLabel)
        addSubview(descriptioneLabel)
        addSubview(herroImage)
    }
    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(self.safeAreaLayoutGuide).offset(50)
        }
        
        herroImage.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.trailing.leading.equalTo(self).inset(10)
        }
        descriptioneLabel.snp.makeConstraints { make in
            make.top.equalTo(herroImage.snp.bottom).offset(5)
            make.trailing.leading.equalTo(self).inset(10)
            make.bottom.equalTo(self.safeAreaLayoutGuide).inset(50)
        }
    }
}
