pipeline {
    agent any
    stages {

        stage("Code Clone") {
            steps {
                sh "whoami"
                git branch: 'main',
                    url: 'https://github.com/ashwinibajanghate/Django_Notes_App.git'
            }
        }

        stage("Docker Build") {
            steps {
                sh """
                    docker build -t notes-app:latest .
                """
            }
        }

        stage("Push to DockerHub") {
            steps {
                sh """
                    docker login -u ashubajanghate -p dckr_pat_-E8kZZuQ05S8SnoQXzs32dydP1c
                    docker tag notes-app:latest ashubajanghate/notes-app:latest
                    docker push ashubajanghate/notes-app:latest
                """
            }
        }

        stage("Deploy") {
            steps {
                  sh "docker compose down && docker compose up -d"
               
            }
        }
    }
}
