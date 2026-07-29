Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B239B392806;
	Wed, 29 Jul 2026 03:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296286; cv=none; b=ImOT1Tekc6ZmkJTts4JHlNmcYBFvufP3Zi+oGpI/uRt4uZ887fdC95e1i08M/je4dpFwKYTMHLwCyT2/KNXc+SGlwvMO32Jog+wcukjSJo6WgIotQekr0xc7De8vWpyf4FSfUtdmqixaN7OnwmqUmGqlKXar0tn3cMCVOWJT7lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296286; c=relaxed/simple;
	bh=2xY8XmsQ169rflgljcAafurgWq/upAZgTuMMbRiXQh8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=deb9uxUtOTpNmLFq3w3AJXjmGxCDjrt9dX7NIcU2W8oKNX+jwnpaoZqO6hXtIvLaz772Dr2+J5Qwb+++71oaZjO8alToZB3YTnZWqIy4f943mK4z05ku++wYAHPLc43zZjJ/8eTfpo5qh9Se8GyLQaCiz0QiSlKsBzGXurneBuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y0OTsjK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y0OTsjK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E3181F00AC4;
	Wed, 29 Jul 2026 03:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785296284;
	bh=FTkFqCNT/LseVbtXKhwVw4AevH2QQucXk6b0DrI2IK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y0OTsjK+UBuvpS8e602ZtYk9Hmif5n4eAuC6HPfpQsl3tRoc4RPhL++nz1m5Vok/l
	 u+Epq3UQbswPOP2dk4sy3p79IJRCo2+dhrkKDjc1/VcIuTTbcI6FzalDvqmAxdrGo6
	 1n2z9pxFbRY3WPNIeX2koWzpJ59r2dUh43BRxl7v09tlq/7t1AD3PABjqBJmIEqPdz
	 V7x+ZsI/tCGAmR5287U7dhjHc9FymJNPc8E2PSnT+4O63TExLis+RT7FlmOcYmmHSE
	 IscfpUpUt5388X66o4k2jpc+QGURquznVouOL0yTuuq+McXQlRYmbS3YtcthN8zVHg
	 85cEQ3lfgqYEQ==
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
Subject: [RFC PATCH v1.1 10/10] Docs/ABI/damon: recommend subsystem doc instead of admin-guide
Date: Tue, 28 Jul 2026 20:37:50 -0700
Message-ID: <20260729033751.131213-11-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260729033751.131213-1-sj@kernel.org>
References: <20260729033751.131213-1-sj@kernel.org>
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
