# Define connection parameters
$server = "IN-PG02P63G"
$database = "devops"
$username = "sa"
$password = "Passw0rd@1234"

# Define SQL command to execute
$sqlCommand = "SELECT top 1 * FROM DEVOPSCONNECT"

# Create connection object
$connectionString = "Server=$server;Database=$database;User Id=$username;Password=$password;"
$connection = New-Object System.Data.SqlClient.SqlConnection($connectionString)

# Open database connection
$connection.Open()

# Create command object and set SQL command
$command = New-Object System.Data.SqlClient.SqlCommand($sqlCommand, $connection)

# Execute SQL command and store results
$results = $command.ExecuteReader()

# Output results
#$results | Format-Table -AutoSize
 $tableVersion = new-object "System.Data.DataTable"
                $tableVersion.Load($results)

foreach ($item in $tableVersion.Rows) {
                        Write-Host  "'"$item[0]"','"$item[1] "','"$item[2]"' ,'"$item[3]"' ,'"$item[4] "' ,"$item[5] " ,'"$item[6]"' ,'"$item[7]"'"
               }

# Close database connection
$connection.Close()