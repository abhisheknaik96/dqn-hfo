import matplotlib.pyplot as plt
import numpy as np
import os, sys, re 
# from re import search
import argparse
from matplotlib import rcParams
rcParams['font.family'] = 'Ubuntu'
rcParams['font.size'] = 15

def moving_average(inp,windowSize):
	filt = np.ones((windowSize))
	filt = filt/len(filt)
	out = np.convolve(inp, filt, "same")
	return out

parser = argparse.ArgumentParser()
parser.add_argument('--logFile', type=str, required=True)
parser.add_argument('--plotTitle', type=str, default="Ille")
parser.add_argument('--windowSize', type=int, default=10)
parser.add_argument('--samplingCoeff', type=int, default=1)

try:
	args = parser.parse_args()
except:	
	print 'Usage : python %s --logFile <logFile>' % (sys.argv[0]) 
	sys.exit(1)

print 'Collecting data...'
logFile = args.logFile
plotTitle = logFile[0:re.search("INFO", logFile).start()-1] if args.plotTitle=="Ille" else args.plotTitle
print plotTitle
fromLog = True if 'log' in logFile else False


if not fromLog:
	
	try:
		os.system('grep "Evaluation:" ' + logFile + ' > ' + logFile + '.log')
	except Exception as e:
		print 'File does not exist. Check the logFile location.'
		sys.exit(1)
		
	logFile = logFile + '.log'
# # tasks = ['move_to_ball', 'move_away_from_ball']
# # maxRewards = [0.6, 0.7]
tasks = ['MoveToBall', 'KickToGoal', 'Soccer']
# maxRewards = [0.6, 0.4, 1.0]
axisFactor = 10000

print 'Reading file...'
f = open(logFile, 'r')
lines = f.readlines()
data = [(int(rawData.split(',')[0].split(' ')[-1]), float(rawData.split(' ')[-1])) for rawData in lines]
(iteration, performance_raw) = zip(*data)
iteration = np.asarray(iteration)/axisFactor
performance_raw = np.asarray(performance_raw)
print 'Parsing data...'
# performance_raw	= np.asarray([i for (i,j) in data])
# taskIDs_raw = np.asarray([j for (i,j) in data])

print 'Preparing data...'
performance, sampledIDs, performance_smooth = {}, {}, {}
for i in range(len(tasks)):
	performance[i] = performance_raw[range(i, len(performance_raw), len(tasks))]
	# sampling every nth observation and normalizing with maximum possible reward in that task
	sampledIDs[i] = range(0, len(performance[i]), args.samplingCoeff)
	performance_smooth[i] = moving_average(performance[i][sampledIDs[i]], args.windowSize) 

colors = ['red', 'blue', 'green']
offset = args.windowSize/2

# plt.figure(figsize=(12, 9))  
ax = plt.subplot(111)  
ax.spines["top"].set_visible(False)  
ax.spines["right"].set_visible(False)  


print 'Plotting data...'
for i, task in enumerate(tasks):
	plt.plot(iteration[0::3][:-offset], performance_smooth[i][:-offset], c=colors[i], label=tasks[i])
	plt.plot(iteration[0::3][:-offset], performance[i][:-offset], c=colors[i], alpha=0.1)

#plt.ylim(-1.1, 1.1)
plt.ylim(-0.1, 1.1)
# plt.xlabel('Iterations (x%s)' % (int(args.samplingCoeff)))
# plt.rc('text', usetex=True)
plt.ylabel('Performance')
# plt.ylabel(r'{\fontsize{30pt}{3em}\selectfont{}{Mean WRFv3.5 LHF\r}{\fontsize{18pt}{3em}\selectfont{}(September 16 - October 30, 2012)}')
# xlabel = 
plt.xlabel(r'Iterations ($\times%s$)' % axisFactor)
# plt.xticks(np.arange(iteration[-1]), iteration[0::3]/axisSampleFactor)
# plt.xticks(np.arange(min(x), max(x)+1, 1.0))
# plt.title(plotTitle)
plt.legend(loc='lower right')
# plt.show(block=False)

fileName = plotTitle + '_win' + str(args.windowSize)
print 'Saving plot... (%s)' % fileName
plt.savefig(fileName)
plt.show()
