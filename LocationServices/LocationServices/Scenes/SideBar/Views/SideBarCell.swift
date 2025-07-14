//
//  SideBarCell.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import UIKit
import SnapKit

enum SideBarCellType {
    case navigate, tracking, settings, more
    
    var title: String {
        switch self {
        case .navigate: return StringConstant.TabBar.navigate
        case .tracking: return StringConstant.TabBar.tracking
        case .settings: return StringConstant.TabBar.settings
        case .more: return StringConstant.TabBar.more
        }
    }
    
    private var icon: UIImage {
        switch self {
        case .navigate: return UIImage.navigateIcon
        case .tracking: return UIImage.trackingIcon
        case .settings: return UIImage.settingsIcon
        case .more: return UIImage.moreIcon
        }
    }
    
    var defaultIcon: UIImage {
        icon.withTintColor(.tabBarUnselectedColor,
                           renderingMode: .alwaysOriginal)
    }
    
    var selectedIcon: UIImage {
        icon.withTintColor(.lsPrimary,
                           renderingMode: .alwaysOriginal)
    }
    
    var accessbilityIdentifier: String {
        switch self {
        case .navigate: return ViewsIdentifiers.General.navigateTabBarButton
        case .tracking: return ViewsIdentifiers.General.trackingTabBarButton
        case .settings: return ViewsIdentifiers.General.settingsTabBarButton
        case .more: return ViewsIdentifiers.General.moreTabBarButton
        }
    }
}

struct SideBarCellModel {
    let type: SideBarCellType
}

final class SideBarCell: UITableViewCell {

    enum Constants {
        static let itemTitleFont: UIFont = .amazonFont(type: .regular, size: 16)
    }
    
    static let reuseId: String = "SideBarCell"
    
    var model: SideBarCellModel! {
        didSet {
            accessibilityIdentifier = model.type.accessbilityIdentifier
            titleLabel.text = model.type.title
            iconImageView.image = model.type.defaultIcon
        }
    }
    
    private var selectionView: UIView = {
        let view = UIView()
        view.isHidden = true
        view.clipsToBounds = true
        view.layer.cornerRadius = NumberConstants.selectionViewCornerRadius
        view.backgroundColor = .settingsSelectionColor
        return view
    }()
    
    private var containerView: UIView = UIView()
    
    private var iconImageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        return iv
    }()
    
    private var titleLabel: UILabel = {
        var label = UILabel()
        label.font = Constants.itemTitleFont
        label.textColor = .lsTetriary
        label.applyLocaleDirection()
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        self.tintColor = .clear
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError(ErrorMessage.errorInitWithCoder)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        selectionView.isHidden = !selected
        iconImageView.image = selected ? model?.type.selectedIcon : model?.type.defaultIcon
    }
    
    private func setupViews() {
        addSubview(selectionView)
        selectionView.snp.makeConstraints {
            $0.verticalEdges.equalToSuperview().inset(4)
            $0.horizontalEdges.equalToSuperview().inset(6)
        }
        
        addSubview(containerView)
        containerView.addSubview(iconImageView)
        containerView.addSubview(titleLabel)
        
        containerView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.verticalEdges.equalToSuperview().inset(4)
        }
        
        iconImageView.snp.makeConstraints {
            $0.height.width.equalTo(20)
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(24)
            $0.trailing.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
