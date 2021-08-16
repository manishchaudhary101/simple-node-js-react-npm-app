pipeline {
     agent any
  
     tools {nodejs "Node16"}
  
     stages {
    
    stage("Build") {
             
        steps {
                slackSend channel: '#pipeline', color: '#439FE0', message: "started the build process. ${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>)", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
                echo "Building"
                sh "npm install"
                sh "npm run build"
                 
            }
    }
      stage("Test") {  

            steps {
                 
                    sh "npm run test-coverage"
                    cobertura autoUpdateHealth: false, autoUpdateStability: false, coberturaReportFile: '**/output/coverage/jest/cobertura-coverage.xml', conditionalCoverageTargets: '70, 0, 0', failUnhealthy: false, failUnstable: false, lineCoverageTargets: '80, 0, 0', maxNumberOfBuilds: 0, methodCoverageTargets: '80, 0, 0', onlyStable: false, sourceEncoding: 'ASCII', zoomCoverageChart: false
                   //s3 bucket config
                   slackSend channel: '#pipeline', color: '#439FE0', message: "Coverage report has been uploaded to S3 bucket. If you want to see the log click here (<${env.BUILD_URL}console|open>)", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
                   

         
            }

      }

        stage("Deploy to QA") {

             steps{ slackSend channel: '#pipeline', color: '#439FE0', message: "Click here to approve the deployment to QA (<${env.BUILD_URL}input|Approve>) or click here (<${env.BUILD_URL}console|To see Logs>)", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
               mail to: 'imchaudhary101@gmail.com', subject: "Please approve #${env.BUILD_NUMBER}", body: "See ${env.BUILD_URL}input or for more info please click here ${env.BUILD_URL}console" 
               input "Ready to deploy for QA Server ?"
                    echo "deploying to QA"
                    
                 }
                 
                 

                   /* sshPublisher(publishers: [sshPublisherDesc(configName: 'bastion', 
                    transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, 
                    makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html', remoteDirectorySDF: false, removePrefix: '/build', 
                    sourceFiles: 'build/*')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                    */ }

             stage("Deploy to Staging") {

             steps{ slackSend channel: '#pipeline', color: '#439FE0', message: "Click here to approve the deployment to Staging (<${env.BUILD_URL}input|Approve>) or If you want to see the log click here (<${env.BUILD_URL}console|To see Logs>)", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
               mail to: 'imchaudhary101@gmail.com', subject: "Please approve #${env.BUILD_NUMBER}", body: "See ${env.BUILD_URL}input or for more info please click here ${env.BUILD_URL}console" 
               input "Ready to deploy for Staging Server ?"
                    echo "deploying to Staging"
                    
                 }
                 
                 

                   /* sshPublisher(publishers: [sshPublisherDesc(configName: 'bastion', 
                    transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, 
                    makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html', remoteDirectorySDF: false, removePrefix: '/build', 
                    sourceFiles: 'build/*')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                    */ }

             stage("Deploy to Prod") {

             steps{ slackSend channel: '#pipeline', color: '#439FE0', message: "Click here to approve the deployment to Prod ${env.BUILD_URL}input or If you want to see the log click here ${env.BUILD_URL}console", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
               mail to: 'imchaudhary101@gmail.com', subject: "Please approve #${env.BUILD_NUMBER}", body: "See ${env.BUILD_URL}input or for more info please click here ${env.BUILD_URL}console" 
               input "Ready to deploy for prod Server ?"
                    echo "deploying to Prod"
                    
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
      
    }
    failure {
          step([$class: 'Mailer',
            notifyEveryUnstableBuild: true,
            recipients: "imchaudhary101@gmail.com",
            sendToIndividuals: true])
    }
  }
}