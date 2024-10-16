#pragma once

#include <QSGMaterial>

namespace qml_material::sg
{

class ElevationMaterial : public QSGMaterial {
public:
    ElevationMaterial();
    ~ElevationMaterial();

    QSGMaterialShader* createShader(QSGRendererInterface::RenderMode) const override;
    QSGMaterialType*   type() const override;
    int                compare(const QSGMaterial* other) const override;

    void init_fadeoff_texture(QQuickWindow* win);
    auto strength_texture() -> QSGTexture*;

private:
    QSGTexture* m_fadeoff_texture;
};

class ElevationShader : public QSGMaterialShader {
public:
    ElevationShader();

    bool updateUniformData(QSGMaterialShader::RenderState& state, QSGMaterial* newMaterial,
                           QSGMaterial* oldMaterial) override;

    void updateSampledImage(RenderState&, int binding, QSGTexture** texture,
                            QSGMaterial* newMaterial, QSGMaterial*) override;
};

} // namespace qml_material::sg