.pragma library

function getXFromIndex(index, m_size, m_offset) {
    if (index < 0) {
        return -1
    }
    var m_col = index % 8
    var x = m_col * (m_size + m_offset)
    x += m_offset
    //console.log(`getXFromIndex[${index}] is [x:${x}] position, size:${m_size}`)
    return x
}

function getYFromIndex(index, m_size, m_offset) {
    if (index < 0) {
        return -1
    }
    var m_col = index % 8
    var m_row = (index > 7) ? ((index - m_col) / 8) : 0
    var y = m_row * (m_size + m_offset)

    y += m_offset
    return y
}

function fillBgrModel(m_model, m_count, m_size, m_dp) {

    for (var index = 0; index < m_count; index++) {

        m_model.append({
                           "x": 0,
                           "y": 0,
                           "new_x": getXFromIndex(index, m_size * m_dp, m_dp),
                           "new_y": getYFromIndex(index, m_size * m_dp, m_dp),
                           "visible": true
                       })
    }
}
