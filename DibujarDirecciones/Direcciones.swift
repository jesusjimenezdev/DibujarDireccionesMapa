//
//  Direcciones.swift
//  DibujarDirecciones
//
//  Created by Jorge M. B. on 09/07/18.
//  Copyright © 2018 Jorge M. B. All rights reserved.
//

import Foundation
import MapKit

class Direcciones: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    var titulo : String?
    var subtitulo : String?
    
    init(titulo: String, subtitulo: String, location: CLLocationCoordinate2D) {
        self.titulo = titulo
        self.subtitulo = subtitulo
        self.coordinate = location
    }
    
}
