# CLAUDE.md — ecommerce-rails/

Hereda todas las reglas de proceso del `CLAUDE.md` en `estudio/` (fases
pequeñas, explicar el porqué, correr el código real, no documentación
extensa, etc.). Este archivo solo agrega las convenciones **específicas
de este repo**.

## Stack

Rails 8, Ruby 3.3, PostgreSQL con `pgcrypto` (UUID como PK en todas las
tablas — ver `config/application.rb`, `g.orm :active_record,
primary_key_type: :uuid`, así que no hace falta pasar `id: :uuid` a mano
en cada migración nueva).

## Dónde vive cada patrón

- `app/models/concerns/` — comportamiento compartido entre modelos
  (`Sluggable`, `Publishable`, `Auditable`). Un concern por
  responsabilidad, nunca un "God concern".
- `app/services/` — casos de uso que mutan estado y pueden fallar por
  reglas de negocio (ej. `Cart::AddItemService`, `Orders::CreateService`).
  Un service = una acción = un método público `#call`. Namespacing con
  módulo (`Cart::`, `Orders::`) en vez de prefijos (`AddCartItemService`).
- `app/queries/` — lectura/filtrado complejo que no pertenece a un scope
  simple del modelo (ej. `Products::FilterQuery`). Si el filtro es un
  `where` de una línea, va como scope en el modelo, no acá.
- `app/decorators/` — presentación para vistas (Draper), nunca lógica de
  negocio. Formateo de moneda, fechas, labels traducidos, clases CSS.

## Convenciones

- **UUID**: toda FK nueva se declara `type: :uuid` explícito en la
  migración (los generadores no infieren el tipo de las referencias).
- **Current.user**: `app/models/current.rb` expone
  `Current.user` vía `ActiveSupport::CurrentAttributes`.
  `ApplicationController` lo setea en un `before_action` cuando hay
  sesión. Los concerns/services que necesiten "quién hizo esto" leen de
  `Current.user`, nunca reciben el usuario como parámetro extra si ya
  está disponible ahí (ej. `Auditable`).
- **JWT**: el monolito es la única fuente de autenticación (Devise). Los
  MFEs y microservicios futuros validan un JWT firmado por el monolito;
  nunca reimplementan login ni guardan contraseñas.
- **Result pattern en services**: ver decisión documentada en la Fase 2
  del historial de este proyecto (objeto `Result` con `success?`/
  `errors` en vez de excepciones, para que los controllers/mutations de
  GraphQL puedan responder sin `rescue`).

## Testing

RSpec + FactoryBot + Shoulda Matchers.

- `spec/factories/` — una factory por modelo, traits para variantes
  (`:out_of_stock`, `:cancelled`, etc.) en vez de duplicar factories.
- `spec/models/` — un `describe` por modelo, validaciones vía
  `shoulda-matchers` (`validate_presence_of`, `validate_numericality_of`,
  etc.) en vez de reescribirlas a mano.
- Correr con `bundle exec rspec`.
