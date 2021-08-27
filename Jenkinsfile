pipeline {
     agent any
  
     tools {nodejs "Node16"}
     stages{
            stage("Build") {
            steps {
      
                slackSend channel: '#pipeline', color: '#439FE0', message: "For ${env.tags} tag, The build process has started. Job Name:-${env.JOB_NAME} Build No.:-${env.BUILD_NUMBER}, For logs click <${env.BUILD_URL}|here>", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
         
               echo "Building"
                sh "npm install"
                sh "npm run build"
                echo "Creating the Zip File"
            }
        }                
            
        stage("Deploy to AUS") {
             when { tag "*-aus" }

          

             steps{ 
                  

               slackSend channel: '#pipeline', color: '#99FF99', message: "Click <${env.BUILD_URL}input|here> to Approve or Abort the deployment to AUS or click here to <${env.BUILD_URL}console|see logs>", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
               mail to: 'imchaudhary101@gmail.com', subject: "Please approve #${env.BUILD_NUMBER}", body: "to Approve or Abort the deployment to AUS, click on the link ${env.BUILD_URL}input or for more info please click here ${env.BUILD_URL}console"
               input "Ready to deploy for AUS Server ?"
                    echo "deploying to AUS"
                    
                 }
                 
                 

                   /* sshPublisher(publishers: [sshPublisherDesc(configName: 'bastion', 
                    transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, 
                    makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html', remoteDirectorySDF: false, removePrefix: '/build', 
                    sourceFiles: 'build/*')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                    */ }

             stage("Deploy to EU") {
             when { tag "*-eu"}

             steps{
              
                slackSend channel: '#pipeline', color: '#99FF99', message: "Click <${env.BUILD_URL}input|here> to Approve or Abort the deployment to EU or click here to <${env.BUILD_URL}console|see logs>", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
               mail to: 'imchaudhary101@gmail.com', subject: "Please approve #${env.BUILD_NUMBER}", body: "to Approve or Abort the deployment to EU, click on the link ${env.BUILD_URL}input or for more info please click here ${env.BUILD_URL}console" 
               input "Ready to deploy for EU Server ?"
                    echo "deploying to EU"
             }
                 
                 
                 

                   /* sshPublisher(publishers: [sshPublisherDesc(configName: 'bastion', 
                    transfers: [sshTransfer(cleanRemote: false, excludes: '', execCommand: '', execTimeout: 120000, flatten: false, 
                    makeEmptyDirs: false, noDefaultExcludes: false, patternSeparator: '[, ]+', remoteDirectory: '/var/www/html', remoteDirectorySDF: false, removePrefix: '/build', 
                    sourceFiles: 'build/*')], usePromotionTimestamp: false, useWorkspaceInPromotion: false, verbose: false)])
                    */ }

             stage("Deploy to USA") {
              
             when { 
                tag  "*-us"}  
                    
              steps{ 
             

               slackSend channel: '#pipeline', color: '#99FF99', message: "Click <${env.BUILD_URL}input|here> to Approve or Abort the deployment to USA or click here to <${env.BUILD_URL}console|see logs>", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
               mail to: 'imchaudhary101@gmail.com', subject: "Please approve ${env.BUILD_NUMBER}", body: "to Approve or Abort the deployment to USA, click on the link ${env.BUILD_URL}input or for more info please click here ${env.BUILD_URL}console"
               input "Ready to deploy for USA Server ?"
               echo "deploying to USA"
               sshagent(['manishnewnew']) {
                    sh ''' scp -o StrictHostKeyChecking=no -r build/* ubuntu@13.127.226.80:/var/www/jenkins-react-app '''
}
                    
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
      sh "echo sending notification to slack channel"
      slackSend channel: '#pipeline', color: '#006600', message: "SUCCESSFUL!! The process has been completed now. click here to <${env.BUILD_URL}console|see logs>", teamDomain: 'jenkins-scy4932', tokenCredentialId: '23b64830-463e-4bcd-9d4d-4af0fa266eb7', username: 'Jenkinsss'
    }
    failure {
          step([$class: 'Mailer',
            notifyEveryUnstableBuild: true,
            recipients: "imchaudhary101@gmail.com",
            sendToIndividuals: true])
    }
  }
}
