Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1662367D0;
	Wed,  2 Jul 2025 05:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751433373; cv=none; b=quiN9/GkbmrdBLiG5HxfVoZLvKMZ25J6LkCO+DBwthlAEnfzPI4xijQQrtWC0kq1Zdv36lKhjBWt1gR4cBLN1mQa30smRatgcTH21suWYTtfavqk2dbA9At6O1IWYKuGZl8gfzl/Q7XPxj5NrmPga5pSCqzNGAPaHaderPxF4rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751433373; c=relaxed/simple;
	bh=4kBKgmAO4np7zdvd9JkbBqwwr9+oQ8UOuTjsr0PkuTc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U+2yNVbRb9eLM+1XaGQsHMV9cjrTgGazOvaZLR/PgrBfZHeiGqi4SPmRL2y/fxKUvuXpyMcwHh1JDUX0n1T80uPUO1kANFZXD5XCSGyRUDW2Z8jfe7pSHlSy/XPfPhZNCv3fWv4HzuCtGjbnn9bKiseWm4gKCIivYTCeKyEmw34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oVPJBL6H; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oVPJBL6H"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17ED5C4CEEF;
	Wed,  2 Jul 2025 05:16:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751433373;
	bh=4kBKgmAO4np7zdvd9JkbBqwwr9+oQ8UOuTjsr0PkuTc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oVPJBL6H2dNgRxmRll33awS9kIJXspDmEAxzkNfDreiYt4TeHAsJVn72hjGbDePNK
	 SV4p3RN231tMEmgmYqZ0HbCTfxn2XmkmwjoqQSv9qpctWq4jIJ7UKgGILJmLFslw5n
	 2Ysw1kYabYPvMt0UjL3Ps86Tb6WG9yFJo2vrNvhwQ11u3IBA9GVWRaXsmpKddQipSV
	 sz23UEo0yKVAnfNUtTsj0hk1cb/Wxe4z0qrFoQDCR8SVk26tJhmOxNL2p1QAi4N9Fu
	 iEQA2UlFiVTadpVXLNzLt72yKp//XUTtNOt4GWw6Ibm76FsYahQYL3Ad9Wgm2Sidlq
	 bajLNmlx3F7aQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Bijan Tabatabai <bijan311@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v2 6/6] Docs/admin-guide/mm/damon/usage: document dests directory
Date: Tue,  1 Jul 2025 22:15:58 -0700
Message-Id: <20250702051558.54138-7-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250702051558.54138-1-sj@kernel.org>
References: <20250702051558.54138-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the newly added DAMOS action destination directory of the DAMON
sysfs interface on the usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 33 +++++++++++++++++---
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d960aba72b82..fc5c962353ed 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -85,6 +85,8 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`{core_,ops_,}filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx,min,max
+    │ │ │ │ │ │ │ :ref:`dests <damon_sysfs_dests>`/nr_dests
+    │ │ │ │ │ │ │ │ 0/id,weight
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
@@ -307,10 +309,10 @@ to ``N-1``.  Each directory represents each DAMON-based operation scheme.
 schemes/<N>/
 ------------
 
-In each scheme directory, seven directories (``access_pattern``, ``quotas``,
-``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``stats``, and
-``tried_regions``) and three files (``action``, ``target_nid`` and
-``apply_interval``) exist.
+In each scheme directory, eight directories (``access_pattern``, ``quotas``,
+``watermarks``, ``core_filters``, ``ops_filters``, ``filters``, ``dests``,
+``stats``, and ``tried_regions``) and three files (``action``, ``target_nid``
+and ``apply_interval``) exist.
 
 The ``action`` file is for setting and getting the scheme's :ref:`action
 <damon_design_damos_action>`.  The keywords that can be written to and read
@@ -484,6 +486,29 @@ Refer to the :ref:`DAMOS filters design documentation
 of different ``allow`` works, when each of the filters are supported, and
 differences on stats.
 
+.. _damon_sysfs_dests:
+
+schemes/<N>/dests/
+------------------
+
+Directory for specifying the destinations of given DAMON-based operation
+scheme's action.  This directory is ignored if the action of the given scheme
+is not supporting multiple destinations.  Only ``DAMOS_MIGRATE_{HOT,COLD}``
+actions are supporting multiple destinations.
+
+In the beginning, the directory has only one file, ``nr_dests``.  Writing a
+number (``N``) to the file creates the number of child directories named ``0``
+to ``N-1``.  Each directory represents each action destination.
+
+Each destination directory contains two files, namely ``id`` and ``weight``.
+Users can write and read the identifier of the destination to ``id`` file.
+For ``DAMOS_MIGRATE_{HOT,COLD}`` actions, the migrate destination node's node
+id should be written to ``id`` file.  Users can write and read the weight of
+the destination among the given destinations to the ``weight`` file.  The
+weight can be an arbitrary integer.  When DAMOS apply the action to each entity
+of the memory region, it will select the destination of the action based on the
+relative weights of the destinations.
+
 .. _sysfs_schemes_stats:
 
 schemes/<N>/stats/
-- 
2.39.5
