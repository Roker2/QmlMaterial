#include "qml_material/token.h"

namespace qml_material::token
{
Token::Token(QObject* parent)
    : QObject(parent),
      m_typescale(new TypeScale(this)),
      m_icon(create_icon_token(this)),
      m_flick(new Flick(this)) {}
Token::~Token() {}
auto Token::typescale() const -> TypeScale* { return m_typescale; }
auto Token::icon() const -> IconToken* { return m_icon; }
auto Token::flick() const -> Flick* { return m_flick; }
auto Token::elevation() const -> const Elevation& { return m_elevation; }
auto Token::state() const -> const State& { return m_state; }
auto Token::shape() const -> const Shape& { return m_shape; }
auto Token::window_class() const -> const WindowClass& { return m_win_class; }

auto Token::datas() -> QQmlListProperty<QObject> { return { this, &m_datas }; }

Flick::Flick(QObject* parent)
    : QObject(parent),
      m_press_delay(100),
      m_flick_deceleration(1000),
      m_maximum_flickVelocity(std::numeric_limits<float>::max()) {}
Flick::~Flick() {}
auto Flick::pressDelay() const -> qint32 { return m_press_delay; }
auto Flick::flickDeceleration() const -> double { return m_flick_deceleration; }
auto Flick::maximumFlickVelocity() const -> double { return m_maximum_flickVelocity; }

} // namespace qml_material::token