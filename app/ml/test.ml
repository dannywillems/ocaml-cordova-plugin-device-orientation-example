let on_device_ready _ =
  let succ heading =
    let doc = Dom_html.document in
    let p = Dom_html.createP doc in
    let magn = Cordova_compass.heading_magnetic_heading heading in
    let true_heading = Cordova_compass.heading_true_heading heading in
    let accuracy = Cordova_compass.heading_heading_accuracy heading in
    p##.innerHTML :=
      Js.string
      (
        "magn: " ^ (string_of_float magn) ^
        "\ntrue heading: " ^ (string_of_float true_heading) ^
        "\naccuracy: " ^ (string_of_float accuracy)
      );
    Dom.appendChild doc##.body p
  in
  let err e =
    Jsoo_lib.alert
    (
      match (Cordova_compass.error_code e) with
      | Cordova_compass.Compass_internal_error -> "internal error"
      | Cordova_compass.Compass_not_supported -> "Not supported"
    )
  in
  let id = Cordova_compass.watch_heading succ err () in
  ignore id;
  ()

let _ =
  Cordova.Event.device_ready on_device_ready
