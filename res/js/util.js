.pragma library

function getXFromIndex(index, m_size, m_offset) {
    if (index < 0) {
        return -1
    }
    var m_col = index % 8
    var x = (m_col * (m_size + (2 * m_offset))) + 5 * m_offset
    return x
}

function getYFromIndex(index, m_size, m_offset) {
    if (index < 0) {
        return -1
    }

    var m_col = index % 8
    var m_row = (index > 7) ? ((index - m_col) / 8) : 0
    var y = (m_row * (m_size + (2 * m_offset))) + 5 * m_offset

    //console.log(`getYFromIndex ${index}  is [y:${y}] position`)
    return y
}

function fillBgrModel(m_model, m_count, m_size, m_dp) {
    m_model.clear()
    for (var index = 0; index < m_count; index++) {
        m_model.append({
                           "x": 0,
                           "y": 0,
                           "new_x": getXFromIndex(index, m_size, m_dp),
                           "new_y": getYFromIndex(index, m_size, m_dp),
                           "visible": true,
                           "m_size": m_size
                       })
    }
}
