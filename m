Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33FAD266F0D;
	Wed,  5 Mar 2025 22:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741213662; cv=none; b=X/fI5FRMFKLPqYLTYPmwPRwoJA9v1kjgAH+5+c+iffxT2NWTi3gnlVc5S9UlPASyD+Osy3k5gu97ZYLtl/zeAVaVyNO2hIy+lIsKB+90j+Ka34gUA+6uJOzeHe+OcSo3U3ULzPo8enxy5qTHgcZ4vT0aj0HamaEObikF2QSvjos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741213662; c=relaxed/simple;
	bh=yhxaKnOdMb0lPXI2cJtKjmbcibbUG7nUMZVQwaF1kHw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pl773RcQVxGoloV/AYHY+1xdCffNCrASAGQhqHcSy8xpSnjPTAa54VrgHMNTtADF2fqm9wBdKO71vME/wm5srY156ziPeJi+jTsdvyTctwCRgaDxtsXYPhMK0vJf+VvWLiU5lCtsslmgtLhc+ij1d/tuyiVwQa2vofQCk0CHe9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StLNs9+Q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StLNs9+Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA715C4CED1;
	Wed,  5 Mar 2025 22:27:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741213662;
	bh=yhxaKnOdMb0lPXI2cJtKjmbcibbUG7nUMZVQwaF1kHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=StLNs9+QuCwCvenK6UtEtHVajVFoZHMemB/YxtPBm6pXj8MCgXS66OJkSA24KOgqt
	 7tiAu4vFhWdJwhB0spu20qZVw1DanxBeyJKMjgcYfPGcY4o1EP28+5UZ/80MBw2wp2
	 P3jY90eW5xR9UCuC69NpNiQ/nJcohBpu8lYjU+rwyiiY8DdoB96A7Tk6dl4sDk2DJw
	 IuBUd1ld/3ffac8T+OpdtpRKKCLyHEtRadq/NLCb3L1mMIhLH/aiLLyvDzVO2epTuE
	 G7Y1RYNvvgYQEf8+uSoqAc4pYvQVgWzZDDTBaUfMbuT27DdrwDau4/+pZmI/eY+nyx
	 1vPHQWy0Lejag==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/8] mm/damon/sysfs-schemes: commit filters in {core,ops}_filters directories
Date: Wed,  5 Mar 2025 14:27:28 -0800
Message-Id: <20250305222733.59089-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250305222733.59089-1-sj@kernel.org>
References: <20250305222733.59089-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Connect user inputs for files under core_filters and ops_filters with
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
