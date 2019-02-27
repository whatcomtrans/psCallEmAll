function Get-AvailableLists {
	[CmdletBinding(SupportsShouldProcess=$false)]
	Param(
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
    }
	Process {
        $request = $CallEmAllProxy.createRequestObject("GetAvailableListsRequestType")
        $response = $CallEmAllProxy.GetAvailableLists($request)
        If ($response.errorCode -ne 0) {
            return $response.errorMessage
        } Else {
            [com.callemall.powershell.ListDetail[]] $lists = $response.lists
            return $lists
        }
    }
}

function Get-ListContents {
	[CmdletBinding(SupportsShouldProcess=$false)]
	Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,HelpMessage="The listID to retrieve members of")]
            [String] $ListID = "0",
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            $PageSize=300,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            $Page=1,
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
    }
	Process {
        [com.callemall.powershell.GetListContentsRequestType] $request = $CallEmAllProxy.createRequestObject("GetListcontentsRequestType")
        $request.listID = $ListID
        $request.pageSize = $PageSize
        $request.whatPage = $Page
        [com.callemall.powershell.GetListContentsResponseType] $response = $CallEmAllProxy.GetListContents($request)
        if ($response.errorCode -ne 0) {
            return $response.errorMessage
        } else {
            return $response.ListContents
        }
    }
}

function Delete-Person {
	[CmdletBinding(SupportsShouldProcess=$true)]
	Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $PersonID,
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
    }
	Process {
        [com.callemall.powershell.DeletePersonRequestType] $request = $CallEmAllProxy.createRequestObject("DeletePersonRequestType")
        $request.personID = $PersonID
        [com.callemall.powershell.DeletePersonResponseType] $response = $CallEmAllProxy.DeletePerson($request)
        if ($response.errorCode -ne 0) {
            return $response.errorMessage
        }
    }
}

function Create-PersonID {
	[CmdletBinding(SupportsShouldProcess=$true)]
	Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $FirstName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $LastName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $PrimaryPhone,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [String] $SecondaryPhone,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [String] $TertiaryPhone,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [String] $Notes,
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
        [com.callemall.powershell.CreatePersonIDRequestType] $request = $CallEmAllProxy.createRequestObject("CreatePersonIDRequestType")
    }
	Process {
        [com.callemall.powershell.CreatePersonIDDetailData] $person = $CallEmAllProxy.createRequestObject("CreatePersonIDDetailData")
        $person.FirstName = $FirstName
        $person.LastName = $LastName
        $person.PrimaryPhone = $PrimaryPhone
        $person.SecondaryPhone = $SecondaryPhone
        $person.TertiaryPhone = $TertiaryPhone
        $person.Notes = $Notes

        $request.personsToAdd = $request.personsToAdd + $person
    }
    End {
        [com.callemall.powershell.CreatePersonIDResponseType] $response = $CallEmAllProxy.CreatePersonID($request)
        if ($response.errorCode -ne 0) {
            return $response.errorMessage
        } Else {
            return $response.InsertResults
        }
    }
}

function Update-PersonID {
	[CmdletBinding(SupportsShouldProcess=$true)]
	Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $PersonID,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $FirstName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $LastName,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $PrimaryPhone,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [String] $SecondaryPhone,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [String] $TertiaryPhone,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [String] $Notes,
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
    }
	Process {
        [com.callemall.powershell.UpdatePersonIDRequestType] $request = $CallEmAllProxy.createRequestObject("UpdatePersonIDRequestType")
        [com.callemall.powershell.PersonDetailData] $person = $CallEmAllProxy.createRequestObject("PersonDetailData")

        $person.PersonID = $PersonID

        $person.FirstName = $FirstName
        $person.LastName = $LastName
        $person.PrimaryPhone = $PrimaryPhone
        $person.SecondaryPhone = $SecondaryPhone
        $person.TertiaryPhone = $TertiaryPhone
        $person.Notes = $Notes

        $request.PersonRecords += $person

        [com.callemall.powershell.UpdatePersonIDResponseType] $response = $CallEmAllProxy.UpdatePersonID($request)
        if ($response.errorCode -ne 0) {
            return $response.errorMessage
        } Else {
            return $response.updateFailures
        }

    }
    End {
    }
}


