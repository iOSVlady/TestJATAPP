//
//  MovieCell.swift
//  TheMovieDatabase
//
//  Created by Victor Mihaita on 02/12/2020.
//

import SwiftUI

struct MovieCard: View {
    var movie: Movie

    @State private var showModal = false

    var body: some View {
        AsyncImage(url: movie.getPosterUrl(.low)) { image in
            image
                .resizable()
                .transition(.fade(duration: 0.5))
                .scaledToFit()
                .clipped()
                .cornerRadius(16)
                .onTapGesture { showModal.toggle() }
                .sheet(isPresented: $showModal) {
                    MovieInfoView(viewModel: MovieInfoViewModel(movie: movie), showModal: $showModal)
                }
        } placeholder: {
            ProgressView()
        }
    }
}
