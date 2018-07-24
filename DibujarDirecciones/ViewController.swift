import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let inicioLocation = CLLocationCoordinate2D(latitude: 24.019894, longitude:  -104.660824)
        let destinoLocation = CLLocationCoordinate2D(latitude: 24.023059, longitude: -104.652279)
        
        let inicioPin = Direcciones(titulo: "Direccion 1", subtitulo: "Inicio", location: inicioLocation)
        let destinoPin = Direcciones(titulo: "Direccion 2", subtitulo: "Destino", location: destinoLocation)
        
        self.mapa.addAnnotation(inicioPin)
        self.mapa.addAnnotation(destinoPin)
        
        let inicioPlaceMark = MKPlacemark(coordinate: inicioLocation)
        let destinoPlaceMark = MKPlacemark(coordinate: destinoLocation)
        
        let directionRequest = MKDirectionsRequest()
        directionRequest.source = MKMapItem(placemark: inicioPlaceMark)
        directionRequest.destination = MKMapItem(placemark: destinoPlaceMark)
        directionRequest.transportType = .automobile
        
        let directions = MKDirections(request: directionRequest)
        directions.calculate { (response, error) in
            guard let directionResponse = response else {
                if let error = error {
                    print("Hubo un error en las direcciones", error)
                }
                return
            }
            let ruta = directionResponse.routes[0]
            self.mapa.add(ruta.polyline, level: .aboveRoads)
            let rect = ruta.polyline.boundingMapRect
            self.mapa.setRegion(MKCoordinateRegionForMapRect(rect), animated: true)
        }
        self.mapa.delegate = self
        
        let inicio = CLLocation(latitude: 24.019894, longitude:  -104.660824)
        let destino = CLLocation(latitude: 24.023059, longitude: -104.652279)
        
        let distancia : CLLocationDistance = inicio.distance(from: destino)
        print(distancia)
        let distanciaFinal = String(format: "Distancia: %02.02f metros", distancia)
        print("Distancia: \(distanciaFinal)")
        
    }// termina ViewDidLoad

    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        let linea = MKPolylineRenderer(overlay: overlay)
        linea.strokeColor = UIColor.red
        linea.lineWidth = 4.0
        return linea
    }


}

