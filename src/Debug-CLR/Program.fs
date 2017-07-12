module Debug.CLR

open Expecto

let tests = 
    testList "hello world" [
        testCase "sound check" (fun () ->
            Expect.isTrue false "make some noise"
        )
    ]

[<EntryPoint>]
let main argv =
    runTestsWithArgs { defaultConfig with ``parallel`` = false } argv tests