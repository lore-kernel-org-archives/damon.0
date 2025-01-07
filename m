Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC89C1F76BD;
	Tue,  7 Jan 2025 20:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736281093; cv=none; b=uyGj7ybY1/VXgwt9GJ5k1vdNy4qYTHHmRnAkcA9ZaMYv/zCQeTWuRwIbJ6rU6SbBi94290gE4dV8eX2OsCwBCPyGTHZofvHmhdgJbLANow57sJ67AI7iTNmsNDSjBq3Z5glf0C2SuE8lQcYrs5QqRI83stpfpFAOME+TPZlQVW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736281093; c=relaxed/simple;
	bh=tuhpVdSKJ2wYJgPTltwUOs4MNNvfzkT5HUY0DvCph2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BdC0MdnhESiMTWyQ8YG244qVGxZPKOLHIXTH/8OYCabfUS8DyC7scFeRp2BlqGUCCBd5PIrYY/TrFNK/ZxAnhxXr7Hz6SFDxcWOQUqPm20TkiaN//9z8krHIfvsiD9hfDkJ6K0Q9wEOmcrOCu65rPl2ia1mFx0C9NShM45PEoYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ap52vc9L; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ap52vc9L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7607CC4CED6;
	Tue,  7 Jan 2025 20:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736281092;
	bh=tuhpVdSKJ2wYJgPTltwUOs4MNNvfzkT5HUY0DvCph2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ap52vc9LCXHiCrhKByqmNaZeFczwv/M3myDnZsagTT2jKr3KDAlahQJP9r5GqYAmv
	 WhKuWXffp4rYtiwln3h1pBXvNPlXzU5tSlvAD+ws9ysKEeBkh3meWpdRD0at3HjVj0
	 B6Hq4BehmjXL9thObdsImAwxK7v2vNkDpEhocsaSygZgLDB5wF0SdLxwu4IKQqnvOc
	 9Z0iH54fE6QJLIO1AKsEAcxKJ7AN5BMaRMldWHKy/oMeF+1X3FzQLLP8URzqoY7/ZH
	 lfW/eDK4hEYKmg6YfVEWrTK2waCVR/PjjspebITjSF3NVv4J8tOWw+rvDOyehpGgYf
	 31sLK6Tcvtk1A==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/10] mm/damon/paddr: support damos_filter->pass
Date: Tue,  7 Jan 2025 12:17:33 -0800
Message-Id: <20250107201739.79484-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250107201739.79484-1-sj@kernel.org>
References: <20250107201739.79484-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Respect damos_filter->pass from 'paddr', which is a DAMON operations set
implementation for the physical address space and supports a few types
of region-internal DAMOS filters (anon, memcg and young).  The change is
similar to that of the previous commit for core layer update.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index b0c283808ba6..71cb02128b46 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -198,7 +198,7 @@ static unsigned int damon_pa_check_accesses(struct damon_ctx *ctx)
 	return max_nr_accesses;
 }
 
-static bool __damos_pa_filter_out(struct damos_filter *filter,
+static bool damos_pa_filter_match(struct damos_filter *filter,
 		struct folio *folio)
 {
 	bool matched = false;
@@ -237,8 +237,8 @@ static bool damos_pa_filter_out(struct damos *scheme, struct folio *folio)
 	struct damos_filter *filter;
 
 	damos_for_each_filter(filter, scheme) {
-		if (__damos_pa_filter_out(filter, folio))
-			return true;
+		if (damos_pa_filter_match(filter, folio))
+			return !filter->pass;
 	}
 	return false;
 }
-- 
2.39.5
