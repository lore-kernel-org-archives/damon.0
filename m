Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D5DA1FAA
	for <damon@lists.linux.dev>; Fri, 12 Jul 2024 01:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720746472; cv=none; b=TDQtLT++aZspV3k+A8awzhaYFI5FGXp7ho+uergQFjc8T67Y/WALk7nqp7bq947BNhJZ83AdZ1a9FnwK5PAoiohLrLgycPcENxGVUAqyX5Y9XoCl/DcALS3mHfYbJ7WBxrRWna8fWKdgrHWbXsWQpczNX32ZMH3YMWKQCh7pVws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720746472; c=relaxed/simple;
	bh=ES/nPpj1hMcnKgxyw+51thCfR0JY4Flqzwir/Rtzano=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B6VN5PS9sUUOIUeJ2JdC7lgM9mi29cLo+fkP1d89dxmD+9jrOsPdQrShGsMs9QGyycJapwqQW399QJU5ySoKmsZMpVI154xkJNbMvTPz7qKJmljVFST+XT3G/zBn6KG6TijOt7j9LKiWC2WZzYWgfWta4eAKehn1qo/nFVROKg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2zz6P8u; arc=none smtp.client-ip=209.85.161.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2zz6P8u"
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-5c669a0b5d1so777566eaf.3
        for <damon@lists.linux.dev>; Thu, 11 Jul 2024 18:07:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720746470; x=1721351270; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IBU1BKV11C3EomsspKDyy4E4pkSa0W4+52SYXLAlbzY=;
        b=i2zz6P8uixwfbxMNotExapV2gSKmsYOlCHVvfvzwYHl2wQY4T5O8Y68DPujw3kKUj2
         dHS0W2fqDvxAS4IV6uYxIWpx0Guuc64iV3Qum289dkmznPF/ZgCuwyOjw7X2lit4uPWJ
         yZQY42Vl/LeB078Dciep2dCWOu++smBF8x8lk4mPfIUP83wlSSmnB0U8dgK+dS7lp4KC
         z2GkORu0ZPsdAXESBNMlpMjm0g8vdU2z68dTPH8s8/bsyJZhcmJLXnWQ1cURA+eXaKer
         gP+KNpRbL/lIDiuCI+KL9OS4CyzgO4g66VhrHP//520LL3xfM6Kdzkq79SO2p+g+Xhl7
         cPtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720746470; x=1721351270;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBU1BKV11C3EomsspKDyy4E4pkSa0W4+52SYXLAlbzY=;
        b=LkngrsOoU0NDE12FGPPX0H713RfqhxFV7NoWyXCtSOOFQXWDU4FXwi/aJnc1ZqCBvY
         H/7ojtvThViJEwLjV5LsXZdK3DOrcpC9RIrHJjAa5CE+gRPdwdjz8hU3SDQLZWRGfIH0
         SSXrglwGvrlE1xJ4U2tTr1FSBF7AYZW5hZFvYKQdvlnQvccgki8PPZLaC68Jg2hADcFB
         msYQZ1Gt8gyQM98GR6FOzFBa1SQuwGtuunMp9qAgo0QpKTby/dMG4hF/55yzuoAHU4C9
         ESolnGunq5mhLJNyLCzwEDsATv5kTrjqef8dZU+jihOllpgg0Ks0GdZS5YDNqDs9KdkX
         oJAA==
X-Gm-Message-State: AOJu0YzBHZywLHv51AW/ne0fZXnoKVUULNAueCm3zXqsqXRazMxURmOa
	GVPVNAYRPUZqNkFLS7fWK8P81Ae/8YvQq8OHqqeShnj3VKnSsBk3
X-Google-Smtp-Source: AGHT+IGV2zBbFCN0BIgEgkvAsVF7aUUx2sgf4naYWnK0W0bRvwNY5rNN7Q2diQtqWVVZ+T7zH+K/lg==
X-Received: by 2002:a05:6870:d88f:b0:25e:1033:9d5c with SMTP id 586e51a60fabf-25eae7cda8amr8746719fac.13.1720746470161;
        Thu, 11 Jul 2024 18:07:50 -0700 (PDT)
Received: from FLYINGPENG-MB1.tencent.com ([103.7.29.30])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b43898c5dsm6309726b3a.35.2024.07.11.18.07.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 11 Jul 2024 18:07:49 -0700 (PDT)
From: flyingpenghao@gmail.com
X-Google-Original-From: flyingpeng@tencent.com
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>
Subject: [PATCH v2]  damon: adjust large arrays to dynamic allocation
Date: Fri, 12 Jul 2024 09:07:42 +0800
Message-Id: <20240712010742.26180-1-flyingpeng@tencent.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peng Hao <flyingpeng@tencent.com>

When KASAN is enabled and built with clang:
    mm/damon/lru_sort.c:199:12: error: stack frame size (2328) exceeds limit (2048) in 'damon_lru_sort_apply_parameters' [-Werror,-Wframe-larger-than]
    static int damon_lru_sort_apply_parameters(void)
               ^
    1 error generated.

This is because damon_lru_sort_quota contains a large array, and
assigning this variable to a local variable causes a large amount of
stack space to be occupied.

Signed-off-by: Peng Hao <flyingpeng@tencent.com>
---
 include/linux/damon.h | 2 +-
 mm/damon/core.c       | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index f7da65e1ac04..8ba0457ab538 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -229,7 +229,7 @@ struct damos_quota {
 	unsigned long charge_addr_from;
 
 	/* For prioritization */
-	unsigned long histogram[DAMOS_MAX_SCORE + 1];
+	unsigned long *histogram; //size:DAMOS_MAX_SCORE + 1;
 	unsigned int min_score;
 
 	/* For feedback loop */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6392f1cc97a3..0614b49fbc35 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -358,6 +358,10 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 {
 	struct damos *scheme;
 
+	unsigned long *histogram = kmalloc(DAMOS_MAX_SCORE + 1, GFP_KERNEL);
+	if (!histogram)
+		return NULL;
+
 	scheme = kmalloc(sizeof(*scheme), GFP_KERNEL);
 	if (!scheme)
 		return NULL;
@@ -375,6 +379,7 @@ struct damos *damon_new_scheme(struct damos_access_pattern *pattern,
 	INIT_LIST_HEAD(&scheme->list);
 
 	scheme->quota = *(damos_quota_init(quota));
+	cheme->quota.histogram = histogram;
 	/* quota.goals should be separately set by caller */
 	INIT_LIST_HEAD(&scheme->quota.goals);
 
@@ -408,6 +413,7 @@ static void damon_del_scheme(struct damos *s)
 
 static void damon_free_scheme(struct damos *s)
 {
+	kfree(s->quota.histogram);
 	kfree(s);
 }
 
@@ -1246,7 +1252,7 @@ static void damos_adjust_quota(struct damon_ctx *c, struct damos *s)
 		return;
 
 	/* Fill up the score histogram */
-	memset(quota->histogram, 0, sizeof(quota->histogram));
+	memset(quota->histogram, 0, sizeof(*quota->histogram) * (DAMOS_MAX_SCORE + 1));
 	damon_for_each_target(t, c) {
 		damon_for_each_region(r, t) {
 			if (!__damos_valid_target(r, s))
-- 
2.27.0

