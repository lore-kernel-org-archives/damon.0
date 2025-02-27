Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D3014831E;
	Thu, 27 Feb 2025 01:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740621483; cv=none; b=qBzbSOKDKGPXACMxPfT2iViDzddkwL1uhCNOXNsCwXZ/fEpZefbo+sOTF+NB2gX6KW/UbEvHHtGWqjdtJFQukxn9qtZNpsUDQiXnlYQep/jFU8G6VYleKsOAt1LOXA/Nxs/JWK1jJNRGxdSIpezm8P3Q/aedGkLSzXrUAGEPA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740621483; c=relaxed/simple;
	bh=N/YtlGcWQ2PX0NMUIcuI8F7U0I6DV10Xf2TomWII3qk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eSc8pwBMJBV5bTzlF+sldvUa4114xUsspHxxmF2OPCfm7UlJlQInLmUHkFN3nDZkpx65DLL9M+aJ2xXc5x2hqb0EcEBGN84OAWwyJ97Lxq34EbMPjqDUA4ahogZpJcEaafjIFHFPm2FlrnPA0dTyt5ux/PsOTzHe2RkbpKsc7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t1dUbAnf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t1dUbAnf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079F0C4CEE2;
	Thu, 27 Feb 2025 01:58:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740621483;
	bh=N/YtlGcWQ2PX0NMUIcuI8F7U0I6DV10Xf2TomWII3qk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=t1dUbAnfFVOaSAla8yVUEws7sBVMN8BWmcjrpG4/6zKUr56c2+Hgd9MoRMyC7DcE+
	 6eGzAOyhCaUMviM/3vJ6pFMlhbeVEg0jemrvzo/Edm7SrN+agFMW3fwmoaD8xrBMCb
	 y7myLvuuU+3pID+CqtewZT+vjo/3aVeHbqEfBFYBwPOtkvlOU4QRFJTIjadPYKnENr
	 6ApnqsgnyiFci4rNtMiRv3JMog+qrrRbMV97PHlfoj47WicQ5NnM7xlL0uLEcC4gdy
	 mlnjVmdd05ZDzVmcEC4jVaF/tjnP4RwkquBCakk3frYFaDAsRPoLacw0Zizdu3dQl8
	 /J+2uSXbBzwDg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 2/9] mm/damon/paddr: support ops_filters
Date: Wed, 26 Feb 2025 17:57:47 -0800
Message-Id: <20250227015754.38789-3-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250227015754.38789-1-sj@kernel.org>
References: <20250227015754.38789-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON keeps all DAMOS filters in damos->filters.  No filter is saved in
damos->ops_filters, but upcoming changes will make it to use
damos->ops_filters to have all operations layer handled DAMOS filters.
DAMON physical address space operations set implementation (paddr) is
not ready for the changes, since it handles only damos->filters.  To
avoid any breakage during the upcoming changes, make paddr to handle
both lists.  After the change is made, ->filters support on paddr can be
safely removed.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 25090230da17..3e651308ba5d 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -257,6 +257,10 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 		if (damos_pa_filter_match(filter, folio))
 			return !filter->allow;
 	}
+	damos_for_each_ops_filter(filter, scheme) {
+		if (damos_pa_filter_match(filter, folio))
+			return !filter->allow;
+	}
 	return false;
 }
 
@@ -287,6 +291,12 @@ static unsigned long damon_pa_pageout(struct damon_region *r, struct damos *s,
 			break;
 		}
 	}
+	damos_for_each_ops_filter(filter, s) {
+		if (filter->type == DAMOS_FILTER_TYPE_YOUNG) {
+			install_young_filter = false;
+			break;
+		}
+	}
 	if (install_young_filter) {
 		filter = damos_new_filter(
 				DAMOS_FILTER_TYPE_YOUNG, true, false);
@@ -535,6 +545,8 @@ static bool damon_pa_scheme_has_filter(struct damos *s)
 
 	damos_for_each_filter(f, s)
 		return true;
+	damos_for_each_ops_filter(f, s)
+		return true;
 	return false;
 }
 
-- 
2.39.5
