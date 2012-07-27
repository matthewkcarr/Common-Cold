#@Author: Matt Carr
#Year: 2006
#This program implements the Dining Philosophers problem and solution via
#Dijkstra's algorithm in python. To run type: python dining_philosophers_FIXED.py 
#For more info see
#http://en.wikipedia.org/wiki/Dining_philosophers_problem
#Essentially the problem is this.  There are MAX number of philosophers
#and MAX number of resources (chopsticks). Each philosopher must have
#two resources in order to work (eat).  
#NOTE: The time.sleep calls are in the code to keep us honest.  
#In other words, they are there to make the program run threads
#in a way a normal program might with I/O calls and/or API calls
#throughout the code. With out them, the if/else statement in run() would not
#be necessary.  

import thread
import time
from threading import *



class Philosopher(Thread):  #The philosopher (threads) that are 
                            #competing for chopsticks (resources/locks)
    global MAX              #Max number of philosophers and chopsticks

    #__init__ initializes the worker thread (philosopher)
    #it defines a name (thread ID), a left chopstick (resource 1), and 
    #a right chopstick (resource 2)
    def __init__(self, name, leftChopstick, rightChopstick):
        Thread.__init__(self)
        self.name = name
        self.leftChopstick = leftChopstick
        self.rightChopstick = rightChopstick

    #run is what the worker thread does when start() is called
    #In this case the philosopher first checks to see if he/she
    #is the 'last one' e.g. If max -1 is me.  If so then he
    #tries to pick up the right chopstick first. If not then
    #try to pick up the left chopstick first. 
    def run(self):

        while 1: #the threads will keep eating and thinking forever
            if( cmp( self.name, "Philosopher" + str(MAX - 1)) == 0):
                self.rightChopstick.acquire()
		print self.name, "picked up right chopstick\n"
		time.sleep(1)
                self.leftChopstick.acquire()
		print self.name, "picked up left chopstick\n"
            else:
		self.leftChopstick.acquire() 
		print self.name, "picked up left chopstick\n"
		time.sleep(1)  
		self.rightChopstick.acquire()
		print self.name, "picked up right chopstick\n"
            #I have both resources so now I can do the work
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
    
    MAX = 5                  #MAX number of threads/resouces set here
    chopstick = []           #the array of resources
    for i in range(MAX):
        lock = thread.allocate_lock()
	chopstick.append(lock) 

    philosopher = []         #array of threads
    for i in range(MAX):
        #if its the last philosopher make sure he shares a resource with the first
	if( i == MAX -1 ):
	    phil = Philosopher("Philosopher" + str(i), chopstick[i], chopstick[0])
	else: #Otherwise he shares a resource with the n-1 and n+1
            phil = Philosopher("Philosopher" + str(i), chopstick[i], chopstick[i+1])
        philosopher.append(phil)
        philosopher[i].start()

    for i in range(MAX):
        philosopher[i].join()
