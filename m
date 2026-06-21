Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753BD2D4B68;
	Sun, 21 Jun 2026 15:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782057464; cv=none; b=rQGx3S7Q6dF7tHzlMuLNpDjYJyUaVXaM8pNAu1hxh3I0R/qvmhSlZfej5M7yBhRDOQ0GmF6j3hZkX+Dvt2bqxdfgfogIgEkyVgB2vMd0AD70wUVR+mJrECaK2umvgwZnw5Grx4EyCvzxiaAQ0lRlM3eJ5/kO8UXTm/VySUWn8cM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782057464; c=relaxed/simple;
	bh=GSiR6rFpomKB+hkh4JfSMEBAzdi3NNnj1dlQF+MAF0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ky8D6yKddyHadmu2hxrAxXHdvgyzpzfyIp9fD2ESXP2JsvtUKzwUJmGWe17CjFaAxgTouYTorA1EfR3TIT62Medv9I51sMmEc6C8dfJq8lLVs0FE4+gDKvvHH8ceit+ehbXu4flxg35uAgJeC9++yKG67hjuHXMSnYIOxJR0GAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PhOnWHb9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PhOnWHb9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF43A1F00AC4;
	Sun, 21 Jun 2026 15:57:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782057463;
	bh=yDzAJDAVQX7rFXuERBq8+a6fsMKEIvYdRJNiU0vHoME=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PhOnWHb9n4REOSc7fN+gT35oSni0CW5rcKMysozwL17Yfmor7IlyIcGxiLZUvYZYT
	 DRPTNJH8Yh14wUFlkAUqcbXqZnH2icH9uMhosiKuwhQapU825XHj1CNhnya2YPTaPv
	 HgND5m4qGXyhrg1ps9TQAJSCCxTMYWHBesffCOPeBvJeFwLeqhmdidQG/5FbH/Sgp8
	 /vx36FeydesJNO6aH8Dz22rDz7DekLfdRh8CQRscI1ebtkTdc3ZzqmpFaj1CRTTWMo
	 cdAJy8QpRPWmLNrpZauP5OUo3sq4Q0ePSOMCmU12CNryvZ3xON+LRyfny66B32r/VX
	 DJ6eoFxr0Nkxw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.2 15/17] mm/damon/vaddr: remove attrs param from __damon_va_check_access()
Date: Sun, 21 Jun 2026 08:57:11 -0700
Message-ID: <20260621155715.87932-16-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260621155715.87932-1-sj@kernel.org>
References: <20260621155715.87932-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is not using attrs parameter.  Remove it.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2e12cc628fea0..ec08fc6624479 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -495,8 +495,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r, bool same_target,
-				struct damon_attrs *attrs)
+				struct damon_region *r, bool same_target)
 {
 	static unsigned long last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
@@ -532,8 +531,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
 		mm = damon_get_mm(t);
 		same_target = false;
 		damon_for_each_region(r, t) {
-			__damon_va_check_access(mm, r, same_target,
-					&ctx->attrs);
+			__damon_va_check_access(mm, r, same_target);
 			max_nr_accesses = max(r->nr_accesses, max_nr_accesses);
 			same_target = true;
 		}
-- 
2.47.3
