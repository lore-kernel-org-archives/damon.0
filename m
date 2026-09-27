Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CACE3E7BC6;
	Sun, 27 Sep 2026 12:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790510766; cv=none; b=PczGbArccMAFIDjEmSByazUqIAf7GxLtzCFSBeYChHQNNrjdbA3N2qUVXwFDo/m5CpdGhPQeoCSVFSkUd7/54VGZ3Rz0RLnJc5LKC1YPH8Dt1Lk5b3pmetJRLiEAGNxD5bLgBPl3W9w4cXPgMgWBMRI+3Yp1lvIAyqxAIcff+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790510766; c=relaxed/simple;
	bh=o3QDdkDlP/1QqDJR/fSZcv74VaLo/7o5nrPfRMjgD/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FWMHdeRJl/YffssS6vHmcxmkFH8Xtp8qzhQa0BSp+c8G+ojlpH+sSlQsXLcVi8nc1ilRMQPSmTAe91yzHSHFe0ZcTrE/v5aHPlcHbacfdWEvb9S0ab84SvRYgNs/ocsLoCDL98OBnjUjnJIDQANf58OMyehWY8FiDyUEgDUIC4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IDs+j7aY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IDs+j7aY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 960B41F00893;
	Sun, 27 Sep 2026 12:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790510764;
	bh=mS1OGjGueuh9xRDDJo/iscVAdMoJD4YdolHQuoVSGCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IDs+j7aYB+5xjvIVONVtCP5GQXJklUoB+f7CdnLTd2uxDeAYLaX73E9EXqgPH248p
	 +iElyfQD6FUs7HyVnijDWBSxsGFU7w5/h1x93dbBhTCEU6PWg8XfRHiJ3li/FX6P0n
	 frf0DLnmIo02l2tu+dLUuUXn/g18gOChW0gUac/UpbD06Y+qunXg6llXkgZXiQPdZJ
	 x3wjS7klRtKXf2t7UoNfhvRmeDvaFr944lxANyP47NIBQONlUjhMravXe7Rk9iegvd
	 GHywvUjRnbJFiZXnrri7dtZCVss7B/GkAPwBtWvkDFNoVhndyGrMKUKgYtD+eDlyHp
	 59Hny+Rjwk7Lw==
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
Subject: [RFC PATCH v4 7/7] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Sun, 27 Sep 2026 05:05:31 -0700
Message-ID: <20260927120533.50484-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260927120533.50484-1-sj@kernel.org>
References: <20260927120533.50484-1-sj@kernel.org>
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
index 55df688ea596..4acb2015c2f4 100644
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
