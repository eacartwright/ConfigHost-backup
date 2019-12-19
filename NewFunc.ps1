function Function {
    param (
        $mode
    )

    $source = "[$($MyInvocation.MyCommand)]"
    LogMessage 6 $source $mode

    switch ($mode) {
        0 {

        }
        1 {

        }
        '?' {
            switch (().Data) {
                1 {
                    $script:FunctionVariable = 1
                }
                default {
                    $script:FunctionVariable = 0
                }
            }
            LogMessage 6 $source $FunctionVariable
            return $FunctionVariable
        }
    }
}