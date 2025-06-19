Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 131C52951BA;
	Thu, 19 Jun 2025 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750370437; cv=none; b=f/a0EVDanJQIJjvyK5CMMn51MshpL9lgCEHZ8FkjRg/RL2j1iK8hq+15aLDIWcBd1xTgoORSVTVoszjN0669lLcfIA7SxitysggGCSumegcTVmc/4gq0yWvXKLce/K2K9s0Kyn+v17uEAVUgW1tB2zi4GHk3ZeerVmS8cOjVE3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750370437; c=relaxed/simple;
	bh=mKWAyXf0fhqfpjFolQB3dWnDHH2ABS2xQxltFWbhL9Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NjFuy8cJwZp9LojGGkaOebxCBDBFbrhBEVNLANFzaU7M5+/xfIXNUZRToWhgs6Luuftn2sk5gkNHGtXca18x616jZQ/Fr+ZMM4NhsnfDe80EkEG4AM28UT+p4us7oAey3BBZ4/SXWmYE1BpQdDhHK5ViTnNYJQoVCq6qDukVCzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cakvDxr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cakvDxr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A362C4CEF1;
	Thu, 19 Jun 2025 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750370435;
	bh=mKWAyXf0fhqfpjFolQB3dWnDHH2ABS2xQxltFWbhL9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cakvDxr1OyYgAtKoMJIZscdHNiK6lfpkPs8Cg2Z+zf54e+TuOPWXYQW4b/s8kmFJ6
	 CY5lhuiXnvghjEbIDaDHBSHTSnmj5q6I2nutSdl2LrOrfklBMDf+z0HeusEQE9g+Bj
	 P9QWTUz7K+WbpDIkbfNkxAIaXJbsL47EroH1MdUvqpd4+j6wAbp/+0NTnw5egaaYn9
	 Fy1NsdPrt2RumgOeNINGGO8ywv22HTyQ1/J+iZ0TvksQDCou1LAhToJ5gP3VFWG+oj
	 th2BSMgshRLEkZateM7dsNZcrN5fgQ6IzbxUI1Z9tQ5eon287c+ATPLdnfEoH7acuX
	 Kd0nk8cATvkCw==
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
Subject: [RFC PATCH 06/11] Docs/mm/damon/design: document DAMOS_QUOTA_NODE_MEMCG_USED_BP
Date: Thu, 19 Jun 2025 15:00:18 -0700
Message-Id: <20250619220023.24023-7-sj@kernel.org>
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
 Documentation/mm/damon/design.rst | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 2290ebefc648..eb6d3b7d0643 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -553,9 +553,9 @@ aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
 is under achieving the goal, DAMOS automatically increases the quota.  If DAMOS
 is over achieving the goal, it decreases the quota.
 
-The goal can be specified with four parameters, namely ``target_metric``,
-``target_value``, ``current_value`` and ``nid``.  The auto-tuning mechanism
-tries to make ``current_value`` of ``target_metric`` be same to
+The goal can be specified with five parameters, namely ``target_metric``,
+``target_value``, ``current_value``, ``nid`` and ``path``.  The auto-tuning
+mechanism tries to make ``current_value`` of ``target_metric`` be same to
 ``target_value``.
 
 - ``user_input``: User-provided value.  Users could use any metric that they
@@ -570,9 +570,16 @@ tries to make ``current_value`` of ``target_metric`` be same to
   set by users at the initial time.  In other words, DAMOS does self-feedback.
 - ``node_mem_used_bp``: Specific NUMA node's used memory ratio in bp (1/10,000).
 - ``node_mem_free_bp``: Specific NUMA node's free memory ratio in bp (1/10,000).
+- ``node_memcg_used_bp``: Specific cgroup's node used memory ratio for a
+  specific NUMA node, in bp (1/10,000).
 
-``nid`` is optionally required for only ``node_mem_used_bp`` and
-``node_mem_free_bp`` to point the specific NUMA node.
+``nid`` is optionally required for only ``node_mem_used_bp``,
+``node_mem_free_bp`` and ``node_memcg_used_bp`` to point the specific NUMA
+node.
+
+``path`` is optionally required for only ``node_memcg_used_bp`` to point the
+path to the cgroup.  The value should be the path of the memory cgroup from the
+cgroups mount point.
 
 To know how user-space can set the tuning goal metric, the target value, and/or
 the current value via :ref:`DAMON sysfs interface <sysfs_interface>`, refer to
-- 
2.39.5
