package Model;

import javax.net.ssl.HttpsURLConnection;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;

public class Player {
    String id;
    String firstName;
    String lastName;
    String team;
    int jersey;
    int year;
    String position;

    final static String API_KEY = "Bearer VTB63JmasppqSnWzLNjrK+duDxjYwrSGWoo2a4z+HQjzkUeUg5cPpPNNPVz0uw6L";

    public Player(String id, String firstName, String lastName, String team, int jersey, int year, String position) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.team = team;
        this.jersey = jersey;
        this.year = year;
        this.position = position;
    }

    public static void getPlayers() {
        //Iterate through every college
        for (College team : College.colleges) {
            String jsonData = getCollegeRoster(team.getSchool());
        }
    }

    private static String getCollegeRoster(String collegeName) {
        String url = "https://api.collegefootballdata.com/roster?team=" + collegeName + "&year=2021";
        return readData(url);
    }

    public static String readData(String httpsURL) {
        System.out.println("Fetching data from CFDB");
        StringBuilder input = new StringBuilder();
        try {
            ArrayList<String> list = new ArrayList<>();
            list.clear();
            URL myUrl = new URL(httpsURL);
            HttpsURLConnection conn = (HttpsURLConnection)myUrl.openConnection();
            conn.setRequestProperty("Authorization", API_KEY);
            conn.setRequestMethod("GET");
            InputStream is = conn.getInputStream();
            InputStreamReader isr = new InputStreamReader(is);
            BufferedReader br = new BufferedReader(isr);
            String inputLine; //Holds current line returned from API
            while ((inputLine = br.readLine()) != null) {
                //pb.step();
                input.append(inputLine);
            }
            br.close();
        } catch (IOException e) {
            throw new RuntimeException(e);
        }
        return input.toString();
    }
}
