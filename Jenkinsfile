#!/usr/bin/env groovy
pipeline {
    agent any
    environment {
        AWS_ACCESS_KEY_ID = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
        AWS_DEFAULT_REGION = "eu-west-2"
    }
    parameters{
        choice(name: 'ENVIRONMENT', choices: ['create', 'destroy'], description: 'create and destroy cluster with one click')
    }
    stages {
         stage("Create nginx-conroller & route53") {
             when {
                expression { params.ENVIRONMENT == 'create' }
            }
            steps {
                script {
                    dir('kubernetes/nginx-controller') {
                        sh "aws eks --region eu-west-2 update-kubeconfig --name hr-dev-TopG-cluster"
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Create prometheus") {
             when {
                expression { params.ENVIRONMENT == 'create' }
            }
            steps {
                script {
                    dir('kubernetes/prometheus-helm') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy invoice-app to EKS") {
             when {
                expression { params.ENVIRONMENT == 'create' }
            }
            steps {
                script {
                    dir('kubernetes/invoice-app') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("Deploy ingress rule to EKS") {
             when {
                expression { params.ENVIRONMENT == 'create' }
            }
            steps {
                script {
                    dir('kubernetes/ingress-rule') {
                        sh "terraform init"
                        sh "terraform apply -auto-approve"
                    }
                }
            }
        }
        stage("destroy nginx-conroller & route53") {
             when {
                expression { params.ENVIRONMENT == 'destroy' }
            }
            steps {
                script {
                    dir('kubernetes/nginx-controller') {
                         sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
        stage("destroy prometheus") {
             when {
                expression { params.ENVIRONMENT == 'destroy' }
            }
            steps {
                script {
                    dir('kubernetes/prometheus-helm') {
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
        stage("Destroy invoice-app in EKS") {
             when {
                expression { params.ENVIRONMENT == 'destroy' }
            }
            steps {
                script {
                    dir('kubernetes/invoice-app') {
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
        stage("Destroy ingress rule in EKS") {
             when {
                expression { params.ENVIRONMENT == 'destroy' }
            }
            steps {
                script {
                    dir('kubernetes/ingress-rule') {
                        sh "terraform destroy -auto-approve"
                    }
                }
            }
        }
    }
}