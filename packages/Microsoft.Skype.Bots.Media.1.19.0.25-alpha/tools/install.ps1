param($installPath, $toolsPath, $package, $project)
 
# $installPath is the path to the folder where the package is installed.
# $toolsPath is the path to the tools directory in the folder where the package is installed.
# $package is a reference to the package object.
# $project is a reference to the project the package was installed to.

$packageName = [System.IO.Path]::GetFileName($installPath)

#logging
write-host "project: " $project.FullName
write-host "installPath: " $installPath
write-host "toolsPath: " $toolsPath
write-host "package: " $package
write-host "project: " $project
 
function AddLinkedFiles($path, $addLocation) 
{ 
    write-host "path: " $path
    write-host "addLocation: " $addLocation.FullName
    
    #Create Folder
    $folderName = $path.Split('\')[-1]
    write-host "Creating the Folder: " $folderName
    
    try
    {
        $addLocation.ProjectItems.AddFolder($folderName)
    }
    catch [Exception]
    {
        echo $_.Exception.GetType().FullName, $_.Exception.Message
    }
    
    $folder = $project.ProjectItems.Item($folderName)
    
    foreach ($item in Get-ChildItem $path)
    {               
        write-host "Adding " $item.FullName " to " $addLocation.FullName   
        $folder.ProjectItems.AddFromFile($item.FullName)
    } 
}

Function Set-IfNewerCopyDirectoryToOutputRecursive
{
       # Recursively set the "Copy to Output Directory" property to "Copy if newer" (2)
        param(
            [object]$item
        )

        if(-not $item)
        {
            return
        }
	   
        $item.ProjectItems | ForEach-Object {
            $n = $_.Name
            Write-Host "processing $n"
            
            if($_.ProjectItems.Count -gt 0)
            {
                # This is a directory, recurse
                Set-IfNewerCopyDirectoryToOutputRecursive $_
            }
            else
            {            
                try
                {
                    # 1 = always, 2 = if newer
                    $_.Properties.Item("CopyToOutputDirectory").Value = 2
                }
                catch [Exception]
                {
                    echo $_.Exception.GetType().FullName, $_.Exception.Message
    			      }
                  
                try
                {
                    $_.Properties.Item("ItemType").Value = "None" #don't try to build.
                }
                catch [Exception]
                {
                    echo $_.Exception.GetType().FullName, $_.Exception.Message
                }
            }
        }
}
  
# Variables
$skypemedialibContent = "src\skype_media_lib"
$skypemedialibPath = [System.IO.Path]::Combine($installPath, $skypemedialibContent)
write-host "skypemedialibPath: " $skypemedialibPath
 
$projectDir = [System.IO.Path]::GetDirectoryName($project.FullName)
write-host "projectDir: " $projectDir
 
write-host "Calling AddLinkedFiles"

AddLinkedFiles $skypemedialibPath $project 
Set-IfNewerCopyDirectoryToOutputRecursive($project.ProjectItems.Item("skype_media_lib"))