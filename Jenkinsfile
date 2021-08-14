pipeline {
     agent any
  
     tools {nodejs "Node16"}
  
     stages {
    
    stage("Build") {
             
        steps {
                echo "Building"
                sh "npm install"
                sh "npm run build"
                 
            }
        }
      stage('SonarQube analysis') {  
        environment {
                scannerHome = tool 'sonar'
            }

            steps {
                withSonarQubeEnv('sonar') {
                    sh "CI=true npm test"
                    sh "npm run test-coverage"
                    sh "${scannerHome}/bin/sonar-scanner"
                    slackUploadFile channel: '#pipeline', credentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', filePath: '/coverage/cobertura-coverage.xml', initialComment: 'Here is the Coverage report '
                    
                }
            }
        }

        stage("Approval"){
           steps{mail to: 'imchaudhary101@gmail.com', subject: "Please approve #${env.BUILD_NUMBER}", body: "See ${env.BUILD_URL}input or for more info please click here ${env.BUILD_URL}console" 
               input "Ready to deploy for ${params.ENVIRONMENT} Server ?"
                

           } 
        }

        stage("Deploy") {

             steps{ 
                    echo "deploying for {$params.ENVIRONMENT}"
                    
                 }
                 
                 

                   /* sshPublisher(publishers: [sshPublisherDesc(configName: 'bastion', 
                    transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, 
                    makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html', remoteDirectorySDF: false, removePrefix: '/build', 
                    sourceFiles: 'build/*')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                    */ }
            
     
        }
    


  post {
    success {
      sh "echo 'Send mail on success'"
      mail to:"imchaudhary101@gmail.com", subject:"SUCCESS: ${currentBuild.fullDisplayName}", body: "Yay, we passed. *${currentBuild.currentResult}:* Job ${env.JOB_NAME} build ${env.BUILD_NUMBER}\n More info at: ${env.BUILD_URL}"
      slackSend channel: '#pipeline', color: '#439FE0', message: 'started ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)', teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
    }
    failure {
          step([$class: 'Mailer',
            notifyEveryUnstableBuild: true,
            recipients: "imchaudhary101@gmail.com",
            sendToIndividuals: true])
    }
  }
}