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
                echo 'sudo docker-compose push'
            }
        }
        stage('Terraform Configuration'){
            steps{
                echo 'bash ./scripts/terraform.sh'
            }
        }
        stage('Deploy App'){
            steps{ 
                echo  'bash ./scripts/deployapp.sh' // sh 'bash ./scripts/deployapp.sh'
            }
        }
    }
}
