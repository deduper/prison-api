package net.syscon.elite.service.support;

import java.util.Comparator;

public class NaturalComparator implements Comparator<String> {

    @Override
    public int compare(String leftValue, String rightValue) {

        String left = (leftValue != null) ? leftValue : "";
        String right = (rightValue != null) ? rightValue : "";

        if(lastValueIsANumber(left) && lastValueIsANumber(right)) {
            int position = stripNumbers(left).compareToIgnoreCase(stripNumbers(right));

            if(position != 0)
                return position;

            int leftNumber = Integer.parseInt(stripLetters(left));
            int rightNumber = Integer.parseInt(stripLetters(right));

            return leftNumber - rightNumber;
        }

        return left.compareToIgnoreCase(right);
    }

    private Boolean lastValueIsANumber(String value) {

        if(value.isEmpty())
            return false;

        char[] data = value.toCharArray();

        return !Character.isAlphabetic(data[data.length-1]);
    }

    private String stripNumbers(String value) {
        String justLetters = "[^a-zA-Z]";

        return value.replaceAll(justLetters, "").trim();
    }

    private String stripLetters(String value){
        String justNumbers = "[^\\d]";

        return value.replaceAll(justNumbers, "").trim();
    }
}