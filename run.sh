# Run this as : ./run.sh > log.stdout

logDir="/data/logs"
snapshotDir="/data/snapshots"

####################################
# Task-embedding for the soccer tasks
# !!!!  do this only after some demonstration of 2-player curriculum tasks
####################################

#fileName="1v0_soccer_embedState_dim8_seq"
#./bin/dqn --gpu -save=$snapshotDir/$fileName -max_iter 1000000 -tasks move_to_ball,kick_to_goal,soccer -state_embed -embed_dim 8 -curriculum sequential > $logDir/$fileName.stdout

fileName="1v0_soccer_embedState_dim8_seq_2.5m"
./bin/dqn --gpu -save=$snapshotDir/$fileName -max_iter 2500000 -tasks move_to_ball,kick_to_goal,soccer -state_embed -embed_dim 8 -curriculum sequential > $logDir/$fileName.stdout


####################################
# Task-embedding for sanity test
####################################

#fileName="1v0_embedNone"
#./bin/dqn --gpu -save=$snapshotDir/$fileName -max_iter 1000000 -offense_agents 1 -tasks move_to_ball,move_away_from_ball > $logDir/$fileName.stdout

#fileName="1v0_embedState_dim8"
#./bin/dqn --gpu -save=$snapshotDir/$fileName -max_iter 1000000 -offense_agents 1 -tasks move_to_ball,move_away_from_ball -state_embed -embed_dim 8 > $logDir/$fileName.stdout

#fileName="1v0_embedState_dim32"
#./bin/dqn --gpu -save=$snapshotDir/$fileName -max_iter 1000000 -offense_agents 1 -tasks move_to_ball,move_away_from_ball -state_embed -embed_dim 32 > $logDir/$fileName.stdout

#fileName="1v0_embedWeight_dim32"
#./bin/dqn --gpu -save=$snapshotDir/$fileName -max_iter 1000000 -offense_agents 1 -tasks move_to_ball,move_away_from_ball -weight_embed -embed_dim 32 > $logDir/$fileName.stdout

####################################

# fileName="1v1naive_run2"
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --max_iter 2500000 --offense_agents 1 --defense_goalie > $logDir/$fileName.stdout
# actor0=$snapshotDir/$fileName_agent0_actor_iter_1740000.solverstate
# actor1=$snapshotDir/$fileName_agent1_actor_iter_1740000.solverstate
# critic0=$snapshotDir/$fileName_agent0_critic_iter_1740000.solverstate
# critic1=$snapshotDir/$fileName_agent1_critic_iter_1740000.solverstate
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --share_replay_memory --log_game --offense_agents 2 --evaluate --repeat_games 10 --evaluate_with_epsilon 0 --actor_snapshot $actor0,$actor1 --critic_snapshot $critic0,$critic1 

## 2v1
# fileName="2v1h_run3"
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --max_iter 3000000 --offense_agents 2 --defense_npcs 1 > $logDir/$fileName.stdout

## 2v1 (with passing)
# fileName="2v1h_passing_run2"
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --max_iter 3000000 --offense_agents 2 --defense_npcs 1 > $logDir/$fileName.stdout


## 2v1 (with passing)
# fileName="2v1h_passing_sharing"
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --max_iter 3000000 --share_replay_memory --offense_agents 2 --defense_npcs 1 > $logDir/$fileName.stdout

## 1v1naive (naive keeper)
#fileName="1v1naive_noFreeze"
## ./bin/dqn --gpu -save=$snapshotDir/$fileName --max_iter 2500000 --offense_agents 1 --defense_goalie --startAfter 100000 > $logDir/$fileName.stdout
#actor0=$snapshotDir/${fileName}_agent0_actor_iter_2500010.solverstate
#critic0=$snapshotDir/${fileName}_agent0_critic_iter_2500010.solverstate
## ./bin/dqn --gpu -save=$snapshotDir/${fileName}_eval --log_game --offense_agents 1 --defense_goalie --startAfter 0 --evaluate --repeat_games 10 --evaluate_with_epsilon 0 --actor_snapshot $actor0 --critic_snapshot $critic0
#./bin/dqn --gpu -save=$snapshotDir/${fileName}_eval --offense_agents 1 --defense_goalie --startAfter 0 --evaluate --repeat_games 20 # --evaluate_with_epsilon 0 --actor_snapshot $actor0 #--critic_snapshot $critic0
#echo "./bin/dqn --gpu -save=$snapshotDir/${fileName}_eval --offense_agents 1 --defense_goalie --startAfter 0 --evaluate --repeat_games 10 --evaluate_with_epsilon 0 --actor_snapshot $actor0 --critic_snapshot $critic0"

## 1v1
# fileName="1v1h"
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --offense_agents 1 --defense_npcs 1 > $logDir/$fileName.stdout

## Share to replay memory
# fileName="2v0_sharedMemory_run4"
# ./bin/dqn --gpu -save=$snapshotDir/$fileName --share_replay_memory --max_iter 3000000 --offense_agents 2 > $logDir/$fileName.stdout

# The raw command
# ./bin/dqn --gpu --save=/data/snapshots/2v0_sharedMemory -alsologtostderr --share_replay_memory --offense_agents 2 > /data/logs/2v0_sharedMemory.stdout

# To evaluate
# ./bin/dqn --gpu --evaluate --resume=$snapshotDir/$fileName -actor_snapshot $snapshotDir/$fileName_agent0_actor_iter_3080015.solverstate,$snapshotDir/$fileName_agent1_actor_iter_3080015.solverstate -critic_snapshot $snapshotDir/$fileName_agent1_critic_iter_3080015.solverstate,$snapshotDir/$fileName_critic1_iter_3080015.solverstate
