# download-images.ps1
# Download high-quality Karnataka images into the local images/ folder
# Usage (PowerShell):
#   cd 'C:\Users\Akshay bk\bk.html'
#   .\download-images.ps1
# This script uses Unsplash Source to fetch a representative image for each keyword.
# If you prefer other photos, replace the URLs with direct image links.

$images = @(
  @{keyword='hampi'; file='images/karnataka-hampi.jpg'},
  @{keyword='mysore palace'; file='images/karnataka-mysore.jpg'},
  @{keyword='coorg'; file='images/karnataka-coorg.jpg'},
  @{keyword='jog falls'; file='images/karnataka-jogfalls.jpg'},
  @{keyword='gokarna beach'; file='images/karnataka-gokarna.jpg'},
  @{keyword='belur halebidu'; file='images/karnataka-belur.jpg'}
)

if (-not (Test-Path -Path 'images')) { New-Item -ItemType Directory -Path 'images' | Out-Null }

foreach ($item in $images) {
    $kw = $item.keyword
    $out = $item.file
    $url = "https://source.unsplash.com/1600x900/?$([uri]::EscapeDataString($kw))"
    Write-Host "Downloading [$kw] -> $out"
    try {
        Invoke-WebRequest -Uri $url -OutFile $out -UseBasicParsing -ErrorAction Stop
        Write-Host "Saved $out"
    } catch {
        Write-Warning "Failed to download $kw. You can download manually and save as $out"
    }
    Start-Sleep -Milliseconds 800
}

Write-Host "Done. Open index.html locally to preview the gallery using the downloaded images."