# Run this as : ./run.sh > log.stdout

logDir="/data/logs"
snapshotDir="/data/snapshots/"
rcgDir="1v1naive_run2"

## 1v1naive
fileName="1v1naive_run2"
./bin/dqn --gpu -save=$snapshotDir/$fileName --offense_agents 1 --defense_goalie 2> $logDir/$fileName.stdout

## 1v1
# fileName="1v1h"
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --offense_agents 1 --defense_npcs 1 2> $logDir/$fileName.stdout

###############################################################################

## Share to replay memory
# fileName="2v0_sharedMemory"
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --share_replay_memory --offense_agents 2 2> $logDir/$fileName.stdout

# The raw command
# ./bin/dqn --gpu --save=/data/snapshots/2v0_sharedMemory -alsologtostderr --share_replay_memory --offense_agents 2 > /data/logs/2v0_sharedMemory.stdout

# To evaluate
# ./bin/dqn --gpu --evaluate --resume=$snapshotDir/$fileName -actor_snapshot $snapshotDir/$fileName_agent0_actor_iter_3080015.solverstate,$snapshotDir/$fileName_agent1_actor_iter_3080015.solverstate -critic_snapshot $snapshotDir/$fileName_agent1_critic_iter_3080015.solverstate,$snapshotDir/$fileName_critic1_iter_3080015.solverstate