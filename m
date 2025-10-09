Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A9B287268;
	Thu,  9 Oct 2025 21:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760044859; cv=none; b=eGuGCHz7ykpd6deWnEoW0nWGK7Pi7/KbQZi53ge1+HY/CFyVznxhoAq2nCzveyipcX0B3iOr9T4PmNbuvncLtn2S9TpQ70tTNH0kTb7azzO2g9xQ2Xy/UfB9jmqzSSUofXb2kKNGGCZH8Z98LGDxKYFyMv9amTRvwz3TYAWFUF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760044859; c=relaxed/simple;
	bh=c3w+jGZIkcFz1bj37NYQVYFms2ZoPQQJjnr1dqcqrzk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m7UfycnvHk+pnSyr9ZKVIY1YWpIhgEONXgkt3o+znfljbobhqSIaDH4x3frN4f48PvIcgoRveHoFJlyILDgYwa9aZSUQcBxCb+4km5OeK6SxlMR1d4gaG0EuC8APwjeeYhAunYldIGiMBZiHUBENLdEiYOCe7/s5nL4ezamPc/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iwiq+z9N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iwiq+z9N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C657DC4CEE7;
	Thu,  9 Oct 2025 21:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760044859;
	bh=c3w+jGZIkcFz1bj37NYQVYFms2ZoPQQJjnr1dqcqrzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iwiq+z9N7k5zhBrw09Vtp1n2Tn6BSsrEl88mOt1tkYea/S5Gz33b45jExVLY/CrKj
	 pKuxINooLI4m/Lv8IX31vpMCFI6OjKRvt1RipEAUWpm93fEcMIQBBE/EtMWE0I7bov
	 hWbb8JxfaqLO8xWEJhFkDQz/C2WMrL0vwBHMZ/EEGKOABodFzOhqvN0UVon0AeQhWJ
	 lMxPpTDHRwBUwTBRS0t1DjxHlTGsFWHSA0pvijHwK7i2bUsHTFo7+G8UJanNqTjhNC
	 DAuW/Z7juLiVu5Mx45odTE4zN156Qf1tGcAEl8yylYfE0IN4CEhNeK3G9+nNJOM9ZS
	 2EZkYzxQ3ns7w==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: [RFC PATCH v2 09/10] Docs/admin-guide/mm/damon/usage: document DAMOS quota goal path file
Date: Thu,  9 Oct 2025 14:20:41 -0700
Message-Id: <20251009212042.60084-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251009212042.60084-1-sj@kernel.org>
References: <20251009212042.60084-1-sj@kernel.org>
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
2.39.5
