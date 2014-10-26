$Names = Import-Csv C:\AccountNames\names.csv

foreach ($Name in $Names) {
    $First = $Name.FirstName
    $Last = $Name.LastName
    $findName = Get-ADUser -Filter "(GivenName -like '$First*') -and (SurName -like '$Last*')" -Properties title | Select-Object -Property Name,SamAccountName,Enabled,title
    If($findName){
        $findName | Export-Csv -Path C:\AccountNames\FoundNames.csv -Append
    }
    else {
        [PSCustomObject]@{Name=$First + ' ' + $Last; SAMAccountName='Not found'; Enabled=$null; Title=$null} | Export-Csv -Path C:\AccountNames\FoundNames.csv -Append
    }
}
