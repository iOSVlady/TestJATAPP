//
//  MovieInfoView.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import SwiftUI

struct MovieInfoView: View {
    @ObservedObject var viewModel: MovieInfoViewModel
    @Binding var showModal: Bool

    private let gradient = Gradient(colors: [Color(UIColor.systemBackground), .clear, .clear, Color(UIColor.systemBackground)])

    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                ZStack(alignment: .bottom) {
                    ZStack {
                        AsyncImage(url: viewModel.movie.getPosterUrl(.high)) { image in
                            image
                                .resizable()
                                .transition(.opacity)
                                .scaledToFit()
                                .clipped()
                        } placeholder: {
                            ProgressView()
                        }

                        Rectangle()
                            .foregroundColor(.clear)
                            .background(LinearGradient(gradient: gradient, startPoint: .top, endPoint: .bottom))
                    }

                    if let tagline = viewModel.movie.tagline, !tagline.isEmpty {
                        Text("'\(tagline)'")
                            .font(.title3)
                            .italic()
                            .fontWeight(.semibold)
                            .padding(.horizontal)
                    }
                }

                VStack(spacing: 16) {
                    HStack(alignment: .top) {
                        Text(viewModel.movie.title)
                            .font(.title)
                            .fontWeight(.bold)
                        Spacer()
                        Text(viewModel.movie.getVoteAverage())
                            .font(.title)
                            .fontWeight(.bold)
                    }
                        .padding(.horizontal)

                    VStack(alignment: .leading, spacing: 16) {
                        Text("Description")
                            .font(.headline)

                        Text(viewModel.movie.overview)
                            .font(.subheadline)
                    }
                    .padding(.horizontal)
                }
            }
            .edgesIgnoringSafeArea(.top)
            .navigationBarItems(leading:
                Button(action: { showModal.toggle() }) {
                    Image(systemName: "xmark.circle.fill")
                }
            )
        }
    }
}
