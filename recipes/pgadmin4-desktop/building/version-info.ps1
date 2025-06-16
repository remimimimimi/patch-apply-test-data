# Create a version-info.ps1 file with this content:
$APP_RELEASE = (Select-String -Path "web\version.py" -Pattern "^APP_RELEASE").Line -replace "^APP_RELEASE\s*=\s*", "" -replace "\s+", "" -replace "'", ""
$APP_REVISION = (Select-String -Path "web\version.py" -Pattern "^APP_REVISION").Line -replace "^APP_REVISION\s*=\s*", "" -replace "\s+", "" -replace "'", ""
$APP_NAME = ((Select-String -Path "web\branding.py" -Pattern "^APP_NAME").Line -replace "^APP_NAME\s*=\s*", "" -replace "'", "" -replace "\s+", "").ToLower()
$APP_SUFFIX = (Select-String -Path "web\version.py" -Pattern "^APP_SUFFIX").Line -replace "^APP_SUFFIX\s*=\s*", "" -replace "\s+", "" -replace "'", ""

# Strip all trailing whitespace characters including carriage returns
$APP_RELEASE = $APP_RELEASE.Trim()
$APP_REVISION = $APP_REVISION.Trim()
$APP_NAME = $APP_NAME.Trim()
$APP_SUFFIX = $APP_SUFFIX.Trim()

# Output values in a format that's easy for bash to parse
# No quotes in the output to avoid path construction issues
Write-Output "APP_RELEASE=$APP_RELEASE"
Write-Output "APP_REVISION=$APP_REVISION"
Write-Output "APP_NAME=$APP_NAME"
Write-Output "APP_SUFFIX=$APP_SUFFIX"
