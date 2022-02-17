package com.k8s.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@SpringBootApplication
@RestController
public class SpringbootK8sDemoApplication {

	@GetMapping("/message")
	public String displayMessage()
	{
		return "Congratulation you successfully deployed your application in kubernetes !!";
	}

	public static void main(String[] args) {
		SpringApplication.run(SpringbootK8sDemoApplication.class, args);
	}

}
