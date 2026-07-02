Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8C330675F;
	Thu,  2 Jul 2026 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783026375; cv=none; b=jy3x1Omu9E9cMa6h2dwS/I0HwtCTS6tCCoZl0riaNUuv8lxCMvJozPqjRs1a5CSw0nW8+/obozVLizeWUmyF6XNvmIJNJz2J4joRXRxV6HBrUKtSxJceXa3r5X36tC0fK/GqkitsD2WpFW7BJknxdPciCu7W5GBYuN+mOrVdYT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783026375; c=relaxed/simple;
	bh=wzDfGXESiahJas2itrLvNt5M85oi6ewwf7xuOPxl2Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipD+XPtrsUtZvgZrYVjzF8pSS2m/u9lTEKN6DkqlOmYj0aGPfMs8G0aOQkFWxYADh9CuWt/a31H9TnvFte3Us3eLvklJ8gqIgYm6gkjXKI9cIcUA+O6xn+jgeWIZtaeFtGjRAIoPuasUb83xrGWpGCOsLB6wTPO1jJPaI/20QSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oIyhVAgA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oIyhVAgA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CD471F000E9;
	Thu,  2 Jul 2026 21:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783026373;
	bh=91/eIt5/uTjkLlfjnN3QJGjfo7AqpmKw2P22J/q/8zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=oIyhVAgAGPFalJ2n/92cMP1H8mLrkWYwBgwSB8E5zjbYnccJE1uH3wnyrHaBxTRQx
	 DdwZFVUHR79dS9+forn6IsKVZSxwi8zfJl6mVBkIsjiAv9MoGS3wB5cpOuQoSJIKW3
	 /JjB1p5kgoC+4ekPpCWPWH2iRQD7yGnnayT398IJ+t0GDd1OPvZGIYs5tRA6A8Oo9J
	 WChR3LvxO02xJBejePSBhi5kENBXZNcze3B4bccXZ3cI7yTwCY0evEB8aZdxXgaaAL
	 SBHfWZssMyDedeiSnOvpd0WzaQ13gysUO9QI0ICS7fO0dwN3JC/u4T49iHGVOkjP9A
	 avm16MbuYoc7Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 6/8] mm/damon: document region size validation in damon_set_regions()
Date: Thu,  2 Jul 2026 14:05:48 -0700
Message-ID: <20260702210551.95167-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260702210551.95167-1-sj@kernel.org>
References: <20260702210551.95167-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel doc comment of damon_region clearly specifies every region
should have positive size.  But it is unclear who should verify it.
damon_set_regions() is the recommended DAMON core function for setting
regions from the callers, and has the verification.  Update the comment
to clarify the callers should be ok to pass any values for region
addresses, as long as they use damon_set_regions().

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 616bdf0954b52..2661231c0ae82 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -49,7 +49,8 @@ struct damon_size_range {
  * @list:		List head for siblings.
  * @age:		Age of this region.
  *
- * For any use case, @ar should be non-zero positive size.
+ * For any use case, @ar should be non-zero positive size.  damon_set_regions()
+ * does the validation.
  *
  * @nr_accesses is reset to zero for every &damon_attrs->aggr_interval and be
  * increased for every &damon_attrs->sample_interval if an access to the region
-- 
2.47.3
