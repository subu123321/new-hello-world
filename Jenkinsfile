// Declarative pipeline. In Jenkins -> Manage Jenkins -> Tools, define:
//   a JDK named "JDK17"   and   a Maven named "Maven3"   (or change the names below).
pipeline {
    agent any

    tools {
        jdk   'JDK17'
        maven 'Maven3'
    }

    environment {
        IMAGE_NAME = 'hello-world-webapp'
        IMAGE_TAG  = "${env.BUILD_NUMBER}"
        // For pushing, set e.g. REGISTRY = 'myregistry.azurecr.io' and add credentials (see Push stage)
    }

    options {
        timestamps()
        buildDiscarder(logRotator(numToKeepStr: '10'))
    }

    stages {
        stage('Checkout') {
            steps { checkout scm }
        }

        stage('Build & Test') {
            steps {
                // "clean package" already compiles; a separate "compile" goal is redundant
                sh 'mvn -B -ntp clean package'
            }
            post {
                always {
                    junit allowEmptyResults: true, testResults: '**/target/surefire-reports/TEST-*.xml'
                }
            }
        }

        // Enable after installing the SonarQube plugin and adding a server named "SonarQube"
        // (Manage Jenkins -> System). Needs sonar-scanner available on the agent.
        // stage('SonarQube Analysis') {
        //     steps {
        //         withSonarQubeEnv('SonarQube') {
        //             sh 'sonar-scanner'      // reads sonar-project.properties
        //             // or: sh 'mvn -B -ntp sonar:sonar'
        //         }
        //     }
        // }

        stage('Archive WAR') {
            steps {
                archiveArtifacts artifacts: 'webapp/target/webapp.war', fingerprint: true
            }
        }

        stage('Docker Build') {
            steps {
                sh "docker build -f Dockerfile.ci -t ${IMAGE_NAME}:${IMAGE_TAG} -t ${IMAGE_NAME}:latest ."
            }
        }

        // Uncomment and adapt to push to Docker Hub / ACR
        // stage('Push') {
        //     steps {
        //         withCredentials([usernamePassword(credentialsId: 'docker-registry-creds',
        //                                           usernameVariable: 'REG_USER', passwordVariable: 'REG_PASS')]) {
        //             sh '''
        //               echo "$REG_PASS" | docker login -u "$REG_USER" --password-stdin
        //               docker tag  ${IMAGE_NAME}:${IMAGE_TAG} $REG_USER/${IMAGE_NAME}:${IMAGE_TAG}
        //               docker push $REG_USER/${IMAGE_NAME}:${IMAGE_TAG}
        //             '''
        //         }
        //     }
        // }
    }

    post {
        cleanup { cleanWs() }
    }
}
