pipeline {
    agent any
    
    stages {
        stage('Checkout') {
            steps {
                git branch: 'main',
                    changelog: false,
                    credentialsId: 'GH_CRED',
                    poll: false,
                    url: 'https://github.com/cyse7125-su24-team11/static-site.git'
            }
        }
        stage('Docker') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'DOCKER_CRED', usernameVariable: 'myuser', passwordVariable: 'docker_password')]) 
                {
                script {
                    try {
                        sh '''
                        docker login -u ${myuser} -p ${docker_password}
                        docker build -f ./Dockerfile -t webapp:latest .
                        docker tag webapp:latest maheshpoojaryneu/csye7125:webapp
                        docker push maheshpoojaryneu/csye7125:webapp
                        '''
                    } catch (Exception e) {
                        throw e
                    }
                }
                }
            }
            
        }
    }
}
