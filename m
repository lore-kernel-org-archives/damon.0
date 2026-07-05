Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC60238B131;
	Sun,  5 Jul 2026 15:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783266968; cv=none; b=kon4+ZO9f8yTB+/5KbGABfhub4DMEYUJR3N6uIfRxkY0L+rA8LzH8tUXZlNQstfRBTD6WhNwuOcG9kSvRGL4teLRt00L5My9a9P6FovHv6gbQK77bwEE74qxvUSKWnkmak92L8UbG6ZXyxPJnT8DaIWKB3h1J++Io9gEkEfdZjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783266968; c=relaxed/simple;
	bh=wzDfGXESiahJas2itrLvNt5M85oi6ewwf7xuOPxl2Lc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YM4JQeDQ/C/RRET+/hQgFj7+UNggkjxAGzmz2A0LnqyE//s5+MoZiP16LgYjQShk1jLJMmNlE7CGixMuytxZpXaEMvjWo9yCgHpHi4YT3wvEMD0qshN6i1hq3x8xJUiCksvpJRkBn3ctm88tJEsjIVIxcqdVtd8ZTCzdG9N4SOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JRa4Actf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JRa4Actf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956D11F00A3D;
	Sun,  5 Jul 2026 15:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783266966;
	bh=91/eIt5/uTjkLlfjnN3QJGjfo7AqpmKw2P22J/q/8zc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JRa4ActfbfMHkbUNp4FEAJ/FNav6kc++orrBOsguqBkasjTIUbXkHWFo5igUcTE1F
	 gWwbODqrVP8SisRlTAVSpNlDXaGhfccoda36GVZ2kMrLSGQY45eEHr2rLD49fQHedc
	 bwqsoYO9Yo+mxHWdI/zBzuweJL5k71BCDidVeWC0+iNhGdsdoAwWj52hmQSazlsfOE
	 2FjEboTJWFyojIesTHk8EbekvCg7nBZZxYn7JiuWRIVfED1O2ZnX2AO40j9R15ViZX
	 y//7fT6pQ5ivJqk1WAMOSMP8gCURraSWf2d8iuhPSGIAZGMq4yci7QJ2Cb0kpOOQIY
	 yBBmaUR6boqtg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 6/8] mm/damon: document region size validation in damon_set_regions()
Date: Sun,  5 Jul 2026 08:55:57 -0700
Message-ID: <20260705155600.96555-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260705155600.96555-1-sj@kernel.org>
References: <20260705155600.96555-1-sj@kernel.org>
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
