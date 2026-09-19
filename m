Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6738C3B47D0;
	Sat, 19 Sep 2026 01:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789780466; cv=none; b=fy09MMX2RuiC8iO0ua5RlcTr4ylperMADTMBAWa3OHXHjheEmLPWrjwtdhcuVPmdzqQiVms4qCXmW/VYg+Q4nQChOCD0jEZHGk4xEtwMgIfUI5As4mg0Fg0jaEE2q/i4CuTwwd/2p0m/mzz6FZFQ6KoacwqXM9fV0nB1Akj3JcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789780466; c=relaxed/simple;
	bh=Pb4vQOwoTY3vtPIlZG9IlsF4JwrmT0eEOny9/u07eTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KIBP9S2Bh+QlPfh8LiC/u+qb6NOd6vRk3m8DJsGPxisGC314m7FL5/L4ozHiqi4rOLlr7HQpri9DlHvtLXYd092W8j6cY8t3G3qAvPVurxvlpROAIpx4Sxf7y0TY05YoQH3vPxaFwKYHOpgscWypcD2jh4vL89yknlb3cjQVHBE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8GWpRiz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8GWpRiz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177091F0089A;
	Sat, 19 Sep 2026 01:14:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789780451;
	bh=X1sX9mUyRN7/6GImxCu2dritOfCzk+oOrOznq8LURqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y8GWpRizei76S0UuKxfiH+DsDk9/rjgfJzoPE7pHmHXQYP9K0QJoeREr52QC7+vk5
	 p8yiE6P9eBHsr4Vod69lNdvcEQKymx1lSJ1M1nPFXIzBrb6CkSRXZgCvYHcTECfbAu
	 /NX64voDVILlwQYDbyEUKyXDFdnget3ZRxbexyiLHpDGtqxnMStIiRPd9/fOS2aTm9
	 55ZhsO9LUS6W67vVi+s2vb0XWUyi1Mdx7iDP/GwiWwJR+vJlPMX0YBfUdXC2jvVmN6
	 zfMEJbYeW0Nknx14mJGaHwGuzsulfOUk8kx4KhYb2CZvfPNtadVLvmZ8rQVfK0oULZ
	 f1LtHEG1EYbjg==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 7/7] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Fri, 18 Sep 2026 18:13:56 -0700
Message-ID: <20260919011359.88921-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260919011359.88921-1-sj@kernel.org>
References: <20260919011359.88921-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update DAMON ABI document for the newly added damos quota goal metric
complement sysfs file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 55df688ea596f..4acb2015c2f4f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -375,6 +375,12 @@ Contact:	SJ Park <sj@kernel.org>
 Description:	Writing to and reading from this file sets and gets the quota
 		auto-tuning goal metric.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/complement
+Date:		Sep 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	Writing to and reading from this file sets and gets whether to
+		use the complement value of the quota auto-tuning goal metric.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/schemes/<S>/quotas/goals/<G>/target_value
 Date:		Nov 2023
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
