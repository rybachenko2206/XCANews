//
//  ArticleRowView.swift
//  XCANews
//
//  Created by Roman Rybachenko on 01.06.2022.
//

import SwiftUI

struct ArticleRowView: View {
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16, content: {
            articleImage()
            
            VStack(alignment: .leading, spacing: 8, content: {
                contentView()
                captionView()
            })
        })
        .padding(.top, 6)
        .padding(.bottom, 10)
    }
    
    @ViewBuilder func contentView() -> some View {
        VStack(alignment: .leading, spacing: 8, content: {
            if let title = article.title {
                Text(title)
                    .font(.headline)
                    .lineLimit(2)
            }
            if let descr = article.description {
                Text(descr)
                    .font(.subheadline)
                    .lineLimit(3)
            }
        })
    }
    
    @ViewBuilder func captionView() -> some View {
        HStack(content: {
            if let dateStr = article.publishedAtString {
                Text(dateStr)
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .lineLimit(1)
            }
            
            Spacer()
            
            Button(action: {
                pl("bookmark button tapped")
            }, label: {
                Image(systemName: "bookmark")
            })
            .buttonStyle(.bordered)
            
            Button(action: {
                pl("Share button tapped")
            }, label: {
                Image(systemName: "square.and.arrow.up")
            })
            .buttonStyle(.bordered)
        })
    }
    
    @ViewBuilder func articleImage() -> some View {
        AsyncImage(url: article.imageUrl, content: { phase in
            switch phase {
            case .empty:
                HStack {
                    Spacer()
                    ProgressView()
                    Spacer()
                }
            case .success(let image):
                image
                    .resizable()
                
            case .failure:
                HStack {
                    Spacer()
                    Image(systemName: "photo")
                        .resizable()
                        .frame(maxWidth: 300, maxHeight: 200)
                        .imageScale(.large)
                    Spacer()
                }
            @unknown default:
                HStack {
                    Spacer()
                    Image(systemName: "photo")
                        .imageScale(.large)
                    Spacer()
                }
            }
        })
        .frame(height: 250)
        .background(Color.gray.opacity(0.3))
        .clipped()
    }
}



struct ArticleRowView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            List(content: {
                ArticleRowView(article: Article.stubItems[safe: 2]!)
            })
        }
    }
}
