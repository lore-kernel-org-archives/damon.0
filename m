Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90F3D3BAD8F
	for <damon@lists.linux.dev>; Mon, 23 Mar 2026 16:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774281728; cv=none; b=ETRBhMzQN5+ud3Ay8jKBQDHUtCH0xL5mfqsBJmLky4OO6b8dH4R6kB3vWHv0ro/g9YB9ePWstE4ASkXTPsOR7Vu/A34nyS6+1dmCU6vEnucYNpZ/GE2O2VF3Bv28SfvI/HDhKZ+th+TJ1b7qt+3YQdWYsDCLA9TjU8s9dIxx+cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774281728; c=relaxed/simple;
	bh=dMh97SpW+uW/eDiBLEvQzJEC02yLRjYzceBP5fe3b+I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PY1GMSIHX6Mk98KRhbAd008BBVIKOdhIvPq/ga2z0Nv3bDLwRArHzFS0tA5323tLkbUngW2lKJx6Z/PpxO99jrqjXgTNy6Oqqn+/HAz4eIPKUjO5x+7VDRthZLVZX+mEDkqwGiMP7MpEIrHlM4Eq2xoTjwzDPXHPnVvnU5JgXU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=bIos0/mY; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="bIos0/mY"
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-8cd90401034so28443385a.0
        for <damon@lists.linux.dev>; Mon, 23 Mar 2026 09:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1774281726; x=1774886526; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xlomcdNVnDUltLo2uoCpQfabx00EAMLLoQfBL4FGNbM=;
        b=bIos0/mYj9X9fXSl+SabGIPu7ovjT8qYSKMFiISjJus91ruABoLZaESYrucfX7+ws6
         IPrzzyocZyQ8lIiShG3c8PzNwJLhlxbBtNR5PlbSPjXHvvOJRhOEUMAAoHa2uZBLKU6q
         mWlpPmBJ9fGfr3m29P5KB9XPyxKbv8f35puifAEKDhbZ/FyoyB1gZ6ecD7Avs3FGuD01
         NZ1RG0HIJtI66wMzlAlx6KdLZigUMIYzvzwwNqDkNtMUZm54wulIoT8+ItnKX8ZctiCn
         ygZwKVT8dlkNsD4K/UVoQget4uQ0YeVQnJs1l++aFqlC/yR7JTT8KxHGW5PI8NIYFe7j
         DQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774281726; x=1774886526;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xlomcdNVnDUltLo2uoCpQfabx00EAMLLoQfBL4FGNbM=;
        b=MJJxPVD3sKn6suIYDsZ0YBO8NRG1q4gcZVYix4GnWVktRkEOjebFcnnruMrthWqzHU
         eCHlJ8SYZ9YSBaVx/tID2Ww/Mr43QXSX1+1kqj4k8L2Q43FY5TmLN+9GxD97FgiCAwrk
         nRZelewFVfH3s2vXJo7iRaUf9iQrisk1yiWfCiA7343lAOcciBsudsirtH8meQrXJiZk
         6e7Rlpl8GfrcpOFqFmR2c0gvm6OkdJFKdSA2PaJM5P3RC/IPLGsGvKlVkc2PTGBd/e7E
         /9OX3TBNlhKo8IY3BEqf5mRAwnU8Y7mP5zIxjb+X8JGKmXvoiD3nB9IdcEMAN4U+sEi5
         k+5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUT90Vgr2WZ4Zfc15MDrtZyYRWdlZHn3T5I37vJlnBf1es/KjY41Ub9dnH7Y0jV5VGKy2IkpQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyuyeo64ZhBeHHak49tvZoxlkneG6BiAjYfUgmqtxCTcp89qhTS
	jkcHYJOX4ujk7B1g6EUqQ2qSc/VKEDWg4hVLKWVBu7U/cSTj5fzwxg0zT6HOJArQngvDdZ4jOYq
	k16R9An3opA==
X-Gm-Gg: ATEYQzwtJrSIrbYAQf09DhEcKhw33hpTCDlQW9SLsXAAVmLSRit6qlcy0M6wUu0sdk9
	6a2eXdgS3JsZiD21BR5hy9G5V2z9vAMdzEx96Wsp/xs1ue4cRB8mOqqoV3/RLBGmY3WphBeEpad
	sH3Hs5DgXDmYXoMFulcw2G1oCQjORgN9xusql/sHO/Rusw8Jz4kbAaorf2LNDJ/WWe4lxgame2E
	td8JUMLxr26y1iGCosteeNLo6N7smqRrpCSTQIRQlY2Ot7hq6PHT+Wwwc1LzdRQ1n1haG/xQL87
	3oqXgGVgFwzMuVuvIuosrtRQ/LAtMdwA3iIjwgfOZNDMA/fgUlEagGIWarzQX3cR7pofz/HnJmO
	GILb0+WHl1folIdqJ3vhbv657WqcgL4fyYe07aLOu0Y3VzegCc3vIxDvhoqANoFD+hxUw3lMD1Z
	BeTzmGrYzTtx950WaojL79i5K6S+z1zDNfKFeS8oDp0iTjQsL7TLGPAvH4TayDtqdSOQ==
X-Received: by 2002:a05:620a:1a04:b0:8b2:e5da:d317 with SMTP id af79cd13be357-8cfc7f69b95mr1829148885a.54.1774281699112;
        Mon, 23 Mar 2026 09:01:39 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cfc9088df1sm843364185a.25.2026.03.23.09.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 09:01:38 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2 18/19] mm: damon: Use trace_call__##name() at guarded tracepoint call sites
Date: Mon, 23 Mar 2026 12:00:37 -0400
Message-ID: <20260323160052.17528-19-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323160052.17528-1-vineeth@bitbyteword.org>
References: <20260323160052.17528-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_damos_stat_after_apply_interval() with
trace_call__damos_stat_after_apply_interval() at a site already guarded
by an early return when !trace_damos_stat_after_apply_interval_enabled(),
avoiding a redundant static_branch_unlikely() re-evaluation inside the
tracepoint.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
---
 mm/damon/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index adfc52fee9dc2..b1cc4f44f90a2 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2342,7 +2342,7 @@ static void damos_trace_stat(struct damon_ctx *c, struct damos *s)
 			break;
 		sidx++;
 	}
-	trace_damos_stat_after_apply_interval(cidx, sidx, &s->stat);
+	trace_call__damos_stat_after_apply_interval(cidx, sidx, &s->stat);
 }
 
 static void kdamond_apply_schemes(struct damon_ctx *c)
-- 
2.53.0

