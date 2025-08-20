import UIKit

extension UIViewController {
    
    @objc
    func keyboardWillShow(sender: NSNotification) {
        guard let userInfo = sender.userInfo,
              let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let currentTextField = UIResponder.currentFirst() as? UITextField,
              let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView else {
            return
        }
        
        let keyboardTopY = keyboardFrame.cgRectValue.origin.y
        let convertedTextFieldFrame = view.convert(currentTextField.frame, from: currentTextField.superview)
        let textFieldBottomY = convertedTextFieldFrame.origin.y + convertedTextFieldFrame.size.height
        
        if textFieldBottomY > keyboardTopY {
            let offset = textFieldBottomY - keyboardTopY + 100
            scrollView.setContentOffset(CGPoint(x: .zero, y: offset), animated: true)
        }
    }
    
    @objc
    func keyboardWillHide(sender: NSNotification) {
        guard let scrollView = view.subviews.first(where: { $0 is UIScrollView }) as? UIScrollView else {
            return
        }
        scrollView.setContentOffset(.zero, animated: true)
    }
}
