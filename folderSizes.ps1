param (
    [Parameter(Mandatory=$true)]
    [string]$FolderPath
)

Get-ChildItem -Path $FolderPath -Directory | ForEach-Object {
    $folderSize = (Get-ChildItem $_.FullName -Recurse -File | Measure-Object -Property Length -Sum).Sum
    [PSCustomObject]@{
        FolderName = $_.Name
        SizeInBytes = $folderSize
        SizeInMB    = [math]::Round($folderSize / 1MB, 2)
    }
} | Format-Table -AutoSize
