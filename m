Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 137A43E63A8;
	Tue, 29 Sep 2026 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790668900; cv=none; b=aie5+VM0byDPw5Lf9weUgIYkNfrZdM5FEqsOzGIUwlqynTfRYeeGOok3Z9I5uhZcr76bswGXSFLoOWIrJ4wYKXz0+6x1ZYm/Ko+ZKV/xVHYHIy2DOnxQCmOMUoWHrwwtdlbFO13j9lGKp3slF0F/edwpdGzduXJNVw2ZhD+WNAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790668900; c=relaxed/simple;
	bh=gZY0WC5GuA2NKx7eNcJuwSntEMh4sHKln3KfjzFkkBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CNrUlV2mzDUpKYH7rkSfcLIcNxLaCcvEFcSKCD3AsaXNG5v9oAXPP2HQFQSi5Zp9YIQ1x/c5v5zODT9M749wqgF3JSJEywrB98ku1TEnMEsSF6hcsUXBu0Eb55XN3LpPxfZlhFRfLcicWuOlV175d7jHNG7Ak/sE+cErXy/fHsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lGFYRwab; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lGFYRwab"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE661F00893;
	Tue, 29 Sep 2026 08:01:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790668898;
	bh=E1gVvDIreHP8ao0G8tKQqDlYq/j2WrsMakNo62d+qXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lGFYRwabYvUuJtk5Cjp2rfA8d7hpEVAuAPyF5FvMTlSaYv5oZ6dTwftRo9F9UkP8P
	 dY2J9oRTYT5YgnNAfqtUBLJfJjNJIl0SbBbLSvwzW3c39wqBybnJX16YU7wFltctqt
	 +f+6bzutPKhZgwaumNUZ9Hx5jang7R8sUT7+r7xRsrP0gAq1twO9BSJKNqt99FFc5Q
	 ro3gm5uNaMEmtZjG52gpS0QBLFj3wKaBEHrCD8gOgiHmW8JkKwuYFtLUht3kLm9z+o
	 rSUZ7O9l4sPW0xmel1oGsWTL5c07Vz76/jhpcMlud4xAq9JrUk5gszynHu82H3/7Bl
	 2q2cvhSLXqDzw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
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
Subject: [PATCH 7/8] Docs/admin-guide/mm/damon/usage: update for quota goal complement file
Date: Tue, 29 Sep 2026 01:01:10 -0700
Message-ID: <20260929080113.41708-8-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260929080113.41708-1-sj@kernel.org>
References: <20260929080113.41708-1-sj@kernel.org>
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
