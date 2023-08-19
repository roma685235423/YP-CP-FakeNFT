import UIKit

// MARK: - FavoriteNFTsPresenterProtocol

protocol FavoriteNFTsPresenterProtocol: AnyObject {
    var networkClient: NFTsNetworkClientProtocol? { get set }
}

// MARK: - FavoriteNFTsViewDelegate

protocol FavoriteNFTsViewDelegate: AnyObject {
    var view: NFTsViewControllerProtocol? { get set }
    var callback: (() -> Void)? { get set }
    func viewDidLoad()
    func getNFTsCounter() -> Int
    func isNeedToHidePlaceholderLabel() -> Bool
    func getModelFor(indexPath: IndexPath) -> MyNFTPresentationModel
    func deleteNFT(at indexPath: IndexPath)
}

// MARK: - NFTsViewControllerProtocol

protocol NFTsViewControllerProtocol {
    var presenter: FavoriteNFTsViewDelegate? { get set }
    func updateTableOrCollection()
    func showNetworkErrorAlert(with error: Error)
}

// MARK: - FavoriteNFTCellDelegate

protocol FavoriteNFTCellDelegate: AnyObject {
    func didTapLikeButton(at indexPath: IndexPath)
}