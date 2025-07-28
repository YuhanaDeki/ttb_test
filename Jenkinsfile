pipeline {
    agent any

    environment {
        VENV = ".venv"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/YuhanaDeki/ttb_test.git'
            }
        }

        stage('Setup Python & Install Dependencies') {
            steps {
                bat '''
                    python -m venv %VENV%
                    call %VENV%\\Scripts\\activate.bat
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat '''
                    call %VENV%\\Scripts\\activate.bat
                    robot -d results tests/
                '''
            }
        }

        stage('Publish Results') {
            steps {
                robot outputPath: 'results'
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**/*.*', fingerprint: true
        }
    }
}
