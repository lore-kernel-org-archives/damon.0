Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A51274BE1
	for <damon@lists.linux.dev>; Sat,  6 Dec 2025 01:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764983892; cv=none; b=ZjqqBpQ8kCUb6nY2SgXnCmvGEnXvOvhvEQ7KCc/yZIcKbNb6JZ9LRJj4HZFVXvBNkCK04ZIbdRmvrh9XmJP38gYVyT6dUW24sLb0VyhMxjkghmu+ENohjZwwGUzfswhCIAJsoXKMTU5gr++SZLqUi3ilZFowavRAzb1Q/3ktS08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764983892; c=relaxed/simple;
	bh=AHTk3YwkNqpRJ7qnmeUFhdcIIPF4pxNmDd6plO/PobY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XmJlOA1B9sNp7CHog0n0fvw+kCSK8JC8TAPNFl2cXzhm2I1OE98zM9KNMvqqfnmYx1IxCHy94kN3sZR0G+b5iM25tyTgzui9HJupRIBTmbTgqHOPODsfZ6qOMbFqY1agbBwLDszsZOCIbRiyaxhi2Ycp5xyynDH2VwNJPj7RmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AQetZv+A; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AQetZv+A"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-29586626fbeso33821845ad.0
        for <damon@lists.linux.dev>; Fri, 05 Dec 2025 17:18:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764983890; x=1765588690; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IAX/oOkxrywzWDIxKOdKl4z84YNY9koHwOweb+G4qdY=;
        b=AQetZv+A7bg835hWqfyyBVXPykej0ydsgFQAZSmBBfl1taChXT0Cc3zoe1xI6/5W/A
         KJaAH2BxdvCQZHfEcpi5Hdic8WTaS/peK6QzAVfGUd2mMxWrHdKITnljpvoOk5h4I7Hj
         DKxj59nP/9AiY0EV9Vqx4Y4MDsG1REeMYz9EBDSLLBcgeYuOGTlVu2GnRZl6YVewcK+I
         6BbEz7Vp4rDBRZrBKxAMh6l5+30ldTIIq3CzRMqwXSRHPyQ3h/Cg2dLrWetR8oKD98nS
         Ah1DWpSrws2pQsRGj27U+YHtNo1cEFEckZy6UibhUuG7JFWNaTu+9FRF3Ziwikyje2wo
         3sZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764983890; x=1765588690;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IAX/oOkxrywzWDIxKOdKl4z84YNY9koHwOweb+G4qdY=;
        b=kI/r2opJ/aZFtNJq/LKs5PDDgxZTxmuuSwqiwPdbuCHO1pyXVVSztVP/r0EWwOz/Dn
         jLxkcTvNcCRW/jGC8ufqKFKMZCj8CPvwoEKLetqXiHw/au8VAAa82ZBiQ2jYRGkQ3xud
         AAjOhoCpNpPtVCDUWyhNXjCEhGgflYTbQldfW8GCNsWwxMipeGk6FuQnL8clRvQDkVf0
         XN32wT4CIX9IJm2MH1QWrT9akHA/6tu0/dtLQUJxxSY4PnH9OQEZCQKIZWN3HWr5iDF5
         lh6McBXc8J7EvC5AgCqQjqN2ER3zM8WuCEBnmkJvP12vzKu07oQ5xofm9lsLtguSbS8C
         auJA==
X-Forwarded-Encrypted: i=1; AJvYcCV9/CnScQFc5zryTJd7sYbm89FHk0vvHeN/sgtfxKRzYodV1nN6FZ/OWZCDWVYhtrffGHadxg==@lists.linux.dev
X-Gm-Message-State: AOJu0YzntSc0HkjVJGMksBBc43D5nobRkSnskKcjOpriGaUFVg8miLZm
	ZqNiuc1VcRmAHAt9pep/d3JuZ+7weWlU24gF1XQ2EDE1mOFh0YiVkTQl
X-Gm-Gg: ASbGncv3RjihHdTfSkDfjQfUJuFk4sjDfIMi7k3FdII63cbBCbxV9TpRpwmndUYhZ85
	s4Z/MdPlbc4GVImzS1dLPOeZwWOY4vk37GJJfVOOOBLrTf0U51ASczvbMKe3uw56/iRXdIqZFBd
	RhK1oQIR55GmJkch/Pu2U/aJGQb+u6MgPn11EM4CJMpN5aONpTDErkxbWg9BzlVDh0ROxeMHaEp
	S43fCVALEn/wN1PpAp63Xwko+X94iONJeqMfL0IrFGkFhdCGg654FPWfsA3bcKM/IScnzvavyy/
	PW7cA1HG+RIO3SC2/W55cvzTkGQWtVzMhO0gJpSMJl7v3o/4tt0gBWy7XDYDOU2YdXCwkgKvRkU
	XZ/oQ5MKMwHCnfg7octMi5pa20hbzoK/vHuy0OqlHzWk3xrVMTDg077OO+cBc0oKwm/NJNhLRGX
	5+dMkAazgIwx6h
X-Google-Smtp-Source: AGHT+IG/Xpf1V10q4as3omd8fCWUSSIhwxXG2nccEzJUjb74z58QvX4UZ04y2ZngrrltvPo2fNxGNA==
X-Received: by 2002:a17:903:3d0d:b0:298:33c9:eda2 with SMTP id d9443c01a7336-29df5e1b1bemr7213565ad.33.1764983889620;
        Fri, 05 Dec 2025 17:18:09 -0800 (PST)
Received: from HP-Note-Host.. ([222.234.91.137])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29dae99f006sm60542625ad.50.2025.12.05.17.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Dec 2025 17:18:08 -0800 (PST)
From: JaeJoon Jung <rgbi3307@gmail.com>
To: sj@kernel.org
Cc: JaeJoon Jung <rgbi3307@gmail.com>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	lienze@kylinos.cn
Subject: [PATCH v3] mm/damon/stat: deduplicate intervals_goal setup in damon_stat_build_ctx()
Date: Sat,  6 Dec 2025 10:17:13 +0900
Message-ID: <20251206011716.7185-1-rgbi3307@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The damon_stat_build_ctx() function sets the values of intervals_goal
structure members.  These values are applied to damon_ctx in
damon_set_attrs().  However, It is resetting the values that were already
applied previously to the same values.  I suggest removing this code as it
constitutes duplicate execution.

Signed-off-by: JaeJoon Jung <rgbi3307@gmail.com>
Reviewed-by: Enze Li <lienze@kylinos.cn>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/stat.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index bf8626859902..51dd29685915 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -173,14 +173,6 @@ static struct damon_ctx *damon_stat_build_ctx(void)
 	if (damon_set_attrs(ctx, &attrs))
 		goto free_out;
 
-	/*
-	 * auto-tune sampling and aggregation interval aiming 4% DAMON-observed
-	 * accesses ratio, keeping sampling interval in [5ms, 10s] range.
-	 */
-	ctx->attrs.intervals_goal = (struct damon_intervals_goal) {
-		.access_bp = 400, .aggrs = 3,
-		.min_sample_us = 5000, .max_sample_us = 10000000,
-	};
 	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
 		goto free_out;
 
-- 
2.43.0

