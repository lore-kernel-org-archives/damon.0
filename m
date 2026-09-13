Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2AD737FF48;
	Sun, 13 Sep 2026 17:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789319505; cv=none; b=cuS2hR/+uYzLtyVHCUOev/efLugUMVk0CqPSdmT4nrRmMYA/cpSl41fZsW/zSOR8CEk6un7cssABhDOsZ6UumKQgKEou6OxQ9/+ZNlF6gsJLhtDyDbrvyEdTGwxwdOER4B4kYGOip2fHgA7GvoH5q+pONnEiUrL+naqA448d7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789319505; c=relaxed/simple;
	bh=hGYrlp8BUYEplerJ3NeTyfTllMHPJtU0fdxbw3cZ6Do=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XEBrBHQEO3j1rvwy6w0q0THyDEzo2OxXltK5hHEzsBs5Hrhk04/T+f1NBEP/GMmIyltbm9g6xeDXnClcc8bPCQaPxNBPArigYNGSC84lKPN8lxf1QUH5DUYumKQ5yAes7D2rB87af2JoTCGLOn/cYqW5DCkwn/Aaj33DqzwUBV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grjHdB5J; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grjHdB5J"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F431F0089B;
	Sun, 13 Sep 2026 17:11:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789319503;
	bh=Gmq/rX+sVM9Hs+BxObGYka5NbSCER5H2QYTBCAxyvwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=grjHdB5JfSV2S4KoV2DSG4jMiq0joP+rFzG0kUDEkqoe2qnjvkezksPoFAR0VQ4F+
	 7MHIEqYiUD29o/RdHRBk4hDizlFMTIR1y8At9bnv1fzjobBrG4ksf5SkpXRyD/QTDi
	 t30d4OqTbr623uGPYSY4AkHnAdpoJAjN9GP3iA585BITW2qfUTvGyxXVNBXzm6/69M
	 ILGigpq6yNpquSS4LLqVmn70/ikuRUKSaxCWNzFItZt6YU7PEhpAY//MdUnxkoZ38B
	 hfOvqmAthmwIkaQ9Fq4b8BokXBzbOYjmKng0L9Sz6ta4UyCpTXCbW7ZnF/KVoGLfXi
	 VIRkJDccJkdUA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 5/8] mm/damon/sysfs: support hugepage_size probe filter
Date: Sun, 13 Sep 2026 10:11:27 -0700
Message-ID: <20260913171133.102366-6-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260913171133.102366-1-sj@kernel.org>
References: <20260913171133.102366-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to support hugepage_size probe filter.
Allows hugepage_size user string input to the filter type file.  Pass
the size range argument that users set via min/max files under the probe
filter directory to the DAMON core.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 8e8d89b8ed981..43519afb9eb7f 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1007,6 +1007,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_PGIDLE_SET,
 		.name = "pgidle_set",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
+		.name = "hugepage_size",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2273,6 +2277,9 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
 				damon_destroy_filter(filter);
 				return err;
 			}
+		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
+			filter->range_min = sys_filter->range_min;
+			filter->range_max = sys_filter->range_max;
 		}
 		damon_add_filter(probe, filter);
 	}
-- 
2.47.3
