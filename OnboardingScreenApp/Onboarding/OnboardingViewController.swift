//
//  OnboardingViewController.swift
//  OnboardingScreenApp
//
//  Created by Aykhan Hajiyev on 04.03.23.
//

import UIKit

struct OnboardingModel {
    let image: String
    let title: String
    let subtitle: String
}

final class OnboardingViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    private var list: [OnboardingModel] = []
    
    private var currentPage: Int = 0 {
        didSet {
            didCurrentPageChange()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        list = [
            .init(image: "slide1", title: "welcome title", subtitle: "welcome slide 1"),
            .init(image: "slide2", title: "welcome title 2", subtitle: "welcome slide 2"),
            .init(image: "slide3", title: "welcome title 3", subtitle: "welcome slide 3")
        ]
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.collectionViewLayout = layout
        nextButton.addTarget(self, action: #selector(didTapNextButtonAction), for: .touchUpInside)
    }
    
    func didCurrentPageChange() {
        pageControl.currentPage = currentPage
        if currentPage == list.count - 1 {
            nextButton.setTitle("Navigate to dashboard", for: .normal)
        } else {
            nextButton.setTitle("Next", for: .normal)
        }
    }
    
    @objc
    private func didTapNextButtonAction() {
        print("tapped next button ")
        
        if currentPage < list.count - 1 {
            currentPage += 1
            
            collectionView.isPagingEnabled = false

            let nextIndexPath = IndexPath(item: currentPage, section: 0)
            
            collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
            
            collectionView.isPagingEnabled = true

        } else {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            performSegue(withIdentifier: "toDashboard", sender: nil)
        }
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "OnboardingCollectionViewCell", for: indexPath) as? OnboardingCollectionViewCell {
            
            cell.configure(list[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let width = scrollView.frame.width
        currentPage = Int(scrollView.contentOffset.x / width)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("DID SCROLL")
    }
    
}
