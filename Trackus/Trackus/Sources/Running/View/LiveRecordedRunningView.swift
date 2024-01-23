//
//  LiveRecordedRunningView.swift
//  Trackus
//
//  Created by SeokKi Kwon on 2024/01/21.
//

import SwiftUI
@_spi(Experimental) import MapboxMaps

struct Settings {
    var mapStyle: MapStyle = .standard
    var orientation: NorthOrientation = .upwards
    var gestureOptions: GestureOptions = .init()
    var cameraBounds: CameraBoundsOptions = .init()
    var constrainMode: ConstrainMode = .heightOnly
    var ornamentSettings = OrnamentSettings()
    var debugOptions: MapViewDebugOptions = [.camera]
    
    struct OrnamentSettings {
        var isScaleBarVisible = true
        var isCompassVisible = true
    }
}

/**
 실시간으로 지나온 러닝 경로를 보여주는 뷰
 */
struct LiveRecordedRunningView: View {
    @State private var settingsOpened = false
    @State private var settings = Settings()
    let center = CLLocationCoordinate2D(latitude: 37.57086522553968, longitude: 126.97897371602562)
    
    var body: some View {
        Map(initialViewport: .camera(center: center, zoom: 12, pitch: 75))
                    .cameraBounds(settings.cameraBounds)
                    .mapStyle(settings.mapStyle)
                    .gestureOptions(settings.gestureOptions)
                    
                    .northOrientation(settings.orientation)
                    .constrainMode(settings.constrainMode)
                    .ornamentOptions(OrnamentOptions(
                        scaleBar: ScaleBarViewOptions(visibility: settings.ornamentSettings.isScaleBarVisible ? .visible : .hidden),
                        compass: CompassViewOptions(visibility: settings.ornamentSettings.isCompassVisible ? .visible : .hidden)
                    ))
                    
                    .ignoresSafeArea()
    }
}

#Preview {
    LiveRecordedRunningView()
}
