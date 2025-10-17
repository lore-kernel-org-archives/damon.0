Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B495333445;
	Fri, 17 Oct 2025 21:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736436; cv=none; b=XpbXytbkBz8xhRp9Wty5ynu8QZzwAMacHoEOm4eni1aRTUlO8K9sA/ATdhMcxbm7PAAJ/8SlHFLsm/InihU9M+QnsvMmW1bZbwYjvRtaIrn+TfGEyz6E1WL3VfOV/LJDOWHHzVWJ0USSKBYlVYPh+yGcTwPuHV8UzJYC7O6yZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736436; c=relaxed/simple;
	bh=V8w4yj3tuugTS097FYP8SAgCD/yVrkYxTz+kNf50q2M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kcl3+stvo8cel+ZlSnjE9zoMvCV2XYC4PuAADpRKNNoyfHPegntdhfSdxsRtPbpoX1PpZmIOj6rlprGn0mA+Hj9fZMKOI9kqE2629RPdpMeoRPrcJllVgT45RMJCtUDByJp+4wwALRVm+0C0n5Vr6+qY19NsmTxtpjXsqe6GsDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UT5NK01b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UT5NK01b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93F48C19422;
	Fri, 17 Oct 2025 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736435;
	bh=V8w4yj3tuugTS097FYP8SAgCD/yVrkYxTz+kNf50q2M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UT5NK01b01kbT+h4k/RxowBNijmS1AZgQgKRn0oY4+Cj6DOeCy/eMAxD5PxbcvhIE
	 cIrRcdBvbtP2/FeCXIDZQEd86C3FcIwm/0BsO/TTnKI8sRhFxlJV4mAkiMvRgwtt+q
	 1m2LpO6u6oFoLbQHqM5MHvOOB3Qji1Jor9OUACyQQEM26LiQpqtHo1t3khjE9Zlav/
	 ACJoV+jM+tNKWdt53CBsEX0zYMvxfNFo93Yh0BrGrxhmGjoUw+VGafcXKRDaZw7fhx
	 2FJ0tD8RIv4wyDll8MJDNRIMea3z3/LMaqupsn38mV3FqsFHz5OMQbPCfZV4JlxcE0
	 Wf43xP425Iowg==
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
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 08/10] Docs/mm/damon/design: document DAMOS_QUOTA_NODE_MEMCG_{USED,FREE}_BP
Date: Fri, 17 Oct 2025 14:27:00 -0700
Message-ID: <20251017212706.183502-9-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update design doc for the newly added two DAMOS quota auto-tuning target
goal metrics, DAMOS_QUOTA_NODE_MEMCG_{USED,FREE}_BP.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 21 +++++++++++++++------
 1 file changed, 15 insertions(+), 6 deletions(-)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 80354f4f42ba..b54925ea78e9 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -564,9 +564,9 @@ aggressiveness (the quota) of the corresponding scheme.  For example, if DAMOS
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
@@ -581,9 +581,18 @@ tries to make ``current_value`` of ``target_metric`` be same to
   set by users at the initial time.  In other words, DAMOS does self-feedback.
 - ``node_mem_used_bp``: Specific NUMA node's used memory ratio in bp (1/10,000).
 - ``node_mem_free_bp``: Specific NUMA node's free memory ratio in bp (1/10,000).
-
-``nid`` is optionally required for only ``node_mem_used_bp`` and
-``node_mem_free_bp`` to point the specific NUMA node.
+- ``node_memcg_used_bp``: Specific cgroup's node used memory ratio for a
+  specific NUMA node, in bp (1/10,000).
+- ``node_memcg_free_bp``: Specific cgroup's node unused memory ratio for a
+  specific NUMA node, in bp (1/10,000).
+
+``nid`` is optionally required for only ``node_mem_used_bp``,
+``node_mem_free_bp``, ``node_memcg_used_bp`` and ``node_memcg_free_bp`` to
+point the specific NUMA node.
+
+``path`` is optionally required for only ``node_memcg_used_bp`` and
+``node_memcg_free_bp`` to point the path to the cgroup.  The value should be
+the path of the memory cgroup from the cgroups mount point.
 
 To know how user-space can set the tuning goal metric, the target value, and/or
 the current value via :ref:`DAMON sysfs interface <sysfs_interface>`, refer to
-- 
2.47.3
