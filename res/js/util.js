.pragma library

function getXFromIndex(index, m_size, m_dp) {
    if (index < 0) {
        return -1
    }
    var m_col = index % 8
    var x = m_col * (m_size + 2 * m_dp)
    x += 2 * m_dp
    console.log("index:" + index + " x:" + x)
    return x
}

function getYFromIndex(index, m_size, m_dp) {
    if (index < 0) {
        return -1
    }
    var m_col = index % 8
    var m_row = (index > 7) ? ((index - m_col) / 8) : 0
    var y = m_row * (m_size + 2 * m_dp)

    y += 2 * m_dp
    return y
}

function fillBgrModel(m_model, m_count, m_size, m_dp) {

    for (var index = 0; index < m_count; index++) {

        m_model.append({
                           "x": getXFromIndex(index, m_size * m_dp, m_dp),
                           "y": getYFromIndex(index, m_size * m_dp, m_dp),
                           "visible": true
                       })
    }
}
