Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A9283ADBA2;
	Fri, 18 Sep 2026 14:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789741721; cv=none; b=GONE6z5y9e1Qw5Pld99aEbBf0ywmZXqV+y6zAuX+6aGu4tdoqcUEiDI+royTQW1vMU+kT8hP2DA+vVc3Y3ua/J2B4lgCIa+YaIozepnmegDfeTuPOGJNoS/jsZ/QHKEEMJEJiTOYRjFRLz63Wd9/9aPRHsfk138TJk79YcqqOjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789741721; c=relaxed/simple;
	bh=gvWivKJrBcvzrhXEPZl+KFvgVzhjqhYKz1YE68nQPT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g14IGNgr74Qvc2oX6pvudDWOfQu759DMRJ5mlXp6n92vN6eHEIcKPN6/oXcWuF4jbEzUEFyKOOiDqOwqAUwQphJIVvvCK9u+oxiHmyuFgnOqKBH61uqMjJs6lLVE+o3Le0guik8Ty8lMdg7ZUHG8zNlUyCg/QxbntgNsKXdcOJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SEUWR5a/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SEUWR5a/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C357E1F000FF;
	Fri, 18 Sep 2026 14:28:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789741718;
	bh=Bt0Ss6VwiTdxRd8z9BHv5kIasgwcGn+W/TUI9MdlD/0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SEUWR5a/rmlvytL1rFznwx3B2avdQl+r+GOMSLRlO0dkl8R1MFZqT00Tucd4QulRg
	 BX2Wc2aElZ0hFss7sHihs4M6J87ArZ2MHySM1nz3RlU0qzTIsla7LL5t4j+WiF2Rkb
	 GaH9bQ/oeWwp+2MqfeLRFwNigMfou5vQRwFpjrn1IvGuPA7avaheYo1dL66zFSk0vm
	 6xzjYBIL+C1jJsb0HB4CCuEvvgoNdw9GBhly9YK18zwtdwoYzACm12jVVraE5l4bNe
	 yB0LPwO9N5xTpnzFFRitXW3ZmCJK8qkUsgF7a6J7A0gsomXWJUUBFE2fgN/boJI9oe
	 ZYyp1P7dNrUTg==
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
Subject: [RFC PATCH 6/7] Docs/admin-guide/mm/damon/usage: update for quota goal complement file
Date: Fri, 18 Sep 2026 07:28:25 -0700
Message-ID: <20260918142827.85303-7-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260918142827.85303-1-sj@kernel.org>
References: <20260918142827.85303-1-sj@kernel.org>
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
 Documentation/admin-guide/mm/damon/usage.rst | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index ba47255448564..b3f2e591fb7e4 100644
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
@@ -493,11 +494,11 @@ to ``N-1``.  Each directory represents each goal and current achievement.
 Among the multiple feedback, the best one is used.
 
 Each goal directory contains five files, namely ``target_metric``,
-``target_value``, ``current_value``, ``nid``, and ``path``.  Users can set and
-get the five parameters for the quota auto-tuning goals that specified on the
-:ref:`design doc <damon_design_damos_quotas_auto_tuning>` by writing to and
-reading from each of the files.  Because the kernel does not update
-``current_value``, reading it only makes sense when ``target_metric`` is
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
