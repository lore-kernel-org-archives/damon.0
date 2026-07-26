Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA26A3BED1F;
	Sun, 26 Jul 2026 17:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087585; cv=none; b=DZe2RrbnvRe2W9w/A445fUXN/cXPbTCUnQtu71SmCw4jsMMPbVUnwrFF0klAy9gF4K7MVPxkCO5iM2f6TfdTWwNxOknqLSl12mckI0k/6U1fbAb1Xv3BME9XPu463h3H61I7RtxiMUvTv8XuKeEPi7/fFRABSoIbnSLqcvvXtKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087585; c=relaxed/simple;
	bh=8Es9t85Bo0rhryEbzvuu9esxBebv1o6si/8zbB0v64k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eYj8okmT+EZBnvBapiF9x/QBr50jTUaS2wCeKcppp5IRnDXgPQaeCFrzF5UcTfL/WzEDRprKj/efFPhtDQhBfLGGjSCCQJ7QVYi3BwR8zr4APFmFlquX4tINST4+3vHtDyXGd8xZKj4orQxGtzujms1NQ8utNYUOLBPOXFPpVkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FHQ6mxzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FHQ6mxzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 976D21F00A3A;
	Sun, 26 Jul 2026 17:39:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087584;
	bh=TO6lwsfm9yD3fzAHYwk5XK83WiQ4wpFTJMXF7vsoc7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FHQ6mxzKDEuHBHoOEGwZBQOyym3BeQ7ltUov1D9T3LMR2jbKsGRDEW8fiJKS8ZQUN
	 fVkCxNT/ttrp57AP0Lym8qGWAWfBgSTXUMfu9MCzxYdYbaDevtArz6vqRkcGk+Wk4s
	 JdhY6ko4nFmWIQHKtBQAO9KGNNE3lQj/FrBp8nWsOuKjmRDXgBaBKI3viF/3x7iwTh
	 JuCuVrJKX10Ap3Qk2vUZYZxc7PsghQASOZtnrZpaOnibDXPrx8chRzk+bOD13S+l76
	 GmvKd3iFGjgPND2f7ZvZf/entQ/W4LK8xkl+rF9k2cew5jX8Qr7660oi+7jvq5MbYn
	 DF5pvaEYLfU8Q==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 02/17] mm/damon/paddr: support PGIDLE_UNSET probe filter type
Date: Sun, 26 Jul 2026 10:39:18 -0700
Message-ID: <20260726173935.94046-3-sj@kernel.org>
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

Implement support of DAMON_FILTER_TYPE_PGIDLE_UNSET in the physical
address space DAMON operations set.  It reuses damon_folio_young(),
which was being used for access monitoring.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 5a6a78054784a..199de1463fa06 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -132,6 +132,12 @@ static bool damon_pa_filter_match(struct damon_filter *filter,
 			matched = filter->memcg_id == mem_cgroup_id(memcg);
 		rcu_read_unlock();
 		break;
+	case DAMON_FILTER_TYPE_PGIDLE_UNSET:
+		if (!folio)
+			matched = false;
+		else
+			matched = damon_folio_young(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
