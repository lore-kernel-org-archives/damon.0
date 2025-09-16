Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7D2244662;
	Tue, 16 Sep 2025 03:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757993032; cv=none; b=JoZ/sHayiJkmQak2ZpI/R0BqA0BOmCTIuDqEVQ8kyFj4JMRP7UOoqW3ztV20qB5uf5b4nlQ/NHxfBA2NhEUTh8TBM49CH5svF/tYGamuzzI6WSMRAl/B0AEdhzXf7tLraCtSmpds8Ues2Fqp8sHYCPXP9Jy7dUt2TdudJQD1CYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757993032; c=relaxed/simple;
	bh=DAVCpI32krZKX7tAL5BJ72tG+a8Y+Yz9N/KNa3xRsxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tTC3TnZeAQWqqC5iAS5MurhfJHI4bIgN+Go5R//QqTk+cGXvJAMar7r9P8vfB9ZVGmVJPH12oOYCF3gqBYogzfj38Ts4FoNdidG5je95f7iLAEf87/g/TX0Kdo5EFSbzXmt3kXfdHKppQ6mrgw5Hrg7Y4tUw7dapYtx2vwh7XsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i4Nmk5U3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i4Nmk5U3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53638C4CEEB;
	Tue, 16 Sep 2025 03:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757993031;
	bh=DAVCpI32krZKX7tAL5BJ72tG+a8Y+Yz9N/KNa3xRsxs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i4Nmk5U37Se2bVXNDzuQr/oiHDccCxrf9fN6IsCMWBKY63wqNk95ZvhqhP7xi89vj
	 Wq8IuCZdE8CmNM4Cii2P9RlDqQdDy6QHOmIeesAHvXzJLeonmU25Q2rKBKYfyTOUKV
	 +Zs9jbjOhs+E9NMS6EuMCn8d8u06drs2oLB8d+vjF+QJtYjfjkQBzANM8fNKw8+CIa
	 KYnAntJepUi/pjD3uMSi02Qr/vONl1l3CCJMm9L83jBLwII/XaNNz83Q1ZMiDWuoue
	 X0zQL/T9r6f83n4+Q7f+v2jcJ8WMn62gpZiQLIAjdMEnhOAeQK4euxR4NWGP2Vj6SB
	 6DMFzMBAmh/yg==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2 4/5] Docs/admin-guide/mm/damon/start: add --target_pid to DAMOS example command
Date: Mon, 15 Sep 2025 20:23:38 -0700
Message-Id: <20250916032339.115817-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250916032339.115817-1-sj@kernel.org>
References: <20250916032339.115817-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The example command doesn't work [1] on the latest DAMON user-space
tool, since --damos_action option is updated to receive multiple
arguments, and hence cannot know if the final argument is for deductible
monitoring target or an argument for --damos_action option.  Add
--target_pid option to let damo understand it is for target pid.

[1] https://github.com/damonitor/damo/pull/32

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/start.rst b/Documentation/admin-guide/mm/damon/start.rst
index ede14b679d02..ec8c34b2d32f 100644
--- a/Documentation/admin-guide/mm/damon/start.rst
+++ b/Documentation/admin-guide/mm/damon/start.rst
@@ -175,4 +175,4 @@ Below command makes every memory region of size >=4K that has not accessed for
 
     $ sudo damo start --damos_access_rate 0 0 --damos_sz_region 4K max \
                       --damos_age 60s max --damos_action pageout \
-                      <pid of your workload>
+                      --target_pid <pid of your workload>
-- 
2.39.5
