Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBA653EA963;
	Tue, 29 Sep 2026 08:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668903; cv=none; b=gF3j7uOwecjCx2pL97tq4KCZ7/ITRnppDn0vG1iEQsMgdwxvQ+RKCvPUXqT6CyKM8/Uddz/NUHgiu2kc9wqUKHil9j7VwWYKDxUwx58dMgr126i1kt2FnYpjR/yajcP4sSzcbKRFevz1XRHpQq5m2dtjaXJvtucy6OGThqSuze0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668903; c=relaxed/simple;
	bh=o3QDdkDlP/1QqDJR/fSZcv74VaLo/7o5nrPfRMjgD/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l7bPRc9gvSR6FzyDZGAu9Kqkp2c6PoPHZLkZ0YBrzLPtRoT83GGsE1O39zMNDyfqDJ7L3KwSVJKXef8Amwn+XkyrVcBrVRswEjn/IY+f8uPJL/xPBwNJDGrUJls6syiG/4CNyGYe3k6qHyuBVexWE++4+ziT1qtJGKsB6auW4ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2TQsi4P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2TQsi4P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33AB1F000FF;
	Tue, 29 Sep 2026 08:01:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668901;
	bh=mS1OGjGueuh9xRDDJo/iscVAdMoJD4YdolHQuoVSGCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i2TQsi4PwELyq4EBO5xilP4w+zwzZP82U+I3u5/cEjBQHlm5b+5kTzjA513cq5oD4
	 GdbVfkV3oBrg3j3yh/H71AywqJ+vQFSzif1CBa3F+9/7Pd/vxMXzV7hAKjNaGXzmfb
	 yugohwAPN+WOuQE2iFSFUxSxm0eLFyw920d7vGqfLMQozsJwufs5WC9QvQZBT2QEyL
	 bQTXY6qjET6RfEfsW1HbIOTKYnc5A1kWr5E3FutgbgxX5maqIKLHkklfiU6MPWryX1
	 yZPSFXVvTRhsijLXVoPWNUX+dwuISIJ/oMDFBUAUM9xPqH/KBPsm9GPaKQaEHdguWY
	 IfxbgTvtKy2nA==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 8/8] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Tue, 29 Sep 2026 01:01:11 -0700
Message-ID: <20260929080113.41708-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929080113.41708-1-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
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
