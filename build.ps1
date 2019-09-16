Import-Module PowerShellGet

#Publish to PSGallery and install/import locally

Publish-Module -Path .\PSCallEmAll -Repository PSGallery -Verbose
Install-Module -Name PSCallEmAll -Repository PSGallery -Force
Import-Module -Name PSCallEmAll -Force