package com.quizapplication.quizapp.Controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.quizapplication.quizapp.Entity.User;
import com.quizapplication.quizapp.Exception.UserException;
import com.quizapplication.quizapp.Repository.UserRepository;
import com.quizapplication.quizapp.Service.UserService;

@RestController
@RequestMapping("/api/")
public class UserController {

    @Autowired
    private UserService userService;

    @Autowired
    private UserRepository userRepository;

    @GetMapping("user")
    public ResponseEntity<User> getUserByToken(@RequestHeader("Authorization")String jwt){
        
        User user = userService.findUserByToken(jwt);

        return new ResponseEntity<User>(user,HttpStatus.OK);
    }

    @GetMapping("user/updateScore/{Score}")
    public ResponseEntity<User> updateUserScore(@PathVariable("Score") Long score,@RequestHeader("Authorization")String jwt){

        User user = userService.findUserByToken(jwt);

        if(user == null){
            throw new UserException("Invalid token");
        }

        Long prevScore = user.getScore();

        user.setScore(prevScore + score);

        User savedUser = userRepository.save(user);

        userService.getAllUsersByRankUsers();

        return new ResponseEntity<User>(savedUser,HttpStatus.OK);

    }

    @GetMapping("user/AllUsers")
    public ResponseEntity<List<User>> getAllUsers(@RequestHeader("Authorization")String jwt){
        
         User user = userService.findUserByToken(jwt);
        
        if(user == null){
            throw new UserException("Invalid token");
        }
        

        List<User>users = userService.getAllUsers();

        return new ResponseEntity<List<User>>(users,HttpStatus.OK);
    }

    
    @GetMapping("user/ranks")
    public ResponseEntity<List<User>> getRanksUsers(@RequestHeader("Authorization")String jwt){

         User user = userService.findUserByToken(jwt);
        
                if(user == null){
                    throw new UserException("Invalid token");
                }
        
        List<User>users = userService.setRankUser();

        return new ResponseEntity<List<User>>(users,HttpStatus.OK);
    }

    @GetMapping("users/ranking")
    public ResponseEntity<List<User>> getAllUserByRanks(@RequestHeader("Authorization")String jwt){

        User user = userService.findUserByToken(jwt);
        
        if(user == null){
            throw new UserException("Invalid token");
        }
        
        List<User>users = userService.getAllUsersByRankUsers();

        users = users.subList(3, users.size());

        return new ResponseEntity<List<User>>(users, HttpStatus.OK);
    } 

    @GetMapping("user/rankers")
    public ResponseEntity<List<User>> getFirstThree(@RequestHeader("Authorization")String jwt){

        User user = userService.findUserByToken(jwt);
        
        if(user == null){
            throw new UserException("Invalid token");
        }
        
        List<User>users = userService.getAllUsersByRankUsers();

        // List<User>users = user.subList(0, 3);

        return new ResponseEntity<List<User>>(users,HttpStatus.OK);
    }

    @PutMapping("updateUser")
    public ResponseEntity<User> updateUserHandler(@RequestBody User user,@RequestHeader("Authorization")String jwt){

        User requestUser = userService.findUserByToken(jwt);

        if(requestUser == null){
            throw new UserException("Invalid token");
        }

        User updatedUser = userService.updateUser(user,requestUser.getId());

        return new ResponseEntity<User>(updatedUser,HttpStatus.OK);
    }
}

