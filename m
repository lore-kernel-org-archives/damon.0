Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B727E1D63E4
	for <damon@lists.linux.dev>; Sat, 15 Aug 2026 14:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786804289; cv=none; b=dI1z+PvzRXafsPI5n1xIzENQDikyjycH5CJApHiJMdw3TqvdOjB7PgSzxXEs4LYby5fMs/osIBMca9Nm/GWF0rX31ftislWT/Xq8m4jamw3IIe8pWgJycHh+hLez33pK5Xf7XZ9h5cbBqq/P4qp9GCi7L+hGB9yxUMO6YiAsgmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786804289; c=relaxed/simple;
	bh=9zz8Gp1TJv1jrYb6vEA6wfZ/VLzUdjP0KgIh77ttoO8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APbM/XGaMLvsoH0JUMqRUHUAn4KjhlxBMYXHdj5mBeaVSrHKl7elPkA5M4M6hPH6S/BgH2BW3ewvCGtTRctjHSyTlnjGNc/IDXsnKCUj9rpa0ISk6uFi6jwVUQznNCo+blGoGKjeVHZe6oKVwUX7BaCcPNNaYtBfL49Wygt7A4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nc3FsCQj; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nc3FsCQj"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495459712d2so5219225e9.1
        for <damon@lists.linux.dev>; Sat, 15 Aug 2026 07:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786804286; x=1787409086; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Vgs6AOcx4CaUB67rv6dy2Cg2Qla+WNDbQRNX2dCqX6U=;
        b=nc3FsCQjY52eoGmkS9CT1J5AOAyazER7uWui/dLYdCDS1g/eIOIFVFwiE7ss0Z88si
         jn9Oam/neN0fdn+gHp/c5IsxRdtg3teQW2j0TxlYQsINai9tg0LE08D1v9XoZy9xMuGX
         swfzAFPpTNbSNC9BhoxjPCPRamp/JnCnA+/dIEXY6c9WYLED91L0YkM9fV4JfRE8YL94
         DPBrwcgEj5MWviP0UyB0WH3rButlNVFXbqzRR7vG0gkNpMi6le3feGOKfDYLQsccx8Zy
         K2532FS4YU4sJ82KEyV5hucXUPzRgTXR5vm6wqQpv9bi9c/O+Iw21NHp+CSqHrBDd6Gk
         zePA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786804286; x=1787409086;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Vgs6AOcx4CaUB67rv6dy2Cg2Qla+WNDbQRNX2dCqX6U=;
        b=kxACBsGQ2TmWm3dNMKhMZqUaHAgM0dvKqbka+b5vr99S5A31vjia7YHgmJMT0GTGe0
         zi4AYl0bvqiT+7py0sSNhlsmL+6/yFaKnFugnGLJUe08xsDtBD3DyaM6FVcxwlmhWdNa
         9GX646UxfKjAfDmDHZt1KTHsavrOzV/8PZfOgGlSMCG4JuVJXUOlOVOISbDqsDJRymrW
         t45gvZNkVAG7SAsteqUtxt33/YFjp2OFBxZxf9w9uGW22mSIW6zzSX7uR9I8iY5k1Qx3
         m2O4128Cbf/UUZwKpzwK4NUbTC/dXaFUzGs21a4LDGN4fNQ094ek8FBLpbh/MJLNgDrz
         4brQ==
X-Forwarded-Encrypted: i=1; AHgh+RoBLbW0OxV0hxT2pbFKitb4u1zFKq+ifRkKlp+5HDSMDlly72afeNc6wHladwCmVP8Ci9abuw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxDDBaUHQYTXDp+9+Ht+/ittiWcVX6s9etVQ5RhO9OlOgSOfxPB
	iiw8qU0lEqxMnbmmb+DJ4gtDoD2p9k/2eH83ewI4rOa1+ubiNQW39SqG
