<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '473,712'
$Form.text                       = "Form"
$Form.TopMost                    = $false

$ListBox1                        = New-Object system.Windows.Forms.ListBox
$ListBox1.text                   = "listBox"
$ListBox1.width                  = 449
$ListBox1.height                 = 332
$ListBox1.location               = New-Object System.Drawing.Point(11,197)
$ListBox1.Font                   = 'Courier New, 21'

$btnCheckLocked                  = New-Object system.Windows.Forms.Button
$btnCheckLocked.text             = "Check lock state"
$btnCheckLocked.width            = 128
$btnCheckLocked.height           = 48
$btnCheckLocked.location         = New-Object System.Drawing.Point(26,25)
$btnCheckLocked.Font             = 'Microsoft Sans Serif,10'

$btnUnlockSelected               = New-Object system.Windows.Forms.Button
$btnUnlockSelected.text          = "Unlock selected"
$btnUnlockSelected.width         = 155
$btnUnlockSelected.height        = 39
$btnUnlockSelected.location      = New-Object System.Drawing.Point(287,28)
$btnUnlockSelected.Font          = 'Microsoft Sans Serif,10'

$btnUnlockAll                    = New-Object system.Windows.Forms.Button
$btnUnlockAll.text               = "Unlock all"
$btnUnlockAll.width              = 87
$btnUnlockAll.height             = 36
$btnUnlockAll.location           = New-Object System.Drawing.Point(187,131)
$btnUnlockAll.Font               = 'Microsoft Sans Serif,10'

$lblAantalLocks                  = New-Object system.Windows.Forms.Label
$lblAantalLocks.text             = "0"
$lblAantalLocks.AutoSize         = $true
$lblAantalLocks.width            = 25
$lblAantalLocks.height           = 10
$lblAantalLocks.location         = New-Object System.Drawing.Point(41,602)
$lblAantalLocks.Font             = 'Microsoft Sans Serif,21'
$lblAantalLocks.ForeColor        = "#f0ff00"

$Form.controls.AddRange(@($ListBox1,$btnCheckLocked,$btnUnlockSelected,$btnUnlockAll,$lblAantalLocks))

$btnCheckLocked.Add_MouseClick({ CheckLockState })
$ListBox1.Add_DoubleClick({ UnlockSelected })
$btnUnlockAll.Add_Click({ UnlockAll })

function UnlockAll { }
function UnlockSelected { }
function CheckLockState { }



#Write your logic code here
$teller = 0
function CheckLockState {
    $Listbox1.Items.Clear()
        Search-ADAccount -LockedOut | Select-Object -Property Name,LastLogonDate | Export-Csv -Path 'C:\Users\abderahman.mahmoud\OneDrive - Royal Reesink B.V\LockedUsers.csv' -Append
        $AllLockedUsers = Search-ADAccount -LockedOut 
        
        ForEach ($user in $AllLockedUsers)

                {
[void] $ListBox1.Items.Add($User.SamAccountName)
$teller += 1
$lblAantalLocks.Text = $teller

                }
}

function UnlockSelected{
   Unlock-ADAccount $Listbox1.SelectedItem
}
function UnlockAll{
    Search-ADAccount -LockedOut | Unlock-ADAccount
    $Listbox1.Items.Clear()
}
[void]$Form.ShowDialog()