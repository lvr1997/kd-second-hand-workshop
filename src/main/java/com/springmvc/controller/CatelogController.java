package com.springmvc.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/category")
public class CatelogController {
    @RequestMapping(value = "category_list")
    public String category(){
        return "category/category_list";
    }
}
