Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE8721E25FA;
	Mon,  6 Jan 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736192059; cv=none; b=lTmeXBhcEYAC2umLxnv4Yqy+0KTy8Ug1YC31gwtsQMSLncC3xf+jFCYJ12awNOBuPL2Fv/5id2YOT5oTDyFwRiQ+Kmmb9IyqodSso+a6CM+JHJQMdyz3KZ1cUqDA4sF3Rx2+N157kgUbWq0lB3niv/8D7Va7YLMODXappWnuIcY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736192059; c=relaxed/simple;
	bh=/5ferqdIUHJtb9RUNwfrb+SM/R7GDkwn6D3djVY4NbA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=M36mw3PV20oKeCnma3yshc8BkhCVLsx+YPCMydLPp4dea93B52EMW58Ca4cYg5eTKH7NVZCxEyB2p46jjg1bFSqQjXy/k68HESgiFOQVZzatN+5izNrqwB75EX2eCyONaMMraMdgaRJeEg+xXvL9fk7ugCtk8c5zJfZsBQfzd2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sxC7kO10; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sxC7kO10"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EBE4C4CED2;
	Mon,  6 Jan 2025 19:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736192058;
	bh=/5ferqdIUHJtb9RUNwfrb+SM/R7GDkwn6D3djVY4NbA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sxC7kO109urARAN/IKaIe5KGU3QthanXoODO6MLv0hb+ybBedxofLTMJ8e1RvRgDf
	 5b94o5op7f+O+m8QwnMLLB9wYjuRNf+pmiQHyP/efPt/KnXwyqckrxNreR5NdWAVom
	 by4llLLglMagZmsZeM+0kom2SmvHWhPaLRSf4W0/w1XsVy0vMXsi3a9AmWCNbu+Arf
	 pBbMfHZCAVzNbNPnSEjUvrNKn77N2uUj/aPIFglFYrclCTN/dDoBo/b9WgCDHG/xOS
	 6tvHh5L+PQCqlLJSqeEgytkeUXS6izaTje5mnRoUkv4/pPp0phfO3Cao8sjduLbZpG
	 Pc1G/Cu17M5yA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 10/16] Docs/admin-guide/mm/damon/usage: document sz_ops_filter_passed
Date: Mon,  6 Jan 2025 11:33:55 -0800
Message-Id: <20250106193401.109161-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106193401.109161-1-sj@kernel.org>
References: <20250106193401.109161-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document the new per-scheme operations set layer-handled DAMOS filters
passed bytes statistic file on DAMON sysfs interface usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index 2e835c9bcfdf..95c174be9c06 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -84,7 +84,7 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
     │ │ │ │ │ │ │ │ ...
@@ -448,18 +448,16 @@ difference is applied to :ref:`stats <damos_stats>` and
 schemes/<N>/stats/
 ------------------
 
-DAMON counts the total number and bytes of regions that each scheme is tried to
-be applied, the two numbers for the regions that each scheme is successfully
-applied, and the total number of the quota limit exceeds.  This statistics can
-be used for online analysis or tuning of the schemes.  Refer to :ref:`design
-doc <damon_design_damos_stat>` for more details about the stats.
+DAMON counts statistics for each scheme.  This statistics can be used for
+online analysis or tuning of the schemes.  Refer to :ref:`design doc
+<damon_design_damos_stat>` for more details about the stats.
 
 The statistics can be retrieved by reading the files under ``stats`` directory
-(``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``, and
-``qt_exceeds``), respectively.  The files are not updated in real time, so you
-should ask DAMON sysfs interface to update the content of the files for the
-stats by writing a special keyword, ``update_schemes_stats`` to the relevant
-``kdamonds/<N>/state`` file.
+(``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``,
+``sz_ops_filter_passed``, and ``qt_exceeds``), respectively.  The files are not
+updated in real time, so you should ask DAMON sysfs interface to update the
+content of the files for the stats by writing a special keyword,
+``update_schemes_stats`` to the relevant ``kdamonds/<N>/state`` file.
 
 .. _sysfs_schemes_tried_regions:
 
-- 
2.39.5
