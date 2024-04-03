import React, { createContext, useContext, useState, useEffect } from 'react';

// Creating a context
const UserContext = createContext();

// Custom hook for easy context usage
export const useUserContext = () => useContext(UserContext);

export const UserProvider = ({ children }) => {
    const [user, setUser] = useState(() => {
        // Trying to get user data from local storage upon initial load
        const savedUser = localStorage.getItem('user');
        return savedUser ? JSON.parse(savedUser) : null;
    });

    // Effect hook to update localStorage when the user state changes
    useEffect(() => {
        if (user) {
            localStorage.setItem('user', JSON.stringify(user));
        } else {
            localStorage.removeItem('user');
        }
    }, [user]);

    // Login function to set user state
    const login = async (email, password) => {
        try {
            const response = await fetch('http://localhost:5000/user/login', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json',
                },
                body: JSON.stringify({ email, password }),
            });

            if (!response.ok) throw new Error('Login failed');
            
            const data = await response.json();
            setUser({ username: data.username, userType: data.userType, email });  
        } catch (error) {
            console.error("Login error:", error);
            throw error; // Propagating error to be handled where login function is called
        }
    };

    // Logout function to clear user state
    const logout = async () => {
        // Here you can also add a call to the backend to invalidate the session/token
        setUser(null); // Clear user from context
    };

    // Providing state and updater functions to the rest of your app
    return (
        <UserContext.Provider value={{ user, login, logout }}>
            {children}
        </UserContext.Provider>
    );
};
