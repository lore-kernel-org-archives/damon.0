Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588CC3C37A2;
	Tue,  1 Sep 2026 13:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788269116; cv=none; b=DiXMYL+ubQYknMgUtSoBG0dZuCrE5gV4sfZD6dQ603Klvi5OPJFZf3IjQBef5XM3qK+ks7jMUDm9FDcHfBz4BnBKfCXQdMQjqTeCgXtQN6y7dC5dM1SkFDEvyX8yD81+0nJAuAvMjjADARtIRKILDCTTPfmQFvXKVoRXkzePpmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788269116; c=relaxed/simple;
	bh=5eiAy3QIbJG0jFQflcMO3WVJL5e78NjuZ+mSKp0XpBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oYEhpqz3+BM0SjEg+ZmFLyRTPDX7Nib+tM/gb+SKdUzUxdD96p9pXCeqkpapmGD0IJ7poeextRMT79Sn3a7KdkhxDCqurhbAx4aRYNoUW1ueHKVBM4eOI5giLOOUJqTdEH68upt2tVpku/B1Q4SvxspWWXisEIXEBx/1Q1ftHCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nJilu1v+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nJilu1v+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F05341F00ADB;
	Tue,  1 Sep 2026 13:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788269115;
	bh=U+5n2m69nUp/8eBxRsZKrpQRqRxmZwpAKuJfK8YQaNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nJilu1v+6XF9e5ByO9wGT3nwIWFxcZVNHpZo3jUMIZlqF50JJ5s83Jg/3dyBF7gpJ
	 jU19FtBk/WvY55inPoMgcixr1Erag2zLQ+QMA/ZpMX+WvA7QRQPH5J3TliUHbenyvn
	 RpDI1p7qfXSRnXMvV1nOgnN/Nb06J7O4EDB6w3pEx3MCC6s6fFzLsiXKMCEeI3ZSlg
	 PPEBOTmAtiNxD/+X455t3pW7X5okDfWPLrBwuQtj2tblIp2y910S+nlEGiPWF2q7CG
	 Tp6Rjnmn7KWTyk++9JJcKZ88CAGf9uijUnGL3rBI2agr9OAoYv1FW9n1VgBtNIzuNk
	 2sDD2cFb1rAPg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v1.1 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Tue,  1 Sep 2026 06:24:48 -0700
Message-ID: <20260901132506.99243-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901132506.99243-1-sj@kernel.org>
References: <20260901132506.99243-1-sj@kernel.org>
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
index 7b1b6050a8286..7a42cbe791845 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -745,12 +745,14 @@ struct damon_intervals_goal {
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
