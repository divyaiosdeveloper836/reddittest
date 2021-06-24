//
//  Data.swift
//  Reddit
//
//  Created by Divya on 24/06/21.
//

import Foundation

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let reddit = try? newJSONDecoder().decode(Reddit.self, from: jsonData)

import Foundation

// MARK: - Reddit
struct Reddit: Codable {
    let data: RedditData
}

// MARK: - RedditData
struct RedditData: Codable {
    let children: [Child]
    let after: String
}

// MARK: - Child
struct Child: Codable {
    let data: ChildData
}

// MARK: - ChildData
struct ChildData: Codable {
    let title: String
    let thumbnailHeight: Int?
    let thumbnailWidth: Int?
    let score: Int
    let thumbnail: String
    let numComments: Int
    let preview: Preview?

    enum CodingKeys: String, CodingKey {
        case title
        case thumbnailHeight = "thumbnail_height"
        case thumbnailWidth = "thumbnail_width"
        case score
        case thumbnail
        case numComments = "num_comments"
        case preview
    }
}


// MARK: - Preview
struct Preview: Codable {
    let images: [Image]
    let enabled: Bool

    enum CodingKeys: String, CodingKey {
        case images, enabled
    }
}

// MARK: - Image
struct Image: Codable {
    let source: ResizedIcon
    let resolutions: [ResizedIcon]
    let variants: Variants
    let id: String
}

enum Format: String, Codable {
    case apng = "APNG"
    case png = "PNG"
}

// MARK: - Variants
struct Variants: Codable {
    let obfuscated, nsfw: Nsfw?
}

// MARK: - ResizedIcon
struct ResizedIcon: Codable {
    let url: String
    let width, height: Int
    let format: Format?
}


// MARK: - Nsfw
struct Nsfw: Codable {
    let source: ResizedIcon
    let resolutions: [ResizedIcon]
}


