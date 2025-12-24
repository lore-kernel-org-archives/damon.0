Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F5A8329380
	for <damon@lists.linux.dev>; Wed, 24 Dec 2025 04:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550138; cv=none; b=Grcx8e3LUbvhSe6W7B2bVAs3O6BuvaVJTV5aa1lTQLD24vAo7l3UiGABTYUxgLcx5TQV+usrWAb0SL6cvRUv9KzHYFBhT+4EmoVHZt7R0wyGPlI9DzkzcEUWdGfMt7x4VTB7FWteQ4aWwKGDVO3L3pnLSEgiXHnhqIu7F+GvaKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550138; c=relaxed/simple;
	bh=RqyPTpe3BkCBdnAPrJUR2Jb2YzobLNs9vjE5paiWqaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdfkRtib1ni+oHJqFbjJ4PY3tys/op8tVGJv4Lt1wRH55fQxJzX4icYN7tDw/lBMh8dPGjadeUSKjy8M0yg2shDgC0CmAgWACL8R+Lbb922kVrwg3uBNuXY7FkzsbtM/ug2958YfczXhBxmzUsT9+vitV2jxVzWCIfP3sDHqJio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AYYqNfIR; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AYYqNfIR"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c0ec27cad8cso3418086a12.1
        for <damon@lists.linux.dev>; Tue, 23 Dec 2025 20:22:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766550137; x=1767154937; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VQkMD3ltAZru2XHuW3W3PQE75mGT0odUsu8IJA/78IY=;
        b=AYYqNfIRrU7jxXzGMuApPeeSJnrv7GsDdskF96uf6qlkcTmXwyWknHmwZ4JJ2uSZSB
         A0uGS9G35z0HvKI7EAtiPQX/DLRluRhc1XuXpB/BbLrG1UJK6gDrRuSTQR2CkQXOAoWe
         6Z2Y8CQ1elrIPYcyHHPbkM4jQmXsPUXzKQ61rkeH0xjcPnBII2JIAKi8xaU+mevOBc9e
         wwIgriQNYdjriXOZGFB3Z2PaqgcB0mjEU6aHqIuiTenfWlQx3hJoc/qFgg8vkUXPS1IO
         n7uObzKc0LUo7JQIhU5Tc4D4hMoKNIWpTwTW2GlsI7MiV4O7muuDtslnTAHcJdep7JHW
         G4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550137; x=1767154937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VQkMD3ltAZru2XHuW3W3PQE75mGT0odUsu8IJA/78IY=;
        b=DkzYOU4jrQl8WMAEQD3GXBNKW2dqwBDTHzhHwENra7stFcNFhm2IlCNsWREcUTNX+f
         I/ixfr8/ly5pU6Lkx6aZatVGygW8uIIthqYnvjLPafejcjqb4XauL7K5LTNKZQWEEvSD
         Ran571KFCRuPWhXP2uMD/8r29BISzEMF7ei3dGUvAY+snr0o9b9lML3ZmhAeu6cL1ZMZ
         arVObxM5xlpc0QBUWBWOo1GHJfYTwuvdvHJcSI4TCO6gfsHwxZQYqvzsmqBWt+NrFTPR
         V4VkaMGHTm1sfS5X2MrIRGHEShlIjsbuOWW+xgCvrmLKfYgr20xRl3YOrMhI6Upc/it/
         zj3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWlz3VMSWfetXrnTznvP723XlyLf3l44uJMQpu++FcF8ZlHQE9FSfq/nPcYXrQ5arKpGQ3Jbg==@lists.linux.dev
X-Gm-Message-State: AOJu0Yxt+vVQtJ04pApms5pJmd38tFEEJ7ybGZ27wUCXB4+G4LlFfAoZ
	nRogXIvUFlUgJp5zJunBmucA6I+ojinbNeI/pAmkb1zy/+VhQk5Bvy96
X-Gm-Gg: AY/fxX6gK05APJnnNat4HP+IJg4vIjvqfdONca0o143bip6jqimxKak+5csAqYv1TBo
	/R17zxt1vhL812oNCEVhCnE6z0Bp9vUFQYExansIwbvhWJZmDY8+/zIFgb0d8ZvmhvTLB8A8f5C
	WJeVE2Zxr6UiRm9Yv9gGnSFObzvDX0SFxY9XrgD1lHFhjM/fbzlvGcXVU1jpyXpBZ/ani3shxLK
	0uKdlfJ8dQ9CU+pnVln3+zMwJC5rZqzlVL3SlBHfLb1pGShXvw8iamOsKcMf4LQ3o/+Mm+KJD8f
	3HY5BY6wWwnNV82VC/KdKdvo2GWb8z7zSwGUd2Q2eG9vpEhGtMZav6hzKGTvYkGG6lYEO3sRNB2
	9a3cIoGWaciKbKN4uLeY2AbFT/nC8W33JqqYfuusWLEWutFrZ81fQQBOvKXc1xvf1Epw44buV/I
	1Y
X-Google-Smtp-Source: AGHT+IEIattYmas64tB4sMSx+gkWrf4v4xDu3o/R+q0wk09aYhAA7BXdfFClMLqznY0MS+X0mGR6Tg==
X-Received: by 2002:a05:7022:e98b:b0:11c:b3ae:c9e9 with SMTP id a92af1059eb24-12172311f8fmr16335393c88.43.1766550136511;
        Tue, 23 Dec 2025 20:22:16 -0800 (PST)
Received: from dev.. ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm48542031c88.8.2025.12.23.20.22.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:22:16 -0800 (PST)
From: Shu Anzai <shu17az@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shu Anzai <shu17az@gmail.com>
Subject: [PATCH v2 1/5] mm/damon/tests/core-kunit: verify the 'age' field in damon_test_split_at()
Date: Wed, 24 Dec 2025 04:21:56 +0000
Message-ID: <20251224042200.2061847-2-shu17az@gmail.com>
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

Extend damon_test_split_at() to verify the 'age' field.

Signed-off-by: Shu Anzai <shu17az@gmail.com>
---
 mm/damon/tests/core-kunit.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index f59ae7ee19a0..88ec046f4942 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -158,6 +158,7 @@ static void damon_test_split_at(struct kunit *test)
 	r->nr_accesses_bp = 420000;
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;
+	r->age = 10;
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
@@ -170,6 +171,7 @@ static void damon_test_split_at(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->nr_accesses_bp, r_new->nr_accesses_bp);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
 	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
+	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
 	damon_free_target(t);
 }
-- 
2.43.0

