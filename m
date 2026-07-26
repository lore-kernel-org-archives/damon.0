Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88F3A3BB67B;
	Sun, 26 Jul 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087585; cv=none; b=NlqIlp7SgFMHS7uGX/PBFKt3RGDLpr6pRwP1db0HNQCbPf7+6TZd0Q/dzTzGsYe8PeK1a5i29tYIHRqIPqfTg/vTMTDW6AVZrahCZoMbjMGxcPxQSkI5lFeoI8XT4zDmwQxgqykzZGoMQ8qXMA0cjvfQOYtq8v3/CqP4YqcdXQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087585; c=relaxed/simple;
	bh=b5kSQGCS/ZAyZmfPJm1xVu80EMtlm0HqrWMr37t/cqg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S0IIMvzWug6vlnt4dQ79ZIkB4gZzqtcpIbmhj/WIp0zQsGRrW5JwYtkyXPkIUxaODoSPvynF5WeOtOAFOW4+Vq7C/iI1vTyhovzHvVYsK6CUopJjRCFAm40aS7XMAyv+auW+nJx1UBAgURhErqubpTotgzOoiACyyaBILQEb1tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWrEly58; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWrEly58"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE541F00ACF;
	Sun, 26 Jul 2026 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087584;
	bh=GZDCgXboPWDjpqLBgpT6yf0F7vtlbLEb3w3NI8ROd0U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LWrEly58rKaHpWNIwKG6oHI0iMSBdjKmcvQ7s2AO2mgAT2VPnt2aRsdPZ06XJ9ZTO
	 dfZ9wlvzM6m161Q2rKE5nDFk/9GMRVDmRn6TA4l9H4qkrMpVmcjTfM6PGtVDBgeMFK
	 Q7lVEVWyJG0JHFPsBak0pAnGnrG3l+ewup7lmZOWAW0nNDoxF3BsVNobl3YpX0wAkP
	 z5blZPRWmTHaPJhZJWoJWHEyDXJTr+eQO6yZrslUUHPgoU24ts5U7sLOrX9ZTJMd/j
	 CD/Vj3doqmcYVvBtqX1tCQGn6CH1cCn+lZG+IODny99luBvDhFiTSeHYVLuSQSbtRU
	 ObHfM+KZwuHCA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Sun, 26 Jul 2026 10:39:17 -0700
Message-ID: <20260726173935.94046-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726173935.94046-1-sj@kernel.org>
References: <20260726173935.94046-1-sj@kernel.org>
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
