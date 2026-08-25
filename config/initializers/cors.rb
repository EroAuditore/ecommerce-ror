# Permite que el MFE de checkout (Vite/React, corriendo en localhost:5173)
# consuma el GraphQL y la API del monolito vía fetch/XHR desde otro origen.
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins "http://localhost:5173"

    resource "/graphql",
      headers: :any,
      methods: %i[get post options],
      credentials: true

    resource "/api/*",
      headers: :any,
      methods: %i[get post put patch delete options],
      credentials: true
  end
end
