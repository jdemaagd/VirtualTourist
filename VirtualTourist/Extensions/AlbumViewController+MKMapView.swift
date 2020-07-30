//
//  AlbumViewController+MKMapView.swift
//  VirtualTourist
//
//  Created by JON DEMAAGD on 7/30/20.
//  Copyright © 2020 JON DEMAAGD. All rights reserved.
//

import MapKit

extension AlbumViewController: MKMapViewDelegate {
       
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
           
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: K.pinReuseId) as? MKPinAnnotationView

        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: K.pinReuseId)
            pinView!.canShowCallout = false
            pinView!.pinTintColor = .red
        
        } else {
            pinView!.annotation = annotation
        }
       
        pinView?.isSelected = true
        pinView?.isUserInteractionEnabled = false
        
        return pinView
    }
    
    func setUpMapView() {
        mapView.delegate = self
        let span = MKCoordinateSpan(latitudeDelta:  0.015, longitudeDelta: 0.015)
        let coordinate = CLLocationCoordinate2D(latitude: pin.latitude, longitude: pin.longitude)
        let region = MKCoordinateRegion(center: coordinate, span: span)
        mapView.setRegion(region, animated: true)
        mapView.addAnnotation(AnnotationPin(pin: pin))
    }
}
