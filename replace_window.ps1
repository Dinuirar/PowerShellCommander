Add-Type -assembly System.Windows.Forms
Add-Type -assembly System.Drawing

$file_name = $args[0]
$path = $args[1]

$start_form = New-Object System.Windows.Forms.Form
$start_form.Text = 'Create new dir'
$start_form.Size = New-Object System.Drawing.Size(350,140)
$start_form.StartPosition = 'CenterScreen'
$start_form.FormBorderStyle = 'FixedDialog'
$start_form.MinimizeBox = $False
$start_form.MaximizeBox = $False

$Label = New-Object System.Windows.Forms.Label
$Label.Location = New-Object System.Drawing.Point(10,15)
$Label.Size = New-Object System.Drawing.Size(350,25)
$Label.Text = "Give a new name for file <$file_name> "
$Label.Font = New-Object System.Drawing.Font("Arial",8)
$start_form.Controls.Add($Label)

$pathBoxUp = New-Object System.Windows.Forms.TextBox
$pathBoxUp.Location = New-Object System.Drawing.Point(15, 40)
$pathBoxUp.Size = New-Object System.Drawing.Size(10, 20)
$pathBoxUp.Width = 300
$pathBoxUp.Text = "New file name"
$start_form.Controls.Add($pathBoxUp)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(10,80)
$okButton.Size = New-Object System.Drawing.Size(90,23)
$okButton.Text = 'OK'
$start_form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(180,80)
$cancelButton.Size = New-Object System.Drawing.Size(90,23)
$cancelButton.Text = 'Cancel'
$start_form.Controls.Add($cancelButton)

$okButton.Add_Click(
{   
    $newFileName = $pathBoxUp.Text

    Rename-Item -Path $path -NewName $newFileName
    
	[System.Windows.Forms.MessageBox]::Show("Successfuly rename file " ,"Rename result")
    $start_form.Close()
}
)
$cancelButton.Add_click(
{
    $start_form.Close()
}
)

$result = $start_form.ShowDialog()