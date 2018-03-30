cd ~/CS/CS7011/Project/AWS;

PTH="/home/abhisheknaik96/CS/CS7011/Project/Screenshots/";
DIR="1v1_naive_noFreeze/";
logFile="20171031094334-base_left_0-vs-base_right_0.rcg";

# echo 'Copying from AWS...'
# scp -i "dqn-hfo.pem" ubuntu@ec2-34-229-165-30.compute-1.amazonaws.com:/data/Code/dqn-hfo/log/$logFile $PTH$DIR

#echo 'Recording screenshots...'
bash ../dqn-hfo/scripts/record.sh $PTH $DIR $logFile 

echo 'Terminated.'
