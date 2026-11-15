Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794774548;
	b=pmetb16eO2cxYZlAf40l/opy7lyvMGm5UtXQ2aY9s49EZqfUgFuSgmVrzydxCtjWI9PC
	 vd2x0NUGGo3hoOJUJOx880fKP4bgsPKMy9ZDjSRFBEnkbbd/v/FZS3W50n9SwPdU7VrnY
	 Xc2kCUcgRceUdjLFBE38mQq1cNIZ12NzfxOmUFEyuUcDtjlrzJcFyfmhWp+ObOpzYSKz/
	 Pzufvcy0d7YFTC2cfu4TmlVfJtzTaNp/RrEJ5frtHyz7ST47lbHOKacnvWKpNPBfsQ0vx
	 vD50KfqwPdxsLxNIZfGLN8XZzajJTuPiUCDwN++ueKOZCNbJ5IRRA76EYmxOGCamZ8Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794774548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WbZTCynxDA8qlWzkpFXejL39caIBFfSg2B35l700hQg=;
	b=LynWIaWZSEg7S6bP6KCvEHUKymP1VGtvuzxBAdvFQBvxG5kEhqkmUesZxx+vcn6gYM1B
	 EJqBlQ8LsceGoI1ALmpKsGKoAePupbVmiCrYL0sZHSzzredkWVajiHQCVi2sb2Z+auu6E
	 cf08Coo0/WVefzW8cVT0CKF5X8xazShkosf/WNM82vLWU3WhEXsUuF7hj0s+Mvmhxn7MS
	 JY+kCL5KuXc8RR323OxbT5tz97vVZDjs5mVAYpOFZl2EgN7ghiQC66WYYbmVUAXPgOvDy
	 I3kEsdNbJlz/PY/OJCEE8LlsueTolXRXo2zBshIc8xqzBovnIwCsVE/XxwRziD/qlbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnoNxGoL;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED71A60A6F4F;
	Sun, 15 Nov 2026 20:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gnoNxGoL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A637C1F00939;
	Sun, 15 Nov 2026 20:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794774547;
	bh=WbZTCynxDA8qlWzkpFXejL39caIBFfSg2B35l700hQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnoNxGoLVrB1c6PqA+9SUSMKtWHDLFu/i1wQ0om5R/ycBjpBzjyeDfDpo+/HyxR5b
	 bzMF7DHxDYXcV+eVLyfpG5BGlbfYx30kPvZTyK59hF5Hz6mCKdXpv0Kzq5B/lAxox7
	 3jutHytUkROnz6XqkLFg9CZkdzkiC+a31zGCqfRE0Yj5w1zwUSdCrHz4aHyS42SjW5
	 mpp44LoKMyCNKm+eGk03sHnOTvtHYpjg/AFKtvjsadocBoksu4sJUkWlNONtArDPkj
	 QvVLFQHDFxyupakxYk+81WgfUQyzs266RoEaM6rLbvi/vAI+ui8JUXEUbne7VZCIv5
	 BfAQKcbIU9Y8A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 16/27] mm/damon/sysfs: support REPORT_MADE type probe filter setup
Date: Sun, 15 Nov 2026 12:28:34 -0800
Message-ID: <20261115202849.99134-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261115202849.99134-1-sj@kernel.org>
References: <20261115202849.99134-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Accept user keyword "report_made" to probe filter type file.  Set the
damon_filter->type as REPORT_MADE for the input.  Setup
damon_filter->report_type with the filter_report_type user input.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ca971cf1dcf6d..1c171af4590a8 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1016,6 +1016,10 @@ damon_sysfs_filter_type_names[] = {
 		.type = DAMON_FILTER_TYPE_ACTIVE,
 		.name = "active",
 	},
+	{
+		.type = DAMON_FILTER_TYPE_REPORT_MADE,
+		.name = "report_made",
+	},
 };
 
 static ssize_t type_show(struct kobject *kobj,
@@ -2336,6 +2340,8 @@ static int damon_sysfs_set_filters(struct damon_probe *probe,
 		} else if (filter->type == DAMON_FILTER_TYPE_HUGEPAGE_SIZE) {
 			filter->range_min = sys_filter->range_min;
 			filter->range_max = sys_filter->range_max;
+		} else if (filter->type == DAMON_FILTER_TYPE_REPORT_MADE) {
+			filter->report_type = sys_filter->report_type;
 		}
 		damon_add_filter(probe, filter);
 	}
-- 
2.47.3
