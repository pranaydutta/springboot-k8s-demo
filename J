pipeline {
    agent any
     tools {
        maven "maven-3.8.4"
       
    }
	
	stages{
   stage ('Initialize') {
            steps {
		    
		    echo "Pipeline triggered by ${params.USER}"
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
        }
		
		stage ('Build') {
        
      
	 
            steps {
                sh 'mvn install' 
            }
	    
    }
	
	stage("Docker build"){
	 steps {
        sh 'docker version'
        sh 'docker build -t jhooq-docker-demo .'
        sh 'docker image list'
        sh 'docker tag jhooq-docker-demo muskan0802/jhooq-docker-demo:jhooq-docker-demo'
    }
	}
	

    stage("Push Image to Docker Hub"){
	
	steps {
	    withCredentials([string(credentialsId: 'muskan_hub_pwd', variable: 'PASSWORD')]) {
        sh 'docker login -u muskan0802 -p $PASSWORD'
        sh 'docker push  muskan0802/jhooq-docker-demo:jhooq-docker-demo'
    }
        
		}
    }
    
    stage("kubernetes deployment"){
	steps {
        sh 'kubectl apply -f k8s-deployment.yaml'
	//	sh 'kubectl apply -f k8s-service.yaml'
		}
    }
	
		}
		
		
		
		
	
	
	}
