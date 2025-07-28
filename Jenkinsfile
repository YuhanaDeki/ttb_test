pipeline {
    agent any

    environment {
        ROBOT_OPTIONS = '--variable BROWSER:chrome --variable HEADLESS:True'
        PATH = "${env.WORKSPACE}\\chromedriver;${env.PATH}"
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
                    python -m venv .venv
                    call .venv\\Scripts\\activate.bat
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Run Robot Tests') {
            steps {
                bat '''
                    call .venv\\Scripts\\activate.bat
                    robot --outputdir results %ROBOT_OPTIONS% tests/
                '''
            }
        }

        stage('Publish Results') {
            when {
                expression { currentBuild.result == null || currentBuild.result == 'SUCCESS' }
            }
            steps {
                publishHTML (target: [
                    reportDir: 'results',
                    reportFiles: 'report.html',
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportName: "Robot Test Report"
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/*.html', fingerprint: true
        }
    }
}
