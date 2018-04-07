/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.util.Scanner;

/**
 *
 * @author EdgarLaw
 */
// avaliable algorithm (MD2,MD5,SHA-1,SHA-224,SHA-256,SHA-384,SHA-512)
public class SimpleHash {

    

    /**
     *
     */
    public static final String HASH = "SHA-512";

    /**
     *
     * @param strings
     * @return
     * @throws java.security.NoSuchAlgorithmException
     */
    public static String getStringHash(String... strings)
            throws NoSuchAlgorithmException {
        StringBuilder sb = new StringBuilder();
        for (String s : strings) {
            sb.append(s);
        }
        return getStringHash(sb.toString().getBytes(), HASH);
    }

    /**
     *
     * @param stringBytes
     * @param algorithm
     * @return
     * @throws java.security.NoSuchAlgorithmException
     */
    public static String getStringHash(byte[] stringBytes, String algorithm)
            throws NoSuchAlgorithmException {
        MessageDigest m = MessageDigest.getInstance(algorithm);
        m.update(stringBytes);
        byte[] bytesArray = m.digest();
        StringBuilder s = new StringBuilder(bytesArray.length * 2);
        for (byte b : bytesArray) {
            s.append((String.format("%02x", b)));
        }
        return s.toString();
//            hashValue = DatatypeConverter.printHexBinary(bytesArray).toLowerCase();

    }

    public static void main(String[] args) throws NoSuchAlgorithmException {
        Scanner scn = new Scanner(System.in);
        
        String password;
        while (scn.hasNext()) {
            System.out.print("password: ");
            password = scn.next().trim();
            System.out.println(password);
            System.out.println(getStringHash(password));
        }
        scn.close();
    }

}
