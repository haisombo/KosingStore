//
//  FirebAuth.swift
//  KOSIGNStore
//
//  Created by Hai Sombo on 5/21/24.
//

import SwiftUI
import GoogleSignIn
import FirebaseAuth
import FirebaseCore

struct GoogleSignInButton: UIViewRepresentable {

    
    func makeUIView(context: Context) -> UIButton {
        let button = UIButton(type: .custom)
           
           // Set image and title for the button
           button.setImage(UIImage(named: "google"), for: .normal)
           button.setTitle(" Login with Google", for: .normal) // Space added for better padding
           button.setTitleColor(.black, for: .normal)
           button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        // Resize the image programmatically
           if let image = UIImage(named: "google") {
               let resizedImage = resizeImage(image: image, targetSize: CGSize(width: 30 , height: 30))
               button.setImage(resizedImage, for: .normal)
           }
           
           // Adjust image and title insets for proper spacing
           button.imageEdgeInsets = UIEdgeInsets(top: 0, left: -20, bottom: 0, right: 0)
           button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
   
        
           // Set target for button action
           button.addTarget(context.coordinator, action: #selector(Coordinator.signInWithGoogle), for: .touchUpInside)
           
           // Set button's frame or constraints
           button.translatesAutoresizingMaskIntoConstraints = false
           let widthConstraint = button.widthAnchor.constraint(equalToConstant: 300)
           let heightConstraint = button.heightAnchor.constraint(equalToConstant: 50)
           NSLayoutConstraint.activate([widthConstraint, heightConstraint])
           
           return button
       }
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio, height: size.height * widthRatio)
        }
        
        let rect = CGRect(origin: .zero, size: newSize)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage!
    }

    func updateUIView(_ uiView: UIButton, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject {
        var parent: GoogleSignInButton

        init(_ parent: GoogleSignInButton) {
            self.parent = parent
        }

        @objc func signInWithGoogle() {
            guard let clientID = FirebaseApp.app()?.options.clientID else { return }

            let config = GIDConfiguration(clientID: clientID)
            guard let presentingVC = UIApplication.shared.windows.first?.rootViewController else { return }

            GIDSignIn.sharedInstance.configuration = config

            GIDSignIn.sharedInstance.signIn(withPresenting: presentingVC) { result, error in
                if let error = error {
                    print("Error signing in: \(error.localizedDescription)")
                    return
                }

                guard let user = result?.user,
                      let idToken = user.idToken?.tokenString else { return }

                let credential = GoogleAuthProvider.credential(withIDToken: idToken, accessToken: user.accessToken.tokenString)
                
                Auth.auth().signIn(with: credential) { authResult, error in
                    if let error = error {
                        print("Firebase sign in error: \(error.localizedDescription)")
                        return
                    }
                    
                    let email           = authResult?.user.email
                    let photoURL        = authResult?.user.photoURL
                    let uid             = authResult?.user.uid
                    let displayName     = authResult?.user.displayName
                
                    
                    print("email \(email)")
                    print("uid \(uid)")
                    print("photoURL \(photoURL)")
                    print("displayName \(displayName)")
                    
                    print("User is signed in")
                    UserDefaults.standard.set(true, forKey: "signIn")
                }
            }
        }
    }
}
