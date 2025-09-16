Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B4D625A2C9;
	Tue, 16 Sep 2025 03:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993028; cv=none; b=uNDbKC02IDa5wFZc2lSI4dLgUyuljCrmN8IG2V0suMjDL5EjLTo6WfRaGZIOf3iZPI8+MVaR44M72TvVCi9rW8zKFWjn/hIcqJ7uHI/GBRbKnZeXJ7svQVPu8i2LhcTAQIl+q7ge++qkPKl/UI+5rOGEQbQB7iKbO0dphJrI1R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993028; c=relaxed/simple;
	bh=N/t9pkNAmKhqz/ieZXdyuuPFRZhjYep3A6xEPihZclg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lfdcS9yuNsrQurOGVxsbQsp70CZ1Rdx7/ikIHtJTU36IHm11brJnDtNnAB6vn0Z3HEuvxe3T7Y+6DOrPDKKOjl8lsU6y4lTTJ9bSd1k6RdYG6qVN0i7nwC7vnWR7x/KHxg2OgwQcOzxusDwhP1l0LrOBX/JmKjA/Fph05V0yLQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxM200Xr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxM200Xr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0910CC4CEF7;
	Tue, 16 Sep 2025 03:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993028;
	bh=N/t9pkNAmKhqz/ieZXdyuuPFRZhjYep3A6xEPihZclg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nxM200Xrc4NknLj1gtWX+oV2pwtyTatyhS2H1Vlz9g9OF2Tu8mzvB2FG34FF13Xq7
	 6jVSvEYjp7ph2Eb91fkCS3MOlYFFv2YHpbRZ5bdoNcdYqD4O3vtywWlyQW7Qc+lheO
	 jLPvKkIU15UEO4EIh7ZsZd6MFcTvJ0zTjPFEwXbyTht3JDWnXSzEEUViFNFIeOnwT4
	 //a421l2H+W6jOTmRAhCAU4LpTUgtTSaIJvDDc2Stwb+CDftA7hyIf/SOF4A7IGBJL
	 CDRosNOe+GaedyvylnHuwXVnX02mCbOQ+t2JI1D5LBvO0nckzK466iiCimykr3XB6E
	 IJrcr8pKQJy9w==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Joshua Hahn <joshua.hahnjy@gmail.com>
Subject: [PATCH v2 1/5] mm/damon/core: reset age if nr_accesses changes between non-zero and zero
Date: Mon, 15 Sep 2025 20:23:35 -0700
Message-Id: <20250916032339.115817-2-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916032339.115817-1-sj@kernel.org>
References: <20250916032339.115817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON resets the age of a region if its nr_accesses value has
significantly changed. Specifically, the threshold is calculated as 20%
of largest nr_accesses of the current snapshot.  This means that regions
changing the nr_accesses from zero to small non-zero value or from a
small non-zero value to zero will keep the age.  Since many users treat
zero nr_accesses regions special, this can be confusing.  Kernel code
including DAMOS' regions priority calculation and DAMON_STAT's idle time
calculation also treat zero nr_accesses regions special.  Make it
unconfusing by resetting the age when the nr_accesses changes between
zero and a non-zero value.

Signed-off-by: SeongJae Park <sj@kernel.org>
Reviewed-by: Joshua Hahn <joshua.hahnjy@gmail.com>
---
 mm/damon/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index be5942435d78..ff2c6bb30621 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2261,6 +2261,8 @@ static void damon_merge_regions_of(struct damon_target *t, unsigned int thres,
 	damon_for_each_region_safe(r, next, t) {
 		if (abs(r->nr_accesses - r->last_nr_accesses) > thres)
 			r->age = 0;
+		else if ((r->nr_accesses == 0) != (r->last_nr_accesses == 0))
+			r->age = 0;
 		else
 			r->age++;
 
-- 
2.39.5
