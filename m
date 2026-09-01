Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1945035B63D;
	Tue,  1 Sep 2026 04:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788237267; cv=none; b=Vvn8J5vCoFksHdJTHFzvQpoRN1F1DWyyq+TWGkim2QS4tlLi7ILWJ0SZDcqrI0kFhh+yUyKbe4mqxA/hLedqmRiyFSUR+F9O6mDdor0ocZppR95vyv/xmBllij9lrTGnGW7D3tWz+QuJ1p2goRyXudr98T/izKKhIhOR6VqYP7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788237267; c=relaxed/simple;
	bh=5eiAy3QIbJG0jFQflcMO3WVJL5e78NjuZ+mSKp0XpBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDoa5Adtlp3FFlVuUDtQ/md9pRx9A//Y4Qyowi9RbYxPvR2LevoJv27loCFPWBdg3dqCJsllBM7WsoVo96Js3rHwE1k6eVDthBH089J6rktXcSGX0jgG3cDaODRmIWYoxZM2LAA7QimwAbeiznRiRFXDw5IJCdWO73Nop8MdCPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GjwMQpj3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GjwMQpj3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 923571F00A3D;
	Tue,  1 Sep 2026 04:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788237265;
	bh=U+5n2m69nUp/8eBxRsZKrpQRqRxmZwpAKuJfK8YQaNw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GjwMQpj3Wrb/6erZFWASypzljTlgEQ+oER1CXJfcnVo3griBMbAIy4bpGwhfkiVtc
	 mQg0Mc48Ji/5Y/+VaSBbR395CYi0YLrtjEZLRwPF2bUPIwoQz8qsHOXbIZNWEy6Nbn
	 MdUzuH/aeom/r7+4r5mN5r7xRGRcqLboHE+OSJOdmSVFUEt9W3mjil1gqP7jU7XlmI
	 hvE3ckZMTIIOj3n2UE+YxTPQZtnZ5KOwizXfBGPUQ26uWqjhtZzie78GPMcNqgj/Ra
	 MvKYybYiR/SrnZDAKmt12QGmtHgPK0ZqWS8zM4+WkloDq/4fTojMoP9gwa4uXncHmc
	 vfJZSWNm0NUZw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 01/17] mm/damon/core: introduce DAMON_FILTER_TYPE_PGIDLE_UNSET
Date: Mon, 31 Aug 2026 21:33:57 -0700
Message-ID: <20260901043417.2165-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260901043417.2165-1-sj@kernel.org>
References: <20260901043417.2165-1-sj@kernel.org>
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
