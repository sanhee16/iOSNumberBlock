//
//  BaseViewController.swift
//  NumberBlock
//
//  Created by sandy on 2023/06/03.
//

import SwiftUI
import FittedSheets

// https://yagom.net/forums/topic/detecting-background-foreground-in-viewcontroller/
// Content는 generic type
class BaseViewController<Content>: UIViewController, Dismissible, Nameable where Content: View {
    // where: 타입에 대한 제약
//    private var observer: NSObjectProtocol?
    private var mainObserver: NSObjectProtocol?
    
    static func bottomSheet(_ rootView: Content, sizes: [SheetSize]) -> SheetViewController {
        let options = SheetOptions(
            pullBarHeight: 0,
            shrinkPresentingViewController: false
        )
        let vc = BaseViewController(rootView, completion: nil)
        let sheetController = SheetViewController(controller: vc, sizes: sizes, options: options)
        sheetController.allowPullingPastMaxHeight = false
        sheetController.gripColor = nil
        
        print(("\(type(of: self)): init BottomSheet, \(String(describing: Content.self))"))
        return sheetController
    }
    
    static func bottomSheet(_ rootView: Content, sizes: [SheetSize], options: SheetOptions) -> SheetViewController {
        let vc = BaseViewController(rootView, completion: nil)
        let sheetController = SheetViewController(controller: vc, sizes: sizes, options: options)
        sheetController.allowPullingPastMaxHeight = false
        sheetController.gripColor = nil
        
        print(("\(type(of: self)): init BottomSheet, \(String(describing: Content.self))"))
        return sheetController
    }
    
    let rootView: Content
    let controller: UIHostingController<Content>
    var completion: (() -> Void)?
    var viewDidLoadCallback: (() -> ())? = nil
    
    var name: String {
        get {
            return String(describing: Content.self)
        }
    }
    
    public init(_ rootView: Content, completion: (() -> Void)? = nil, viewDidLoadCallback: (() -> ())? = nil) {
        print("\(type(of: self)): init, \(String(describing: Content.self))")
        self.rootView = rootView
        self.controller = UIHostingController(rootView: rootView)
        self.completion = completion
        self.viewDidLoadCallback = viewDidLoadCallback
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }
    
    
    public init(_ rootView: Content, completion: (() -> Void)? = nil) {
        print("\(type(of: self)): init, \(String(describing: Content.self))")
        self.rootView = rootView
        self.controller = UIHostingController(rootView: rootView)
        self.completion = completion
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .fullScreen
    }
        
    required init?(coder: NSCoder) {
        print("\(type(of: self)): init")
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        print("deinit (\(type(of: self)))")
        if type(of: self) == BaseViewController<MainView>.self, let observer = self.mainObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        print("viewDidLoad: \(type(of: self))")
        
        DispatchQueue.main.async { [weak self] in
            self?.controller.navigationController?.isNavigationBarHidden = true
        }
        addChild(controller)
        controller.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
        
        NSLayoutConstraint.activate([
            controller.view.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1),
            controller.view.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1),
            controller.view.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            controller.view.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        controller.view.backgroundColor = UIColor.backgroundColor
        self.view.backgroundColor = UIColor.backgroundColor
        
        if type(of: self) == BaseViewController<MainView>.self {
            print("MainView type viewDidload!!!")
            mainObserver = NotificationCenter.default.addObserver(
                forName: UIApplication.willEnterForegroundNotification,
                object: nil,
                queue: .main) {
                    [unowned self] notification in
                    print("notification: \(notification)")
                    self.viewDidLoadCallback?()
                }
        }
    }
    
    public func attachDismissCallback(completion: (() -> Void)?) {
        self.completion = completion
    }
    
    func attachViewModel(_ vm: BaseViewModel) {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("viewDidAppear (\(type(of: self)))")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("viewDidDisappear (\(type(of: self)))")
    }
    
}

public protocol Dismissible {
    var completion: (() -> Void)? { get set }
    func attachDismissCallback(completion: (() -> Void)?)
}

public protocol Nameable {
    var name: String { get }
}

extension Nameable {
    func isSameView<Type>(view: Type.Type) -> Bool {
        name == String(describing: Type.self)
    }
}

