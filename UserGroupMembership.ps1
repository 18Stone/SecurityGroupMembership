<#
    Author: J.C. Geribon 2017
        
    This script associates each user within a particular domain or OU 
    and the security group in which they belong.
    It then outputs the results into a csv for further examination.
    On each line of the output, it lists the user and the security group in which they are a member.
#>

Import-Module ActiveDirectory
$Groups = Get-ADGroup -Properties * -Filter * -SearchBase “OU=,DC=”

$Table = @()

$Record = @{
    "Group Name" = ""
    "UserName" = ""
}


Foreach($Group In $Groups) 
    
    { $Arrayofmembers = Get-ADGroupMember -identity $Group | select samaccountname

        foreach ($Member in $Arrayofmembers) 
        {
            $Record."Group Name" = $Group
            $Record."UserName" = $Member.samaccountname
            $objRecord = New-Object PSObject -property $Record
            $Table += $objrecord
        }
    }

#Write-Host $Table

$Table | Out-File "C:\Users\*" 