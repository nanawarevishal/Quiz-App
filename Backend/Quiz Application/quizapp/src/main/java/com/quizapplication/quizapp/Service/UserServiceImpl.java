package com.quizapplication.quizapp.Service;

import java.util.Collections;
import java.util.Comparator;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.quizapplication.quizapp.Config.JwtProvider;
import com.quizapplication.quizapp.Entity.User;
import com.quizapplication.quizapp.Exception.UserException;
import com.quizapplication.quizapp.Repository.UserRepository;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserRepository userRepository;
    
    @Override
    public User createUser(User user) {
        
        User createUser = new User();

        createUser.setFirstName(user.getFirstName());
        createUser.setLastName(user.getLastName());
        createUser.setEmail(user.getEmail());
        createUser.setPassword(user.getPassword());

        setRankUser();
        
        return userRepository.save(createUser);
    }


    @Override
    public User updateUser(User user,Long userId) {
        
        User createUser = findUserById(userId);

        if(user.getFirstName()!=null){
            createUser.setFirstName(user.getFirstName());
        }

        if(user.getLastName()!=null){
            createUser.setLastName(user.getLastName());
        }

        return userRepository.save(createUser);

    }

    @Override
    public User findUserById(Long userId) {
        
        Optional<User>opt = userRepository.findById(userId);

        if(opt.isPresent()){
            return opt.get();
        }

        throw new UserException("Your not exist with id: "+userId);
    }


    @Override
    public String deleteUser(Long userId) {
        
        User user = findUserById(userId);
        userRepository.delete(user);

        return "User deleted Successfully...!";
    }


    @Override
    public User findUserByToken(String jwt) {
        
        String email = JwtProvider.getEmailFromJwtToken(jwt);

        User user = userRepository.findByEmail(email);

        if(user == null){
            throw new UserException("Invalid token");
        }

        return user;
    }


    @Override
    public List<User> getAllUsers() {
       List<User>users = userRepository.findAll();
        
       Collections.sort(users,new SortByScore());
       return users;
    }

    
    @Override
    public List<User> setRankUser() {
       
        List<User>users = getAllUsers();
        long rank = 1;

        long score = users.get(0).getScore();
        users.get(0).setRanks(rank);
        userRepository.save(users.get(0));

        for(int i=1;i<users.size();i++){
            if(users.get(i).getScore() == score){
                while(i<users.size()){
                    if(users.get(i).getScore() == score){
                        users.get(i).setRanks(rank);
                        userRepository.save(users.get(i));
                        i++;
                    }
                    else{
                        rank++;
                        score = users.get(i).getScore();
                        users.get(i).setRanks(rank);
                        userRepository.save(users.get(i));
                        i++;
                    }

                }
            }else{
                rank++;
                score = users.get(i).getScore();
                users.get(i).setRanks(rank);
                userRepository.save(users.get(i));
            }
        }
        return users;
    }


    @Override
    public List<User> getAllUsersByRankUsers() {
        
        List<User>users = setRankUser();

        Collections.sort(users,new SortByRanks());
        
        return users;
    }
}

class SortByScore implements Comparator<User>{

    @Override
    public int compare(User obj1, User obj2) {
        return (int) -(obj1.getScore() - (obj2.getScore()));
    }
}

class SortByRanks implements Comparator<User>{

    @Override
    public int compare(User obj1, User obj2) {
        return (int) (obj1.getRanks()-obj2.getRanks());
    }
    
}

