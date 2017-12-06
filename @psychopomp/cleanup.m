%                          _                                       
%                         | |                                      
%     _ __  ___ _   _  ___| |__   ___  _ __   ___  _ __ ___  _ __  
%    | '_ \/ __| | | |/ __| '_ \ / _ \| '_ \ / _ \| '_ ` _ \| '_ \ 
%    | |_) \__ \ |_| | (__| | | | (_) | |_) | (_) | | | | | | |_) |
%    | .__/|___/\__, |\___|_| |_|\___/| .__/ \___/|_| |_| |_| .__/ 
%    | |         __/ |                | |                   | |    
%    |_|        |___/                 |_|                   |_|
%  

function cleanup(self)
	do_folder = [self.psychopomp_folder oss 'do' oss ];
	doing_folder = [self.psychopomp_folder oss 'doing' oss ];
	done_folder = [self.psychopomp_folder oss 'done' oss ];

	% remove all .ppp files
	allfiles = dir([do_folder '*.ppp']);
	for i = 1:length(allfiles)
		delete(joinPath(allfiles(i).folder,allfiles(i).name))
	end
	allfiles = dir([doing_folder '*.ppp']);
	for i = 1:length(allfiles)
		delete(joinPath(allfiles(i).folder,allfiles(i).name))
	end
	allfiles = dir([done_folder '*.ppp']);
	for i = 1:length(allfiles)
		delete(joinPath(allfiles(i).folder,allfiles(i).name))
	end

	allfiles = dir([done_folder '*.ppp.data']);
	for i = 1:length(allfiles)
		delete(joinPath(allfiles(i).folder,allfiles(i).name))
	end

	% cleanup all remotes
	for i = 1:length(self.clusters)
		if strcmp(self.clusters(i).Name,'local')
			continue
		end
		command = 'cleanup';
		save('~/.psychopomp/com.mat','command')
		[e,o] = system(['scp ~/.psychopomp/com.mat ' self.clusters(i).Name ':~/.psychopomp/']);
		assert(e == 0,'Error copying command onto remote')
	end
end