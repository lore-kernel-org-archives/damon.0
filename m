Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CD4D3DD500;
	Tue, 30 Jun 2026 04:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782792512; cv=none; b=aBlNyExLP+/c8O6etbtPe6QFGFK8CeBMhWI5Fn+SJMOyCERpMiz6d4yZpAS3NCRrooGrrly1+2i9fGr6vwxi2OyrSYOhouJZIOryDTwBBnWYDmbFK/AiNCaPknoQx81xlaelRYdtRu/x7h9SzJLafRtz8v/+pVMyk+ZzB+TYgdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782792512; c=relaxed/simple;
	bh=7ASb5o9wOUlbZj9EFx+8q5X7Vn76BcmzA8I2vHhmp7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JLjF/AUVZLsZAgKeSOEZdVhBkZohZ4QrcMij33blmBmwWgHanKRTu3TWV6Tfl9f15t6DUbK3wXiCavyC39xCjkBsdZtG+anEHOgpSc1ywSdl4h0f9Hgr8zVbEfNxSTtMHTkevlphG8m15Q67nPRhek1x+NJfQ5ezl90TjThDiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWPp9yXB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWPp9yXB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 098C31F00A3A;
	Tue, 30 Jun 2026 04:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782792511;
	bh=iItvK+ZWl2wg0NN27wk4KDGoWSXX0z4a95wgJsqCs/I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BWPp9yXBudFU2EZEIPJpz1sI0Asw2XFu4/fmrEYXAsfJQP/9h5bz01LB1v7/n2ung
	 TVlkFIqRA94z7+ehBXfxmLDlUppeXavi5YvdeAwcJlIQV5FyMI2VLzn9vBfvtnga4B
	 SErK8FYkzgdkyNY2nj4KKdFIkifqxXNket44MMZcuekeyOwtXqE3ZCNHJfBm23cIE1
	 BuKVs6JXQbDlgXymWaZaJ8HluiOfzOBAzDUdYmUsiCLdNLXg63PXAbrXT5sqroLRpH
	 t5putgGmprHsyHmZ2f3JoRP5oEzBZjtblAZEjAEjdE8K7eq2eMbTDKmxozMJxizml5
	 3aplPa+b9bTqw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 16/18] mm/damon/vaddr: remove attrs param from __damon_va_check_access()
Date: Mon, 29 Jun 2026 21:08:09 -0700
Message-ID: <20260630040812.149729-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630040812.149729-1-sj@kernel.org>
References: <20260630040812.149729-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function is not using attrs parameter.  Remove it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/vaddr.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 2eaced0765e26..2058db9c01d52 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -493,8 +493,7 @@ static bool damon_va_young(struct mm_struct *mm, unsigned long addr,
  * r	the region to be checked
  */
 static void __damon_va_check_access(struct mm_struct *mm,
-				struct damon_region *r, bool same_target,
-				struct damon_attrs *attrs)
+				struct damon_region *r, bool same_target)
 {
 	static unsigned long last_addr;
 	static unsigned long last_folio_sz = PAGE_SIZE;
@@ -530,8 +529,7 @@ static unsigned int damon_va_check_accesses(struct damon_ctx *ctx)
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
