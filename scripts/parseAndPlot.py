import matplotlib.pyplot as plt
import numpy as np
import os, sys, re 
# from re import search
import argparse

def moving_average(inp,windowSize):
	filt = np.ones((windowSize))
	filt = filt/len(filt)
	out = np.convolve(inp, filt, "same")
	return out

# try:
# 	logFile = sys.argv[1]
# 	title = sys.argv[2]
# 	windowSize = 10
# except:	
# 	print 'Usage : python %s logFile plotTitle' % (sys.argv[0]) 
# 	sys.exit(1)

parser = argparse.ArgumentParser()
parser.add_argument('--logFile', type=str, required=True)
parser.add_argument('--plotTitle', type=str, default="Ille")
parser.add_argument('--windowSize', type=int, default=10)
parser.add_argument('--samplingCoeff', type=int, default=100)

try:
	args = parser.parse_args()
except:	
	# print 'Usage : python %s --logFile <logFile> --plotTitle <plotTitle>' % (sys.argv[0]) 
	print 'Usage : python %s --logFile <logFile>' % (sys.argv[0]) 
	sys.exit(1)

logFile = args.logFile
print args.plotTitle
plotTitle = logFile[0:re.search("INFO", logFile).start()-1] if args.plotTitle=="Ille" else args.plotTitle
os.system('grep Episode ' + logFile + ' > ' + logFile + '.log')
logFile = logFile + '.log'
# logFile = "1v0_embedNone_INFO_20180126-112051.2603.log"
# title = 'NoEmbed'
# logFile = "1v0_embedState_dim8_INFO_20180126-212522.3691"
# title = 'StateEmbed_dim8'
# tasks = ['move_to_ball', 'move_away_from_ball']
# maxRewards = [0.6, 0.7]
tasks = ['move_to_ball', 'kick_to_goal', 'soccer']
maxRewards = [0.6, 0.4, 1.0]

print 'Reading file...'
f = open(logFile, 'r')
lines = f.readlines()
data = [(float(rawData.split(',')[1].split(' ')[-1]), int(rawData.split(',')[-1].split(' ')[-1])) for rawData in lines]
# (rewards, taskIDs) = zip(*data)
print 'Parsing data...'
rewards_raw	= np.asarray([i for (i,j) in data])
taskIDs_raw = np.asarray([j for (i,j) in data])

print 'Preparing data...'
taskIDs, rewards, sampledIDs, rewards_smooth = {}, {}, {}, {}
for i in range(len(tasks)):
	rewards[i] = rewards_raw[taskIDs_raw==i]
	# sampling every 100th observation and normalizing with maximum possible reward in that task
	sampledIDs[i] = range(0, len(rewards[i]), args.samplingCoeff)
	rewards_smooth[i] = moving_average(rewards[i][sampledIDs[i]], args.windowSize)/maxRewards[i] 

# samplingIdx = range(0, len(rewards), 100)
# samplingIdx_t1 = [i for i in samplingIdx if taskIDs[i]==0]
# samplingIdx_t2 = [i for i in samplingIdx if taskIDs[i]==1]

# plt.plot(range(len(samplingIdx_t1)), rewards[samplingIdx_t1], c='red', linestyle='--', marker='o', label=tasks[taskIDs[samplingIdx_t1[0]]])
# plt.plot(range(len(samplingIdx_t2)), rewards[samplingIdx_t2], c='blue', linestyle='--', marker='o', label=tasks[taskIDs[samplingIdx_t2[0]]])

# rewards_t1_smooth = moving_average(rewards[samplingIdx_t1], args.windowSize)/maxRewards[0]
# rewards_t2_smooth = moving_average(rewards[samplingIdx_t2], args.windowSize)/maxRewards[1]

# # plt.plot(range(len(samplingIdx_t1)), rewards_t1_smooth, c='red', linestyle='--', marker='o', label=tasks[taskIDs[samplingIdx_t1[0]]])
# # plt.plot(range(len(samplingIdx_t2)), rewards_t2_smooth, c='blue', linestyle='--', marker='o', label=tasks[taskIDs[samplingIdx_t2[0]]])
# samplingIdx_t1 = samplingIdx_t1[:-args.windowSize/2]
# samplingIdx_t2 = samplingIdx_t2[:-args.windowSize/2]
# rewards_t1_smooth = rewards_t1_smooth[:-args.windowSize/2]
# rewards_t2_smooth = rewards_t2_smooth[:-args.windowSize/2]
# plt.plot(range(len(samplingIdx_t1)), rewards_t1_smooth, c='red', label=tasks[taskIDs[samplingIdx_t1[0]]])
# plt.plot(range(len(samplingIdx_t2)), rewards_t2_smooth, c='blue', label=tasks[taskIDs[samplingIdx_t2[0]]])

colors = ['red', 'blue', 'green']
offset = args.windowSize/2

print 'Plotting...'
for i, task in enumerate(tasks):
	plt.plot(range(len(sampledIDs[i])-offset), rewards_smooth[i][:-offset], c=colors[i], label=tasks[i])

#plt.ylim(-1.1, 1.1)
plt.ylim(-0.1, 1.1)
plt.xlabel('Episodes (x%s)' % (int(args.samplingCoeff)))
plt.ylabel('Reward per episode')
plt.title(plotTitle)
plt.legend(loc='lower right')
# plt.show(block=False)
plt.savefig(args.plotTitle + '_win' + str(args.windowSize))
plt.show()
