//
//  MainViewController.swift
//  Kuban Kredit Test
//
//  Created by Антон Захарченко on 20.12.2019.
//  Copyright © 2019 Антон Захарченко. All rights reserved.
//

import UIKit
import Alamofire
import UserNotifications



class ViewController: UIViewController {
    
    let mainRequest = RequestManager()
    let notificationManager = NotificationManager()
    var timer = Timer()
    var counter = GetConfiguration().timerCounter
    
    @IBOutlet weak var logTextView: UITextView!
    @IBOutlet weak var mainLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        runTumer()
        mainLabel.text = "Timer: \(counter) seconds left"
    }
    
    @IBAction func playPauseButton(_ sender: UIButton) {
        
        if timer.isValid {
            timer.invalidate()
            sender.setImage(UIImage(systemName: "play.circle"), for: .normal)
        } else {
            runTumer()
            sender.setImage(UIImage(systemName: "pause.circle"), for: .normal)
        }
        
    }
    
    @IBAction func stopButton(_ sender: UIButton) {
        let button = self.view.viewWithTag(2) as! UIButton
        button.setImage(UIImage(systemName: "play.circle"), for: .normal)
        resetTimer()
        
    }
    
    
    @IBAction func clearLogButton(_ sender: UIButton) {
        logTextView.text = ""
    }
    
    @IBAction func shareLogButton(_ sender: UIButton) {
        
        let activityController = UIActivityViewController(activityItems: [logTextView.text ?? ""], applicationActivities: nil)
        present(activityController,animated: true,completion: nil)
        
    }
    
    
    //MARK: - Timer Delegates
    
    func runTumer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target:self, selector: #selector(updateTimer), userInfo:nil, repeats: true)
    }
    
    @objc func updateTimer() {
        
        // This block of code response for timer in background mode
        
        var backgroundTask = UIApplication.shared.beginBackgroundTask()
        
        if backgroundTask != UIBackgroundTaskIdentifier.invalid {
            if UIApplication.shared.applicationState == .active {
                UIApplication.shared.endBackgroundTask(backgroundTask)
                backgroundTask = UIBackgroundTaskIdentifier.invalid
            }
        }
        
        mainLabel.text = "Timer: \(counter) seconds left"
        
        if counter == 0 {
            makeRequest()
            counter = GetConfiguration().timerCounter
        } else {
            counter -= 1
            
        }
    }
    
    @objc func resetTimer() {
        timer.invalidate()
        counter = GetConfiguration().timerCounter
        mainLabel.text = "Timer: \(counter) seconds left"
    }
    
    //MARK: - Make Server Request
    
    func makeRequest () {
        
        notificationManager.sendNotification()
        
        request(mainRequest.firstFullUrl, method: HTTPMethod(rawValue: mainRequest.firstHttpMethod) ?? .get).response { response in
            
            let getFirstMethod = response.request?.httpMethod ?? "httpMethod error"
            let getFirstUrl = response.request?.url?.absoluteString ?? "URL error"
            let getFirstStatusCode = response.response?.statusCode ?? 0
            
            self.logTextView.insertText("\n---------------------- \nFirst server \nMethod: \(getFirstMethod) \nURL:\(String(describing: getFirstUrl)) \nStatusCode: \(String(describing: getFirstStatusCode)) \(self.mainRequest.checkStatus(getFirstStatusCode)) \n----------------------")
        }
        
        if mainRequest.secondServer {
            request(mainRequest.secondFullUrl, method: HTTPMethod(rawValue: mainRequest.secondHttpMethod) ?? .get).response { (response) in
                let getSecondMethod = response.request?.httpMethod ?? "httpMethod error"
                let getSecondUrl = response.request?.url?.absoluteString ?? "URL error"
                let getSecondStatusCode = response.response?.statusCode ?? 0
                
                
                
                self.logTextView.insertText("\n---------------------- \nSecond server \nMethod: \(getSecondMethod) \nURL: \(String(describing: getSecondUrl)) \nStatusCode: \(String(describing: getSecondStatusCode)) \(self.mainRequest.checkStatus(getSecondStatusCode)) \n----------------------")
                
            }
        }
        
    }
    
}


