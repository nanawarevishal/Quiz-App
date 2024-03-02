package com.quizapplication.quizapp.Controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quizapplication.quizapp.Config.JwtProvider;
import com.quizapplication.quizapp.Entity.User;
import com.quizapplication.quizapp.Exception.UserException;
import com.quizapplication.quizapp.Repository.UserRepository;
import com.quizapplication.quizapp.Request.LoginRequest;
import com.quizapplication.quizapp.Response.AuthResponse;
import com.quizapplication.quizapp.Service.CustomerUserServiceImpl;
import com.quizapplication.quizapp.Service.UserService;

@RestController
@RequestMapping("/auth/")
public class AuthController {
    
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private UserService userService;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private CustomerUserServiceImpl customerUserServiceImpl;

    //  PostMapping

    @PostMapping("signup")
    public ResponseEntity<AuthResponse> createUserHandler(@RequestBody User user){

        User isEmailExist = userRepository.findByEmail(user.getEmail());

        if(isEmailExist !=null){
            throw new UserException("User exist with email : "+user.getEmail());
        }

        User createdUser = new User();
        createdUser.setEmail(user.getEmail());
        createdUser.setFirstName(user.getFirstName());
        createdUser.setLastName(user.getLastName());
        createdUser.setPassword(passwordEncoder.encode(user.getPassword()));
        createdUser.setScore((long)0);

        User savedUser = userRepository.save(createdUser);

        userService.setRankUser();

        Authentication authentication = new UsernamePasswordAuthenticationToken(savedUser.getEmail(),savedUser.getPassword());

        String token = JwtProvider.generatedToken(authentication);

        AuthResponse authResponse = new AuthResponse();
        authResponse.setToken(token);
        authResponse.setMsg("Register Successfull....!");
        authResponse.setStatus(true);

        return new ResponseEntity<AuthResponse>(authResponse,HttpStatus.OK);
      
    }

    @PostMapping("signin")
    public ResponseEntity<AuthResponse> signInHandler(@RequestBody LoginRequest loginRequests){

        Authentication authentication = authenticate(loginRequests.getEmail(), loginRequests.getPassword());

        String token = JwtProvider.generatedToken(authentication);

        AuthResponse response = new AuthResponse();
        response.setToken(token);
        response.setMsg("SignIn Successfull...!");
        response.setStatus(true);

        return new ResponseEntity<AuthResponse>(response,HttpStatus.OK);
    }

    private Authentication authenticate(String email,String password){

        UserDetails userDetails = customerUserServiceImpl.loadUserByUsername(email);

        if(userDetails==null){
            throw new UserException("User not found with email: "+email);
        }

        if(!passwordEncoder.matches(password,userDetails.getPassword())){
            throw new UserException("Invalid password: "+password+"\nPlease Enter correct Credentials..!");
        }

        return new UsernamePasswordAuthenticationToken(userDetails, null, userDetails.getAuthorities());

    }
}
