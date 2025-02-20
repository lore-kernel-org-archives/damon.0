Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CCA5264638;
	Thu, 20 Feb 2025 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080119; cv=none; b=XUdL/Vh86PlAa4GdKxlPid7vlpK1DHwSx/7Zq4SL17ZXcqpdIXwunxS3bK1a7Fb+/UZG41OjX+bCUn7ZRlb66AuBto4vhQMT4siSL2WKj1HKcC/IPI1z2k7znM1133Gn0X+2YvuPSGFPH7Vz5PkjF+RKWK5B3zziN4JLggggtAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080119; c=relaxed/simple;
	bh=GU12uco2vMf4JAexsBOLi5pNACf7z+JWPqGOUvIGCS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FgDIgcMwWtpnvDS5REJ4icHkzKYH36eDL/jRrjApQ0zcXBCAAVGNM8iiDbqn4kNPdWiT642HRGoAN6lmKZvYqkGWAtZCxgRCBS7NiACGXT4H7bNqaRpROYwoDd617dMdX37DUy/rL46HoniULmhi+q3CqYU27RrlWUU5fnfouzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeyIYp78; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeyIYp78"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E3BC4CED1;
	Thu, 20 Feb 2025 19:35:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080118;
	bh=GU12uco2vMf4JAexsBOLi5pNACf7z+JWPqGOUvIGCS0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BeyIYp78GztU1YYwb+ca3cS2Yi8BGrJD3+R7gQXyZWNhNe6K1eIWckOwHrUEGeFQj
	 21vcAgPEer4wqEwTJLzAzZ3riFyBOSPwGEt4Myr9BRaQG5/cnNuye38TmkNjBK3T0L
	 EDHfmBOcvRtjIrtkwONumdBuwS5XWBFhwDMEZLvgpexhs+UrvRZ7m9Sj0Dekp/IekM
	 odpTa6ritv1555zu1SF1eUNwc0Xk57Z9VZi4+rHWc2Or0na3danBy6cEnuMVP1j8tu
	 7grOWDow9U938cuH6/agBg+ZWIAn4fNkD58ZTAdFfsvfBbEDmDWHYog0XIXIHSaGAs
	 CVxgLV9EilVtQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/9] mm/damon/core: put ops-handled filters to damos->ops_filters
Date: Thu, 20 Feb 2025 11:35:04 -0800
Message-Id: <20250220193509.36379-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220193509.36379-1-sj@kernel.org>
References: <20250220193509.36379-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damos->ops_filters has introduced to be used for operations layer
handled filters.  But DAMON kernel API callers can put any type of DAMOS
filters to any of damos->filters and damos->ops_filters.  DAMON ABI
users have no way other than still using only damos->filters.  Update
damos_add_filter(), which should be used by API callers to install DAMOS
filters, to add core layers and operation layer handled filters to
->filters and ->ops_filters, respectively.  The change is applied to
both API callers and ABI users since ABI users use the API internally.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index ffdd84ff6fa5..78126a5145fd 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -281,9 +281,24 @@ struct damos_filter *damos_new_filter(enum damos_filter_type type,
 	return filter;
 }
 
+static bool damos_filter_for_ops(enum damos_filter_type type)
+{
+	switch (type) {
+	case DAMOS_FILTER_TYPE_ADDR:
+	case DAMOS_FILTER_TYPE_TARGET:
+		return false;
+	default:
+		break;
+	}
+	return true;
+}
+
 void damos_add_filter(struct damos *s, struct damos_filter *f)
 {
-	list_add_tail(&f->list, &s->filters);
+	if (damos_filter_for_ops(f->type))
+		list_add_tail(&f->list, &s->ops_filters);
+	else
+		list_add_tail(&f->list, &s->filters);
 }
 
 static void damos_del_filter(struct damos_filter *f)
-- 
2.39.5
