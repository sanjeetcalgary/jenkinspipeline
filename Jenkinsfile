pipeline{
    agent {
        node{
            label 'kworkerthree'
        }
    }

    tools {
        maven 'slave-mvn'
        git 'slave-git'
    }

    environment {
        DOCKER_USER = credentials('dockerid')
        DOCKER_PASSWORD = credentials('dockerpwd')
        NEXUS_USER = credentials('nexusID')
        NEXUS_PWD = credentials('nexusPwd')
    }

    stages {
        
        stage('Build jar file') {
            steps {
                echo "Building jar"
                sh 'mvn clean package'
                echo "executin pipeline for branch= $BRANCH_NAME"
            }
        }

        stage('Deploy jar to nexus repository'){
            steps {
                echo "Deploying snapshot to nexus"
                sh 'mvn deploy'
            }
        }


        stage('Build docker image') {
            when {
                expression {
                    BRANCH_NAME == 'master'
                }
            }
            steps {
                echo "Building docker image"
                sh "docker build -t 10.0.0.174:8083/java-maven:v3.1 ."
                sh "docker login -u $DOCKER_USER -p $NEXUS_PWD"
                sh "docker push 10.0.0.174:8083/java-maven:v3.1"
            }
        }

        stage('Build when not master') {
            when {
                expression {
                       not BRANCH_NAME == 'master'
                }
            }
             steps {
                echo "Building docker image"
                sh "docker build -t sanjeetkr/web-app:v1.1 ."
                sh "docker login -u $NEXUS_USER -p $DOCKER_PASSWORD"
                sh "docker push sanjeetkr/web-app:v1.1"
            }
        }



        stage('Deploy the image') {
            when {
                expression {
                    BRANCH_NAME == 'master'
                }
            }
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