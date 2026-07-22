Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4172481FDD
	for <damon@lists.linux.dev>; Wed, 22 Jul 2026 11:33:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784720040; cv=none; b=OEIvSLB42R4wdnK6cV7ezcw9DPLP3cGyGN1whgaFMHWvLeMFevGTVohPJVX+Un7MVYNk2umVc9K5kC8pUPhvnmw+/8UVP0qgen6IZe8udigznifV5C77OyWzAi5fd5QEJ/nPFNFCKSLxSCFTnOT8hpVQJwbT2mVW1B/RZH0ymm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784720040; c=relaxed/simple;
	bh=4dZ9VLxDpR3TIfuk0B4upDrYn2kZuOWz/udMkCi9ovU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QEIDknDV56d42PlojKSnXIbVXfUMU95+pMLc3fR1KHpyD7tbV8s27sLksDgyFIdbY7LxSCi+1rhoZNcbaagD0A4IIPOJHvO7Vt3W/NiWPX1Pg8xA5wad8X7zl9nCD79VVFyeGLZHN9vMVr81+8+NMAH9GLQeCRTUeihhYEpB/+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kcy1eaSq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kcy1eaSq"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cbb662575d3so1124493a12.0
        for <damon@lists.linux.dev>; Wed, 22 Jul 2026 04:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784720038; x=1785324838; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YtTalQDtKgX2+sfw/36efx5Lj5w8MeFStk5ysuXqYT8=;
        b=kcy1eaSqkYxNZovZEZlV9jmlBlzklEDznK/Z87Re96mXv2OCy8pt52Y1OrIby0DYrn
         5k5Ksfrp3/+nVkFuPzBsw75JwLiTp8fkDatgIV5ISSiXtxE53TYz51S8pUYW6mmOtpCN
         70zHxM6gOcD5vvprx6MHBC3bl18Lo+rfYX9m4mLg5UmTMWdsch1wUR3rvMrx8w+kNI7n
         v3sHKjtqZ6ljghkPQKiW1wxgMCta3LDdKFZ85Du5OTbZOQsfysqzmP1np9ec0asb3M/8
         nKZlf+2Ay/92+4y/5H5NrdteeGkF/DRtXXZZ2TX3QcO29jxrQTExBdck4heE/FLD2F6N
         ahnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784720038; x=1785324838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YtTalQDtKgX2+sfw/36efx5Lj5w8MeFStk5ysuXqYT8=;
        b=i6eXjbF7ONrHUhASmVT3Z9nEqmUbMO+MnTGBYTN8sqpXCyfXu2ENf9Rxi9fk0Ml7lV
         FRisPC3DKE16Edi5t1Av2KtBpc9iWRcQqoEPub9XRdMeV0Iz22lnXfJMxNGAec1RTRJB
         hIBJc1emmILe0+EiDca6V57jIlczOZR/4LACO90lzCKSkpcGDrm1dT6ivDDJdT69P/eZ
         QlVR+paYtAz0t56vj7JkJPZlW3NXot5zb/Mlw5hTt6j8jmsKU+KMfEk0VKC7N5ln7x5N
         EkDUfgl1fppGvyENOAszaOHhh3jUyPON3p7drT2w88BFQ9BCaU3NB3HuiE2Ccj/qo2n6
         Ur4w==
X-Forwarded-Encrypted: i=1; AHgh+RrDSXIpZRY1iMPQqJScna8T9TAqR3kvWa+f4jKZFVuR0lEdPp3I5MeMJMSu3SHeeztwIKysQQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx0YIE8MHIcAXwws7o9X6k+vxwJllgGqs7q4UIeNokinFmpWJH6
	oIHuh1H+EjUMe6FTCW2FcjOyqgJ3f2XJiyN2J4igc8NOcvhNviZaTMUX
X-Gm-Gg: AR+sD13shzifsIZ7GOgDpXq+otjNLLgMB2N681LhUzhHGf7VvY3rEOKazOw1JsIGhjn
	2LqPCMli1WHyWQt89TBhZhewfhDNEDSHQl0msMW/q8VIqJOqdJx+clxjhy9cIne37dH7/BsnsaG
	1QoKV+/ocXmuduzSk/AS8LIglxvknYJNxJoUcY7zNHL7pPYFeWg/R3iHZSk9vKlZU0U+J0YlhJR
	8s8HurfBa8KmhWrU0uA7XES51+anJkl84uJUYbK5bWEBlOACrWhhX6FX2ZyGrA6nCdxZs70GfdR
	FwaCgSKHfq2eagd5Jewl3qiKjdWuoPK1LtcOJ2ZrW4celV7GssdthBcETNRFOmaoJP3RkEj1q1N
	BzCEhnL5o8QCOxBZKz+5Acb9Nw/xf5Iu25Pda74crl6dVFnEG9XiXmtUJKAxdE8mrCetQXST0Ew
	rOt4ETWw6DaVHbq941hA==
X-Received: by 2002:a05:6a20:4388:b0:3b3:fc6:622d with SMTP id adf61e73a8af0-3c3ada195d5mr24819669637.38.1784720038040;
        Wed, 22 Jul 2026 04:33:58 -0700 (PDT)
Received: from apt.tailc82bd0.ts.net ([140.123.97.23])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbb8f1c376esm980979a12.29.2026.07.22.04.33.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 04:33:57 -0700 (PDT)
From: Cheng-Han Wu <hank20010209@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	Cheng-Han Wu <hank20010209@gmail.com>
Subject: [PATCH 2/2] mm/damon/core: remove unused damon_nr_running_ctxs()
Date: Wed, 22 Jul 2026 19:33:38 +0800
Message-ID: <20260722113338.302603-3-hank20010209@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260722113338.302603-1-hank20010209@gmail.com>
References: <20260722113338.302603-1-hank20010209@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_nr_running_ctxs() has had no in-tree users since commit
5ec4333b1967 ("mm/damon: remove DAMON debugfs interface") removed
all of its callers.

Remove the unused declaration and definition.

Signed-off-by: Cheng-Han Wu <hank20010209@gmail.com>
---
 include/linux/damon.h |  1 -
 mm/damon/core.c       | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8e5589ccf50f..50659c9083a9 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -1064,7 +1064,6 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs);
 void damon_set_schemes(struct damon_ctx *ctx,
 			struct damos **schemes, ssize_t nr_schemes);
 int damon_commit_ctx(struct damon_ctx *old_ctx, struct damon_ctx *new_ctx);
-int damon_nr_running_ctxs(void);
 bool damon_is_registered_ops(enum damon_ops_id id);
 int damon_register_ops(struct damon_operations *ops);
 int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index da97b2dc39d1..891f851bcbbf 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1847,20 +1847,6 @@ int damon_commit_ctx(struct damon_ctx *dst, struct damon_ctx *src)
 	return err;
 }
 
-/**
- * damon_nr_running_ctxs() - Return number of currently running contexts.
- */
-int damon_nr_running_ctxs(void)
-{
-	int nr_ctxs;
-
-	mutex_lock(&damon_lock);
-	nr_ctxs = nr_running_ctxs;
-	mutex_unlock(&damon_lock);
-
-	return nr_ctxs;
-}
-
 /* Returns the size upper limit for each monitoring region */
 static unsigned long damon_region_sz_limit(struct damon_ctx *ctx)
 {
-- 
2.52.0

