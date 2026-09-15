Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E543CB2E7;
	Tue, 15 Sep 2026 14:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482853; cv=none; b=STbaF0jzb1/jyyZnWn9oX8E5pHGMSLKuCTF2QW30PYxasyaDmE94rLqz+7AkIT1PTmYVwO6dbJtH9ScvRQqvJAsicQBmhE6cvTvdhy/E/ttYoVmDF0WcUIfx6W5zhY8CQPdS4zyCJafk+ESzaEkjA1rn6rSGcmMTmfXWfoNY4Ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482853; c=relaxed/simple;
	bh=mdrTtuzWyI8F7lQlAtoXmlw72idaeRcZ7fA3+Z9qesQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XBUwBWLw1Csg1dgbeMy+hmUMeuTdM6bhVmYYJCSfPCWnHo7p6Chhj8cXgcyYlQXvfbRiV43eJV8sp/fRz278ll2ruCk42+brhPbsfs+dpZk3uJt/Uzy/lqP4VwyJ4Z03nttE+Ye+8eNGrdiUUsNk0+Es+8LZnzcNm+LvnyYaE9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lae3T1U7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lae3T1U7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DDC81F00898;
	Tue, 15 Sep 2026 14:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789482850;
	bh=Pe5PEKflMlDglfugpw4os1GpkWtazCvp49h5WT4n+gE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lae3T1U7A2VSpNa+UqOhDrASVpciluogDdg9lfwEPGUzWSAdy1jpoPvTvR3G98NPI
	 YhaOJg4oi3f51zbIIPNK9v7s81No0glnLhWto3WzxJ333YjGWSlu/qyewp5I+J4bf1
	 ozAhiBfVIBcpNRnFek5TY0vvHRSlXLl5/yf1x8TZ1UvCJpWjxmu3YonQsRx3zsM+Eh
	 lCnbAmtMEHgX5JWuMkvEnTwrPXlnAOHVv93hs6KzP/4BGQoPTjRbmellLoR+pfB8rg
	 6dOFG4vaLKds3NG8EE8sYJ95eTU9ySSX2Gto0ESe+LpAWEPOtu5YdTF1frYyli/4I9
	 tygT9kCUUetyA==
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
Subject: [PATCH 8/8] Docs/ABI/damon: update for hugepage_size probe filter
Date: Tue, 15 Sep 2026 07:33:57 -0700
Message-ID: <20260915143359.91472-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260915143359.91472-1-sj@kernel.org>
References: <20260915143359.91472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For the newly added hugepage_size data attribute probe filter, two new
sysfs files are added for the size range.  Update DAMON ABI document for
the new files.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index ad21f58f3c912..55df688ea596f 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -206,6 +206,20 @@ Description:	If 'memcg' is written to the 'type' file, writing to and
 		reading from this file sets and gets the path to the memory
 		cgroup of the interest.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/min
+Date:		Sep 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'hugepage_size' is written to the 'type' file, writing to and
+		reading from this file sets and gets the minimum size of the
+		huge page of the interest.
+
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/max
+Date:		Sep 2026
+Contact:	SJ Park <sj@kernel.org>
+Description:	If 'hugepage_size' is written to the 'type' file, writing to and
+		reading from this file sets and gets the maximum size of the
+		huge page of the interest.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/probes/<P>/filters/<F>/matching
 Date:		May 2026
 Contact:	SJ Park <sj@kernel.org>
-- 
2.47.3
