iwr https://wallpapercave.com/wp/wp3805150.jpg -OutFile hasselhoff.jpg

[CmdletBinding()]
$Style = 'Fill'
$Tiled = '0'
#---------------------------------------------------#
#  Hash Table for WallPaper Style Value             #
#---------------------------------------------------#

$Wstyle = @{
            'Centered'  = 0
            'Stretched' = 2
            'Fill'      = 10
            'Fit'       = 6
            'Span'      = 22
}

#-----------------------------------------------------------------#
#  Hash Table for Tiles Option. Tiles can be set to 1             #
#  if Wstyle is centered. Otherwise, should be set to 0           #
#-----------------------------------------------------------------#

$WTile = @{
            'Tiles'     = 1
            'NoTiles'   = 0                      
        }

    #Main Code
    $code = @'
    using System.Runtime.InteropServices;
    namespace Win32{
     public class Wallpaper{
        [DllImport("user32.dll", CharSet=CharSet.Auto)]
         static extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ;
         public static void SetWallpaper(string thePath){
            SystemParametersInfo(20,0,thePath,3);
         }
    }
 }
'@

if ($error[0].exception -like "*Cannot add type. The type name 'Win32.Wallpaper' already exists.*")
{
    write-host "Win32.Wallpaer assemblies already loaded"
    write-host "Proceeding"
} else {
    add-type $code
}

# Code for settings TileStyle and Wallpaper Style
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name wallpaperstyle -Value $Wstyle[$Style]
Set-ItemProperty -Path 'HKCU:\Control Panel\Desktop' -Name TileWallpaper -Value $WTile[$Tiled]

#Apply the Change on the system
$Path="hasselhoff.jpg"
[Win32.Wallpaper]::SetWallpaper($Path)
