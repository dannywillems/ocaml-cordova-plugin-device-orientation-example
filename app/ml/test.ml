let on_device_ready _ =
  let c = Cordova_compass.t () in
  Js._false

let _ =
  Dom.addEventListener Dom_html.document (Dom.Event.make "deviceready")
  (Dom_html.handler on_device_ready) Js._false
