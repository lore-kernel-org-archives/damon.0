Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A3C534405F;
	Tue, 16 Dec 2025 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872111; cv=none; b=l0uNwLaH+ZxC6QVfgCyyH1m4dwr6iL99I8OhMi7KeaO57zbwRhY08f52Q1JjrysIhrBMvyyAMdYspLu6ZPnbCdpKmWp+jJ5NRJQGUuaMCOtXRcApjDot2DsI9XKE2g8OvKRRAEg9Ij3ttbCdujiEpOZrpynvbpVc/ZcsR2H+AmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872111; c=relaxed/simple;
	bh=MfosQBkwjx3KXwTbjhH363GcqS+Z5CKxnOYfPNTR2Lk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOQaGCHgEsybi6ghrGW7NoDII7GkJa57X3OjHTcC0EzHQn8RgPRjmUIj/WZnk+8rD4uiyOcXmNIfufzq+m8n+qwpF7eumnWYUG8s45E89hivx8sOemwkXY8jEb10y6bWQNwQm2HzwiHLF5TM1Lf301tmsEogxCSlVrRISV8CxDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OUovyuT8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OUovyuT8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98C3CC16AAE;
	Tue, 16 Dec 2025 08:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765872110;
	bh=MfosQBkwjx3KXwTbjhH363GcqS+Z5CKxnOYfPNTR2Lk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OUovyuT8mOWNSj4yBidcsIzNj9345lnE+QWR6NN/1cp+78PiaMHSKntKB4eWVztv0
	 YBsHoM48j0YwPPN9Cil7XAGCBea1pKyyLJH7NfpxBEvgqUmGqY6Iw/HW53TPSDVAWl
	 5ZdTNeH13QCxHB8EBCCV+vm/vCoREFLHCpdyY2/qVXt2RzUBR/Im6gEVaguHPi4ca1
	 bZIiBYWMV0a1ZcWj15fxab4wbwz8vwvQismPblVbHeNcgqirO8ZYUP0A7klHYEVNf/
	 dkE+hZYhDFbs48fiB8PmEEtmz8YkxrHAVct9XC2XJ+2Pw30eINbUCRG6ADr8FgoRl0
	 GLTNY6qvVlnww==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	David Hildenbrand <david@kernel.org>,
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
Subject: [PATCH 04/12] Docs/admin-guide/mm/damon/usage: update for nr_snapshots damos stat
Date: Tue, 16 Dec 2025 00:01:17 -0800
Message-ID: <20251216080128.42991-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251216080128.42991-1-sj@kernel.org>
References: <20251216080128.42991-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update DAMON usage document for the newly added damos stat,
nr_snapshots.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 9991dad60fcf..d0944bd78964 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -87,7 +87,7 @@ comma (",").
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
     │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
     │ │ │ │ │ │ │ │ 0/id,weight
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds,nr_snapshots
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
     │ │ │ │ │ │ │ │ ...
@@ -543,9 +543,9 @@ online analysis or tuning of the schemes.  Refer to :ref:`design doc
 
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``,
-``sz_ops_filter_passed``, and ``qt_exceeds``), respectively.  The files are not
-updated in real time, so you should ask DAMON sysfs interface to update the
-content of the files for the stats by writing a special keyword,
+``sz_ops_filter_passed``, ``qt_exceeds`` and ``nr_snapshots``), respectively.
+The files are not updated in real time, so you should ask DAMON sysfs interface
+to update the content of the files for the stats by writing a special keyword,
 ``update_schemes_stats`` to the relevant ``kdamonds/<N>/state`` file.
 
 .. _sysfs_schemes_tried_regions:
-- 
2.47.3
