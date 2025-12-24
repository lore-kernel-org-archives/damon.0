Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0448329398
	for <damon@lists.linux.dev>; Wed, 24 Dec 2025 04:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550145; cv=none; b=be4/Fu/lgk4jIG6EGK4fbXyW9YRXfZhVshJ0XaJ4npUxyYf+hVLfc+r5T+aLcfSE73freJEXZNoRVtlkFy+UmwyHfjf/l71nXXwmipXgXP63B9vD33EtbVHf1IT/xywFjanJw44Y7kJVsfc6/23k8aUxPbHmXVsBB+RuxyFoESI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550145; c=relaxed/simple;
	bh=asj8X4ydgQjVB9nERq6SZQQxwSNt/tgRpvozol7cTKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6laewCv8bfzJwR/HR1LnQXaDXq0UrF7VGOJHuLDv6I3xQbiACc/s0vnD3Q6ktiCnqBKKnjwgIt61iHoz6V9/E6NtJjdJHx0GKSW7bVwlhtd32Uy4Im6rlyS/BTSGQqXBIooy9MUkfXlW1JHLtBHxPe+VyfWDtJ/M6w74uTZibs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBFUd/jj; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBFUd/jj"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-29efd139227so75077755ad.1
        for <damon@lists.linux.dev>; Tue, 23 Dec 2025 20:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766550143; x=1767154943; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojTNko6SbqP+E6WbK+gbYq75ItQHYqDMxABt5GrcXzI=;
        b=NBFUd/jj3s02R9wrWlQwMqvwt+H/EpGZFHOFNOcWq7u3DryK5p9hAdgr55BQ/fsnpS
         U7QbiOgBQWy62kcXj60UjF/woENS1UWlACedNSyL5n690si/sVBtUU8ElY0Znfv/U6c9
         SDNhgHd385kTvKMZofgLst/roy/jyJ9ntNe4uKyEKNpdCp9KzFgslCHIeV+sMkHVBeI1
         vRxSOvAUT3zQsMr6Pp/fwaZiSLUm1KZCIY10SQyVymaEDcs5cUNqbWwk6LD2h+2c3rlK
         zzZsi4ZCDcmJjA7pkRBto+HuPDcolV1Qn/eG7WGNiUOmBoDZ71M3QNWJdKUBHgOHVlLH
         eZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550143; x=1767154943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ojTNko6SbqP+E6WbK+gbYq75ItQHYqDMxABt5GrcXzI=;
        b=FagYNNimlshqQH4j6cgO0blxm3BudGZJAvoAHbVmj8yzorgxBDtXnJ3zhIjSvrsz7v
         U8Jer1Eajmq78xUZmmy2MzTY7hs+ENXwkO598MB1PUyyr85Y89MZ3M4bgkpU7d3zbtBs
         K2tAyOE+SoaTzo/EVv7GIdytq+hHki/byMzFpNL/ceYLbrNaI9M1PDrugo/ejkJYCgtf
         9fDGEwQ29vdRNN8e/VRvjynPjOwBcw1yNqDzfs7WuCShpWBhGo/xt4eDTWID90BEOLGI
         79zcOLhgyGL++a6mod9kvFaMiRr1xtQQKuES7hxYWsIym/7vU4bW6GRvETxb3YMFjRL8
         k0sA==
X-Forwarded-Encrypted: i=1; AJvYcCX/np+6eLLuhRUB2Wx6aYNh+GtqxnSg3JC/1qbex6UdKPPmgL/7bnmgPhXJuKwncGSoWLepWA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyJ0pCSW9o/2pLw9Au7FbuG7UXdOF3e4xHpYeLF0GDs7LPPs7+S
	92Nt4yL2zUrtDb9V9u+Msa3N3eGr10JqS2b25+7DorNr5TcBIODKpw+O
