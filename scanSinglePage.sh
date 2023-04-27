### SCAN PDF FILES FROM FUJITSU SCANSNAP S1300 ###
### VARIABLE DEFINITIONS ###
SCANDEVICE="epjitsu:libusb:001:003"
SCANDIR="/media/USB/scanDir/Pi4Scan-"
DATETIME=`date '+%d%m%Y_%H-%M-%S'`
FORMAT=".jpg"
FILE=$SCANDIR$DATETIME$FORMAT
PDFFILE=${FILE/.jpg/.pdf}

### SCAN PAGE ###
scanimage > $FILE --format jpeg --resolution=300 -p -d $SCANDEVICE --batch-prompt

### DELETE EMPTY FILES ###
if [[ ! -s $FILE ]] ; then
        echo "EMPTY FILES WILL BE DELETET!"
        rm $FILE
        exit 1
fi

### ROTATE PICTURE ###
mogrify -rotate 180 $FILE

### EXPORT TO PDF ###
convert $FILE $PDFFILE

### DELETE OLD JPG File ###
rm $FILE

echo "Scanned to: " $PDFFILE
