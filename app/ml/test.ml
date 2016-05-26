let on_device_ready _ =
  let c = Cordova_compass.t () in
  ()

let _ =
  Cordova.Event.device_ready on_device_ready
