Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC2929A326;
	Thu, 19 Jun 2025 22:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370441; cv=none; b=ctYRe+w3gC8pZ5nhmD/FRv8B3X3Odxkxqe4kownjhHrjsPYkTSFf8oIuQ3Qq3ciq3zfVBoreCHsfZnIeVbg3NaLT6fQEqNVLyHIAa+oy8I4S4C/NLm3JdekJj26XvT1aZOg68LztJg6Igmewd+LskNQ710sA0g0Jnkcu3l7Q/kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370441; c=relaxed/simple;
	bh=t+FYzdxss4O8PIT6azsMosL7ZC/90ZpCpkaRaenf1iQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QESoRdkM9HE1BFqd7YyIDGPeQwxj4AeJ5aJdYaE34WNS4U5hA33rsX43jdBkdve2J7PmwbgVKuVUYxaFjOz3ftoHqedgWCVlOS/qK50qHXrknzT0EgNfe7/b919ogJokSSKUpIAT6smj7WiZi6n9lRQu+wRiro4wTSH6G6QvKS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mmJIg977; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mmJIg977"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93623C4CEEA;
	Thu, 19 Jun 2025 22:00:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370440;
	bh=t+FYzdxss4O8PIT6azsMosL7ZC/90ZpCpkaRaenf1iQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mmJIg977cWmX1e009jjzG7TfAtvLm92a6f3IH03B27nsJjTQzym3L95Wa+J8Dtzcg
	 ukOa8Nw8tPivP/YCknfL5bK3kkcAbvRm/B+qLYtM0FRMBsp1bp2bzwOvShPcl9g9Lz
	 xhgfVcWfTpTLgeQyhAnSK7lmTw/gygK5vqWBewyKRfQoGho0atHo+o0NgiNOKiqPi/
	 M3eQCCmxlgfDmVb8kXMKezKg0kFCeSPM8pb6UWFbp7m5Sk/adZ7PDpkguFZsaDyd2h
	 02jtx00LHCJYdJqljYakY46PZHOrfM/YPJ4hNp/k7Prq4VF3ZxSRHzur1SLXAub1jG
	 jPe3OJFnFNz+g==
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
Subject: [RFC PATCH 11/11] Docs/mm/damon/design: document DAMOS_QUOTA_NODE_MEMCG_FREE_BP
Date: Thu, 19 Jun 2025 15:00:23 -0700
Message-Id: <20250619220023.24023-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250619220023.24023-1-sj@kernel.org>
References: <20250619220023.24023-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index eb6d3b7d0643..6e1f772006d9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -571,15 +571,16 @@ mechanism tries to make ``current_value`` of ``target_metric`` be same to
 - ``node_mem_used_bp``: Specific NUMA node's used memory ratio in bp (1/10,000).
 - ``node_mem_free_bp``: Specific NUMA node's free memory ratio in bp (1/10,000).
 - ``node_memcg_used_bp``: Specific cgroup's node used memory ratio for a
+- ``node_memcg_free_bp``: Specific cgroup's node unused memory ratio for a
   specific NUMA node, in bp (1/10,000).
 
 ``nid`` is optionally required for only ``node_mem_used_bp``,
-``node_mem_free_bp`` and ``node_memcg_used_bp`` to point the specific NUMA
-node.
+``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
+point the specific NUMA node.
 
-``path`` is optionally required for only ``node_memcg_used_bp`` to point the
-path to the cgroup.  The value should be the path of the memory cgroup from the
-cgroups mount point.
+``path`` is optionally required for only ``node_memcg_used_bp`` and
+``node_memcg_free_bp`` to point the path to the cgroup.  The value should be
+the path of the memory cgroup from the cgroups mount point.
 
 To know how user-space can set the tuning goal metric, the target value, and/or
 the current value via :ref:`DAMON sysfs interface <sysfs_interface>`, refer to
-- 
2.39.5
