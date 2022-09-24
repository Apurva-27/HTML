5) Installation of Java
Prerequisite :
	1. Centos 7.9(RHEL) should be already installed  on machine with the following architecture.  
                      RAM:   2 GB RAM
                      HD:   10 GB Avg local disk storage.
                      Software requirement:  GOLANG (go1.11.5 linux/amd64) 
	2.Download the 'jdk-18_linux-x64_bin.rpm'  from the below link.
URL: https://download.oracle.com/java/18/latest/jdk-18_linux-x64_bin.rpm

Steps:
	1.To install 'jdk-18_linux-x64_bin.rpm' package run below command.
              # rpm -ivh jdk-18_linux-x64_bin.rpm

Verification:
	1. To verify java installation run below command to check java version.
              # java -version

----------------------------------------------------------------------------------------------------------------------------------
6) Installation of application 

Common Prerequisite :
	1. Centos 7.9(RHEL) should be already installed  on machine with the following architecture.  
                      RAM:   2 GB RAM
                      HD:   10 GB Avg local disk storage.
                      Software requirement:  GOLANG (go1.11.5 linux/amd64) 
	
1.Tomcat
Prerequisite for Tomcat :
	i.'apache-tomcat-10.1.0-M17.tar.gz' must be downloaded from below url.
	URL:https://archive.apache.org/dist/tomcat/tomcat-10/v10.1.0-M17/bin/apache-tomcat-10.1.0-M17.tar.gz
	ii.Item no.5 must be performed.
Install Tomcat:
		i.Make 'tomcat' directory in 'opt' directory using below command:
                    # mkdir /opt/tomcat
		ii.Extract downloaded tomcat tar.gz file in opt/tomcat using below command:
                    # sudo tar xzvf apache-tomcat-10.1.0-M17.tar.gz -C /opt/tomcat/ --strip-components=1
		iii.New tomcat user needs execute privileges over the directory by using below command:
                    # sudo chown -R tomcat:tomcat /opt/tomcat
                    # sudo sh -c 'chmod +x /opt/tomcat/bin/*.sh'
		iv. Find the Java location with the following command:
                    # readlink -f $(which java)

2.Wildfly
Prerequisite for Wildfly:
	i. 'wildfly-26.1.1.Final.tar.gz' must be downloaded from below URL:
	URL:https://github.com/wildfly/wildfly/releases/download/26.1.1.Final/wildfly-26.1.1.Final.tar.gz
Install Wildfly	
	i. Extract the downloaded tomcat tar.gz file in opt/tomcat using the below command:
                # sudo tar xf <downloaded_dir>/wildfly-26.1.1.Final.tar.gz -C /opt/
	ii.Rename wildfly-26.1.1.Final.tar.gz to wildfly using the below command:
                # mv  /opt/wildfly-26.1.1.Final.tar.gz /opt/wildfly
	iii. Add user using the below command:
                # adduser wildfly
	iv.  Change the directory ownership to user and group using the below command:
                # sudo chown -RH wildfly: /opt/wildfly

3.Jetty
Prerequisite for Jetty:
	i. 'jetty-distribution-9.4.48.v20220622.tar.gz' must be downloaded from the below URL:
	URL: https://repo1.maven.org/maven2/org/eclipse/jetty/jetty-distribution/9.4.48.v20220622/jetty-distribution-9.4.48.v20220622.tar.gz
	ii.Item no.5 must be performed.
Install Jetty:
	i.Create a user to own Jetty software.
          # useradd jetty
	ii.Extract downloaded file to /opt directory.
          # sudo tar xf /root/jetty-distribution-9.4.48.v20220622.tar.gz -C /opt/
	iii.Rename  jetty-distribution-9.4.48.v20220622
          # mv /opt/jetty-distribution-9.4.48.v20220622 /opt/jetty
	iv.Set environment variables for Jetty server.
          # vi /etc/default/jetty 
		 Enter below content:
			JETTY_HOME=/opt/jett y
			JETTY_USER=jetty
			JETTY_HOST=0.0.0.0
			JETTY_ARGS=jetty.port=8080
	v.Create and set privileges on Jetty’s run directory.
			# mkdir /var/run/jetty
			# chown jetty:jetty /var/run/jetty
	vi.Allow Jetty service port in Linux Firewall.
			# firewall-cmd --permanent --add-port=8080/tcp
			# firewall-cmd --reload


----------------------------------------------------------------------------------------------------------------------------------
7) Configuration of application
Prerequisite: 
    i) Same as Installation of application
	ii) Step 6 must be performed 
	
