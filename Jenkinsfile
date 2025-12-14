pipeline{
    agent any
    
    stages{
        stage('Build Docker Images') {
            steps {
                echo "Building Docker images..."
                sh "docker compose build"
            }
        }
        stage("Push to DockerHub"){
            steps{
               echo "this is image push to dockerHub"
            }
        }
        stage('Deploy Containers') {
            steps {
                echo "Starting new containers..."
                sh "docker compose down && docker compose up -d"
            }
        }
    }
}
