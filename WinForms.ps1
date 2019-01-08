Add-Type -assembly System.Windows.Forms
Add-Type -assembly System.Drawing
Add-Type -AssemblyName Microsoft.VisualBasic

$main_form = New-Object System.Windows.Forms.Form
$main_form.Text = 'PowerShell Commander'
$main_form.Width = 600
$main_form.Height = 400
$main_form.AutoSize = $true
$gbHeight = $main_form.Height

$groupboxL = New-Object system.Windows.Forms.Groupbox
$groupboxL.Height = $gbHeight
$groupboxL.Width = $main_form.Width / 2
$groupboxL.Text = "pane L"
$groupboxL.location = New-Object System.Drawing.Point(0,0)

#Add pathBox
$pathBox = New-Object System.Windows.Forms.TextBox
$pathBox.Location = New-Object System.Drawing.Point(5,5)
$pathBox.Size = New-Object System.Drawing.Size(260,20)

$pathBox.Add_KeyDown({
    if ($_.KeyCode -eq "Enter") {
	
        $output = $pathBox.Text 
							 
		$files = Get-ChildItem -Path "$output"
		
		$leftFileList.Items.Clear();
		
		foreach ($file in $files)
		{	
			if ($file.length -gt 20000)
			{
				#Write-Output $file.Name | Out-Host
				$leftFileList.Items.Add($file.Name)
			}
		}
		
		
    }
})

$groupboxL.Controls.Add($pathBox)

# Add Button
$Button = New-Object System.Windows.Forms.Button
$Button.Location = New-Object System.Drawing.Size(35,35)
$Button.Size = New-Object System.Drawing.Size(120,23)
$Button.Text = "search"

#Add Button event 
$Button.Add_Click({ $leftFileList.Items.Clear(); $leftFileList.Items.Add('atl-dc-008')})
#$groupboxL.Controls.Add($Button)

# Add list box.
$leftFileList = New-Object System.Windows.Forms.ListBox
$leftFileList.Location = New-Object System.Drawing.Size(10,40)
$leftFileList.Size = New-Object System.Drawing.Size(295,200)
$leftFileList.location = New-Object System.Drawing.Point(0,50)
$leftFileList.Height = 400

$groupboxL.Controls.Add($leftFileList)

$main_form.Controls.AddRange(@($groupboxL,$files))
$groupboxL.Controls.AddRange(@($files))

$groupboxR = New-Object system.Windows.Forms.Groupbox
$groupboxR.Height = $gbHeight
$groupboxR.Width = $main_form.Width / 2
$groupboxR.Text = "pane R"
$position = $main_form.Width / 2
$groupboxR.location = New-Object System.Drawing.Point($position,0)

$main_form.Add_Shown({$pathBox.Select()})

$main_form.controls.AddRange(@($groupboxR,$files))
$groupboxR.Controls.AddRange(@($files))

$result = $main_form.ShowDialog()







