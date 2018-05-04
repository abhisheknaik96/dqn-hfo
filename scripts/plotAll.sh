LOGDIR='/home/abhisheknaik96/Nike/Thesis/Plots/logs/'
PLOTDIR='/home/abhisheknaik96/Nike/Thesis/Plots/'

for fullname in $LOGDIR*.log; do
	filename=${fullname##*/}
	plotname=${filename%_INFO*}
	python scripts/parseAndPlot.py --logFile $LOGDIR$filename --plotTitle $PLOTDIR$plotname --windowSize 35 
	echo "Done with" $filename
done