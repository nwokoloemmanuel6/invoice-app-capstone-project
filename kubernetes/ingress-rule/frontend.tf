resource "kubernetes_ingress_v1" "frontend-service" {
  metadata {
    name      = "frontend-service"
    #namespace = "prometheu"
    labels = {
      name = "invoice-app-pod"
      app = "invoice-app"
    }
    annotations = {
      "kubernetes.io/ingress.class" : "nginx"
    }
  }

  spec {
    rule {
      host = "www.danielamadi.me"
      http {
        path {
          backend {
            service{
              name = "invoice-frontend-service"
              port {
               number = 80
               }
          }
        }
      }
    }
  }
}
}
