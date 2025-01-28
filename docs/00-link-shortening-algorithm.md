# Link Shortening Algorithm

## Overview

This document explains the process of generating a shortened link using the provided Ruby method. The method ensures
that each generated link is unique by leveraging timestamp and sequence components.

## Components

### 1. Timestamp

- **Bits:** 32 bits
- **Description:** Represents the current time in milliseconds since the Unix epoch (January 1, 1970).
- **Calculation:**

```ruby
    timestamp = (Time.now.to_i * 1000) & 0xFFFFFFFF # 32 bits
```

### 2. Sequence

- **Bits:** 16 bits
- **Description:** Sequence is a incrementing number that are used to prevent duplication when there is alot of create
  request coming in from the same msF
  Code:

### Bit Composition Diagram

```
┌───────────────32 bits───────────────┐┌──16 bits──┐
│            Timestamp                ││ Sequence  │
└─────────────────────────────────────┘└───────────┘
```

### Encoding

Base Encoding: Base62
Output Length: 8 characters

Rationale: Base62 encoding efficiently represents the 48-bit combined timestamp and sequence value in a compact 8-character format.

### Key Takeaways
- The use of a 32-bit timestamp and 16-bit sequence provides sufficient uniqueness for high-volume link creation scenarios. 
- Sorting can be achieved by timestamp since the higher-order bits represent the time component.
- Base62 encoding ensures short, URL-friendly identifiers.
- This approach avoids duplication without relying on external databases.