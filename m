Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A005333457;
	Fri, 17 Oct 2025 21:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760736436; cv=none; b=B+RSOw5xuTZ40I2zralDUbEp3VzJmjB5YPGCGA+fIvow3CM135X2rpqm8VbOe2kCQVaajVlJfyiPQpIqS/tmid2DyYmTZE2oHQ0XvUZ7SLQW6VCn5UKKaNGdeSQunQyKLRzF6Hx+G8tfHU34eMkqPIqPFrk6ehQB8MRQEAIaZXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760736436; c=relaxed/simple;
	bh=host/mbZFT4OeHnIo2pSXmMweFfCPczlM3sHm3V1brI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qi/juGrYMwp1A9aNSIQiLQNUZF2kEyKGvaUd257kzfrWxqGqg1ov/+Gm+4Op16XCe8EmKkfZMvaSzm+s+D3i7K9o0pZoZ2w9Z6pTW7GRKXnWDtzhCfgnxVGFnV/5Km8ymyAZvwGJ/j2k7Ut+zy+yGDqp9IPOfmZGtKtkNEkUVW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BmDnI+Zp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BmDnI+Zp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB1FCC4CEE7;
	Fri, 17 Oct 2025 21:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760736436;
	bh=host/mbZFT4OeHnIo2pSXmMweFfCPczlM3sHm3V1brI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BmDnI+ZpiNNPmsjHtEWSkv9ZcnwkWPozf2psauxop1e/pHt9eWGb85ceQ5fkLGlX6
	 LIbfkJ7IHB5rCN4/zZf3L8XpvpH6dGudQ9YXrd04Q5Shsz0yeSckPtbCpw6DLPdSLG
	 H2qgY2WsgsBlxXvsjsfgfLtBt82eEn9Fij+ojuhTkbZRY4ltkmaLB6BZ35rGL7q1WB
	 C77fXR7MQQMUZXq2aQevv7rTEtHZ8s0oxMZ6iQ5Dy2w1AjDYgiKBgAp886W74lLGnc
	 NjXCWCZqBmVSC351gDh7hTNUJhvmXqDbrwHvQnDjAW3vs/+r5lbUMtwyLRpzwMyV7e
	 iKQAsRf2zB57g==
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
Subject: [PATCH 09/10] Docs/admin-guide/mm/damon/usage: document DAMOS quota goal path file
Date: Fri, 17 Oct 2025 14:27:01 -0700
Message-ID: <20251017212706.183502-10-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251017212706.183502-1-sj@kernel.org>
References: <20251017212706.183502-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A new DAMON sysfs interface file, namely 'path' has been added under
DAMOS quota goal directory, for specifying the cgroup for
DAMOS_QUOTA_NODE_MEMCG_{USED,FREE}_BP metrics.  Document it on the usage
document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index eae534bc1bee..98958975604d 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -81,7 +81,7 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`quotas <sysfs_quotas>`/ms,bytes,reset_interval_ms,effective_bytes
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
-    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid
+    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
@@ -402,9 +402,9 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each goal and current achievement.
 Among the multiple feedback, the best one is used.
 
-Each goal directory contains four files, namely ``target_metric``,
-``target_value``, ``current_value`` and ``nid``.  Users can set and get the
-four parameters for the quota auto-tuning goals that specified on the
+Each goal directory contains five files, namely ``target_metric``,
+``target_value``, ``current_value`` ``nid`` and ``path``.  Users can set and
+get the five parameters for the quota auto-tuning goals that specified on the
 :ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to and
 reading from each of the files.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
-- 
2.47.3
