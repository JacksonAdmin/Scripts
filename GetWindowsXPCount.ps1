#Script to locate all of the Windows XP machines on the Domain "JHMR.com"

#Sets powershell to the domain, and changes the directory to the OU "Domain Computers"
Get-ADDomain
cd AD:
cd "DC=JHMR,DC=COM"
cd "OU=Domain Computers"

#Get all the computers in the domain that have Windows XP Operating System
Get-ADComputer -Filter {operatingSystem -like "Windows XP Professional"} -Property Description,whenCreated,whenChanged | 

#Exclude the Retired Computers OU
Where-Object {$_.DistinguishedName -notlike "*ou=Retired Computers - To be deleted,*"} |

#Formatting
Select-Object Name,Description,whenCreated,whenChanged |

#Outputs to a file
Export-Csv i:\WinXPComputers.csv -NoTypeInformation