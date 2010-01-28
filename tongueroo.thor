#!/usr/bin/env ruby

class Git < Thor
  desc "pullall", "git pull all the subdirectories"
  def pullall
    Dir["*"].each {|f|
      if File.directory?(f)
        Dir.chdir(f) {
          puts "changing into directory #{f} and git pulling latest code"
          cmd = "git pull"
          puts cmd
          puts `#{cmd}`
        }
      end
    }
  end
end

class Ssh < Thor
  def initialize(args=[], options={}, config={})
    super
    @yaml_file = File.expand_path("~/.thor/ssh_already_uploaded.yml")
  end
  
	desc "clear_ec2", "clear out ec2 known hosts"
	def clear_ec2
	  puts `grep -v 'compute-1.amazonaws.com' ~/.ssh/known_hosts > ~/.ssh/known_hosts.tmp`
	  puts `mv ~/.ssh/known_hosts.tmp ~/.ssh/known_hosts`
  end

	desc "upload", "say hello"
	method_options :servers => :array
	def upload
	  puts "uploading ssh keypair to servers..."
    # @keypair = ask("What is the name of the ssh keypair you want to upload from your .ssh dir? (id_rsa.pub)")
		@keypair = 'id_rsa.pub' if @keypair.nil? or @keypair.empty?
		servers = options[:servers]
		servers.each do |server|
		  upload_keypair(server)
	  end
	end
	
	private
	  def upload_keypair(server)
	    if already_uploaded?(server)
	      puts "already uploaded this keypair to #{server}"
      else
  	    cmd = "ssh-copy-id -i ~/.ssh/#{@keypair} #{server}"
  	    puts cmd
  	    run cmd
  	    update_uploaded(server)
        # run cmd
      end
	  end
	  
	  def read_servers
	    if File.exist? @yaml_file
  	    servers = YAML.load(File.read(@yaml_file))
      else
        servers = []
      end
	  end

	  def already_uploaded?(server)
	    servers = read_servers
      servers.include?(server)
	  end
	  
	  def update_uploaded(server)
	    servers = read_servers
	    servers << server
	    File.open(@yaml_file, 'w') {|f| YAML.dump(servers,f)}
	  end
	  
	  def run(cmd)
	    `#{cmd}`
	  end
end

