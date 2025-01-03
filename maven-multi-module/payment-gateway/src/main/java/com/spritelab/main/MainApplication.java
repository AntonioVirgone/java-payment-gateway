package com.spritelab.main;

import com.spritelab.main.exception.RepositoryBadRequestException;
import com.spritelab.main.exception.ResourceNotFoundException;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.http.HttpStatus;
import org.springframework.web.ErrorResponse;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;

@SpringBootApplication
public class MainApplication {

    public static void main(String[] args) {
        SpringApplication.run(MainApplication.class, args);
    }

    @ControllerAdvice
    public static class GlobalExceptionHandler {
        @ExceptionHandler(value = ResourceNotFoundException.class)
        @ResponseStatus(HttpStatus.NOT_FOUND)
        public @ResponseBody ErrorResponse handleException(ResourceNotFoundException ex) {
            return ErrorResponse.builder(ex, HttpStatus.NOT_FOUND, ex.getMessage())
                    .build();
        }

        @ExceptionHandler(value = RepositoryBadRequestException.class)
        @ResponseStatus(HttpStatus.BAD_REQUEST)
        public @ResponseBody ErrorResponse handleException(RepositoryBadRequestException ex) {
            return ErrorResponse.builder(ex, HttpStatus.BAD_REQUEST, ex.getMessage())
                    .build();
        }
    }
}
