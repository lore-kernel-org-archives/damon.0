Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E9199FAB;
	Thu, 26 Dec 2024 22:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735251308; cv=none; b=mVbM53+rc5PgH1DoaFXNBwWSbIzU6lI2t2ME4NCENfnpfCxZTUWXQQjRcE+edU20R6ZwLyhXMxuRSpqix42E9GQYLWXJTkFG4qMjku10xiyFSK+R9j2pv3xjSRHOu75+xtMFeEudphIpW8zia1rT9J41FTZvfhw8XzrDjHL/CR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735251308; c=relaxed/simple;
	bh=0f0Lpal72vM2StRK6no1fT4yLv96CM7EUNHKZOxnDlE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N0Mmtx20Ut4B8xWhdrDPU1TDTP9HDT7AxY8ThdrwGr2LXsYOWu7vuDAyf5S/NCrkIh5sOJPp3vNNOcRcJ4Q6plglWumHXnLlk3ukvYbz64oO9brE07HPGSSzzQH9DXm1w5VPAtKC6QKxazuOegKnmEWtN/ik9LKAf19frG+sP/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RyBTRG7q; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RyBTRG7q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E298C4CEDD;
	Thu, 26 Dec 2024 22:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735251308;
	bh=0f0Lpal72vM2StRK6no1fT4yLv96CM7EUNHKZOxnDlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RyBTRG7qaa8/dvTMhhcXh0+PZx946PmFR323CgbNSzEerJ1xkQT+X3v3GUZHtdewq
	 S2AeFgRWfgiblLpevzE5ynWM+e4IY9n015Bq1o+edkeNioQ0NwUA1oH7YPV6N0KGpO
	 KsOCJaiY7PMTkiM02GUWGCY5CZlCNq30x8d7Bn9gum2FSYqPKpKO/FKt9iHxKFeMur
	 HvxnFxUIyLfB3XPz9cypDj1V5D6pbTTNlrTH3AH9zvCImIiWjwGuw0UPytZtQ01vQA
	 sy8hHGrqZo0YgsxXZRxkN7GsIWIdOREQpJh+ene0uKuwewpcmmwCCm6Mcrh2PcNByG
	 JatB1vN1zjG/A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/10] Docs/admin-guide/mm/damon/usage: omit DAMOS filter details in favor of design doc
Date: Thu, 26 Dec 2024 14:14:44 -0800
Message-Id: <20241226221445.78433-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241226221445.78433-1-sj@kernel.org>
References: <20241226221445.78433-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON usage document is describing some details about DAMOS filters,
which are also documented on the design doc.  Deduplicate the details in
favor of the design doc.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 29 ++++++++++----------
 1 file changed, 14 insertions(+), 15 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index a891e830c2a1..fa8a5e4199b1 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -417,13 +417,17 @@ Each filter directory contains six files, namely ``type``, ``matcing``,
 file, you can write one of five special keywords: ``anon`` for anonymous pages,
 ``memcg`` for specific memory cgroup, ``young`` for young pages, ``addr`` for
 specific address range (an open-ended interval), or ``target`` for specific
-DAMON monitoring target filtering.  In case of the memory cgroup filtering, you
-can specify the memory cgroup of the interest by writing the path of the memory
-cgroup from the cgroups mount point to ``memcg_path`` file.  In case of the
-address range filtering, you can specify the start and end address of the range
-to ``addr_start`` and ``addr_end`` files, respectively.  For the DAMON
-monitoring target filtering, you can specify the index of the target between
-the list of the DAMON context's monitoring targets list to ``target_idx`` file.
+DAMON monitoring target filtering.  Meaning of the types are same to the
+description on the :ref:`design doc <damon_design_damos_filters>`.
+
+In case of the memory cgroup filtering, you can specify the memory cgroup of
+the interest by writing the path of the memory cgroup from the cgroups mount
+point to ``memcg_path`` file.  In case of the address range filtering, you can
+specify the start and end address of the range to ``addr_start`` and
+``addr_end`` files, respectively.  For the DAMON monitoring target filtering,
+you can specify the index of the target between the list of the DAMON context's
+monitoring targets list to ``target_idx`` file.
+
 You can write ``Y`` or ``N`` to ``matching`` file to filter out pages that does
 or does not match to the type, respectively.  Then, the scheme's action will
 not be applied to the pages that specified to be filtered out.
@@ -440,14 +444,9 @@ pages of all memory cgroups except ``/having_care_already``.::
     echo /having_care_already > 1/memcg_path
     echo Y > 1/matching
 
-Note that ``anon`` and ``memcg`` filters are currently supported only when
-``paddr`` :ref:`implementation <sysfs_context>` is being used.
-
-Also, memory regions that are filtered out by ``addr`` or ``target`` filters
-are not counted as the scheme has tried to those, while regions that filtered
-out by other type filters are counted as the scheme has tried to.  The
-difference is applied to :ref:`stats <damos_stats>` and
-:ref:`tried regions <sysfs_schemes_tried_regions>`.
+Refer to the :ref:`DAMOS filters design documentation
+<damon_design_damos_filters>` for more details including when each of the
+filters are supported and differences on stats.
 
 .. _sysfs_schemes_stats:
 
-- 
2.39.5
