(* -------------------------------------------------------------------------- *)
type watch_id = int
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
(* Default value for frequency is 100 and for filter is 0 (see Compass.js in the
 * original plugin)
 *)
type options =
  <
    frequency : int Js.readonly_prop ;
    filter    : float Js.readonly_prop
  > Js.t

let create_options ?(frequency=100) ?(filter=0.) () =
  object%js
    val frequency = frequency
    val filter    = filter
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
type heading =
  <
    magneticHeading : float Js.readonly_prop ;
    trueHeading     : float Js.readonly_prop ;
    headingAccuracy : float Js.readonly_prop ;
    timestamp       : int Js.readonly_prop
  > Js.t
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
type error =
  <
    code : int Js.readonly_prop
  >

type type_error =
  | Compass_internal_error
  | Compass_not_supported
  | Unknown

let code_to_type c = match c with
  | 0   ->  Compass_internal_error
  | 20  ->  Compass_not_supported
  | _   ->  Unknown
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
class type compass =
  object
    method getCurrentHeading  :   (heading  -> unit)  ->
                                  (error    -> unit)  ->
                                  unit Js.meth
    method watchHeading       :   (heading  -> unit)  ->
                                  (error    -> unit)  ->
                                  options             ->
                                  watch_id Js.meth
    method clearWatch         :   watch_id -> unit Js.meth
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
let compass () = Js.Unsafe.js_expr ("navigator.compass")
(* -------------------------------------------------------------------------- *)

