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
                sh 'docker-compose build'
            }
        }
        stage('Push'){
            steps{
                echo 'docker-compose push'// sh 'docker-compose push'
            }
        }
        stage('Terraform Configuration'){
            steps{
                echo 'bash ./scripts/terraform.sh' // sh 'bash ./scripts/terraform.sh'
            }
        }
        stage('Deploy App'){
            steps{ 
                echo  'bash ./scripts/deployapp.sh' // sh 'bash ./scripts/deployapp.sh'
            }
        }
    }
}
