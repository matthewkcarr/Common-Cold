#@Author: Matt Carr
#Year: 2006
#This program implements the Dining Philosophers problem without solution 
#in python. To run type: python dining_philosophers_DEADLOCK.py 
#For more info see
#http://en.wikipedia.org/wiki/Dining_philosophers_problem
#NOTE: The time.sleep calls are in the code to keep us honest.  
#In other words, they are there to make the program run threads
#in a way a normal program might with I/O calls and/or API calls
#throughout the code. With out them, the if/else statement would not
#be necessary.  

import thread
import time
from threading import *



class Philosopher(Thread):

    global MAX
    
    def __init__(self, name, leftChopstick, rightChopstick):
        Thread.__init__(self)
        self.name = name
        self.leftChopstick = leftChopstick
        self.rightChopstick = rightChopstick

    def run(self):

        while 1:
	    self.leftChopstick.acquire()  #get the first chopstick
	    print self.name, "picked up left chopstick\n"
	    time.sleep(1)  # results in a deadlock/livelock
	    self.rightChopstick.acquire()  #get the second chopstick
	    print self.name, "picked up right chopstick\n"
   	    print self.name, "is Eating unagi-don\n"
	    time.sleep(1)
	    self.rightChopstick.release()
	    print self.name, "put down right chopstick\n"
    	    time.sleep(1)
	    self.leftChopstick.release()
	    print self.name, "put down left chopstick\n"
	    print self.name, "is thinking\n"
	    time.sleep(1)

if __name__ == "__main__":   #only execute if this is the main thread
    
    MAX = 5
    chopstick = []
    for i in range(MAX):
        lock = thread.allocate_lock()
	chopstick.append(lock)

    philosopher = []
    for i in range(MAX):
	if( i == MAX -1 ):
	    phil = Philosopher("Philosopher" + str(i), chopstick[i], chopstick[0])
	else:
            phil = Philosopher("Philosopher" + str(i), chopstick[i], chopstick[i+1])
        philosopher.append(phil)
        philosopher[i].start()

    for i in range(MAX):
        philosopher[i].join()
