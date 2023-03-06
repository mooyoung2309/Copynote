//
//  NoteView.swift
//  FeatApp
//
//  Created by 송영모 on 2023/03/05.
//  Copyright © 2023 Copynote. All rights reserved.
//

import SwiftUI

import ComposableArchitecture

struct NoteView: View {
    let store: StoreOf<NoteStore>
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .tint(.white)
    }
}

struct NoteView_Previews: PreviewProvider {
    static var previews: some View {
        NoteView(store: .init(initialState: .init(), reducer: NoteStore()._printChanges()))
    }
}
