Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC52E78F2B;
	Thu, 10 Sep 2026 04:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789013365; cv=none; b=tdgWz1mqn8xNsifZvf1qcxZciHJPP99Vu2rmrSbwDCkrx8/tBsBgjuimcZ9NmqoX3Yvv49XLakBmWmLVdRna8LPkLuNvqptGV32KfQ5d3SA39498NI/gxrPRVW4oLvs+2E2ZIa7SKH5xkitYT2oZyEHz+KrzImXgu35yEh/4dMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789013365; c=relaxed/simple;
	bh=Yavx6ZImddLXtzyngrwSUfNMonmsC2f7ftbCJ/nz8k8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y5Pk26MGQ7yvdWIX75veSHEf9J8V6tF/MXJP8JghfzyXMJZra571Qwo6Yd1T7Xs//d1NA7po9tYlToicrbNrXyC1iLwztyquqeMlnX/TRGf8jAbw4i8CvXFpRt0SkvVenjFgYB8DmX04NG9hs8+T+MRTt3mU4uEbx/QKUNZKygQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPoKLjX+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPoKLjX+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9351D1F00893;
	Thu, 10 Sep 2026 04:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789013364;
	bh=i2ojgP+YWZIQpYhSbuiMhxpjYN+Q61j7jKyFOHSqFg0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EPoKLjX+ZcSlwt52QHYcV91tQAe1h4R68xOCna+AzW9rW7CYKz9EPUiT2mkjvDx9P
	 gC8I5YJCf+0Ng7NrdtO2vA25p6kXfQndZ39kXqloMVSlDEp4ZYmcloVt7byG2u01Gt
	 H7EChV8Bn/EXfSpdqffqsGiGKstsSumn9af69c8RdpotOTtpxW9Jg7CQS4aVFMv26W
	 Qavqw/rByypBJCGzoLgdxveFQYFT0pg1ALsfA43Yw3uZz+MeAHmffT4jvDB/fUwuQr
	 jMXY3YZnZssfySxQAayfsHtBFqt3WJGwZA+kRwj4CokTyTOiIiJMmWAoR6b/VGrYhy
	 wAWv0wf2ESBmQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v1.1 1/5] mm/damon/api: introduce DAMON_FILTER_TYPE_PGIDLE_SET
Date: Wed,  9 Sep 2026 21:09:03 -0700
Message-ID: <20260910040911.148273-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260910040911.148273-1-sj@kernel.org>
References: <20260910040911.148273-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON_FILTER_TYPE_PGIDLE_UNSET matches only memory that was able to
confirm if it is marked as idle.  If the memory cannot be marked as
idle, it simply doesn't match.  Hence, finding memory that was marked as
idle with only DAMON_FILTER_TYPE_PGIDLE_UNSET is impossible.  Introduce
a new filter for the purpose, DAMON_FILTER_TYPE_PGIDLE_SET.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9fa99f92a2e94..ec6bfc292a7cf 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -782,11 +782,13 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
  * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
  * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
+ * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
 	DAMON_FILTER_TYPE_MEMCG,
 	DAMON_FILTER_TYPE_PGIDLE_UNSET,
+	DAMON_FILTER_TYPE_PGIDLE_SET,
 };
 
 /**
-- 
2.47.3
