Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A6030ACF2;
	Fri, 11 Sep 2026 14:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136731; cv=none; b=ZXm4KPRAzO2cpPbn1U03lGmzuGpJnfl0DtRtC377FCBvRkkwIzsGkX5dYJattr1r0Z8vK8DcORKSf9aQqhhsUJMVQvrOWk2cJ0KT/OecaSkxpIZO95Eed9U2DpSfA1X6ZC/Y/Gy+tgTRzkNKgrC5TggGFtVfQKBsf2EShdOggj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136731; c=relaxed/simple;
	bh=SkahHKFXGt/ZhOVlK8irr1HdYWXacq2DcQ3BGyRJEnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BA1DaJ1ff/RygGfMT3oJB9yPFWNGYG1cC0u6NF8BgPyXX4CDsuQQq4WStfoHUR/KIdBQUZzBFrVh06qPZ1Ab5pZkcjcubrTjbnCwydR/EoDLsZepqMpRLs8k3EvZGGw/6p4Zdkvs0x4K1L3c08nLiDyiIbk31r+S4bu4swUlZ0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l9HYc2BH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l9HYc2BH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDBC01F000FF;
	Fri, 11 Sep 2026 14:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136729;
	bh=UWnB1+LHCrUWvW0DYQclwKKSDqJPcdee5LBGVppRb50=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l9HYc2BHkIpkXbRx3zT79clZlV0VQtq0mhtO0jud9OHUaUCKW+LFtATJ0JJCcLmqW
	 32U0Pjz8d6MvglKVDkLWGy3uljiLOWAhk/Rn/mDTzdAbIzRnXzgq1GSUvOdPjAx0xJ
	 PY7nU6mVO0s/lZFxK6Zi9MKEQWONuJNh+NI15nfZrEyBfEYb1g6D84ItB2Wp8S5CPy
	 cfsng1L4wIIEJuKkSYKVgN/TMeK8Oq9BdGc1loa2bh7Y+EmslWSJsWSMKftIUqTjrg
	 ZLMyJVomRZJwstJ1eG8ZfasXc3rYGoipzquGKR10h705ZSFgh2oxxw9qK6+ULvZRk1
	 2uKNsxiIxqPFw==
From: SJ Park <sj@kernel.org>
To: SJ Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: [PATCH v2 1/7] mm/damon/api: introduce DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
Date: Fri, 11 Sep 2026 07:25:22 -0700
Message-ID: <20260911142522.98013-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260911135510.96914-2-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 11 Sep 2026 06:55:03 -0700 SJ Park <sj@kernel.org> wrote:

> Update DAMON kernel API to introduce new DAMOS core filter type,
> PROBE_HITS_WSUM.  It will allow API callers to describe the DAMOS action
> target regions based on their probe_hits weighted sum.  For describing
> the filtering target weighted sum range, add two type-dependent union
> fields to damos_filter.
> 
> Signed-off-by: SJ Park <sj@kernel.org>
> ---
>  include/linux/damon.h | 20 ++++++++++++++------
>  1 file changed, 14 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/damon.h b/include/linux/damon.h
> index 16800b3dc379b..9e84bdeb5616d 100644
> --- a/include/linux/damon.h
> +++ b/include/linux/damon.h
> @@ -399,14 +399,15 @@ struct damos_stat {
>   * @DAMOS_FILTER_TYPE_UNMAPPED:	Unmapped pages.
>   * @DAMOS_FILTER_TYPE_ADDR:	Address range.
>   * @DAMOS_FILTER_TYPE_TARGET:	Data Access Monitoring target.
> + * @DAMOS_FILTER_TYPE_PROBE_HITS_WSUM:	probe_hits weighted sum range.
>   * @NR_DAMOS_FILTER_TYPES:	Number of filter types.
>   *
> - * All types except &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET
> - * are handled by the underlying &struct damon_operations as a part of scheme
> - * action trying, and therefore accounted as 'tried'.  In contrast,
> - * &DAMOS_FILTER_TYPE_ADDR and &DAMOS_FILTER_TYPE_TARGET filters are handled
> - * by the core layer before trying of the action, and therefore not accounted
> - * as 'tried'.
> + * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
> + * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
> + * damon_operations as a part of scheme action trying, and therefore accounted
> + * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR and
> + * &DAMOS_FILTER_TYPE_TARGET filters are handled by the core layer before
> + * trying of the action, and therefore not accounted as 'tried'.

Sashiko found [1] the second sentence is also better to be updated.  Reposting
this patch only for the trivial change feels too much to me.  Andrew, could you
please add attaching patch as a fixup?  Please let me know if you prefer
reposting the series.

[1] https://lore.kernel.org/20260911142049.97838-1-sj@kernel.org


Thanks,
SJ

[...]
=== >8 ===
From 8095628debba5ececa0664314ef4a3b777ef0fbf Mon Sep 17 00:00:00 2001
From: SJ Park <sj@kernel.org>
Date: Fri, 11 Sep 2026 07:20:01 -0700
Subject: [PATCH] mm/damon/api: clarify DAMOS_FILTER_TYPE_PROBE_HITS_WSUM
 behavior

Clarify it's behavior.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 33929a400aa7a..23df189015198 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -440,9 +440,9 @@ struct damos_stat {
  * All types except &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET and
  * &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM are handled by the underlying &struct
  * damon_operations as a part of scheme action trying, and therefore accounted
- * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR and
- * &DAMOS_FILTER_TYPE_TARGET filters are handled by the core layer before
- * trying of the action, and therefore not accounted as 'tried'.
+ * as 'tried'.  In contrast, &DAMOS_FILTER_TYPE_ADDR, &DAMOS_FILTER_TYPE_TARGET
+ * and &DAMOS_FILTER_TYPE_PROBE_HITS_WSUM filters are handled by the core layer
+ * before trying of the action, and therefore not accounted as 'tried'.
  *
  * Support for the operations-handled filters depends on the running
  * &struct damon_operations.
--
2.47.3


