resource "kubernetes_deployment" "invoice-frontend-deployment" {
  metadata {
    name      = "invoice-frontend-deployment"
    #namespace =  kubernetes_namespace.kube-namespace.id
    labels = {
      name = "invoice-app"
    }
  }

  spec {
    replicas = 1
    selector {
      match_labels = {
       name = "invoice-app-pod"
       app = "invoice-app"
      }
    }
    template {
      metadata {
        name =  "invoice-app"
        labels = {
         name = "invoice-app-pod"
         app = "invoice-app"
        }
      }
      spec {
        container {
          image = "public.ecr.aws/m7q7a4s1/project-frontend:latest"
          name  = "invoice-frontend-app"

            env {
         name = "REACT_APP_SERVER_UR"
         value = "http://localhost:5000"
      }

      port {
        container_port = 80
      }
      }
    }
  }
}
}



# Create kubernetes  for cart service

resource "kubernetes_service" "invoice-frontend-service" {
  metadata {
    name      = "invoice-frontend-service"
    #namespace =  kubernetes_namespace.kube-namespace.id
   /*  annotations = {
        prometheus.io/scrape: "true"
    } */

    labels = {
        name = "invoice-app-pod"
        app = "invoice-app"
    }
  }
  spec {
    selector = {
     name = "invoice-app-pod"
     app = "invoice-app"
    }
    port {
      port        = 80
      target_port = 80
    }
  }
}