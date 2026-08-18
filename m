Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32DCE2F39B5
	for <damon@lists.linux.dev>; Tue, 18 Aug 2026 03:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787024777; cv=none; b=mZBlW+DhBVsLNE4SkUWnQtUCWQ+PMY8Q+AFlXNmjmqVCh5aHPpxAv3sFvO6mSwWGdJi5tDqGzHo1MDyY45//xkTrfWOB9/lxj6pwE1wMIdBbFHmsfKjKFqlnKxVuLDBddH0piRaEI03rdc2kBEuZyCtfknl/6yCxfUs0008BGzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787024777; c=relaxed/simple;
	bh=kYC4QQqxDYM8I4uPfjXO9ISGQ4PSqpAyELi/rWAaDJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKYB5tCaHYNng4O5L1tTjh+WDJqwUS5ARlYeGBzL6CjmHITEg7cEY2SUxybsiw0JIp61olXMOScrqmJmwxA8o/T9wrw/S+XMsFnS6qMl+XJZueRurPQnN8Jl9tWt9qR7Q6ab0As6Hd+kYs6FZb64i89DQMZe58wO/CDbNhdFDsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu; spf=pass smtp.mailfrom=g.ucla.edu; dkim=pass (2048-bit key) header.d=g-ucla-edu.20251104.gappssmtp.com header.i=@g-ucla-edu.20251104.gappssmtp.com header.b=j9l9dg5H; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ucla.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=g.ucla.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=g-ucla-edu.20251104.gappssmtp.com header.i=@g-ucla-edu.20251104.gappssmtp.com header.b="j9l9dg5H"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d01663d816so37160945ad.1
        for <damon@lists.linux.dev>; Mon, 17 Aug 2026 20:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=g-ucla-edu.20251104.gappssmtp.com; s=20251104; t=1787024775; x=1787629575; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lcV78j2ZP/Yix6CCbssJ5cpLVJY9XnuazqlvUAmQ51E=;
        b=j9l9dg5HCpYcFGMDPeCDufaWcVj8dIVty0JTG7Qm1QMYHnBMHbBNqRiLNQc/laW4W/
         vj2BAlPxT2y1HKgQAPqx8B991/hoGKlfNpgBtdAyoC+pclXv9zazEoWZHtAvdPgzpBBn
         Ld23k+HwJn88H0JM+aHMEP3gbsYyeZPJe4ZhStpMdsF9ACOI7FMOX1J6klEYK/rotS3y
         XflpCWSyzpq09JTi3tj9i8+f8qJXzYZcPiMDJSH9fOWab/tQJ2cCbRO8hP4dTTgwZKlB
         NJ+8Ho6vZ4mtBR/d2tGvlRnhqywZ7+aQd/s63/1s9nSYMrwcZcJo1iRccm4L3IjzynSQ
         7vsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787024775; x=1787629575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lcV78j2ZP/Yix6CCbssJ5cpLVJY9XnuazqlvUAmQ51E=;
        b=llXMzx6wnWPSbCjZ4nDthRZCWG3YPAzEdnkXRrIGvoRKE6wYBBAUIiJYGrWlhBKC6Z
         rLBMNdrTJDzaDWS0jPyasR+jmv7mbFb9/K8L1BkLMKi2O5VHZz4EtgET79GlywNYYhQt
         z/DbnUJ6TWsLAH89A/VZKxmeMe8SpbzxFzT5s+uOZVb5Jlj55KwbS0OIChNLg92QKNKe
         huzpMZtrl0QDty+zttq06j+7JHxv80ruygMLuo7wa2/QBYCFdAJv7S0JfOfxlW2+xCUU
         yr9RjVUnASoTy4HOvJxiK7stHtokj2OxZDku0aq/pxiwFkn4RbUdLz/dBAhXDs7xmm5W
         U/1Q==
X-Forwarded-Encrypted: i=1; AHgh+Rq40vcHLCD5m9E3q1dtUU5Wkg0TpYTNIvZ54jGnka6mHgTGr1W3O7akO2ibZIJH5pl9sOydDA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yzz+X8c2cUZkDuk5sHaHgVvLrrF4XZf9C8hMR6ZYscOppKtP7bh
	O+q0MwLHJ0HOPuwiNOFC0r3297fZW0GpyTyIKPwWbLJlI7KTeGISYS2t3J4ivvoqW5fo3aGZUE0
	byVpTBgW6trXd
