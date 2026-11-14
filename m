Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794616205;
	b=UC7fVMwcucjIu/BcIpOuYoj9tvxKU4m2MkqmQ18KK5P/l16JjazJ3XUOsYr4x9UQCIdg
	 QuYhz0F2tJsxiOZWpxEO1f4cpsRj5X6EbZy5RHaFRfNStMg339eu4++x2FYcZDKkVJXAg
	 3osrv5MNX28VaL64zYUQpqZh0ia83gVkosofXVkeHGSr29G0MFPliQn1Xah1MylOme0li
	 I0C+Zvb7DIUdN22dSXjbx4mycoq6f5R32+J6aE08nl00+1WfeqkUQJNxYL/8okw1ykuVh
	 rp5flS2EF0a7tTS91dFbYf+a+W+kptSAOOiuUtac3Ri6HzEVZVjaCI0FmzB62uMFWeQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794616205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AolziNO7wrlcNMetD7JvJr3jJHx3WRU9EZSr3HZdTJ8=;
	b=XdT3sgxdwJbgVwP+HQQ+7ECLZAXd3FW9Iku2xWI9ndObYMppAnK3DKInXfcm62ZGuMpI
	 0TaWzp68euybxO/Vrc78j7m88EZarcNIxt/oa49fIUlKkZ6Jfsmt78OPYx2C3Wkn+c22x
	 9xZEZFjax1BKWsgdEHeeTYdWwP4aqeelvv5GP4INw/aPkr1cXFsidFvz3brWtipC28MEo
	 8vmkGOEEorDPfcq9tQ07Pvm9/NBtVvQvLmxickt/YlYHKruKUdCh5H7ODfPrI8XtaAFsh
	 b/0hBWxPG5dTBZ2tsvMtc7sAfIaZ21d34YjA3Sxn5/7gMugqPfHDjW6OTZE96NFC0Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiwrF1yC;
	arc=none smtp.remote-ip=74.125.224.44
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEEE606A329
	for <damon@lists.linux.dev>; Sat, 14 Nov 2026 00:30:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6AEEE606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BiwrF1yC
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-67c2c2ac1c3so1661332d50.1
        for <damon@lists.linux.dev>; Fri, 13 Nov 2026 16:30:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794616203; x=1795221003; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AolziNO7wrlcNMetD7JvJr3jJHx3WRU9EZSr3HZdTJ8=;
        b=BiwrF1yC/bLKrvZEAHxVu0/xafMwQtFeoVCJpH4nvDgKlwKYKJRMxt7ELT+mSWLHZX
         SPQOP3IKVleCEbKHJCY1fLi1S4J2j8JTTj5RO9c9u522xcijjzbVT3BxRkRGdsNbtVFs
         j9yKJIWpkKCd5CnVvhAC2PbRdaqexZUOUYDIiuvZUsxRaA0Rqk4rVM+C05sobmq0Vwbx
         R8nzNel43sZP+t8tv/j/2Hbrv8TBlZRqKxGuvBNe8DNbMIoRejnmGoMp2LrxDQA2q9Qn
         6bCfZ6h9CxqlzRmxs1ZYmiv4Ffzwok7zl1Q5PU+dvwsXx73yMVJSkqDPWcYqGwNRsbT7
         2JuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794616203; x=1795221003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AolziNO7wrlcNMetD7JvJr3jJHx3WRU9EZSr3HZdTJ8=;
        b=tsHe1tEW7izTkktKPSAZ6hB2qiWLORfVO5nptXWG5R6LE+ukC2ME8ODfzgqAfN9cC9
         IcKAQYDxILFzLZpDxJVAUpL+5aZVSWw1QhL64ShNKVbSPvA2swaY3qZImn8sNjymA4In
         2rtwCv0w9+q3mfR3bVj1hOUjokvRdm1U4pvaEXOq4Hh5P2O0t+8KFjDh4QtC9P/nS4TY
         kqafnFxD31Rjzo08HiU3QF+jjrP5BigFsTTM8xN46VjjGkAgF9oSZiUWyBZ3W52TXapL
         qpcjdiKi1ACASv2ZEYYV2I0uS9l0vHtTTPQN+7TwqzUzlUMXmx+1lzqZb8Hy4kjSQX3i
         Ylkw==
