# Compartido entre AddToCart y RemoveFromCart: cómo ubicar "el carrito de
# quien está pidiendo esto", ya sea un usuario logueado (JWT) o un guest
# identificado por session_token. Vive acá y no en cada mutation para no
# tener dos criterios de "de quién es este carrito" que se puedan desincronizar.
module Mutations::ResolvesCart
  private

  # Usado por AddToCart: si no existe carrito todavía, lo crea (carrito
  # "lazy" — no hace falta un paso previo de "crear carrito" antes de
  # poder agregar el primer producto).
  def find_or_create_cart(session_token)
    if context[:current_user]
      context[:current_user].carts.order(created_at: :desc)
        .first_or_create!(session_token: SecureRandom.hex(16))
    else
      token = session_token.presence || SecureRandom.hex(16)
      Cart.find_or_create_by(session_token: token)
    end
  end

  # Usado por RemoveFromCart: acá no tiene sentido crear un carrito vacío
  # solo para decir "no tenía ese producto".
  def find_cart(session_token)
    if context[:current_user]
      context[:current_user].carts.order(created_at: :desc).first
    elsif session_token.present?
      Cart.find_by(session_token: session_token)
    end
  end
end
