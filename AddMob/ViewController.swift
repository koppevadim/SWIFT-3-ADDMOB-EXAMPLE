//
//  ViewController.swift
//  AddMob
//
//  Created by Вадим Коппе on 12.09.16.
//  Copyright © 2016 Вадим Коппе. All rights reserved.
//

import UIKit
import GoogleMobileAds

class ViewController: UIViewController, GADBannerViewDelegate, GADRewardBasedVideoAdDelegate {
    
    var bannerView: GADBannerView!
    
    var interstitial: GADInterstitial!
    
    var rewardBasedVideo: GADRewardBasedVideoAd!
    
    var nativeExpressAdView: GADNativeExpressAdView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    fileprivate func removeAdds() {
        if (bannerView != nil) {
            bannerView.removeFromSuperview();
            bannerView = nil
        }
        
        if (nativeExpressAdView != nil) {
            nativeExpressAdView.removeFromSuperview()
            nativeExpressAdView = nil
        }
        
        if (interstitial != nil) {
            interstitial = nil
        }
        
        if (rewardBasedVideo != nil) {
            rewardBasedVideo = nil
        }
    }

    @IBAction func BannerExample() {
        removeAdds()
        
        print("BannerExample");
        
        bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.delegate = self
        
        view.addSubview(bannerView)
        
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        
        // Layout constraints that align the banner view to the bottom center of the screen.
        view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: bannerView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
    }
    
    @IBAction func InterstitialExample() {
        removeAdds()
        
        print("InterstitialExample");
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/2934735716")
        let request = GADRequest()
        // Request test ads on devices you specify. Your test device ID is printed to the console when
        // an ad request is made.
        request.testDevices = [ kGADSimulatorID, "2077ef9a63d2b398840261c8221a0c9a" ]
        interstitial.load(request)
        
        let alert = UIAlertController(title: "Message:", message: "Show Interstitial Add", preferredStyle: .actionSheet)
        let actionAdd = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
            if self.interstitial.isReady {
                self.interstitial.present(fromRootViewController: self)
            } else {
                print("Ad wasn't ready")
            }
        })
        
        alert.addAction(actionAdd)
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func NativeExpressExample() {
        removeAdds()
        
        print("NativeExpressExample");
        
        nativeExpressAdView = GADNativeExpressAdView(adSize: kGADAdSizeMediumRectangle)
        
        view.addSubview(nativeExpressAdView)
        
        nativeExpressAdView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addConstraint(NSLayoutConstraint(item: nativeExpressAdView, attribute: .centerY, relatedBy: .equal, toItem: view, attribute: .centerY, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: nativeExpressAdView, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0))
        
        nativeExpressAdView.adUnitID = "ca-app-pub-3940256099942544/2934735716"
        nativeExpressAdView.rootViewController = self
        
        let request = GADRequest()
        request.testDevices = [kGADSimulatorID]
        nativeExpressAdView.load(request)
    }
    
    @IBAction func RewardedVideoExample() {
        removeAdds()
        
        print("RewardedVideoExample");
        
        rewardBasedVideo = GADRewardBasedVideoAd.sharedInstance()!
        rewardBasedVideo.delegate = self
        
        rewardBasedVideo.load(GADRequest(), withAdUnitID: "ca-app-pub-3940256099942544/4411468910")
        
        
        if rewardBasedVideo.isReady{
            rewardBasedVideo.present(fromRootViewController: self)
        }else {
            let alert = UIAlertController(title: "Message:", message: "Show Video Add", preferredStyle: .actionSheet)
            let actionAdd = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: { (UIAlertAction) -> Void in
                if self.rewardBasedVideo.isReady {
                    self.rewardBasedVideo.present(fromRootViewController: self)
                } else {
                    print("Ad wasn't ready")
                }
            })
            
            alert.addAction(actionAdd)
            self.present(alert, animated: true, completion: nil)
        }

    }
    
    // MARK: - GADBannerViewDelegate
    
    // Called when an ad request loaded an ad.
    func adViewDidReceiveAd(_ bannerView: GADBannerView!) {
        print("an ad request loaded an ad.")
    }
    
    // Called when an ad request failed.
    func adView(_ bannerView: GADBannerView!, didFailToReceiveAdWithError error: GADRequestError!) {
        print("an ad request failed.")
    }
    
    // Called just before presenting the user a full screen view, such as a browser, in response to
    // clicking on an ad.
    func adViewWillPresentScreen(_ bannerView: GADBannerView!) {
        print(#function)
    }
    
    // Called just before dismissing a full screen view.
    func adViewWillDismissScreen(_ bannerView: GADBannerView!) {
        print(#function)
    }
    
    // Called just after dismissing a full screen view.
    func adViewDidDismissScreen(_ bannerView: GADBannerView!) {
        print(#function)
    }
    
    // Called just before the application will background or terminate because the user clicked on an
    // ad that will launch another application (such as the App Store).
    func adViewWillLeaveApplication(_ bannerView: GADBannerView!) {
        print(#function)
    }
    
    // MARK: GADRewardBasedVideoAdDelegate implementation
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd!, didFailToLoadWithError error: Error!) {
        print("Reward based video ad failed to load: \(error.localizedDescription)")
    }
    
    func rewardBasedVideoAdDidReceive(_ rewardBasedVideoAd: GADRewardBasedVideoAd!) {
        print("Reward based video ad is received.")
    }
    
    func rewardBasedVideoAdDidOpen(_ rewardBasedVideoAd: GADRewardBasedVideoAd!) {
        print("Opened reward based video ad.")
    }
    
    func rewardBasedVideoAdDidStartPlaying(_ rewardBasedVideoAd: GADRewardBasedVideoAd!) {
        print("Reward based video ad started playing.")
    }
    
    func rewardBasedVideoAdDidClose(_ rewardBasedVideoAd: GADRewardBasedVideoAd!) {
        print("Reward based video ad is closed.")
    }
    
    func rewardBasedVideoAdWillLeaveApplication(_ rewardBasedVideoAd: GADRewardBasedVideoAd!) {
        print("Reward based video ad will leave application.")
    }
    
    func rewardBasedVideoAd(_ rewardBasedVideoAd: GADRewardBasedVideoAd!, didRewardUserWith reward: GADAdReward!) {
        print("Reward received with currency: \(reward.type), amount \(reward.amount).")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

