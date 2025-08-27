#!/usr/bin/env python3
import requests
import json
import sys

def get_quote():
    """Fetch inspirational quote of the day with proper error handling."""
    fallback_quote = "If you love life, do not waste time, because time is what life is made of. - Bruce Lee"
    
    try:
        # Use ZenQuotes API which provides free inspirational quotes
        url = "https://zenquotes.io/api/today"
        
        # Set timeout and headers for better reliability
        headers = {'User-Agent': 'dotfiles-quote-fetcher/1.0'}
        response = requests.get(url, headers=headers, timeout=5)
        
        if response.status_code == 200:
            data = response.json()
            
            # ZenQuotes returns an array with one quote object
            if isinstance(data, list) and len(data) > 0:
                quote_data = data[0]
                quote = quote_data.get('q', '').strip()
                author = quote_data.get('a', 'Unknown').strip()
                
                if quote and author:
                    return f"{quote} - {author}"
        
        return fallback_quote
        
    except requests.exceptions.Timeout:
        return fallback_quote
    except requests.exceptions.ConnectionError:
        return fallback_quote
    except (requests.exceptions.RequestException, json.JSONDecodeError, KeyError, IndexError):
        return fallback_quote
    except Exception:
        return fallback_quote

if __name__ == "__main__":
    print(get_quote())
