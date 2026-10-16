Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA67338F95E
	for <damon@lists.linux.dev>; Fri, 16 Oct 2026 14:38:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792161515; cv=none; b=E1gQKogB2bnTxx7EEXiCqNRbbT5IJ/ULBXFMkzGZDmT2sohS/6TOtbFAFxE7QyEDIjES6kphrj5QqgxW4ASuYqrGRa9nG256Hfsk1kzrNFcGlllXTseI1dkLphRR62aLc7UpCAJfuPA/MC58MdnwCyv+TTFRpOUDVkOyWOZmA7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792161515; c=relaxed/simple;
	bh=A9/CTtLXPAMUxIYV6URIzmuV9rHKPxyUydDb49cbIJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=p7kND9mJBEnkVaaljuLyIfBtvdi9T8T491O4bE85tS8vSxkeWtYLfzk+KLMOCnXsgvTPrXPC+7d+JyIH3Qjg3iVuwWOFBghpvUdXh13qi4j5T7LC0CdcX7T7xc59yS5pmJizmQTwpdG4AZU7lzuDSl7UCZzjezmEN7mlV/WnaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kCmn0ckh; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kCmn0ckh"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-35c76e9614aso5002908eec.0
        for <damon@lists.linux.dev>; Fri, 16 Oct 2026 07:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792161513; x=1792766313; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VzZTNMyuwZMv2FtdIQag5FG4n3GogIS30Eq+umwptRE=;
        b=kCmn0ckh5AcTDgBb/5YMHmEMt01wPacsJVkzpitzh9R5O302BfHgprNsaAagW+kprD
         /iEE16/heVj92zYVpI48xQGFsZfKDszBFuXEMk6wfDxSjjWF0ZONT4vZQfxL5xGrUpsP
         0WsCqMgmX1iDoJ/kuWn4vORhhNEhqomRUyIw0Y266C/qAXxuIabUj2bqTaZWYlPhhL9I
         UKRSvZU5B+zulqVimiWGRXM+Rnqm2TZVoEQmsw5kuNGh0+rrThiImbdHZEj0Wk+NU9am
         VUIrToSPiZxVyJaONtk+qj49WhDfN8giS0WAKP6xg/dEb0JirOfwzKXpExssGL2UVtNl
         +6Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792161513; x=1792766313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VzZTNMyuwZMv2FtdIQag5FG4n3GogIS30Eq+umwptRE=;
        b=oTHT1yyQtM6bMdNtL+7RbWUDdWWlVJPI+AFiWLy2pCiNnFzwmDJv3sDF7HaUVYGoju
         vtN0LD7YnvAxbuahTxV17B/4jX3LyhQzFjfrRM6u4nwHN6+SFirIItIozW8lRcw3q4Ge
         Bo7rm+t65Bse/S/7PuY+V9jkQDy4ytlQIcRpXJIUz+ExlaNw1FrrNDwH1k06xkLlSmVI
         eC+w6obuXElzLDWulezw4i4A1kajllA4v4PygspEfoHwWJVl1XEAfamZSr3OZK7eJco/
         kbukaTcDcP7EOrw5zbocSsOSqu8vcOIjslUUOpjnCaHqEQZKyYvkCpQRD2MpYH0XSfx3
         hvfg==
X-Forwarded-Encrypted: i=1; AKwUvBznqMq4zBQEV5fiaUeWIGRoHZmo3zZPNnc1EVRc0Dm0NcXlhWqRorNZh/r8qNdhNvOGqEGEyA==@lists.linux.dev
X-Gm-Message-State: AFq9FYIqL+++fiKwPxMeIamN9j/X0iRfVf86uLpMrTXkq0w0Ccf46ZgS
	yC44rw/oYCqKPax3Y+g3ju48h2iqvZNmYgEg8cGqAxeR58feMJQf/8zj
X-Gm-Gg: AYBFou2lIizSo8Bw+ugBSxGjc221HLFw4ucJeZwMOZqdDbx/OIrxLTJrEjyU+ofuMRx
	00yksk6vgyzMQdK6e6zGFcgmmt0j0QfELOKRwCtHknE9d4R5ihbzpONu4BW4sFnej/2Yqb/z3y7
	ycxvZVfwNod4/7T+qb8Son/HAtpQ5ryATjZ/IEcDkEPxj9TqsYTNGnH5DE9qY7WSFdwnQd813bj
	h721QnpD8e0aaxD6LEkki5kIx2AJAxKXrv3ZcPgvfksmk3Tbc79CSIQYDgCkrM3HuczL1BSJnVb
	+YwIFAByw3zeZj80JYizJMyIB6fBZ5JcOAL9Zd+vZNCW0sOOHpZhz5I6YB0NlxQMME2QJ8nkEW+
	xqqLAz5kWX8YAPdcHmzec/kBqkpVXx9pePNhwtbAUNqzACN7eD3oaQXfgPTW8TyBulh5T6vpdxB
	hIYYiUzk5tr398jAeV955eqjZNnEGnNQtiQiabwQCHAY41UbzTMiRVXQC9GQy1QKZwJysvtJNtE
	ySQdXltNeFI9VrbSPbzNL0N9iIhS/KMUFkXmuWgqScHOYFmIRrOfTaEcH23CJJUpeKBZQ+iEF+h
	oViyCnNrMm1Uuem+mA==
X-Received: by 2002:a05:7300:7aa4:b0:35e:43fa:eea3 with SMTP id 5a478bee46e88-361a137072dmr28441eec.8.1792161497077;
        Fri, 16 Oct 2026 07:38:17 -0700 (PDT)
Received: from AHUANG12-3ZHH9X.lenovo.com (61-221-208-111.hinet-ip.hinet.net. [61.221.208.111])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36081ea7e5csm7069382eec.15.2026.10.16.07.38.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 07:38:16 -0700 (PDT)
From: "Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	ahuang12@lenovo.com,
	"Adrian Huang (Lenovo)" <adrianhuang0701@gmail.com>
Subject: [PATCH 1/1] mm/damon/core: Remove unnecessary zero-initialization in damon_new_ctx()
Date: Fri, 16 Oct 2026 22:37:33 +0800
Message-Id: <20261016143733.320-1-adrianhuang0701@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_new_ctx() allocates the context structure using kzalloc(),
which already initializes all fields to zero.

The explicit initialization of passed_sample_intervals,
next_aggregation_sis, and next_ops_update_sis is therefore redundant.
In addition, they are later initialized by kdamond_init_ctx() before use.

Remove the unnecessary assignments to simplify the code.

Signed-off-by: Adrian Huang (Lenovo) <adrianhuang0701@gmail.com>
---
 mm/damon/core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index b63e60ef8990..74e6022ca137 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -918,11 +918,6 @@ struct damon_ctx *damon_new_ctx(void)
 	ctx->attrs.aggr_interval = 100 * 1000;
 	ctx->attrs.ops_update_interval = 60 * 1000 * 1000;
 
-	ctx->passed_sample_intervals = 0;
-	/* These will be set from kdamond_init_ctx() */
-	ctx->next_aggregation_sis = 0;
-	ctx->next_ops_update_sis = 0;
-
 	mutex_init(&ctx->kdamond_lock);
 	INIT_LIST_HEAD(&ctx->call_controls);
 	mutex_init(&ctx->call_controls_lock);
-- 
2.53.0

