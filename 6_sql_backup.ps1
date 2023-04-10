$folderPath = "D:\Backup"

$files = Get-ChildItem $folderPath

foreach ($file in $files) {
    if ($file.Extension -eq ".bak") {
        if ($file.LastWriteTime -lt (Get-Date).AddDays(-7)) {
            Remove-Item $file.FullName
        }
    }
}