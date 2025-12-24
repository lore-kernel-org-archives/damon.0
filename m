Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8702329C57
	for <damon@lists.linux.dev>; Wed, 24 Dec 2025 04:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766550147; cv=none; b=O3YREa59lShNPO8Udk3HFi/C5hoSqZluGvlqUb8K1tNx/xR6Nw0mazYwt/M9zGoisFgJ4actkUaYjiY+xZMACqxHAvv/wl+CYzO9QGYOAS5bK0pULVWYTKzO2UkAC/ajJEGmTdQRbZ7pHABvDSI2aC5d9sxcs4wnnTzuA6ZqQic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766550147; c=relaxed/simple;
	bh=OLcX8Zd+fdUl6dxE06+L08d3gACwTJsWI4bS9MuvLJA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9OIMhDoozWKosGuAHD7WJC5c95j2khe4p7abxHe0iXj+5O9dc14m0p7faCYmMvQ9zgeUL7m7WF2N6lAa9WgttY44g0EyQMUQCZ/v8KHexXnFVQP/CPOO+6JFEX0tTvascfhegWEojVALQKIJHghSmDVTv93KXvjKQ93/63MhYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PCSxxoeW; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCSxxoeW"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c1e4a9033abso4670411a12.3
        for <damon@lists.linux.dev>; Tue, 23 Dec 2025 20:22:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766550145; x=1767154945; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qAW++Y4fgSGuWCowvvKY4zihTht5dFRLAo1G1kvZ8PA=;
        b=PCSxxoeWGc2iEXMRO4o+JXX63cSH9WUs2BLbIVkW0eQgfkBgDrIeVtywf2ppP4EVjV
         jOmT0uKZCtLwd2SUnohId7WWDiQ1p4i8yN26BO5PGkREnoxTiLPjIgqlNQ4BgdJAJUKZ
         4z644SbyVoPS7P7QHhk3gK4X5CqyVBcynU+X/4GNp0TJCMmqb6pYE9Ol5N31xeqHYFlS
         R0OmaLMvEYKKpNZsa6V8QAJjOXjM3J4mXpWzRP4XeBxX+PQ5wuWehPMLwch5hMXKeHmR
         P4NCLEan+2je0fePqW3iQOBMOd1UNCnHvy1QYo67rE/MbW5o9U2ieu7+FMbD8yRHDhHc
         RRqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766550145; x=1767154945;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qAW++Y4fgSGuWCowvvKY4zihTht5dFRLAo1G1kvZ8PA=;
        b=c5aatXLjlDmYb+Govo75zUE0fGMo2kKKISPHhkUFwrRD4e28SoOBYpArcTRucnmdxe
         Dfe7MYPgW7xnXpSh/3i8YlforSQbszD/tVkArEjo0WCSOevL9MZafHc8ZGi4AuDELcrj
         2rBMVTCkTyuVxTjQE18Oi5mD0NvnOcXGYDjTnh5a8GZshXNWQxPVBBYuVvmLRmGCMHIW
         8OyRLW11N8Q5g7IcgJ97axVvi5ECSszk2GspwrOwILWvShKGhAQaH0Z39vfb5yG1cpbx
         2D0wb5bSitIVXVtaWhEuadp4KYOXdjXcmFS27wfyC+VZZE8eRezJH5L/0ActCo7AzAdm
         Ak6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXME/q9COeCdDXwrZyvsFubj++g6sXI68HU65vOsRGu8L7oRHJXlk3rw8xorAcQuqRz2TzQLA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyfdfH/VkmK08hanj5YF2xAACQw+dp58R7CBDbwaDGuQuF/Qabf
	dCI5MjYYQZrL3XnFo76M48iRUSu03w/qrzwYsJzHfhyUpLH3ixG6YPtI
X-Gm-Gg: AY/fxX5n2H1OIT+JF8XnF8FoKXLjoAl4ZRKMqGj4DcV2iJOzXaIoVn01hake1zKrj3e
	Gyu7OYZaRDhBONskjNeFABhLIWH3LnKsdLUaUzGtmm78h/LyCiU1z1SqhejkB54yHHhXErO3rk+
	QGsAV/MVwTTdMYJ+gRPmsbth1bCV191jSaHDn8de53lb/DC+NPZVWjftnY6Yqv+olc9joYkEVnF
	A9b3AlkI8QECEk2IODnEHrMqJ7O/+NlDHwP9OoA67CaGGKpD5AuIoapjmhCF64jHVeBTI8OKid0
	S3pHLNg0WRD4lMb1coJNpUXtB28i0rcAl7MXV2XSFbhg3y0hoDz+o1ccPQwuBfHMNCJQwLrrfWW
	fyVFfTitXzFJr+3IMWBzSE49/kxKhLfy6VP+miwWlrFaqYBcDqFuMvvM6X15pzmhEgeIrRUeZJu
	Is
X-Google-Smtp-Source: AGHT+IEu3ypAtOJAXn9xiXQKRtee61CBDqJzBQT9KTWObNvd9b3sJXcWL8HyG3+q6D0Cz6eLFD6TVg==
X-Received: by 2002:a05:7022:2590:b0:11d:fcb2:3311 with SMTP id a92af1059eb24-121722e32demr13284390c88.27.1766550144772;
        Tue, 23 Dec 2025 20:22:24 -0800 (PST)
Received: from dev.. ([208.184.112.130])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-121724de268sm48542031c88.8.2025.12.23.20.22.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Dec 2025 20:22:24 -0800 (PST)
From: Shu Anzai <shu17az@gmail.com>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shu Anzai <shu17az@gmail.com>
Subject: [PATCH v2 4/5] mm/damon/tests/core-kunit: add test cases for multiple regions in damon_test_split_regions_of()
Date: Wed, 24 Dec 2025 04:21:59 +0000
Message-ID: <20251224042200.2061847-5-shu17az@gmail.com>
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

Extend damon_test_split_regions_of() to verify that it correctly handles 
multiple regions with various 'min_sz_region'.

Signed-off-by: Shu Anzai <shu17az@gmail.com>
---
 mm/damon/tests/core-kunit.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 2eb6f41635a8..36622a2c11f1 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -275,6 +275,9 @@ static void damon_test_split_regions_of(struct kunit *test)
 {
 	struct damon_target *t;
 	struct damon_region *r;
+	unsigned long sa[] = {0, 300, 500};
+	unsigned long ea[] = {220, 400, 700};
+	int i;
 
 	t = damon_new_target();
 	if (!t)
@@ -301,6 +304,24 @@ static void damon_test_split_regions_of(struct kunit *test)
 	damon_split_regions_of(t, 4, 1);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 4u);
 	damon_free_target(t);
+
+	t = damon_new_target();
+	if (!t)
+		kunit_skip(test, "third target alloc fail");
+	for (i = 0; i < ARRAY_SIZE(sa); i++) {
+		r = damon_new_region(sa[i], ea[i]);
+		if (!r) {
+			damon_free_target(t);
+			kunit_skip(test, "region alloc fail");
+		}
+		damon_add_region(r, t);
+	}
+	damon_split_regions_of(t, 4, 5);
+	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 12u);
+	damon_for_each_region(r, t) {
+		KUNIT_EXPECT_GE(test, damon_sz_region(r) % 5ul, 0ul);
+	}
+	damon_free_target(t);
 }
 
 static void damon_test_ops_registration(struct kunit *test)
-- 
2.43.0