1.Tomcat
	i.  Execute below command to configure tomcat.service file.Configure the parameters as per configuration file attached in apendix, save the file and exit.
		#vi /etc/systemd/system/tomcat.service
	ii. Execute below command to configure tomcat.service file.Configure the parameters as per configuration file attached in apendix, save the file and exit.
		#vi /opt/tomcat/conf/server.xml

Note: For tomcat.service and server.xml files  please refer attached file in apendix.

2.Wildfly
	i.   Create a directory that will hold the WildFly configuration file using the below command:
             # sudo mkdir -p /etc/wildfly
	ii.  Copy the configuration file to the /etc/wildfly directory using the below command:
             # sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.conf /etc/wildfly/
	iii. Copy the WildFly launch.sh script to the /opt/wildfly/bin/ directory using the below command:
             # sudo cp /opt/wildfly/docs/contrib/scripts/systemd/launch.sh /opt/wildfly/bin/
	iv. The scripts inside bin directory must have executable flag using the below command:
             # sudo sh -c 'chmod +x /opt/wildfly/bin/*.sh'
	v.  Copy the systemd unit file named to the /etc/systemd/system/ directory using the below command:
             # sudo cp /opt/wildfly/docs/contrib/scripts/systemd/wildfly.service /etc/systemd/system/

Note: For wildfly.conf,launch.sh and wildfly.service files please refer attached file in apendix.	

3.Jetty
	i.Execute below command to configure 'jetty.service' file.Configure the parameters as per configuration file attached in apendix, save the file and exit.
         # vi /usr/lib/systemd/system/jetty.service
	ii.Execute below command to configure 'jetty' file.Configure the parameters as per configuration file attached in apendix, save the file and exit.
		 # vi /etc/default/jetty
	iii.Execute below command to configure 'start.ini' file.Configure the parameters as per configuration file attached in apendix, save the file and exit.
		# vi /opt/jetty/start.ini

Note: For jetty.service,jetty and start.ini files please refer attached file in apendix.			
----------------------------------------------------------------------------------------------------------------------------------
8) Start application
Prerequisite: 
    i) Same as Installation of application
	ii) Step 7 must be performed 
	
1.Tomcat
	i. Refresh the system:
           # sudo systemctl daemon-reload
	ii. Set the Tomcat service to start on boot:
           # sudo systemctl enable tomcat
	iii. Start the Tomcat service:
           # sudo systemctl start tomcat
    iv. To verify tomcat service is running execute below command.
		   # sudo systemctl status tomcat
2.Wildfly
	i. Notify system  that we created a new unit file using the below command:
           # sudo systemctl daemon-reload
	ii.Start the WildFly service an enable it to be automatically started at boot time by running using the below command:
           # sudo systemctl start wildfly
           # sudo systemctl enable wildfly
	iii. To verify wildfly service is running execute below command.
		   # sudo systemctl status wildfly	   
3.Jetty
	i.Enable Jetty service.
           # systemctl enable jetty.service
	ii.Start Jetty service
           # systemctl start jetty.service

	iii. To verify jetty service is running execute below command.
		   # sudo systemctl status jetty	   	   
----------------------------------------------------------------------------------------------------------------------------------
9) Deploy application
Prerequisite: 
    i) Same as Installation of application
	ii) Step 8 must be performed 
	
1. Tomcat
Prerequisite for Tomcat
	
    i.test.html file should be created and placed inside 'opt/tomcat/webapps/' directory.
	
Command	 :	
	i.Deploy file must be present at below location.
	    # cd 'opt/tomcat/webapps/'
	ii.We can also deploy the application using web browser. Follow the below steps:
	steps:
	    a. Open web browser.
		b. Type below URL:
			http://<tomcat_server_ip>:<port_number>
		c. Press 'ENTER' key.
		d. After pressing 'ENTER' key, we can see the web page.
2.Wildfly
Prerequisite for Wildfly
	i. test.html file should be created and placed inside '/etc/systemd/system/' directory.
	
Command	 :	
	i. Deploy file must be present at below location.
		# cd '/etc/systemd/system/'
	ii.We can also deploy the application using web browser. Follow the below steps:
	steps:
	    a. Open web browser.
		b. Type below URL:
			http://<wildfly_server_ip>:<port_number>
		c. Press 'ENTER' key.
		d. After pressing 'ENTER' key, we can see the web page.

3.Jetty
Prerequisite for Jetty
	i. test.html file should be created and placed inside 'opt/jetty/webapps/' directory.
	
Command	 :	
	i. Deploy file must be present at below location.
		# cd 'opt/jetty/webapps/'
	ii.We can also deploy the application using web browser. Follow the below steps:
	steps:
	    a. Open web browser.
		b. Type below URL:
			http://<jetty_server_ip>:<port_number>
		c. Press 'ENTER' key.
		d. After pressing 'ENTER' key, we can see the web page.



