package net.syscon.util;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.*;
import java.text.MessageFormat;
import java.text.ParseException;
import java.util.*;

public class SQLProvider {

    private final Logger logger = LoggerFactory.getLogger(getClass());
	private Map<String, String[]> statements = new HashMap<String, String[]>();
    private final Map<String, String> variables = new HashMap<String, String>();
    private File file;



    public SQLProvider() {
    }

    public SQLProvider(Class<?> clazz) {
        String resourcePath = "/net.syscon.elite.persistence.repository.impl.".replace('.', '/')  + clazz.getSimpleName() + ".sql";
        InputStream in = clazz.getResourceAsStream(resourcePath);
        loadFromStream(in);
    }




    public SQLProvider(File file) {
        this.file = file;
    }

    protected void loadVariables() {
        for (final Map.Entry<String, String> entry : System.getenv().entrySet()) {
            variables.put(entry.getKey(), entry.getValue());
        }
        for (final Map.Entry<Object, Object> entry : System.getProperties().entrySet()) {
            variables.put(entry.getKey().toString(), entry.getValue().toString());
        }
        // workaround to define $HOME on Windows
        final String value = variables.get("${HOMEPATH}");
        if (value != null) {
            variables.put("${HOME}", value);
        }
    }

    public void addVariable(String key, String value) {
        variables.put(key, value);
    }

    public void loadFromFile(File file) {
        InputStream in = null;
        try {
            in = new FileInputStream(file);
            loadFromStream(in);
            this.file = file;
        } catch (final IOException ex) {
            throw new RuntimeException();
        } finally {
            if (in != null) {
                try {
                    in.close();
                } catch (final IOException e) {
                }
            }
        }
    }

    public void loadFromClassLoader(String filename) {
        final ClassLoader cl = Thread.currentThread().getContextClassLoader();
        final InputStream in = cl.getResourceAsStream(filename);
        if (in != null) {
            loadFromStream(in);
        } else {
            throw new RuntimeException("File " + filename + " not found on the classloader");
        }
    }

    public void loadFromStream(InputStream in) {
        loadVariables();
        final CharArrayWriter out = new CharArrayWriter();
        final char cbuf[] = new char[1024];
        try {
            final BufferedReader reader = new BufferedReader(new InputStreamReader(in));
            int size = reader.read(cbuf);
            while (size > -1) {
                out.write(cbuf, 0, size);
                size = reader.read(cbuf);
            }
            parse(out.toCharArray());
        } catch (final Exception ex) {
            throw new RuntimeException(ex);
        }
    }

    public void parse() {
        loadFromFile(file);
    }

    public void setFile(File file) {
        this.file = file;
    }

    private void parse(char content[]) throws ParseException {

        final Map<String, String[]> newStatements = new HashMap<String, String[]>();
        String paramName = null;
        int startIndex = -1;

        final Queue<Character> queue = new LinkedList<Character>();

        int i = 0;
        while (i < content.length) {

            // get the param name
            if (paramName == null) {
                startIndex = i;
                while (i < content.length && paramName == null) {
                    if (content[i] == '{') {
                        queue.add('{');
                        paramName = new String(content, startIndex, i - startIndex);
                    }
                    i++;
                }
            }

            if (i >= content.length) {
                continue;
            }

            paramName = validateConfigName(paramName.trim());
            startIndex = i;

            while (i < content.length && queue.size() > 0) {
                if (content[i] == '{') {
                    queue.add('{');
                }
                if (content[i] == '}') {
                    queue.poll();
                }
                if (queue.size() == 0) {
                    final String s = new String(content, startIndex, i - startIndex - 1);
                    final List<String> list = new ArrayList<String>();
                    String values[] = s.split("\\\n");
                    for (int k = 0; k < values.length; k++) {
                        String ss = values[k];
                        for (final Map.Entry<String, String> entry : variables.entrySet()) {
                            final String key = "${" + entry.getKey() + "}";
                            ss = ss.replace(key, entry.getValue());
                        }
                        if (ss.indexOf("${") > 0) {
                            throw new RuntimeException("Variable on configs file not resolved => " + ss);
                        }
                        final String clean = getCleanStr(ss).trim();
                        if (!"".equals(clean)) {
                            list.add(ss);
                        }
                    }
                    values = list.toArray(new String[0]);
                    newStatements.put(paramName, values);
                    paramName = null;
                }
                i++;
            }
        }
        if (queue.size() > 0) {
            final String text = new String(content, content.length - 21, 20);
            throw new ParseException("Missing end brace", text.length() - 1);
        }
        statements = newStatements;

    }

    private String getCleanStr(String text) {

        if (text == null) {
            throw new IllegalArgumentException("Input text is null");
        }

        int startIndex = -1;
        int endIndex = -1;
        int i = 0;
        char c;

        // get the startIndex
        while (i < text.length() && startIndex == -1 && i < text.length()) {
            c = text.charAt(i);
            if (c != '\n' && c != '\r' && c != ' ' && c != '\t') {
                startIndex = i;
            }
            i++;
        }

        // get the endIndex
        i = text.length() - 1;
        while (i >= 0 && i >= 0 && endIndex == -1) {
            c = text.charAt(i);
            if (c != '\n' && c != '\r') {
                endIndex = i;
            }
            i--;
        }

        if (startIndex == -1 || endIndex == -1) {
            return "";
        }
        return text.substring(startIndex, endIndex + 1).trim();
    }

    private String validateConfigName(String statementName) throws ParseException {
        char c;
        int i;
        boolean valid;
        statementName = getCleanStr(statementName);
        final String s = statementName.toUpperCase();

        for (i = 0; i < s.length(); i++) {
            c = s.charAt(i);
            valid = c >= 'A' && c <= 'Z' || c == '.' || c == '_' || c >= '0' && c <= '9';
            if (!valid) {
                throw new ParseException(statementName, i);
            }
        }
        return statementName;
    }

    public String get(String name) {
        return get(name, false);
    }

    public String get(String name, boolean trimElements) {
        String sep = "";
        final StringBuilder sb = new StringBuilder();
        final String values[] = statements.get(name);
        if (values != null) {
            for (int i = 0; i < values.length; i++) {
                if (values[i].startsWith("\t")) {
                    values[i] = values[i].substring(1);
                }
                if (trimElements) {
                    values[i] = getCleanStr(values[i]);
                }
                sb.append(sep).append(values[i]);
                sep = "\n";
            }
        }
        return sb.toString().trim();
    }

    public String getWithParams(String name, String... args) {
        final String s[] = statements.get(name);
        final StringBuilder sb = new StringBuilder();
        if (s != null) {
            for (int i = 0; i < s.length; i++) {
                sb.append(s[i]).append("\n");
            }
        }
        final Object params[] = new Object[args.length];
        for (int i = 0; i < args.length; i++) {
            params[i] = args[i];
        }
        final String result = MessageFormat.format(sb.toString(), params);
        return result;
    }


}