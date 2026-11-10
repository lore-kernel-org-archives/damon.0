Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.180
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794275640;
	b=OGkxRv9ng5lLJdGvgLmX4Zf4OuZucEbB8nq1/Xnn+jxDqtU3YibSkS0yRwE6NFCtiVpj
	 UW4hsikZrdiarhCCFGdhcBhfbicwEkHjqJ5etMGgFcJQf6AeWgZeFQYPp/uBpGMvohsRd
	 imXxxGR+hRWeBw49qvEK0IU6jY8mBr/hdsRpH8/RNBv3RGHKYfL8Nchiwq8kRSb+Eb/tu
	 HTlHoJR/dTtKIlnZY61WdocgxVepWuumKgpE57VmxxNpaReY85WBJaB+ETl0BBLdBYv/e
	 E9mNYu9Q5v9fSkUFs0chnw2ApFof+DQYvv4hfCl/sJ/8PCcUW3mg80+wD2g4EdkJ1aA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794275640;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=BHlakyrx19DFI00OyTV3/5itJ6vPo7FNJRTP0VUFhsQ=;
	b=ore4KD/68diJ6psM5kTNpJVeQej98HVuftjA8aEhsHpgOc8JKDnKQ7O+KjMYlfW8dZay
	 7OQZq/GRuDKorYR/0AJzqDL1OdJGDr4odB3X8ljlZF4msGr5HIw6MpQ6cPSeMrIamLPEm
	 JKNKjp+3WvWh/h1XcyWFS5nHRz4AGaR50b+4deaRsNklbPQXBPZioY1Zzh6BvJTibKZ/k
	 et/JFWpIFsKkhPOp+gG0av/H/3UtXznU/cVMfrM5T/kDu7EZ4h+P1PBER/M5Mh4TKrRIF
	 btRw1wXDNuNFCsS4htLY/JZqce8WFKh4EXHctRqCqYRSJS8EmiGWHgVs0QAuV9tNcbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uthBJ08w;
	arc=none smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C511A606A321
	for <damon@lists.linux.dev>; Tue, 10 Nov 2026 01:53:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C511A606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uthBJ08w
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06e79e152so796174b3a.0
        for <damon@lists.linux.dev>; Mon, 09 Nov 2026 17:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794275639; x=1794880439; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BHlakyrx19DFI00OyTV3/5itJ6vPo7FNJRTP0VUFhsQ=;
        b=uthBJ08wp80VgRj+Rz5M1e+dxJGLf5MgQel3V1TN32oNjpgAmkMhWsIdX+Am9R19kw
         rkOMgPj20Ru5MC76YcE3tSJRe1P/RAmaAG8IlyW6BRghXSk8MEaesr6thQIX3S7T3qrG
         PVHWOgPARq8wPOow2QEGb/RPTROp7rk7iMuNfUfLbkgpvSrZMrQruYQILaWXHkfjOuPP
         UvNbi6QbaIPM9lsap7BWnxVjsksOEO3jZC57tXeMcuFi+jgeoPEs8YFdXrbkwyUu4JSh
         w+UaJ2j5GJBG8zH9nYGKgldeJ2Sl405T95TMT1HiUkCO314hKTbYzUxGoFjbNZzyHU7a
         QBDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794275639; x=1794880439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BHlakyrx19DFI00OyTV3/5itJ6vPo7FNJRTP0VUFhsQ=;
        b=CDuOE2Hy8QY37YYDw5WNGVODkthZUt3vmMXb4Mim3sFXOycSOfKURVc30ZkFVrdPnx
         N0Q6pmydX2wBx/sQJJcBrXfxmQylrCYoHCWB4BZ+lhQZcfG3p8pO3g7gTbYTGvKaUnFt
         NmFtVN4/HioKX+npripK1hijomAuyrlwI8GWADuNsCICchSsyuDzYJo1r1QQ7A8DZkKN
         rRLtidXJ+2fR9yYopQQGepOpZLtHPgUPJaH/zjTCTsXULQox1/eOzTwkdTG8a+JCAMGj
         ktNRXK29nskwKt/2eNz/aZRmIIJMMoYlgAlvMjdR40eLgpwHKzA/qx4Q1wLc3iaUfLeD
         yksA==
