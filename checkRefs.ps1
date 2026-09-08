$refs = @()
# use current directory context
$html = Get-Content '.\galeri.html' -Raw
foreach ($part in $html -split '"') {
    if ($part -match '\.jpe?g$') {
        $refs += $part
    }
}
1..33 | ForEach-Object { $refs += "cilalı$_.jpeg" }
$refs = $refs | Select-Object -Unique
$imgs = Get-ChildItem '.\img' -File | Select-Object -ExpandProperty Name
$un = $imgs | Where-Object { $_ -notin $refs }
$output = "Referenced count: $($refs.Count)`r`nImage count: $($imgs.Count)`r`nUnreferenced:`r`n" + ($un -join "`r`n")
Set-Content -Path '.\unrefs.txt' -Value $output -Encoding utf8
Write-Host "Done, results in unrefs.txt"