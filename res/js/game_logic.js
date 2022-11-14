.pragma library

function oneStep(m_model, m_fps) {
    var new_x = m_model.get(5).new_x
    var new_y = m_model.get(5).new_y

    m_model.set(5, {
                    "x": new_x,
                    "y": new_y
                })
}