X-Forwarded-Encrypted: i=1; AL+hErEMv5O/ao17aJrylKaBLxxkc7FLMySeOhdlvjcHpl3swg6cx03krLihMx1B0Be85LuM2I/YjQ==@lists.linux.dev
X-Gm-Message-State: APuU4Z9zh1ccz3SU0k+WKwnWH6hf2Y+qnKaWJsSvh4YiMX3SreIGnMz2
	SA+yNriaz0Jb0ypifXHAWvyN6+lfckrH2fAqfmJ+WlTpzUPzCeluhRFt
X-Gm-Gg: AYBFou1DRtj6sWiJ8mNlQY6fXHgS61r7eWDzzSe2inYLPYijx9GUkSzodnPAJEMAB/b
	xI8AKCpz+f23mFTmErk6buWljSSHfH3XwvRP6f/cuRxF0x7JBF5eDHbn+UYhylHtv4SSN2b0kBK
	J0FCT8e7Z+33Ouevn2Lm+GmCs2Rne8AjZwaCk98smZxXPaTPAFgmRizTgC6KHZN9udLCqrguec7
	DsKfrCsWyiM8oAZ06E9j4tO51qEV0BpvislqClJ3T8jcGZWB2+QUY9bOsoX5kEoWlwBKUwELRzG
	ZFO6mvpyCa+ZlAQ9XepKNR0ekuf2I5B/U8hBuHLo1yXar8d307CqFAgoaBQMSR/PmhkIaybv3SU
	XGRJ5YM3yZcHwbzV5CgQL6Mi/EtV+6Q+vbbl6iG5Xl9F1WuhxZEy+fQp0yVR/ImDkjFabfkzhDB
	iJm95tiNJ4bUx/9zOBpjC3wxjovz/9X7Qadmo4fIMIwQb+2OVSi+8LILhbeL/dgROqRdPnKysmO
	zol8J2dybEWLXTf2uXIx76dj718PGqTbyGBW9hEGIaeuNsM90esSHcYLfLJzTHUUFkaye22R/qJ
	zFkkw2grE8msnurw/QA6/uNwxAPiTd7uDJ6yrF6UN2+4z+3MvXD9/o2f7Cx8cCWcYQERdph7t1k
	M6q3dDw==
X-Received: by 2002:a05:690e:130e:b0:675:1102:ffa5 with SMTP id 956f58d0204a3-67d8933e768mr2424694d50.3.1794616203430;
        Fri, 13 Nov 2026 16:30:03 -0800 (PST)
Received: from localhost ([2a03:2880:ff:50::])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67d8a55b09esm3473161d50.6.2026.11.13.16.30.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 16:30:02 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org,
	david@kernel.org
Cc: yosry@kernel.org,
	mkoutny@suse.com,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	ljs@kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH v3 4/4] mm/damon/core: use node counters instead of flushing the root memcg
Date: Fri, 13 Nov 2026 16:28:22 -0800
Message-ID: <20261114002822.1043378-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.1
In-Reply-To: <20261114002822.1043378-1-joannelkoong@gmail.com>
References: <20261114002822.1043378-1-joannelkoong@gmail.com>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_get_node_memcg_used_bp() flushes the memcg stats before reading
the LRU sizes of the goal's memcg on the goal's node. For the root
memcg, that flushes every cgroup in the system. The flush is not
ratelimited, which means it happens every time the goal is evaluated.

lruvec_page_state() now reads the LRU sizes of the root memcg from the
node counters, which are always up to date, so skip the flush for the
root memcg.

Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 mm/damon/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 0a056949604f..14f2a36c1025 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -3057,7 +3057,12 @@ static unsigned long damos_get_node_memcg_used_bp(
 			return 10000;
 	}
 
-	mem_cgroup_flush_stats(memcg);
+	/*
+	 * The root memcg's LRU sizes are read directly from the node counters
+	 * (see lruvec_page_state()).
+	 */
+	if (!mem_cgroup_is_root(memcg))
+		mem_cgroup_flush_stats(memcg);
 	lruvec = mem_cgroup_lruvec(memcg, NODE_DATA(goal->nid));
 	used_pages = lruvec_page_state(lruvec, NR_ACTIVE_ANON);
 	used_pages += lruvec_page_state(lruvec, NR_INACTIVE_ANON);
-- 
2.52.1

