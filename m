Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B7639150B;
	Wed,  2 Sep 2026 05:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788328081; cv=none; b=TRXf90ei4zSu9E6NtEWbTToHT9CAFMgSj2A1sXW1L4egBzsPAcFEp8XpYV3M7WVwFck0NxxZsi6OQ8mTJ/OB+TEfDX+it1T3UUTx26oKlWYxpZL7RVjqV4Wflj1dcaN8642+9SVsKaF/asY1utrzL3+SkvQcUSXYvl1iFtb21MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788328081; c=relaxed/simple;
	bh=2xY8XmsQ169rflgljcAafurgWq/upAZgTuMMbRiXQh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aDzXE4j/QdsvMelTiiKvDPSLfvNqANgE9+sf9qmzky1d+wDT8hjBpA9KuPq1+CAO7OjPyMIiVuBfEG7xu0uZSzRFXQLn9ca3EmnA2ywexWqHfxvk5mlAgdDi0/6HUvegJ1c7SG7SsfaNkdSWbWTrAzZGXJCwP4m5iSqABN560yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJBD+xhb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJBD+xhb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 307D91F00A3A;
	Wed,  2 Sep 2026 05:47:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788328079;
	bh=FTkFqCNT/LseVbtXKhwVw4AevH2QQucXk6b0DrI2IK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iJBD+xhbGsbTbi8FntI+zlKjLKAHwo5WB2UcnafQzV8jHHYe5RCEmLlQ+PohvNbt0
	 EazBZCYqe9sA55ZsKS/mhMtCUHty+EnfSWeGOo9VwXf8ZgxbrlZLQUz2re0efopegt
	 y4FuWHEi7R2ofbeC7dWcs9ztWVGtQ2RpGyL+jlmTzIye55vYmFhmPlaM2Kdnafepn+
	 pAtMlZUHonTYibPaqirBAR+Fx69M2mIxvFTSERvzX6WuuHtUHpSemPLPVRiCq58Mb+
	 lin32ZCuP+S3UiCMKwqRe3QPV2jQDZ/sjXzQn2j34DvAv7TNXnlRj3vUTxZhoLPShS
	 xvEdWNVNsVMmg==
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
Subject: [PATCH 12/12] Docs/ABI/damon: recommend subsystem doc instead of admin-guide
Date: Tue,  1 Sep 2026 22:47:45 -0700
Message-ID: <20260902054747.99370-13-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260902054747.99370-1-sj@kernel.org>
References: <20260902054747.99370-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON ABI doc is recommending DAMON admin-guide for people who are
willing to know further about DAMON.  Nowadays the subsystem doc
(Documentation/mm/damon) is a more recommended place for even beginners.
Recommend the subsystem doc over admin-guide.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index f8d2601e82904..ad21f58f3c912 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -3,7 +3,7 @@ Date:		Mar 2022
 Contact:	SJ Park <sj@kernel.org>
 Description:	Interface for Data Access MONitoring (DAMON).  Contains files
 		for controlling DAMON.  For more details on DAMON itself,
-		please refer to Documentation/admin-guide/mm/damon/index.rst.
+		please refer to Documentation/mm/damon/index.rst.
 
 What:		/sys/kernel/mm/damon/admin/
 Date:		Mar 2022
-- 
2.47.3
