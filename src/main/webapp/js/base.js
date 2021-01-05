$(function () {
    $.basePath = getContextPath()
})

/**
 * 获取工程上下文路径
 * @returns
 */
function getContextPath() {
    var pathName = document.location.pathname;
    var index = pathName.substr(1).indexOf("/");
    var result = pathName.substr(0, index + 1);
    return result;
}
