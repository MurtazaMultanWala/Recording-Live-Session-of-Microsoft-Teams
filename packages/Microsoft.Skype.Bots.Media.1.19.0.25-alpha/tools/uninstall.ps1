param(
       $installPath, # the path to the folder where the package is installed
       $toolsPath,   # the path to the tools directory in the folder where the package is installed
       $package,     # a reference to the package object.
       $project      # a reference to the EnvDTE project object and represents the project the package is installed into.
                     # http://msdn.microsoft.com/en-us/library/51h9a6ew(v=VS.80).aspx                           
)

Function Delete-ProjectItemIfExists
{
       param(
              [object]$item
       )

       if(-not $item)
       {
              return
       }
       try
       {
            $item.Delete()
       }
       catch [Exception]
       {
            echo $_.Exception.GetType().FullName, $_.Exception.Message
       }
 }

&{
    
    Write-Host "Modifying project to remove all the Skype Media Bots SDK files."
    
    if($project -and $project.ProjectItems)
    {    
       Delete-ProjectItemIfExists($project.ProjectItems.Item("skype_media_lib"))
    }
} 