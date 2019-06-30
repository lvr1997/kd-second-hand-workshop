;
(function() {
    /**
     *
     *	作者	: 老可
     * 	日期	: 2015-05-26
     *	版本	: v1.2
     *	QQ  	: 279662403 群 246502174
     * 	兼容性  : IE6+ 
     */

    var EventUtil, Get, Element;
    EventUtil = {
        addHandler: function(ele, type, handler) {
            if (ele.addEventListener) {
                ele.addEventListener(type, handler, false)
            } else if (ele.attachEvent) {
                ele.attachEvent("on" + type, handler)
            } else {
                ele["on" + type] = handler;
            }
        },
        removeHandler: function(element, type, handler) {
            if (element.removeEventListener) {
                element.removeEventListener(type, handler, false);
            } else if (element.detachEvent) {
                element.detachEvent("on" + type, handler);
            } else {
                element["on" + type] = null;
            }
        },
        getEvent: function(event) {
            return event ? event : window.event;
        },
        getTarget: function(event) {
            return event.target || event.srcElement;
        },
        preventDefault: function(event) {
            if (event.preventDefault) {
                event.preventDefault();
            } else {
                event.returnValue = false;
            }
        },
        stopPropagation: function(event) {
            if (event.stopPropagation) {
                event.stopPropagation();
            } else {
                event.cancelBubble = true;
            }
        }
    };

    Get = {
        byId: function(id) {
            return typeof id === "string" ? document.getElementById(id) : id
        },
        byClass: function(sClass, oParent) {
            var aClass = [];
            var reClass = new RegExp("(^| )" + sClass + "( |$)");
            var aElem = this.byTagName("*", oParent);
            for (var i = 0; i < aElem.length; i++) reClass.test(aElem[i].className) && aClass.push(aElem[i]);
            return aClass
        },
        byTagName: function(elem, obj) {
            return (obj || document).getElementsByTagName(elem)
        }
    };

    Element = {
        hasClass: function(obj, name) {
            return (' ' + obj.className + ' ').indexOf(' ' + name + ' ') > -1 ? true : false;
        },
        addClass: function(obj, name) {
            if (this.hasClass(obj, name)) return;
            obj.className += ' ' + name;
        },
        removeClass: function(obj, name) {
            obj.className = obj.className.replace(new RegExp('(^|\\s)' + name + '(?:\\s|$)'), '$1').replace(/\s{1,}/g, ' ');
        }
    }

    function MagnifierF() {
        this.init.apply(this, arguments);
    }

    MagnifierF.prototype = {
        init: function(id) {
            var _is = this;
            this.magWrap = Get.byId(id);
            this.magMain = this.magWrap.children[0];
            this.mW = this.magMain.offsetWidth;
            this.mH = this.magMain.offsetHeight;
            this.magImg = this.magMain.getElementsByTagName('img')[0];
            // this.mImgSrc = this.magImg.getAttribute('src').slice(0,-4);
            this.mImgSrc = this.magImg.getAttribute('src');

            this.specBox = Get.byClass("spec-items", this.magWrap)[0];
            this.specUl = this.specBox.getElementsByTagName('ul')[0];
            this.specItem = this.specBox.getElementsByTagName('li');

            _is.specFn();
            _is.setEventFn().dragEvent();

        },
        setEleFn: function() {
            var _is = this,
                _html1 = "",
                oFrag = document.createDocumentFragment(),
                oFrag2 = document.createDocumentFragment();

            _is.oMD = document.createElement('div');
            _is.oMD.className = "MagnifierDrag";
            _is.oMD.style.cssText = 'width:' + _is.mW / 2 + 'px;height:' + _is.mH / 2 + 'px;';
            _is.oMD.innerHTML = "&nbsp;";

            _is.oMP = document.createElement('div');
            _is.oMP.className = 'MagnifierPop';
            _is.oMP.style.cssText = 'width:' + _is.mW + 'px;height:' + _is.mH + 'px;right:' + (-_is.mW - 10) + 'px;';

            _is.oMI = document.createElement('div');
            _is.oMI.className = 'MagnifierImg';
            _is.oMI.style.cssText = 'width:' + _is.mW * 2 + 'px;height:' + _is.mH * 2 + 'px;';
            // _html1 = '<img style="width:100%;height:100%;" src="' + _is.mImgSrc + '-big.jpg">'
            _html1 = '<img style="width:100%;height:100%;" src="' + _is.mImgSrc + '">'
            _is.oMI.innerHTML = _html1;

            _is.oMP.appendChild(_is.oMI)

            oFrag.appendChild(_is.oMD);
            oFrag2.appendChild(_is.oMP);

            _is.magMain.appendChild(oFrag);
            _is.magWrap.appendChild(oFrag2);

        },
        removeFn: function() {
            var _is = this;
            _is.magMain.removeChild(_is.oMD);
            _is.magWrap.removeChild(_is.oMP);
        },
        setMousemoveFn: function(event) {
            var _is = this,

                _WinScrLeft = document.documentElement.scrollLeft || document.body.scrollLeft,
                _WinScrTop = document.documentElement.scrollTop || document.body.scrollTop;

            _x = event.clientX + _WinScrLeft -
                (_is.magWrap.getBoundingClientRect().left + _WinScrLeft) - _is.oMD.offsetWidth / 2;

            _y = event.clientY + _WinScrTop -
                (_is.magMain.getBoundingClientRect().top + _WinScrTop) - _is.oMD.offsetHeight / 2;

            _l = _is.magMain.offsetWidth - _is.oMD.offsetWidth;
            _t = _is.magMain.offsetHeight - _is.oMD.offsetHeight;

            _l2 = -(_is.oMI.offsetWidth - _is.magMain.offsetWidth);
            _t2 = -(_is.oMI.offsetHeight - _is.magMain.offsetHeight);

            if (_x < 0) {
                _x = 0;
            } else if (_x > _l) {
                _x = _l;
            }

            if (_y < 0) {
                _y = 0;
            } else if (_y > _t) {
                _y = _t;
            }


            _is.oMD.style.left = _x + "px";
            _is.oMD.style.top = _y + "px";


            _bigx = _x / _l;
            _bigy = _y / _t;


            _is.oMI.style.left = _bigx * _l2 + "px";
            _is.oMI.style.top = _bigy * _t2 + "px";
        },
        setEventFn: function() {
            var _is = this,
                _x = 0,
                _y = 0,
                _l = 0,
                _t = 0,
                _bigx = 0,
                _bigy = 0,
                _l2 = 0,
                _t2 = 0;

            function handleEvent(event) {
                event = EventUtil.getEvent(event);

                switch (event.type) {
                    case "mouseenter":
                        _is.setEleFn();
                        break;
                    case "mousemove":
                        if (_is.oMD) {
                            _is.setMousemoveFn(event);
                        }
                        break;
                    case "mouseleave":
                        _is.removeFn();
                        break;
                }

            }
            return {
                dragEvent: function() {

                    EventUtil.addHandler(_is.magMain, "mouseenter", handleEvent);
                    EventUtil.addHandler(_is.magMain, "mousemove", handleEvent);
                    EventUtil.addHandler(_is.magMain, "mouseleave", handleEvent);
                }
            }

        },
        specFn: function() {
            var _is = this,
                _oSpImg, _oISrc,
                oLBtn = Get.byClass("spe_leftBtn", _is.magWrap)[0],
                oRBtn = Get.byClass("spe_rightBtn", _is.magWrap)[0],
                oLiW = this.specUl.getElementsByTagName('li')[0].offsetWidth + 5,
                _len = _is.specItem.length,
                n = 0,
                l = null,
                r = null;

            function TabFn(event) {
                var target = EventUtil.getTarget(event),
                    i = 0;

                if (target.nodeName != "UL") {

                    if (target.nodeName == "IMG") {
                        target = target.parentNode;
                    }
                    for (; i < _len; i++) {
                        _is.specItem[i].className = '';
                    }
                    target.className = 'on';

                    _oSpImg = target.getElementsByTagName('img')[0];
                    _oISrc = _oSpImg.getAttribute('src');

                    _is.magImg.setAttribute('src', _oISrc);
                    // _is.mImgSrc =  _oISrc.slice(0,-4);  
                    _is.mImgSrc = _oISrc;
                }

            }
            EventUtil.addHandler(_is.specUl, "mouseover", TabFn);

            function moveFn(event) {
                var target = EventUtil.getTarget(event);

                if (target.className.indexOf("spe_rightBtn") > -1) {
                    r = ++n;
                    if (r > _len - 5)
                        Element.removeClass(target, "on");

                    if (r > _len - 4) {

                        n = _len - 4;
                        return false;
                    } else {

                        _is.buttur(_is.specUl, {
                            left: -(r * oLiW)
                        });
                        Element.addClass(oLBtn, "on");
                    }
                }
                if (target.className.indexOf("spe_leftBtn") > -1) {
                    l = --n;
                    if (l < 1)
                        Element.removeClass(target, "on");

                    if (l < 0) {

                        n = 0;
                        return false;
                    } else {

                        _is.buttur(_is.specUl, {
                            left: -(l * oLiW)
                        });
                        Element.addClass(oRBtn, "on");
                    }
                }
            }

            if (_len > 4) {

                Element.addClass(oRBtn, "on");
                EventUtil.addHandler(_is.magWrap, "click", moveFn);
            }



        },
        buttur: function(ele, obj) {

            window.clearTimeout(ele.timer);

            var _this = this,
                end = null;

            for (direc in obj) {

                var direc1 = direc.toLowerCase(),
                    strOffset = "offset" + direc1.substr(0, 1).toUpperCase() + direc1.substring(1).toLowerCase(),
                    target = obj[direc],
                    nSpeed = (target - ele[strOffset]) / 8;

                nSpeed = nSpeed >= 0 ? Math.ceil(nSpeed) : Math.floor(nSpeed);
                ele.style[direc1] = ele[strOffset] + nSpeed + "px";
                end += nSpeed;

            }

            if (end)

                if (typeof fnCallback == "function") {
                fnCallback.call(ele);
            } else {

                ele.timer = window.setTimeout(function() {
                    _this.buttur(ele, obj)
                }, 20);

            }
        }

    }

    window['MagnifierF'] = function(id) {
        return new MagnifierF(id);
    }

})()