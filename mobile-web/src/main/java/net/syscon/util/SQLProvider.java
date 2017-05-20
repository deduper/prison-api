package net.syscon.util;


import net.syscon.elite.exception.EliteRuntimeException;
import org.springframework.core.io.ClassPathResource;

import java.io.*;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

public class SQLProvider {

	private final Map<String, String> statements = new HashMap<>();
    private File file;

    public SQLProvider() {
    	// default constructor to be used with lazy loading ...
    }

    public SQLProvider(final Class<?> clazz) {
        try {
            final String resourcePath = clazz.getSimpleName() + ".sql";
            ClassPathResource resource = new ClassPathResource(resourcePath);
            final InputStream in = resource.getInputStream();
            loadFromStream(in);
        } catch (IOException ex) {
            throw new EliteRuntimeException(ex.getMessage(), ex);
        }
    }

    public SQLProvider(final File file) {
        this.file = file;
    }

    public void loadFromFile(final File file) {
    	try (FileInputStream in = new FileInputStream(file)) {
            loadFromStream(in);
            this.file = file;
        } catch (final IOException ex) {
            throw new EliteRuntimeException(ex.getMessage(), ex);
        }
    }

    public void loadFromClassLoader(final String filename) {
        try {
            ClassPathResource resource = new ClassPathResource(filename);
            final InputStream in = resource.getInputStream();
            loadFromStream(in);
        } catch (IOException ex) {
            throw new EliteRuntimeException(ex.getMessage(), ex);
        }
    }

    public void loadFromStream(final InputStream in) {
        final CharArrayWriter out = new CharArrayWriter();
        final char[] cbuf = new char[1024];
        try {
            final BufferedReader reader = new BufferedReader(new InputStreamReader(in));
            int size = reader.read(cbuf);
            while (size > -1) {
                out.write(cbuf, 0, size);
                size = reader.read(cbuf);
            }
            parse(out.toCharArray());
        } catch (final Exception ex) {
            throw new EliteRuntimeException(ex);
        }
    }

    public void parse() {
        loadFromFile(file);
    }

    public void setFile(final File file) {
        this.file = file;
    }
    
    
    private int getNext(final char[] content, final int offset, final char searchFor) {
    	if (offset >= 0) {
	    	for (int i = offset; i < content.length; i++) {
	    		if (content[i] == searchFor) return i;
	    	}
    	}
    	return -1;
    }


    private String makeString(final char[] content, int startIndex, int endIndex) {
        StringBuilder sb = new StringBuilder();
        for (int i = startIndex; i < content.length && i < endIndex; i++) {
            sb.append(content[i]);
        }
        return sb.toString();
    }

    private void parse(final char[] content) throws ParseException {
        final Map<String, String> newStatements = new HashMap<>();
        int i = 0;
        while (i < content.length) {
        	final int startIndex = getNext(content, i, '{');
        	final int endIndex = getNext(content, startIndex, '}');
        	if (startIndex > -1 && endIndex > -1) {
        		final String key = removeSpecialChars(makeString(content, i, startIndex).trim(), ' ', '\t', '\n', '\r');
        		final String value = removeSpecialChars(makeString(content, startIndex + 1, endIndex),  '\r', '\n');
        		newStatements.put(key, value);
                i = endIndex + 1;
        	} else {
        	    if (startIndex < 0 && endIndex < 0) {
                    i = content.length;
                } else {
                    throw new ParseException("Missing end brace + ", startIndex);
                }
        	}
        }
        statements.putAll(newStatements);
    }


    private boolean in(char value, char[] elements) {
        boolean found = false;
        for (int i = 0; !found && i < elements.length; i++) {
            found = elements[i] == value;
        }
        return found;
    }


    private String removeCharsStartingWith(String text, char ... elementsToRemove) {
        for (int i = 0; i < text.length(); i++) {
            if (!in(text.charAt(i), elementsToRemove)) {
                return text.substring(i);
            }
        }
        return "";
    }

    private String removeCharsEndingWith(String text, char ... elementsToRemove) {
        for (int i = text.length() - 1; i > 0; i--) {
            if (!in(text.charAt(i), elementsToRemove)) {
                return text.substring(0, i + 1);
            }
        }
        return "";
    }

    private String removeSpecialChars(final String text, char ... elementsToRemove) {
        String result = removeCharsStartingWith(text, elementsToRemove);
        return removeCharsEndingWith(result, elementsToRemove);
    }


    public String get(String name) {
        return statements.get(name);
    }
}

