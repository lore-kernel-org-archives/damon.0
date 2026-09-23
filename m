Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9D5F480DCB;
	Wed, 23 Sep 2026 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790158533; cv=none; b=RAmMmo8FoPFdilUvNBVjjuadcnfvUvdgJfVFeTIkLf3FrbOh9WCoiweqhIQfqcG6oDZ/pXsy+SfLwrOdChnF2bTth2pyySK+Ro971Vabey3dj36sJGq5/5Ji19WgVTLgEsDuKbHYGC7EZMksuw5bNsK7ezLBaNHpPxix6K4URo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790158533; c=relaxed/simple;
	bh=o3QDdkDlP/1QqDJR/fSZcv74VaLo/7o5nrPfRMjgD/0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qhRjnDbNcS3xYPf89jH4dAuoiL2/ctb7I+ozfbrGTlzY9YU0oXGd2LKKHXEeqsSIGhWOOovDVKFO3rcusbweoIOlcM2S1csqolIVXWICIGZM3cH4yhz/wc/kkzKD6vN1fCNujZIKZUzgcSCJX/WYLwaFZkpumNMI5uuTVdfviMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxdmR5D+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxdmR5D+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 835391F0089C;
	Wed, 23 Sep 2026 10:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790158522;
	bh=mS1OGjGueuh9xRDDJo/iscVAdMoJD4YdolHQuoVSGCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SxdmR5D+x+a9bjNYIJJa/xFr9r7VnWhtn0QxulWtSOsE+AwFogqEJVKZvIyUpmGQH
	 ASLdwYCFNlUevU4cH5uIs4t4rNCZBQ1rWyASxledL8j2vcizNDStdITTgd1goMYU9F
	 9c7/P3vMPbYt+kjRyUkAaPpTQvxjPuQhpu92Usn+sJGtyku7oSGb3ao7eN4Ajs+FFG
	 KqLgdz4Oq23CMS2TlK0MMeer5IBCpqTNipCx5SfxkUs4sI2GZnt0b3XWNFHKSlU9YR
	 0l3ulKcf3z9LuKJW0vrTjlfj03AuAB8NRNh1htNjpfozXY918ZbFjLFe6sM2DXelSP
	 A0cInBCAC/+ZQ==
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
Subject: [RFC PATCH v3 7/7] Docs/ABI/damon: update for quota goal metric complement sysfs file
Date: Wed, 23 Sep 2026 03:14:52 -0700
Message-ID: <20260923101454.5748-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260923101454.5748-1-sj@kernel.org>
References: <20260923101454.5748-1-sj@kernel.org>
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
