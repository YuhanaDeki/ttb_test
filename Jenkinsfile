pipeline {
    agent any

    tools {
        // ต้องมี Jenkins tool config ชื่อว่า "Chrome"
        // ต้องมี Jenkins tool config ชื่อว่า "ChromeDriver"
        // ตั้งชื่อใน Global Tool Configuration ให้ตรงกับชื่อที่เรียก
        chrome 'Chrome'
        chromedriver 'ChromeDriver'
    }

    environment {
        ROBOT_OPTIONS = '--variable BROWSER:chrome --variable HEADLESS:True'
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
            steps {
                publishHTML (target: [
                    reportDir: 'results',
                    reportFiles: 'report.html',
                    alwaysLinkToLastBuild: true,
                    keepAll: true,
                    reportName: "Robot Report"
                ])
            }
        }
    }

    post {
        always {
            archiveArtifacts artifacts: 'results/**/*.*', fingerprint: true
        }
    }
}