X-Gm-Gg: AR+sD11utIhhdm3x2P24JBDiHOgEEAIK9D3i8a1Vu/OrJCJ3D3wls0ijRoVVdtjhCcB
	gjMpVPNo5rkGLu4xRYPMnuo11gV4yqQODmyYPgvSftFF4NWQSAx9bMMKcpFINk9scs5Emnb1V9p
	wlUZ3OYG4HsMDYt3psm6TmeNISSEauO59h2oyVSLYFfX/DK4H8GPgM+7xghcKOQ2pA5I/n58dz6
	kQ/1hoyXBSfHZF0RYorwSoSqVSdeh8PZ5gf+E0Ad7xZNsUERT0MG3gs4+FJ4LjfPWcM/0zweUbg
	XTM0d/nXH+tpVa0TMrDGmxr5u3w3s7aLSHgpV9Wp4ImL9Do52lxZ7ASxialBRQm+dkTawbAK7BI
	ObQziSuEsUO0WsG6fHvpqBWyfAqFwP90hMSZW9cla6CZUrHOy0Ki4jIOLG/xNUsw1LbnftWUFok
	aTrM3ftJbmiFAHaJjCsKjhZ1/eaqHLpTOkohh6nrcGNuAguuSl5xGwXqMd+fBtje3s+r73dsXIZ
	F23z/P+uRQr7qpS
X-Received: by 2002:a17:902:e950:b0:2d3:a6db:299 with SMTP id d9443c01a7336-2d3b0c312b7mr344343175ad.6.1787024775405;
        Mon, 17 Aug 2026 20:46:15 -0700 (PDT)
Received: from damon-kunit-dev.tailb106f5.ts.net ([73.93.135.51])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3267be8e35bsm11453293eec.14.2026.08.17.20.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 20:46:14 -0700 (PDT)
From: Jason Angelov <jasonangelov@ucla.edu>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Jason Angelov <jasonangelov@ucla.edu>
Subject: [PATCH 1/2] mm/damon/core-kunit: test probe_hits handling at region split and merge
Date: Tue, 18 Aug 2026 03:45:51 +0000
Message-ID: <20260818034552.11975-2-jasonangelov@ucla.edu>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260818034552.11975-1-jasonangelov@ucla.edu>
References: <20260818034552.11975-1-jasonangelov@ucla.edu>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_split_region_at() copies probe_hits[] and last_probe_hits[] to
the new split region.
damon_merge_two_regions() sets probe_hits[] to the size-weighted
average of the merged regions.

Extend damon_test_split_at() and damon_test_merge_two() tests to
cover those fields.

Signed-off-by: Jason Angelov <jasonangelov@ucla.edu>
---
 mm/damon/tests/core-kunit.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4a536d41cdb2..2db94d49c9ba 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -152,6 +152,8 @@ static void damon_test_split_at(struct kunit *test)
 	}
 	r->nr_accesses = 42;
 	r->last_nr_accesses = 15;
+	r->probe_hits[0] = 7;
+	r->last_probe_hits[0] = 3;
 	r->age = 10;
 	damon_add_region(r, t);
 	damon_split_region_at(t, r, 25);
@@ -168,6 +170,8 @@ static void damon_test_split_at(struct kunit *test)
 
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, r_new->nr_accesses);
 	KUNIT_EXPECT_EQ(test, r->last_nr_accesses, r_new->last_nr_accesses);
+	KUNIT_EXPECT_EQ(test, r->probe_hits[0], r_new->probe_hits[0]);
+	KUNIT_EXPECT_EQ(test, r->last_probe_hits[0], r_new->last_probe_hits[0]);
 	KUNIT_EXPECT_EQ(test, r->age, r_new->age);
 
 out:
@@ -189,6 +193,7 @@ static void damon_test_merge_two(struct kunit *test)
 		kunit_skip(test, "region alloc fail");
 	}
 	r->nr_accesses = 10;
+	r->probe_hits[0] = 6;
 	r->age = 9;
 	damon_add_region(r, t);
 	r2 = damon_new_region(100, 300);
@@ -197,6 +202,7 @@ static void damon_test_merge_two(struct kunit *test)
 		kunit_skip(test, "second region alloc fail");
 	}
 	r2->nr_accesses = 20;
+	r2->probe_hits[0] = 14;
 	r2->age = 21;
 	damon_add_region(r2, t);
 
@@ -204,6 +210,7 @@ static void damon_test_merge_two(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, r->ar.start, 0ul);
 	KUNIT_EXPECT_EQ(test, r->ar.end, 300ul);
 	KUNIT_EXPECT_EQ(test, r->nr_accesses, 16u);
+	KUNIT_EXPECT_EQ(test, r->probe_hits[0], 11);
 	KUNIT_EXPECT_EQ(test, r->age, 17u);
 
 	i = 0;
-- 
2.43.0

