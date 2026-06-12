Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AECB4390981
	for <damon@lists.linux.dev>; Fri, 12 Jun 2026 15:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781278904; cv=none; b=QdoqPAGx7VGR/27op7ByzJnVzs3bYXrkujkcxXUbgS6i4F3AxiRIemUbRJzWmX8z5dT8TpEf50srk6rWJhFVO4nSHInGvykQG50HO2tpVCIQhHHoMSpmiPPKMgXRO2VqSiyOhD7vElPKvMlb0hhAS/JBbCxknQr63GgO0vOwD3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781278904; c=relaxed/simple;
	bh=XSbiX35MYt88wNRA9jDtXoTuBV9O4gzqI0rmqMUENh4=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=uSrY/fa0+v8rWsdt1YVLcM3f5XCz1f33lEz6supNjInPjwzhcy2jUTDZqLf6UbBEz+bRjtOq2lYUOkOC90eV1xWl8p9GFBz0mdLD9LjRtceOjPngL6/SBrl26hnoMV1OEEDbzI+/pfFroUENRDSekCQ9fi1fI4aHsHfR1YPVtHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m2awfWgF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2awfWgF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0c35980fdso10870125ad.2
        for <damon@lists.linux.dev>; Fri, 12 Jun 2026 08:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781278903; x=1781883703; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=lMSNFcJBymbDQ1FfS4jB1HE+wy0VFeTfT8KyQHMfM+0=;
        b=m2awfWgF7D0EAbc1OY0LDR23b0QdhFuu/3+m6pwHJi9ga8e0J1XglbIDZAApJ/sjye
         Foe7aceqZwkj8SdJntkKtfbyEtcjjg0C10SNdLKS8DMADYTPMgFx8KfuL/It9Y8+vi/F
         vZAREQW57dN4ixxUT8wYt5ZH/g6v+jdBgztcGARTRXR/cxEZMJ8hbeLczhxcxdFjDaVG
         5w9ED1pdacZMeKRCvUc7D3pXFmKAE5b3TGzJHkRiqx4IVLM0M7CzYwCP5y8HaCz0gcE8
         UGMUwKHd54aiMN50/FqBa7NTW15N70o8NmZ0BcwcOHy5AR5DBuObdOm25q4dGqBcLVDH
         jZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781278903; x=1781883703;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lMSNFcJBymbDQ1FfS4jB1HE+wy0VFeTfT8KyQHMfM+0=;
        b=NGla6fic7c0mEBEG8+l7B940HTA/woJjxV6lDEPlVma+qqEjeRwLp25yvf3Kwib/ji
         u2DOrJdSOpPVka2THn3ZsSj9tb0VJWVCNu6um4HslxXfIwWYqjMhnHlOiqQhE6bWD7lG
         ETFmQ2BzxCV5G69grd8Bw1Ri0bEDUR5BPXvjT/Mzl5gOGzbIXmGXq/yIdBuhuiZAU30t
         6ksAgMewHfxW9smnTphzrd7J+zrZgnigcblMJMNvXuXkIaXXY9Vt2Wk2lkxqVHRqM/z4
         UVAas3I5kABd25iECB0RzZL2NV1UvncDmvwi8SRJMyoYQuA8a9ynaGNuKvqnfieMMY1p
         r58Q==
X-Forwarded-Encrypted: i=1; AFNElJ/jij3cXf0/BjO/LH/drlMfLdBiU8EaFyj1y40l5pJnWEb5DcGcmEZ5e9l0QyWLGbkpP+mgGg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw3OSxXijmgB1Z5oXKBGioNGqUb1EXYcp0d7iEv9O4XPd7enS5r
	jJr0iBfF2ItZlbpLQBQ7PSpWUcGx3gTA9Yow30ldhtYdQ0M9g1OhYzVO
X-Gm-Gg: Acq92OE3wkayS/A9ZACQfqjOYKCY6VKyJ4tXAoR5LlD/sY2hgPhVzdkVG5YbcXYD3wt
	vJGVsTq02xlEGt25AUrRq6/UOpfj3egt+t/HrriIxdX2MvJwbSB7V8SX2XAydtATyyXuJcOxJSP
	b1+yYrwzlY4UXeM/66ad1950hCKJmqewE87832F1+fju0H3pkoWI5FQ2suzkNR9946BlCp5+xJA
	KwkSEMGbIy+mBHdRhJ2LCdrvgs4Jtd945vKTDrbJCZk13BMo4NSoNFn1UR1cwEfQ5jAIcXN7Arr
	Dfgp9HW6+NoDHcUe2R9Z9WRu/MrLWC9NrWFnRCI8Of6RN45ERrJyedUvV2Z/He8sBHAsMh58Omo
	WoUSVORg1GsV/Exg8g9uothJjEbxIl6xLaeMZtrRk9W3QqoS7jak0ljTkSYh8TEeWQcXPryWPf8
	My/g2CdUQFENlNhjPTa/VGU+87w5bbjJ39u4xr9hT2F+X/jgcdT2plNRLcHBFwiqt+M+J9oDkjv
	VSmnkM=
X-Received: by 2002:a17:903:2985:b0:2c1:564b:4f47 with SMTP id d9443c01a7336-2c412840ae4mr41665205ad.26.1781278902981;
        Fri, 12 Jun 2026 08:41:42 -0700 (PDT)
Received: from shardul-ThinkPad-P16s-Gen-4-AMD.tail792e28.ts.net ([2401:4900:1c17:d4b4:80cb:f14b:59ec:7cab])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42f2e52b5sm24559555ad.7.2026.06.12.08.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 08:41:42 -0700 (PDT)
From: Shardul Deshpande <iamsharduld@gmail.com>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] Docs/mm/damon/design: fix a typo in the Address Unit section
Date: Fri, 12 Jun 2026 21:10:54 +0530
Message-ID: <20260612154054.720363-1-iamsharduld@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "Address Unit" section misspelled the C type that the DAMON core
layer uses for monitoring target address ranges.  Correct it to read
"unsigned long".

Signed-off-by: Shardul Deshpande <iamsharduld@gmail.com>
---
 Documentation/mm/damon/design.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index afc7d52bd..899ac9c69 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -140,7 +140,7 @@ as Idle page tracking does.
 Address Unit
 ------------
 
-DAMON core layer uses ``unsinged long`` type for monitoring target address
+DAMON core layer uses ``unsigned long`` type for monitoring target address
 ranges.  In some cases, the address space for a given operations set could be
 too large to be handled with the type.  ARM (32-bit) with large physical
 address extension is an example.  For such cases, a per-operations set
-- 
2.43.0

