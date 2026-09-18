Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E3814DE70B;
	Fri, 18 Sep 2026 14:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741721; cv=none; b=BYgNKnPgeGHzEz43yWzl4MuaGCYpWYNVpnP20kX+0wGAbREyo2AVOqUv4RgxRtBpg8704KAIBD1mb+tcrsNIKrDFJDJqLwnPaVGt8iNBwTwYDt7H/AkrJ71t1r3KntcQHJmAMNJ5XxkFdz/dGzwRmCRvjll80+nZ5yojnEtSu0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741721; c=relaxed/simple;
	bh=Pb4vQOwoTY3vtPIlZG9IlsF4JwrmT0eEOny9/u07eTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WxPM4xnKbLIp7tbFreDSrNTvB4ezAZilojYhIQ/QTQti20QI1UCoegpohJ1r7cf431O9ws/YYVw2oNfP+fexfvRjSr34XRA/r0dZ6BnWa1l6T5mpFFGdKfQxg9jpDFeZyE519gg3WRGpmWH84gX4N7KIRUcaZzKlbuAfshZNqx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bj3bNF3Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bj3bNF3Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA861F00899;
	Fri, 18 Sep 2026 14:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741718;
	bh=X1sX9mUyRN7/6GImxCu2dritOfCzk+oOrOznq8LURqo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bj3bNF3YnTkRyExK4aA81r+y4I01gJoc/vxkdx1RVsUyacvvlrZdyvJfIakTUMpJN
	 J3ox1PGyg+j89n1Yx7wpx6bi1eRAsmVr8GvhfrmcCtzsyu9DiuUy5KBwNg5k14Gg3J
	 N9Z0xEpgg2oQA+rjor9/eJ1diN2Ts7vLOjoOw4bYbxeuBIsEnuGcsXIRFrAbLJ671i
	 PpTyuwEyehc23uPdwc1OKBgr7Dvr5vu3583rZLiPTl/qTzta0e1QOm631IxhbPWLE9
	 aHW3zqDiahqQ8IE8yBsKAC3mrWwPFKVJi5GKmQKoH+RheG/AbGx5jXChAB0g80sb5f
	 wwE5m3Mqsfxvw==
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
Subject: [RFC PATCH 7/7] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Fri, 18 Sep 2026 07:28:26 -0700
Message-ID: <20260918142827.85303-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142827.85303-1-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
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
