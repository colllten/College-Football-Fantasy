//
//  HomeView.swift
//  College Fantasy Football
//
//  Created by Colten Glover on 7/4/22.
//

import SwiftUI
import Firebase

struct Data {
    
    func getData() -> String {
        let db = Firestore.firestore()
        
        let docRef = db.collection("Users")
        //docRef.addDocument(data: ["firstName" : "Mochi", "lastName" : "Man", "email" : "mochiman@gmail.com"])
        docRef.getDocuments { snapshot, error in
            if error == nil {
                if let snapshot = snapshot {
                    print("The amount of documents returned: \(snapshot.count)")
                    let documents = snapshot.documents
                    for doc in documents {
                        print(doc.data())
                    }
                }
            } else {
                print("ERROR GETTING DOCUMENTS")
            }
        }
        return "nothing"
    }
}


//        db.collection("Users").getDocuments { snapshot, error in
//            if error == nil {
//                if let snapshot = snapshot {
//                    resultA = snapshot.documents.map { doc in
//                        return doc.documentID
//                    }
//                }
//            }
//        }

struct HomeView: View {
    
    @EnvironmentObject var viewModel: AppViewModel
    @EnvironmentObject var user: User
    //let data = Data()
    
    
    var body: some View {
        VStack {
            Text("First Name: test")
            Text("Last Name: test")
            Text("Email: \(UserDefaults.standard.value(forKey: "userEmail") as! String)")
            
            Button {
                viewModel.signOut()
            } label: {
                Text("Sign Out")
                    .frame(width: 250, height: 50, alignment: .center)
                    .cornerRadius(10)
                    .font(.title)
                    .background(.red)
                    .foregroundColor(.white)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
