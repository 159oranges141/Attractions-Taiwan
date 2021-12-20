//
//  MapViewController.swift
//  Attractions Taiwan
//
//  Created by NDHU_CSIE on 2021/12/13.
//

import UIKit
import MapKit
import AVFoundation

class MapViewController: UIViewController {
    
    var targetPlacemark: CLPlacemark!
    
    @IBOutlet var map: MKMapView!
    
    var scenes: Scene!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Configure map view
        map.delegate = self
        //mapView.showsCompass = true
        //mapView.showsScale = true
        //mapView.showsTraffic = true
        
        // Convert address to coordinate and annotate it on map
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(scenes.address, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                // Get the first placemark
                let placemark = placemarks[0]
                self.targetPlacemark = placemark
                
                // Create annotation object
                let annotation = MKPointAnnotation()
                annotation.title = self.scenes.name
                annotation.subtitle = self.scenes.city
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    // Display the annotation view
                    self.map.showAnnotations([annotation], animated: true)
                    //select the annotation marker to turn it into the selected state
                    self.map.selectAnnotation(annotation, animated: true)
                }
            }
            
        })
    }
    

    // show the navigation route
    @IBAction func openAMAP() {
        // enable the voice speaking
               let voiceText = AVSpeechUtterance(string: "Start navigation")
                voiceText.voice = AVSpeechSynthesisVoice(language: "en-US")
        //        let voiceText = AVSpeechUtterance(string: "開始導航")
        //        voiceText.voice = AVSpeechSynthesisVoice(language: "zh-TW")
                let syn = AVSpeechSynthesizer()
                syn.speak(voiceText)
                
                // open the apple maps and show the route
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: targetPlacemark.location!.coordinate, addressDictionary: nil))
                
                mapItem.name = "Destination"
                mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving])
            }

}


// Provide customized annotations

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifier = "MyMarker"
        
        if annotation.isKind(of: MKUserLocation.self) {  //unchanged to the marker of the current location
            return nil
        }
        
        // Reuse the annotation if possible
        var annotationView: MKMarkerAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKMarkerAnnotationView
        
        if annotationView == nil {
            annotationView = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            annotationView?.canShowCallout = true
        }
        
        annotationView?.glyphImage = UIImage(systemName: "heart")
        annotationView?.markerTintColor = UIColor.orange
        
        //let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        //leftIconView.image = UIImage(data: scenes.photos)
        //annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
    }
}
