Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4234E38654F;
	Tue, 28 Jul 2026 04:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785211974; cv=none; b=VEgX126fcdlB75D2QyPLvkK20fGD7e6NwUwieD8cnMiY1B4gSKR0aR6WvC+Y1Zr9pLXCiyafn/m1TujXZhR0VL2kV1EdRvWCXLLneufz8rdqZruib4BXZD4G/4cE9gT1CERWB+f2GKlni6UYC27ohJgCkFD/QsQW49OSwwxt6bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785211974; c=relaxed/simple;
	bh=b5kSQGCS/ZAyZmfPJm1xVu80EMtlm0HqrWMr37t/cqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAHHOacSS9VfyIMcxKte2BxteyccL7BMeqFR0kUm/DJHoKmb6XgpcUHOJzEZmEpYxo+R0vf9oexXqetyb1KlyqcCambRLD7nOGqw8NzKK+qeFubUrfT8dX957u4LN5qzIfXgygJsxhacEvVwxtVjsGFwvlCbvlDoiTTWVCZAsxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMAV/yKg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMAV/yKg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F00201F00A3D;
	Tue, 28 Jul 2026 04:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785211972;
	bh=GZDCgXboPWDjpqLBgpT6yf0F7vtlbLEb3w3NI8ROd0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FMAV/yKgSN6qOzUST3yzRCnZ/hBR94O9YoOjLb9OY2m97U5pFemsAZ7aePTN+vao7
	 OVIWV2Wu9dDUY+/Tmk51AhPS4tvW+mxqgsg9LUdpzZ3Q5JMGLwX4SrfX+wUm+WFJGO
	 JU+8p5+KN2KQ/OkGrQOiHQTw+BXdmemTMGi+20d8WapCs/hXbBxDn04TUJ/Z9s1Y77
	 cz4fi42x2gKUnPK7OtcPwREp6eI/b9hWM3CJMcK6fqKjBspFPkMZ4+pQMQY3+Eb/s5
	 M99uAZcjqg4X7b950Agv5XoxgQLRE5+8LwUdVQ8cmBwNxAZ8Co+AGZ+qW8237P6Yvx
	 m9ijx7QjM0Z+g==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2.2 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Mon, 27 Jul 2026 21:12:22 -0700
Message-ID: <20260728041242.187380-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728041242.187380-1-sj@kernel.org>
References: <20260728041242.187380-1-sj@kernel.org>
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