function Add-PersonsToList {
	[CmdletBinding(SupportsShouldProcess=$true,DefaultParameterSetName="SingleID")]
	Param(
        [Parameter(Mandatory=$true)]
            [String]$ListID,
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true,ParameterSetName="SingleID")]
            [String] $PersonID,
        [Parameter(Mandatory=$true,ParameterSetName="ArrayID")]
            [String[]] $PersonIDs,
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
        [com.callemall.powershell.AddPersonsToListRequestType] $request = $CallEmAllProxy.createRequestObject("AddPersonsToListRequestType")
        [com.callemall.powershell.AddPersonsToListDetailData[]] $Data = @()
    }
	Process {
        if ($PersonIDs) {
            $PersonIDs | %{[com.callemall.powershell.AddPersonsToListDetailData] $DetailData = New-Object -TypeName com.callemall.powershell.AddPersonsToListDetailData, $DetailData.PersonID = $_; $Data += $DetailData}
        } else {
            [com.callemall.powershell.AddPersonsToListDetailData] $DetailData = New-Object -TypeName com.callemall.powershell.AddPersonsToListDetailData
            $DetailData.PersonID = $PersonID
            $Data += $DetailData
        }
    }
    End {
        $request.PersonIDsToAdd = $Data
        $request.listID = $ListID
        [com.callemall.powershell.AddPersonsToListResponseType] $response = $CallEmAllProxy.AddPersonsToList($request)
        If ($response.errorCode -ne 0) {
            return $response.errorMessage
        } Else {
            return $response.ListContents
        }
    }
}

function Get-ListIDByName {
	[CmdletBinding(SupportsShouldProcess=$false)]
	Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String]$ListName,
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
    }
	Process {
            [com.callemall.powershell.GetListIDByNameRequestType] $request = $CallEmAllProxy.createRequestObject("GetListIDByNameRequestType")
            $request.listName = $ListName
            [com.callemall.powershell.GetListIDByNameResponseType] $response = $CallEmAllProxy.GetListIDByName($request)
            If ($response.errorCode -ne 0) {
                return $response.errorMessage
            } Else {
                return $response.listID
            }
    }
}

function Create-NewList {
	[CmdletBinding(SupportsShouldProcess=$true)]
	Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String] $ListName,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [Switch] $IsAutoReplyOn,
        [Parameter(Mandatory=$false,ValueFromPipelineByPropertyName=$true)]
            [String] $AutoReplyMessage,
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
    }
	Process {
        [com.callemall.powershell.CreateNewListRequestType] $request = $CallEmAllProxy.createRequestObject("CreateNewListRequestType")
        $request.listName = $ListName
        if ($IsAutoReplyOn) {
            $request.IsAutoReplyOn = "1"
        } else {
            $request.IsAutoReplyOn = "0"
        }
        $request.AutoReplyMessage = $AutoReplyMessage
        [com.callemall.powershell.CreateNewListResponseType] $response = $CallEmAllProxy.CreateNewList($request)
        if ($response.errorCode -ne 0) {
            return $response.errorMessage
        } Else {
            return $response.listID
        }
    }
}

function Get-PersonIDDetails‏ {
	[CmdletBinding(SupportsShouldProcess=$false)]
	Param(
        [Parameter(Mandatory=$true,ValueFromPipelineByPropertyName=$true)]
            [String]$PersonID,
        [Parameter(Mandatory=$true,HelpMessage="URL to the WSDL, defaults to Staging")]
		    [String]$WSDL = "http://staging-api.call-em-all.com/webservices/ceaapi_v3-2-13.asmx?wsdl",
        [Parameter(Mandatory=$true,HelpMessage="Username to connect with")]
		    [String]$Username,
        [Parameter(Mandatory=$true,HelpMessage="Pin to connect with")]
		    [String]$Pin
    )
    Begin {
        $CallEmAllProxy = New-WebServiceProxy -Uri $WSDL -Namespace "com.callemall.powershell" -Class "psCallEmAll"
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "pin" -Value $Pin -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "username" -Value $Username -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType NoteProperty -Name "WSDL" -Value $WSDL -Force
        Add-Member -InputObject $CallEmAllProxy -MemberType ScriptMethod -Name "createRequestObject" -Force -Value {
            Param ([String] $shortType)
            $request = New-Object -Type "com.callemall.powershell.$shortType"
            if ($request.GetType().GetProperties().Name -contains "username") {$request.username = $this.username}
            if ($request.GetType().GetProperties().Name -contains "pin") {$request.pin = $this.pin}
            return $request
        }
    }
	Process {
            [com.callemall.powershell.GetPersonIDDetailsRequestType] $request = $CallEmAllProxy.createRequestObject("GetPersonIDDetailsRequestType")
            $request.personID = $PersonID
            [com.callemall.powershell.GetPersonIDDetailsResponseType] $response = $CallEmAllProxy.GetPersonIDDetails($request)
            If ($response.errorCode -ne 0) {
                return $response.errorMessage
            } Else {
                return $response.ListContents
            }
    }
}

Export-ModuleMember -Function *