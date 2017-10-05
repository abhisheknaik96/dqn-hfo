# Run this as : ./run.sh > stdout.log

logDir="/data/logs"
snapshotDir="/data/snapshots"
fileName="2v0_sharedMemory"

./bin/dqn --gpu -save=$snapshotDir/$fileName -alsologtostderr --share_replay_memory --offense_agents 2 2> $logDir/$fileName.stdout

# ./bin/dqn --gpu -save=/data/snapshots/2v0_sharedMemory -alsologtostderr --share_replay_memory --offense_agents 2 > /data/logs/2v0_sharedMemory.stdout