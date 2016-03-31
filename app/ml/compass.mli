(* -------------------------------------------------------------------------- *)
(* Default value for frequency is 100 and for filter is 0 (see Compass.js in the
 * original plugin)
 *)
class options : Ojs.t ->
  object
    inherit Ojs.obj
    method frequency : int
    method filter    : float
  end

val create_options :
  ?frequency:(int [@js.default 100])  ->
  ?filter:(float [@js.default 0.])    ->
  unit                                ->
  options
[@@js.builder]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
class heading : Ojs.t ->
  object
    inherit Ojs.obj
    method magnetic_heading : float
    method true_heading     : float
    method heading_accuracy : float
    method timestamp        : int
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
class error : Ojs.t ->
  object
    inherit Ojs.obj
    method code             : int
  end

(* Sum type for error code. It's useful to use type instead of integer
 * Unknown constructor is added for the pattern matching.
 *)
[@@@js.stop]
type type_error
val code_to_type : int -> type_error
[@@@js.start]

[@@@js.implem
type type_error =
  | Compass_internal_error
  | Compass_not_supported
  | Unknown

let code_to_type c = match c with
  | 0   ->  Compass_internal_error
  | 20  ->  Compass_not_supported
  | _   ->  Unknown
]
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
class compass : Ojs.t ->
  object
    inherit Ojs.obj
    method get_current_heading  : (heading  -> unit)  ->
                                  (error    -> unit)  ->
                                  unit
    method watch_heading        : (heading  -> unit)  ->
                                  (error    -> unit)  ->
                                  options             ->
                                  int
    method clear_watch          : int -> unit
  end
(* -------------------------------------------------------------------------- *)

(* -------------------------------------------------------------------------- *)
val t : unit -> compass
[@@js.get "navigator.compass"]
(* -------------------------------------------------------------------------- *)
