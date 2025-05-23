//
//  ImageAnnotation.swift
//  LocationServices
//
// Copyright Amazon.com, Inc. or its affiliates. All Rights Reserved.
// SPDX-License-Identifier: MIT-0

import UIKit
import MapLibre

class ImageAnnotation:MLNPointAnnotation {
    var image: UIImage?
    var identifier: String?
    init(image: UIImage, identifier: String? = "ImageAnnotationViewIdentifier") {
        self.image = image
        self.identifier = identifier
        super.init()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

class ImageAnnotationView: MLNAnnotationView {
    
    enum Constants {
        static let size: CGSize = CGSize(width: 32, height: 32)
    }
    
    private var imageView: UIImageView?
    
    init(annotation: ImageAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        frame.size = Constants.size
        addImage(annotation?.image)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func addImage(_ image: UIImage?) {
        guard let image else { return }
        
        let imageView = UIImageView()
        self.imageView = imageView
        imageView.frame = CGRect(origin: .zero, size: frame.size)
        addSubview(imageView)

        imageView.image = image
    }
}