X-Gm-Gg: AR+sD13nSHWqicMHl2U8zxGp5y67e2TtwW15TTcrBgny3e9p9DviFvqrTGMW2aaFv20
	m/Huztjcrj5X+KhBLy9Q8dkb43WTDam4dS+2VuaFe5UN4UUfZ+/1QAWNaSDlYxwRZTg3SFWrya+
	oSN/b6BZfmno2dDuFEoLea7prDmPIWcMDdDtiR32UX9ndIsVRAQSEVbc+8oIPNWL/LnheG0Mznq
	QntXR5ARxFccyysVjY3MKBBJ+lPGQYT1Q1krZe6GkjcC2ENCOdujpju6I/9I7qoRqTonMsF4XN9
	uRsFLJp6IuMhUsaspMcH6u8Q2t12j8dtqNxfnGtVBS6E9C1EviZ/swU3Q5CesH6/VUxXt04lqeh
	l2UyFSAJeTEVqi2Pw5Ll/QgKNuxpQfiESw15+B7qiCRtf/41tmD2babBuLXqf1D18a6X6/E1kbe
	VumyB8mcQ9HUAZPDKp6HxoYmwKWKSaPWuQ28xyvHfh1v1BDxBYB2Pv1an+cQUl+SjdLJn0kljry
	MKUhKuNhTVlxz8JYX+rKUrdEN8RRxP4cRS8l76gK5iPCGqIc9taFv8uKcCHlucdwFL2pa2+IUek
	Fut0lYgxUuqI1gn4GLc=
X-Received: by 2002:a05:600c:4e04:b0:499:9069:c2c9 with SMTP id 5b1f17b1804b1-4999069cf2bmr75580105e9.11.1786804285834;
        Sat, 15 Aug 2026 07:31:25 -0700 (PDT)
Received: from lima-kernel.telekom.ip (84-115-221-9.cable.dynamic.surfer.at. [84.115.221.9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49988b24746sm251357515e9.12.2026.08.15.07.31.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 07:31:25 -0700 (PDT)
From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: shu17az@gmail.com,
	jiayuan.chen@shopee.com,
	jaeyeon.lee.dev@gmail.com,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mm/damon/tests: use scoped_guard() for damon_test_ops_registration
Date: Sat, 15 Aug 2026 16:30:39 +0200
Message-ID: <20260815143039.17291-1-jaeyeon.lee.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace manual mutex_lock() and mutex_unlock() calls with the
scoped_guard() macro. This simplifies the code, improves readability,
and ensures that the lock is automatically released when the scope
ends, preventing potential lock leaks in the future.

Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
---
 mm/damon/tests/core-kunit.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 4a536d41cdb2..770927a30021 100644
--- a/mm/damon/tests/core-kunit.h
+++ b/mm/damon/tests/core-kunit.h
@@ -434,17 +434,17 @@ static void damon_test_ops_registration(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, damon_select_ops(c, NR_DAMON_OPS), -EINVAL);
 
 	/* Registration should success after unregistration */
-	mutex_lock(&damon_ops_lock);
-	bak = damon_registered_ops[DAMON_OPS_VADDR];
-	damon_registered_ops[DAMON_OPS_VADDR] = (struct damon_operations){};
-	mutex_unlock(&damon_ops_lock);
+	scoped_guard(mutex, &damon_ops_lock) {
+		bak = damon_registered_ops[DAMON_OPS_VADDR];
+		damon_registered_ops[DAMON_OPS_VADDR] =
+			(struct damon_operations){};
+	}
 
 	ops.id = DAMON_OPS_VADDR;
 	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), 0);
 
-	mutex_lock(&damon_ops_lock);
-	damon_registered_ops[DAMON_OPS_VADDR] = bak;
-	mutex_unlock(&damon_ops_lock);
+	scoped_guard(mutex, &damon_ops_lock)
+		damon_registered_ops[DAMON_OPS_VADDR] = bak;
 
 	/* Check double-registration failure again */
 	KUNIT_EXPECT_EQ(test, damon_register_ops(&ops), -EINVAL);
@@ -452,10 +452,9 @@ static void damon_test_ops_registration(struct kunit *test)
 	damon_destroy_ctx(c);
 
 	if (need_cleanup) {
-		mutex_lock(&damon_ops_lock);
-		damon_registered_ops[DAMON_OPS_VADDR] =
-			(struct damon_operations){};
-		mutex_unlock(&damon_ops_lock);
+		scoped_guard(mutex, &damon_ops_lock)
+			damon_registered_ops[DAMON_OPS_VADDR] =
+				(struct damon_operations){};
 	}
 }
 
-- 
2.43.0

