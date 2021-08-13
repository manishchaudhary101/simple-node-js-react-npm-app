pipeline {
    agent any

    stages {
        stage('Commit stage') {
            steps {
                task('Compile and package') {
                    echo 'Building...'
                    
                    echo 'Successfully built project!'
                }

                task('Upload artifacts') {
                    
                    echo 'Successfully uploaded artifacts!'
                }
            }
        }
        stage('Test stage') {
            steps {
                task('Run component tests') {
                    echo 'Running tests...'
                    
                    echo 'Component tests finished!'
                }

                task('Run integration tests') {
                    
                    echo 'Integration tests finished'
                }
            }
        }
        stage('Deploy') {
            steps {
                task('Deploy to UAT') {
                    echo 'Deploying to UAT...'
                    
                    echo 'Successfully deployed to UAT'
                }

                task('Deploy to production') {
                    echo 'Deploying to production...'
                    
                    echo 'Deployed to production!'
                }
            }
        }
    }
}