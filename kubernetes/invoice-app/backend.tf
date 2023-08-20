resource "kubernetes_deployment" "invoice-backend-deployment" {
  metadata {
    name      = "invoice-backend-deployment"
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
        name =  "invoice-app-pod"
        labels = {
          name = "invoice-app-pod"
          app = "invoice-app"
        }
      }
      spec {
        container {
          image = "public.ecr.aws/m7q7a4s1/project-backend:latest"
          name  = "invoice-app"

          env {
         name = "CLIENT_URL"
         value = "http://localhost:3000"
      }

        env {
         name = "SERVER_URL"
         value = "http://localhost:5000"
      }

        env {
         name = "DB_URL"
         value = "mongodb+srv://danielamadi000:2vKqCPTg1YJbh2yG@cluster1.b1yedfp.mongodb.net/?retryWrites=true&w=majority"
      }

      port {
        container_port = 5000
      }
      }
    }
  }
}
}



# Create kubernetes  for cart service

resource "kubernetes_service" "invoice-backend-service" {
  metadata {
    name      = "invoice-backend-service"
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
      port        = 5000
      target_port = 5000
    }
  }
}