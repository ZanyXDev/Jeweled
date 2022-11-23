.pragma library

const CellState = {
    "Normal": 0,
    "Explosive": 1,
    "HyperCube": 2,
    "RowColumnRemove": 3
}

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

function moveBackgroundTile(m_model) {
    // console.log("moveBackgroundTile() begin")
    for (var index = 0; index < m_model.count; index++) {

        //console.log(`Idx ${index} y:${m_model.get(index).y}`)
        m_model.setProperty(index, "x", m_model.get(index).new_x)

        m_model.setProperty(index, "y", m_model.get(index).new_y)
        // console.log(`Idx ${index} y2:${m_model.get(index).y}`)
    }
}

function isOpacity(m_width, m_x, m_y) {
    var halfWidth = m_width / 2
    var eightWidth = m_width * 8

    return ((m_x < -halfWidth) || (m_y < -halfWidth) || (m_x >= eightWidth)
            || (m_y >= eightWidth)) ? 0 : 1
}

function getGemImageSource(m_isHyrpeCube, m_type) {
    var sourceImage

    if (m_isHyrpeCube) {
        sourceImage = "qrc:/res/images/gems/hyperCube.svg"
    } else {

        switch (m_type) {
        case 0:
            sourceImage = "qrc:/res/images/gems/yellowGem.svg"
            break
        case 1:
            sourceImage = "qrc:/res/images/gems/redGem.svg"
            break
        case 2:
            sourceImage = "qrc:/res/images/gems/blueGem.svg"
            break
        case 3:
            sourceImage = "qrc:/res/images/gems/greenGem.svg"
            break
        case 4:
            sourceImage = "qrc:/res/images/gems/purpleGem.svg"
            break
        case 5:
            sourceImage = "qrc:/res/images/gems/whiteGem.svg"
            break
        case 6:
            sourceImage = "qrc:/res/images/gems/orangeGem.svg"
            break
        default:
            break
        }
    }
    console.log("sourceImage:" + sourceImage)
    return sourceImage
}

function calcRandomDuration(m_behavior_pause) {
    var rnd = 1 + Math.random() * 0.4 - 0.2
    return Math.floor(m_behavior_pause * rnd)
}

function fillGemsModel(m_model, m_count, m_size, m_dp, m_columnCount) {
    m_model.clear()

    for (var index = 0; index < m_count; index++) {
        var row = index / m_columnCount
        var column = index % m_columnCount
        var item = {
            "x": 0,
            "y": 0,
            "t_row": row
        }
        console.log("item:" + item)
        m_model.append(item)
    }
}

function createBlock(m_row, m_col, m_startRow) {
    var item = {
        "x": 0,
        "y": 0,
        "t_row": row
    }
}
