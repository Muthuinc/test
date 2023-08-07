pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS secret access ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS sceret access key')
        DOCKER_CRED = credentials('Docker')
         GIT_COMMIT = sh(script: 'git rev-parse --short HEAD', returnStdout: true).trim()
    }

    stages {
         stage ('checkout'){
            steps {
               checkout changelog: false, poll: false, scm: scmGit(branches: [[name: '*/master']], extensions: [], userRemoteConfigs: [[url: 'https://github.com/Muthuinc/test.git']])  
            }
        }
        
        stage ('build') {
            steps {
                sh 'build/./build.sh'         
            }
        }

        stage ('push') {
            steps{ 
               sh ' push/./push.sh '
            }
        }

        stage ('create') {
            when { changeset "main.tf" }
            steps{ 
               script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "create/./create.sh  "
                    }
               }
            }
        }

        stage ('deploy') {
            steps{
               script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "deploy/./deploy.sh  "
                    }
               }
            }
        }

        stage ('monitor') {
            when {
                equals(actual: currentBuild.number, expected: 1)
            }
            steps{ 
               script {
                    withCredentials([sshUserPrivateKey(credentialsId: 'Avamumbai', keyFileVariable: 'SSH_KEY', usernameVariable: 'ubuntu')]) {
                        sh "monitor/./monitor.sh  "
                    }
               }
            }
        }
    }
}
