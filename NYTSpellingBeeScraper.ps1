#https://www.shunn.net/bee/s/60
#The historical Bees are stored with a URL of this format

$startvalue = 59
#Shunn's record of the Bee starts at #59


$endValue = 1169
#Today's Bee is #1169. This number would have to be updated if the data were to be collected in the future


$val = $startvalue
#We need a value to iterate through the Bees

while($startvalue -le $endValue){

$data = Invoke-WebRequest -Uri ("https://www.shunn.net/bee/s/"+$val)
#Every time the script fires, query the next Bee

#$Data is always set to $null, otherwise the script spits out TRUE every time it finds a match
#With a bit of regex, we can grab the data we need

$null = ($data -match '<input type="text" name="string" value="(.*?)">')
$beeLetters = $matches[1] 
#Return the letters in the Bee


$null = ($data.content -match '<b>score:<\/b> (.*?) pts<br>')
$beeScore = $matches[1]
#Return the score of the Bee


$null = ($data.content -match '<b>words:<\/b>(.*?)<br>')
$beeWordCount = $matches[1]
#Return the word count of the Bee

$null = ($data.content -match '"click for monthly archive">Daily Spelling Bee<\/a> for (.*?)<\/span>')
$beeDate = $matches[1]
#Get the date of the Bee

$beeCenter = $beeLetters.ToCharArray()
#Get the Center Letter of the Bee. It's always the first letter in the string of letters

$null = ($data.content -match 'pangrams:<\/b>(.*?)<br>')
$beePGCount = $matches[1]
#Get the number of Pangrams for the bee

write-host ($beeLetters+"^"+$beeCenter[0]+ "^" +$beeScore+ "^" + $beeWordCount + "^" + $beeDate+ "^" + $beePGCount)
#Assemble the data. I used ^ as a delimiter, to make import into Excel easier.

$val++
#Iterate and move on to the next Bee
}


