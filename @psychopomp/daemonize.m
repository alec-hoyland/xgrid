function daemonize(self)
	

% stop all existing timers
t = timerfindall;
for i = 1:length(t)
	if any(strfind(func2str(t(i).TimerFcn),'psychopomp'))
		stop(t(i))
		delete(t(i))
	end
end


% add the ~/.psych folder to the path so that sim functions can be resolved
addpath('~/.psych')


self.daemon_handle = timer('TimerFcn',@self.psychopompd,'ExecutionMode','fixedDelay','TasksToExecute',Inf,'Period',.5);
start(self.daemon_handle);

% make sure the parpool never shuts down 
try
	pool = gcp('nocreate');
	pool.IdleTimeout = Inf;
catch
end
