pipeline{
    agent {
        node{
            label 'kworkerthree'
        }
    }

    tools {
        maven 'slave-mvn'
       
    }

    environment {
        DOCKER_USER = credentials('dockerid')
        DOCKER_PASSWORD = credentials('dockerpwd')
        NEXUS_USER = credentials('nexusID')
        NEXUS_PWD = credentials('nexusPwd')
        VERSION_TAG = "10.0.0.174:8083/java-maven:v1.2.1"
    }

    stages {
        
        stage('Build jar file') {
            steps {
                echo "Building jar"
                sh 'mvn clean package deploy'
                echo "executing pipeline"
            }
        }




        stage('Build docker image') {
            steps {
                echo "Building docker image"
                sh "docker build -t ${VERSION_TAG} ."
                sh "docker login -u $NEXUS_USER -p $NEXUS_PWD 10.0.0.174:8083"
                sh "docker push ${VERSION_TAG}"
            }
        }
        /* 
        stage('Build when not master') {
             steps {
                echo "Building docker image"
                sh "docker build -t sanjeetkr/web-app:v1.1 ."
                sh "docker login -u $DOCKER_USER -p $DOCKER_PASSWORD"
                sh "docker push sanjeetkr/web-app:v1.1"
            }
        }

        */

        stage('Deploy the image') {
            steps {
                echo "Deployment phase"
            }
        }


    }
    post{
        always{
            echo "Publishing test result"
            junit "**/target/surefire-reports/*.xml"
        }
    } 
    
}