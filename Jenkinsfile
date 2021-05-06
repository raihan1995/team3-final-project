pipeline {
    agent any
    stages{
        stage('Testing'){
            steps{
                echo 'test stage' // sh 'bash ./scripts/backend-test.sh'
                // sh 'bash ./scripts/frontend-test.sh'
            }
        }
        stage('Build'){
            steps{
                sh 'sudo docker-compose build'
            }
        }
        stage('Push'){
            steps{
                sh 'echo pwd' //'sudo docker-compose push'
            }
        }
        stage('Terraform Configuration'){
            steps{
                sh 'bash cd ~/team3-final-project && scripts/terraform.sh'
            }
        }
        stage('Deploy App'){
            steps{ 
                sh 'bash scripts/deployapp.sh'
            }
        }
    }
}
