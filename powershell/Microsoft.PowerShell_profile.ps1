If (-Not (Test-Path Variable:PSise) -Or $host.Name -eq 'ConsoleHost') {  # Only run this in the console and not in the ISE

    # Ensure oh-my-posh is loaded
    # Import-Module oh-my-posh
    oh-my-posh init pwsh --config $env:POSH_THEMES_PATH\probua.minimal.omp.json | Invoke-Expression

    Enable-PoshTransientPrompt
    Enable-PoshLineError
    # Set the default prompt theme
    # Set-PoshPrompt -Theme ys
    
    # Ensure that Get-ChildItemColor is loaded
    Import-Module Get-ChildItemColor

    # Ensure PSReadLine is enabled
    Import-Module PSReadLine
    # Enable predictive suggestion
    Set-PSReadLineOption -EditMode Windows
    Set-PSReadLineOption -PredictionSource HistoryAndPlugin
    Set-PSReadLineOption -PredictionViewStyle ListView
    
    # bash style completion
    Set-PSReadLineKeyHandler -Key Tab -Function Complete
    
    # Ensure posh-git is loaded
    Import-Module posh-git

    # Enable folder icons
    Import-Module -Name Terminal-Icons
    
    # Set l and ls alias to use the new Get-ChildItemColor cmdlets
    # Set-Alias l Get-ChildItemColorFormatWide -Option AllScope
    Set-Alias ls Get-ChildItem | Format-Wide
    # Set-Alias ls Get-ChildItemColor -Option AllScope

}

# Helper function to set location to the User Profile directory
function cuserprofile { Set-Location ~ }
Set-Alias ~ cuserprofile -Option AllScope

# Helper function to show Unicode characters
<#
function U
{
    param
    (
        [int] $Code
    )

    if ((0 -le $Code) -and ($Code -le 0xFFFF))
    {
        return [char] $Code
    }

    if ((0x10000 -le $Code) -and ($Code -le 0x10FFFF))
    {
        return [char]::ConvertFromUtf32($Code)
    }

    throw "Invalid character code $Code"
}
#>


#34de4b3d-13a8-4540-b76d-b9e8d3851756 PowerToys CommandNotFound module
Import-Module "C:\Program Files\PowerToys\WinUI3Apps\..\WinGetCommandNotFound.psd1"
#34de4b3d-13a8-4540-b76d-b9e8d3851756
