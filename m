Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795294826;
	b=Sat2VAlcHOoRtCnRfQlWyihPk070PHuFLR3BfuqVJZXX7j3R09plm3/3kMmSKgYXLgEy
	 0qNd964E0wPoS6sCrZQW4vu1QbUaYcf/OXmNzYzMdqPWRlvHbqMaGeV8nRhqRA2U/hhL2
	 h0OJZG8ue5m9dQT9i8U2zQZUBB3bqMdSXPtP10Rm1Kt63HfLU/F8xsV0UOaDitc/4Zabn
	 DqOddHGWMa7TUWqM1MremtQmyVrndrYrfrB25PIx6vdAeWeDAq2jqsjXtVff6xrLwgNj0
	 nR0pPUv6xmHKxyveCuQt1Tyy18wl4k9yDGZz6XLsBRiZkcYqUbesIf4y6aSIpQOQSoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795294826;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=WbZTCynxDA8qlWzkpFXejL39caIBFfSg2B35l700hQg=;
	b=F16fLyeAdp56xcPnbUE+vgX/pMw2JM8vhwPWj/ohYsF1WI5W6ze4NX89Y6dv3rGrLZxJ
	 XfudcRiuacY/MiqqruB0NtcM3R0SJjDcQmwdutkft7TME2EbK0k+8mp42Oks+zdq3XTx6
	 qAIvFk+6Z+QtLiCWTJhsvCJR8dywbaZwCEwhWglQy4FNknesns9cpViXuMNyJkB3E8rYM
	 AcTyyW0z6TKdw17VmyFGTCS2qtRtNiB4SZs7rzt279/uOvDDQCVEe/plHKTDQW4L5jefg
	 iItAT0+yKVQSz5ReqDdLkjL76TGEB77VpVwcRKQjeBYMYukIc3AMu0vNJNyhqCSMDWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfO4Ry3U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8E89606A32C
	for <damon@lists.linux.dev>; Sat, 21 Nov 2026 21:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nfO4Ry3U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C6E1F000C6;
	Sat, 21 Nov 2026 21:00:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795294826;
	bh=WbZTCynxDA8qlWzkpFXejL39caIBFfSg2B35l700hQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nfO4Ry3USlMbmLI9W4/Bpcx7I6pq2rJZZHDU6rognuYyg0rELkfEYxgwJQsXxPZoP
	 a0zULYArVAjwMRGqq2DZ4PANyB1Jnao9wd1ZOMTTmmJCdYnC6R2dbGEelca9EJHHxi
	 XcOjSSUrifpeowSpPdiWji7CY1BF3SpB8FG45IddCeTFcCGRaGC1shCShtFL4iwxFQ
	 P4bNzCbpVFxTmzUEh7yqcl2+Fd1xH1iXgep7B3uTibkvJV3B4FVzHbnh5cCwaQO8rS
	 I30U6A2WpOZwfA0+KlzTTHqZ25Ux0kuftgfxLmQzN/Irid6QFiS2oQ6EmJZXocjLXs
	 s2ESjt5WyMQWQ==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [PATCH 16/27] mm/damon/sysfs: support REPORT_MADE type probe filter setup
Date: Sat, 21 Nov 2026 13:00:00 -0800
Message-ID: <20261121210013.130397-17-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261121210013.130397-1-sj@kernel.org>
References: <20261121210013.130397-1-sj@kernel.org>
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
