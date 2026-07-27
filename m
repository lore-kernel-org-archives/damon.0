Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C40437F74C;
	Mon, 27 Jul 2026 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785163115; cv=none; b=SORbDIwISqvkdIu1lj55Hf3cxCrGW+nhLTt0kVEXPeNQmT4TSMwaRChtO5BTZTKFXzw1MCuhVwW8LcTRPy0X0vTPPnBk827Ab0VKMYh2Cgb4PfX2xSY4JjAZesBsoffRveftdX3SXruvu3NFA00iWDTS3BSngFI+zwurXm1YyHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785163115; c=relaxed/simple;
	bh=b5kSQGCS/ZAyZmfPJm1xVu80EMtlm0HqrWMr37t/cqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kJ3WKZQwaLR0uVQ5kgO2zlouztXKUQ/1V+QQWsQttJGZcQyvMQepcK6RSpY4Cc2YcK+0KLat8CfAjVWTWiMFVeE63V0K9YTYVMVGVsOvydL5TIDPiGjVKIYbi2SGGr4bf72PUkbk0JNq/C6cQxuUdi4jvFlMmtqhxKZi3y15/h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=befYxMiy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="befYxMiy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A438A1F00A3A;
	Mon, 27 Jul 2026 14:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785163112;
	bh=GZDCgXboPWDjpqLBgpT6yf0F7vtlbLEb3w3NI8ROd0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=befYxMiy6AyURSIp+XkQKBehuQc3Jwld2EV7aKfBQsYpX+808ukS5GlaFV5o/Klj9
	 DrO9OWz35Rk/heMaMmAAUs8KePMFg2bvABfsC1TEDQZYcEb5eqb+0IOoCyHSd2MGBL
	 nRVWmc0sYcLzhPdwl9EP6LZUZHs6XpXR7ET4K9Tb+xfZIVmaD1KFx6BxF0Lk/Q/dxk
	 PF31RVYx7SlbA//hx1g8cS84eJXV0l9fMF2cgFnO65a2w+x6fuEdYu9qUD/RTbp+vK
	 Av29OKb/5I8NLZGGQyYrohyFjzKM59DpSvnGVHoza2cJ/J1RRuzIe8mVWkuyzF/n3y
	 y1xtRIhlQiN5A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.1 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Mon, 27 Jul 2026 07:38:10 -0700
Message-ID: <20260727143829.86236-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260727143829.86236-1-sj@kernel.org>
References: <20260727143829.86236-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce a new DAMON filter type, pgidle_unset.  It will match pages
that have their PG_Idle flag unset, or the page table accessed bit set.
In other words, it says if the page is accessed.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 8ad6ef2e063de..cee4b74761081 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -744,12 +744,14 @@ struct damon_intervals_goal {
 /**
  * enum damon_filter_type - Type of &struct damon_filter
  *
- * @DAMON_FILTER_TYPE_ANON:	Anonymous pages.
- * @DAMON_FILTER_TYPE_MEMCG:	Specific memcg's pages.
+ * @DAMON_FILTER_TYPE_ANON:		Anonymous pages.
+ * @DAMON_FILTER_TYPE_MEMCG:		Specific memcg's pages.
+ * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
 	DAMON_FILTER_TYPE_MEMCG,
+	DAMON_FILTER_TYPE_PGIDLE_UNSET,
 };
 
 /**
-- 
2.47.3
