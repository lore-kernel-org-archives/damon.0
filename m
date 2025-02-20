Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5EA26461C;
	Thu, 20 Feb 2025 19:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740080814; cv=none; b=cTeqHrEbEdkxD/O3TnyRspX2FtTrGoJy3Zuk4bZ6A7QWIsSrWOzrvUrYEyRIdxxsAuVG5goXPI28uPAwFqJrSPrWlH+TtEDbNUK75GUiFyt5l1cSeSXX7I/luOkCh7WUaAsvpdj0nmR8+ZS4IaHwS/B7olRgPMJ7SvHmU/6o56A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740080814; c=relaxed/simple;
	bh=wL/4Ps4xqCe4JY2MuJBUpgRAAyA49p5mtKK+mW9qR+A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ld8lQe+K8wXnUI6rdBLhxcMCa8ed9lBq1WBCgREwRlv9D5uy7ZoTuKglVfHQVZzPn54I4q22JCVIbWCXu2iYeENs9vV2+GBufq29EFD98VXvELfFssfFGn+isdfRiPSwkQf72MiPuX4/6LM5szah76+tARf9Fe0uShbkokzx46A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RKWygKjo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RKWygKjo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286DEC4CED1;
	Thu, 20 Feb 2025 19:46:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740080814;
	bh=wL/4Ps4xqCe4JY2MuJBUpgRAAyA49p5mtKK+mW9qR+A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RKWygKjoL1oSenPwdkIqV8dQ+WNR2ETeM5PdaAJFbqHb8eDuLmlNz3PPe270203cs
	 FD7wIoi3aBMqxE5kFuhWQF+JhOfzbz7tQEYQfsXfxto6vB4Okv3E83HlZBegiNwE0R
	 sVv4+zeFHbppPIUbvz9mjbMJJO0heWpcCOmvXSCaDUY5dpq2vvGS71xXnSVMSOl2vo
	 jawR1UKrYM/8JVV+kg6dCG1aJ96RS4bwUdPjzXdhPsT041nr79zeP4cniEbYHjyNHP
	 y8BANuduzs1tie4HkHG7B1CGoF/OQjJHDHrUR+dnNN5r3YeS7jS9A0dSUMnOS8xNTW
	 3/48jwN1j+Jew==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mm/damon/sysfs-schemes: commit filters in {core,ops}_filters directories
Date: Thu, 20 Feb 2025 11:46:41 -0800
Message-Id: <20250220194646.37726-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250220194646.37726-1-sj@kernel.org>
References: <20250220194646.37726-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect user inputs to files under core_filters and ops_filters with
DAMON, so that the files can really function.  Becasuse
{core,ops}_filters are easier to be managed in terms of expecting
filters evaluation order, add filters in {core,ops}_filters before
'filters' directory.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 61ff800ce78d..e85feb329bd6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -2143,8 +2143,6 @@ static struct damos *damon_sysfs_mk_scheme(
 	struct damon_sysfs_quotas *sysfs_quotas = sysfs_scheme->quotas;
 	struct damon_sysfs_weights *sysfs_weights = sysfs_quotas->weights;
 	struct damon_sysfs_watermarks *sysfs_wmarks = sysfs_scheme->watermarks;
-	struct damon_sysfs_scheme_filters *sysfs_filters =
-		sysfs_scheme->filters;
 	struct damos *scheme;
 	int err;
 
@@ -2184,7 +2182,17 @@ static struct damos *damon_sysfs_mk_scheme(
 		return NULL;
 	}
 
-	err = damon_sysfs_add_scheme_filters(scheme, sysfs_filters);
+	err = damon_sysfs_add_scheme_filters(scheme, sysfs_scheme->core_filters);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
+	err = damon_sysfs_add_scheme_filters(scheme, sysfs_scheme->ops_filters);
+	if (err) {
+		damon_destroy_scheme(scheme);
+		return NULL;
+	}
+	err = damon_sysfs_add_scheme_filters(scheme, sysfs_scheme->filters);
 	if (err) {
 		damon_destroy_scheme(scheme);
 		return NULL;
-- 
2.39.5
