import Foundation

enum ProfileConstants {
    static let profilePhotoSideSize: CGFloat = 70.0
    static let editProfileButtonSideSize: CGFloat = 42.0
    static let tableCellHeight: CGFloat = 54.0
    static let tableHeight: CGFloat = tableCellHeight * CGFloat(mockArray.count)
    
    static let endpoint = "https://64c516f8c853c26efada7af9.mockapi.io"
    static let apiV1Profile1Get = "/api/v1/profile/1"
    
    static let mockArray = [
        "Мои NFT",
        "Избранные NFT",
        "О разработчике"
    ]
    static let mockProfileName = "Joaquin Phoenix"
    static let mockProfileDescription = "Дизайнер из Казани, люблю цифровое искусство и бейглы. В моей коллекции уже 100+ NFT, и еще больше — на моём сайте. Открыт к коллаборациям."
    static let mockProfileSite = "Joaquin Phoenix.com"
}
