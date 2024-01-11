//
//  RoutineView.swift
//
//  Created by Woo Jye Lee on 1/2/24.
//

import UIKit
import SnapKit

final class DailyView: UIView {

    // MARK: - Properties
    
    // MARK: - UI Components

    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 40), height: 136)
        flowLayout.footerReferenceSize = CGSize(width: (UIScreen.main.bounds.width - 40), height: 136)
        flowLayout.minimumLineSpacing = 12
        flowLayout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 12, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        view.backgroundColor = .SoftieBack
        return view
    }()
    
    // MARK: - Life Cycles
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setHierarchy()
        setLayout()
        setAddTarget()
        setRegisterCell()
        
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Extensions

extension DailyView {

    func setUI() {
        self.backgroundColor = .white
    }
    
    func setHierarchy() {
        self.addSubviews(collectionView)
    }
    
    func setLayout() {
    }
    
    func setAddTarget() {

    }
    
    @objc
    func buttonTapped() {
        
    }
    
    func setRegisterCell() {
        DailyRoutineCollectionViewCell.register(target: collectionView)
        DailyFooterView.register(target: collectionView)
    }
    
    func setDataBind() {
        
    }

}
