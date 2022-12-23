# Set-PADTDetectionKey
Creates a entry in the registry for your PADT detection needs!

Copy the function to AppDeployToolkitExtensions.ps1 Requires the rest of PADT.

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
