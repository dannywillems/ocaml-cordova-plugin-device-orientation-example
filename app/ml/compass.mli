(* -------------------------------------------------------------------------- *)
type watch_id
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

val create_options : ?frequency:int -> ?filter:float -> unit -> options
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

type type_error
val code_to_type : int -> type_error
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
val compass : unit -> compass Js.t
(* -------------------------------------------------------------------------- *)
