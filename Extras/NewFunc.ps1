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
            if (!(Test-Path '')) {
                New-Item -Path '' -Force | Out-Null
            }

        }
        '?' {
            switch (Get-ItemPropertyValue -Path '' -Name '') {
                1 {
                    $script:FunctionName = 1
                }
                default {
                    $script:FunctionName = 0
                }
            }
            LogMessage 6 $source $FunctionName
            return $FunctionName
        }
    }
}