X-Gm-Gg: AY/fxX7c0ok9FG5zAiVa6yZizcgiDxN/JqoTR/m1B21YumieJJhD3YxpifGI7d61SyJ
	dG1tcj/RpSBUspqtXZxIoLL6daTPhYBG+H9Z7ehdFri7Nz2yUySwmVv8UZewm744t1vuyLpGa/b
	7/8Z6bmDU7fkfvhqXoIQhU6vwjGbrS+kgFa4hP9RUmtvviguawKC1hYlaurlBAO/ckebwD/Rmg9
	X0o0cX/uNiw7QCOBVWmzzEsgzV/vyB9wzzM786S3NOANxIJo2BNDSK42ZpS8ef0lsPCdBB0Kqs2
	KiLPCjpjIw3WZE37K8jjeN1W3/Bs5RZC60+ALQTMGaGFTH1CE4bTWlsq29M14bdbeyolslou9WI
	c9lHjgE/RznGNSbiFMT4PRZKOBDmmQ1ZLRAk3K4wl8CgIw9r+XkFv0XiTnJ+4yoWlHoicbav3au
	uQ
X-Google-Smtp-Source: AGHT+IGmB2OF59M41ORjl8EXcHftJB+6OeJbuGVRaKx7zyjvrQZlxUR8IYdNNeYdGju3hyl4EBODKA==
X-Received: by 2002:a05:7022:220b:b0:11d:e40f:ee69 with SMTP id a92af1059eb24-121722e9112mr19346355c88.36.1766550142874;
        Tue, 23 Dec 2025 20:22:22 -0800 (PST)
Received: from dev.. ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm48542031c88.8.2025.12.23.20.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:22:22 -0800 (PST)
From: Shu Anzai <shu17az@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shu Anzai <shu17az@gmail.com>
Subject: [PATCH v2 3/5] mm/damon/tests/core-kunit: add a test case for region merge size limit in damon_test_merge_regions_of()
Date: Wed, 24 Dec 2025 04:21:58 +0000
Message-ID: <20251224042200.2061847-4-shu17az@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251224042200.2061847-1-shu17az@gmail.com>
References: <20251224042200.2061847-1-shu17az@gmail.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a test case in damon_test_merge_regions_of() to verify that 
two adjacent regions are not merged if the resulting region would 
exceed the specified size limit.

Signed-off-by: Shu Anzai <shu17az@gmail.com>
---
 mm/damon/tests/core-kunit.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 6e301113e103..2eb6f41635a8 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -238,12 +238,12 @@ static void damon_test_merge_regions_of(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r;
-	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184};
-	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230};
-	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2};
+	unsigned long sa[] = {0, 100, 114, 122, 130, 156, 170, 184, 230};
+	unsigned long ea[] = {100, 112, 122, 130, 156, 170, 184, 230, 10170};
+	unsigned int nrs[] = {0, 0, 10, 10, 20, 30, 1, 2, 5};
 
-	unsigned long saddrs[] = {0, 114, 130, 156, 170};
-	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
+	unsigned long saddrs[] = {0, 114, 130, 156, 170, 230};
+	unsigned long eaddrs[] = {112, 130, 156, 170, 230, 10170};
 	int i;
 
 	t = damon_new_target();
@@ -261,9 +261,9 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	}
 
 	damon_merge_regions_of(t, 9, 9999);
-	/* 0-112, 114-130, 130-156, 156-170 */
-	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 5u);
-	for (i = 0; i < 5; i++) {
+	/* 0-112, 114-130, 130-156, 156-170, 170-230, 230-10170 */
+	KUNIT_EXPECT_EQ(test, damon_nr_regions(t), 6u);
+	for (i = 0; i < 6; i++) {
 		r = __nth_region_of(t, i);
 		KUNIT_EXPECT_EQ(test, r->ar.start, saddrs[i]);
 		KUNIT_EXPECT_EQ(test, r->ar.end, eaddrs[i]);
-- 
2.43.0

