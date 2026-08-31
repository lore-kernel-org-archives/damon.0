Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B97E34DB560;
	Mon, 31 Aug 2026 14:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788186387; cv=none; b=LAEFrO1pNYltcszYaPgaqG1e6fBBMtMpMels1jHzX8kgR6ai16DZUmXa9RDlUbSB+Wpvi3ePny5XG9NbMvWdPucAzpVXkoa8se8/ys1taDMGldGhAtPDHJrKdMHkJ9u/3D1JmB6QeSENmy3KAGalIQPEt0cCzrknPUPxUZRJn60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788186387; c=relaxed/simple;
	bh=LmPFijN0srbmeFBjVnA/wHwqxOTM8ysBoVE+a+30+iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nwryJUe0fNlwKK0gthm9kLUmNkOaqwvciA3waDOeo+pewBs24UBDC4KA/Il9+j2FKuR4RId7CgZ0MhHjvSFuAlAYlDT45LZ8SXKxbvQ44/C43V/3iMCGAP4qGYv/vztt6ITRkAcYhCFaz1FWqbSdETVnnWxd2UTXVNMnLyQjHMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LKuV2UB2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LKuV2UB2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523A51F00A3F;
	Mon, 31 Aug 2026 14:26:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788186385;
	bh=5b7EjDYfsY4UBVu5ajlJqmnOtSzQbzeAwcctf4S77Lw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LKuV2UB2InsWQ/SUpl3zP1k3HLngPLcg/I9+ug+j1Z8imWtS5NIK6UqEG+7FVmWFs
	 kUqo4iwx63rdY7RrJMvwZ/cd0FcYXRZkGLcXDa1e2554bPWFBWPzvmiSZnm8TMhlm/
	 6ocAQNk0Dh2GMEm0SkwGjsbn/1ktxNqJctJJAOp1DJ1FQnbAQ4OfxZefMYLowmwFqK
	 N7yZD/jcEgKWX6Kkk7UmiEehGVqujNfFFJb90yry5MDLS4OOvj0sHnbNsG8ShVppqO
	 ysdU/bYg+5txGldI5fLTiVv6uMue2Oo2XaOMatZlOaE1YJ8I2bF0ErwS2Ci9oQKsW/
	 gJYPhKXiASITA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 5/7] mm/damon/tests: use scoped_guard() for damon_test_ops_registration
Date: Mon, 31 Aug 2026 07:26:07 -0700
Message-ID: <20260831142611.77572-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831142611.77572-1-sj@kernel.org>
References: <20260831142611.77572-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>

Replace manual mutex_lock() and mutex_unlock() calls with the
scoped_guard() macro. This simplifies the code, improves readability,
and ensures that the lock is automatically released when the scope
ends, preventing potential lock leaks in the future.

Signed-off-by: Jaeyeon Lee <jaeyeon.lee.dev@gmail.com>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260815143039.17291-1-jaeyeon.lee.dev@gmail.com
- Collec R-b: from SJ.
- Rebase to latest mm-new.

 mm/damon/tests/core-kunit.h | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/mm/damon/tests/core-kunit.h b/mm/damon/tests/core-kunit.h
index 65443aba03300..ec7260a3bfea8 100644
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
2.47.3
