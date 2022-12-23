function Set-PADTDetectionKey {
        <#
    .SYNOPSIS
        Creates a detection key in registry to to use for intune or SCCM
    .DESCRIPTION
        Creates a detection key in registry to use for intune or SCCM. Default values will use $appName and $appScriptVersion from Deploy-Application.ps1.
        Detection path, name and value/version can be set via parameters.
    .PARAMETER KeyPath
        Specifies in which key path in the registry that should be created. Default is set to "HKEY_LOCAL_MACHINE\SOFTWARE\PADT"
    .PARAMETER KeyName
        Specifies what Application name should be used for the value. Default is $appName from Deploy-Application.ps1.
    .PARAMETER KeyValue
        Specifies what Version number should be used for the value. Default is $appScriptVersion from Deploy-Application.ps1.
    .PARAMETER Remove
        Removes the detection value file.
    .EXAMPLE
        Set-PADTDetectionKey
    .EXAMPLE
        Set-PADTDetectionKey -Remove
    .EXAMPLE
        Set-PADTDetectionFile -KeyPath "HKEY_LOCAL_MACHINE\SOFTWARE\PADT" -KeyName "MyApp" -KeyValue "1.0.2"
    .NOTES
        This is should be run under Post-Installation, preferably under some if-statement to verify the installation.
        Or under the Post-Uninstallation with the -Remove switch.
    .LINK
        http://vstrj.com
    #>
    [CmdletBinding()]
    param(
    [Parameter(ValueFromPipeline)]
    [String] $KeyPath = "HKEY_LOCAL_MACHINE\SOFTWARE\PADT",
    [Parameter(ValueFromPipeline)]
    [String] $KeyName = $appName,
    [Parameter(ValueFromPipeline)]
    [String] $KeyValue = $appScriptVersion,
    [Parameter(ValueFromPipeline)]
    [Switch] $Remove
    )
    Begin {
		## Get the name of this function and write header
		[string]${CmdletName} = $PSCmdlet.MyInvocation.MyCommand.Name
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -CmdletBoundParameters $PSBoundParameters -Header
	}
    process {
        if (-not $Remove){
            If (-not (Test-Path $KeyPath))
                {
                Write-Log -Message "PADT-Detection Registry Key does not exsis, creating Key!"
                Set-RegistryKey -Key $KeyPath -Value '(Default)'
                }
                Write-Log -Message "Creating KeyValue $KeyName with $KeyValue under $KeyPath"
                Set-RegistryKey -Key $KeyPath -Name $KeyName -Value $KeyValue
        }
        else {
            Write-Log -Message "Removing TagFile"
            Remove-RegistryKey -Key $KeyPath -Name $KeyName
        }   
    }
    End {
		Write-FunctionHeaderOrFooter -CmdletName ${CmdletName} -Footer
    }
}

