package blockchain.breizhcamp.speakersdapp;

/**
 * Created by gunicolas on 28/03/17.
 */

public abstract class Constants {

    private static final String ID1 = "e6847cc3eabba1b9c4b0c4663067a839f2387e6252c482f49ea991da28822a2b7de926b86ab9ffd0847da72367f8642d6f87d68f407110bad6210ef6c86dc318";
    private static final String ID2 = "3c979e5dec51a4fa66d256b7c5fe2c15d295b57221a7289fab2f6abe61a10a79d6e8389108e8baddf631f2d3a77e5e262c94ebcf2d705c0666cda5de14d01017";

    public static final String[] BOOTNODES_ID = new String[]{
        "enode://"+ID1+"@192.168.0.10:30303",
        "enode://"+ID2+"@192.168.0.10:30304"
    };
}
