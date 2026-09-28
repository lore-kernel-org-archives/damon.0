Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2A9D48FF82;
	Mon, 28 Sep 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790588051; cv=none; b=XWyiebWMHnkuTubkSSq1EMvPAxuVFhYVO0gRd/oneNMOBhYNNWnbgYVoqE4ipIf9o/5QMM262BLIyZHr+nYl9l2Up6u9BhM8aFRK8M00PadbMHZ5i1OvaqwGhlXjfyRxCGvKTJk1AZkFHRJLV1G6qJgjwJkw9UL78AwdotwzUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790588051; c=relaxed/simple;
	bh=gZY0WC5GuA2NKx7eNcJuwSntEMh4sHKln3KfjzFkkBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=edqsT9qUDuqQc9pxopxb7LnFhykSsZZD5QSo7dalAEXe7pmcnin9sxV2cN0q2hhjFCIMoXz8eew+eczkxi9GcgyNsf5uSiWgxOInHf/dWi3Fm1uMkdfYqynjKgKdZSkc3ZmpMvNIWC1uBYWHgjufLzoMSKkeFWvX4SAoiWIc1ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N0E02JoM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0E02JoM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560931F000FF;
	Mon, 28 Sep 2026 09:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790588050;
	bh=E1gVvDIreHP8ao0G8tKQqDlYq/j2WrsMakNo62d+qXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N0E02JoMH3PkLl6vfJjQIv/qRCFJeRXyUWyaMhsLe8Lf0M54ozhhKT0zfuzkSsacq
	 thmbBSFwAt4ZgGdjOCWYFgo25dhHtb3SMicMPvB05mOcfh3T+Sz09IfmFv6ex1zgpo
	 b2+e+Ovm7CM2tiZ0qrcGsTStwvQTHG427fnoVF54tDF1+GgVch6DK6792BnFjOWcXV
	 G0DxeYgSfNgHGOvxMzdVKCkoIzK7yr2vKc0l6hXhD7xH6zRVR9fEw8L1kKNiZzAq4m
	 y7SQSXNB1ER3U+EqQxwz6TMp/S8kHwGPjCA93MDQ7ziT9vYn+OA65VzORMfEP89nDh
	 zrkWzrOZqevoA==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v5 7/8] Docs/admin-guide/mm/damon/usage: update for quota goal complement file
Date: Mon, 28 Sep 2026 02:33:39 -0700
Message-ID: <20260928093342.16584-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260928093342.16584-1-sj@kernel.org>
References: <20260928093342.16584-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added quota goal metric
complement sysfs file.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index ba4725544856..3d43954c7046 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -98,7 +98,8 @@ comma (",").
     │ │ │ │ │ │ │     fail_charge_num,fail_charge_denom
     │ │ │ │ │ │ │ │ weights/sz_permil,nr_accesses_permil,age_permil
     │ │ │ │ │ │ │ │ :ref:`goals <sysfs_schemes_quota_goals>`/nr_goals
-    │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value,nid,path
+    │ │ │ │ │ │ │ │ │ 0/target_metric,complement,target_value,
+    │ │ │ │ │ │ │ │ │  current_value,nid,path
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,damon_target_idx,min,max
@@ -492,12 +493,12 @@ number (``N``) to the file creates the number of child directories named ``0``
 to ``N-1``.  Each directory represents each goal and current achievement.
 Among the multiple feedback, the best one is used.
 
-Each goal directory contains five files, namely ``target_metric``,
-``target_value``, ``current_value``, ``nid``, and ``path``.  Users can set and
-get the five parameters for the quota auto-tuning goals that specified on the
-:ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to and
-reading from each of the files.  Because the kernel does not update
-``current_value``, reading it only makes sense when ``target_metric`` is
+Each goal directory contains six files, namely ``target_metric``,
+``complement``, ``target_value``, ``current_value``, ``nid``, and ``path``.
+Users can set and get the six parameters for the quota auto-tuning goals that
+specified on the :ref:`design doc <damon_design_damos_quotas_auto_tuning>` by
+writing to and reading from each of the files.  Because the kernel does not
+update ``current_value``, reading it only makes sense when ``target_metric`` is
 ``user_input``.  Note that users should further write
 ``commit_schemes_quota_goals`` to the ``state`` file of the :ref:`kdamond
 directory <sysfs_kdamond>` to pass the feedback to DAMON.
-- 
2.47.3
