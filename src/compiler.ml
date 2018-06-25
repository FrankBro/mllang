(* compiler.ml*)
open Pervasives
open Lexer
open Parser
open Lang

let arg_list =
    [ ("-parse",
    Arg.String (fun str -> print_endline (string_of_exp_parsed (Parser.prog token (Lexing.from_channel (open_in str))))),
    "Prints the abstract syntax tree generated by the parser")
    ; ("-step",
    Arg.String (fun str -> eval_print (Parser.prog token (Lexing.from_channel (open_in str)))),
    "Prints the step by step execution of the program")
    ]

let usage_msg =
        "Usage: compiler [flag] [filename.arith]\nAvailable flags:"

let main () =
    Arg.parse
    (Arg.align arg_list)
    (fun x -> (open_in x
        |> Lexing.from_channel
        |> prog token
        |> eval
        |> string_of_value
        |> print_endline))
    usage_msg

let _ = if !Sys.interactive then () else main ()
