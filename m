Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 582042C1586;
	Tue, 14 Jul 2026 04:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784003685; cv=none; b=gBVChYLF9UhdfK3hfa3co8IWi+4TijKT5GwVBpNxNqFVDS8Hy9MVuRKI7NEEN2XkA5MQgf8KNIpG8+E6pYEEiCU4s9X5xLLQ4kpk4HG+NERfbVV9pD4EYrLmB081/hn5jYhAbpXQoDaTJld+mWdE3x6P9lOsSZtdFLsPKCmSvkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784003685; c=relaxed/simple;
	bh=/YooC0Og/qESa3EjUx8EinIYLgt3NHWfzDOzYxdEP/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aipLe4MVO7i8yTvjMlxh2fxFt+tbSsw/Kzz+oFOGn9TGKhtaiUOrqs2Ee+lweqdHzYT6nASQtozdv9JgKicdZvd+eu6Q2uKskNrAvVPBJn7viom/IX30onv8REhFJI0YCML+EWY/xPqQW/Czqpw6xarQpL/41029tIcZ9wkSXRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFw4SMDE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFw4SMDE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D5E1F00ACA;
	Tue, 14 Jul 2026 04:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784003684;
	bh=K9M+/498pDyKMm1s0mlHFjJL8e/IqqSwdiOP+0fBImU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lFw4SMDEogKyEWuA6QtbGBzeT6n0wFQfRE1ayLXO6ZGS0GMl3ZTITnpyo1+Qy+a02
	 AxjZi/yZA4CjXGPHBWyqDOFzJQswXUOnaRub7RrW1o2AwaZwQ2AnChiqfr7pQLSa08
	 DujXVyHhErK/TEZZUkKNAAipDRe/IPBMX3y1gE1z006FfEPJjrzX++vv+gYFyKQdwU
	 +ZLAyxoZQcGxMTnCxdtrVwaM0zkTjUH6S9M9q3iiJ7BHZk+sfmjpCEG0CmmzVPoxTW
	 BqMFY9+w/OmDRLaEMuUQ8nl5PyYsiyWiI+hsl9ouORR4N9dzM+BhyKed1xGyHZVs+Y
	 EoHGhHPbS5WTg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 05/10] mm/damon/core: hide private damos_filter fields
Date: Mon, 13 Jul 2026 21:34:31 -0700
Message-ID: <20260714043437.95811-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260714043437.95811-1-sj@kernel.org>
References: <20260714043437.95811-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos_filter->list is intended to be used by only the DAMON core layer.
However, it is mistakenly not marked as private.  Mark as private.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bd024b89adfa3..15517be3e4960 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -432,7 +432,6 @@ enum damos_filter_type {
  *		&damon_ctx->adaptive_targets if @type is
  *		DAMOS_FILTER_TYPE_TARGET.
  * @sz_range:	Size range if @type is DAMOS_FILTER_TYPE_HUGEPAGE_SIZE.
- * @list:	List head for siblings.
  *
  * Before applying the &damos->action to a memory region, DAMOS checks if each
  * byte of the region matches to this given condition and avoid applying the
@@ -450,6 +449,8 @@ struct damos_filter {
 		int target_idx;
 		struct damon_size_range sz_range;
 	};
+/* private: */
+	/* List head for siblings. */
 	struct list_head list;
 };
 
-- 
2.47.3