X-Forwarded-Encrypted: i=1; AL+hErGaCDnZbxPWIT9k+ve8HwK5P4m0ybqN4dz+PAzeKOBIQ/t3/F1UpCCg4yKkOFfeerKRGfeOsg==@lists.linux.dev
X-Gm-Message-State: APuU4Z+SYcFTVxOneJyX0iRvhblmoOHVJ6Gi1qXs5uF2eOZQ6ArBxBRo
	R8ckTeXA2zfcIAyvfvXtojBj+CHcMNsBLC3EI9drebgxmd3xXWBQ2ysVPGDeJw==
X-Gm-Gg: AYBFou3lbDtxmqT6kM59q4mbsaGkvz6L/dNsDDdUEeoWdm7+Vgx/gkL7bZUdr7Stdoz
	iq7ldXa0eweoH8m8cOEgs7VEkyLlQhf+yssmcQZoyiO9aEypfl58zDV42yP0fj2qO3tNZgkkLbI
	lj5XUe20/H1MvzWuRQp5LQmekdSZUYLaIgcyddcryTWcfkLTWEozTrBkkQ1srNmafpRV5sAftfk
	raBFhtnAe64GSrBoqSTBL63cQRvISoNR9JHYK6ymxW/SBRMP/o4WYbTusro5tQWcTyEwT9CxcKf
	v/GWzfgpsASWuTTNh6vSWk9UiutOmIQj4shWkcc/+55M7JXX080qUWeOykNTiVVdaZHbAzHZ1cO
	jqAqSGtnis9KmExH4VbuQ9Kk9G4ShSxsoq+wccwxJ3fzAaaeDrz522lO8mMRNBgV8rWwaDrDlMr
	u2G2RJ3eIo6Vhh9Au3jjDEKEpP3kG2+sob+hyzWnGxqO/b6GOA6ytAnFTmAAEycE7YmzL8axkko
	JC5Pvq/PR8l/iqfTxldLMiApiSUKpy3KvKVpinSKPnAoXB7dnDsBOpaHJh7MuOn1I98tkkd11YZ
	A9RnaMgF85oDcYF6gHXXVCxsuIjJndW61VLZ4vKY57KwQP9EzN6kA7EGnsBcDt7iLhSwrm5OWwo
	IlmcpCS/helfTEGALwh2fUO26ixY=
X-Received: by 2002:a17:90b:2d8a:b0:3ac:ea3b:f28b with SMTP id 98e67ed59e1d1-3b166ceb599mr1275045a91.24.1794275639153;
        Mon, 09 Nov 2026 17:53:59 -0800 (PST)
Received: from localhost ([2a03:2880:ff:45::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1690f4733sm552422a91.3.2026.11.09.17.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 17:53:58 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: yosry@kernel.org,
	shakeel.butt@linux.dev,
	hannes@cmpxchg.org,
	mhocko@kernel.org,
	roman.gushchin@linux.dev,
	muchun.song@linux.dev,
	nphamcs@gmail.com,
	chengming.zhou@linux.dev,
	sj@kernel.org,
	david@kernel.org,
	ljs@kernel.org,
	linux-mm@kvack.org,
	cgroups@vger.kernel.org,
	damon@lists.linux.dev
Subject: [PATCH v2 4/4] mm/damon/core: use node counters instead of flushing the root memcg
Date: Mon,  9 Nov 2026 17:53:21 -0800
Message-ID: <20261110015321.611093-5-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20261110015321.611093-1-joannelkoong@gmail.com>
References: <20261110015321.611093-1-joannelkoong@gmail.com>
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
2.52.0

