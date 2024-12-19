Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F0E1A38F9;
	Thu, 19 Dec 2024 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581031; cv=none; b=oSqJe4YhXr1aLiBbmaiPzHc7fpSHBxYUeIbJtLMJIDct5uL4h1NRuA3x0lMSYouwC0LcfVtNxX4ajlK/EHG12rF7OY8M0RnrJCHGnk/9oRyC5UTLc14hjw+LS/6MJ4KR63LTJUXzkD30rFS9X5Cz5JOicyK9DoiP8PqY2ZSbiyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581031; c=relaxed/simple;
	bh=E3nDxsQnOnucfR2JdCI6gXATVIHYtLFHhB+wDRP7hiA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bTwsaI7I+RMdJlEhnN5pdXnVw3pVry3WGt/vrb2Ailag51cxMoWuguV2bqsYS48nuj98mAR0Ph7ywb+4GeuY0UQmdbvIKA+6ibnf+wuP6qZjQ7J2iG3VJTWQ1L3WQKkiOd9IA+pxnsQ/mvcG6ieXqseIGRt5vZk2e7NWse+vfRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKqclcbh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKqclcbh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23831C4CED4;
	Thu, 19 Dec 2024 04:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581031;
	bh=E3nDxsQnOnucfR2JdCI6gXATVIHYtLFHhB+wDRP7hiA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CKqclcbhPJF7kqBVAm02cPqjr4b/PMnD/U8sX8WuWogMdXCphEjY/C16CebDzcjru
	 kTMexC+Xk4wt4g4iCGSKjnD55BuWbTx2Srh895iCRkEtu8KwyGlZotxN/aa5YN52Jx
	 PX1fSqlm9ch6RFmtWBib6ULcj1XvHxKpDc4imqoayb6+7fU+BNTerh+BeKcrkSc3oS
	 0X/qiya1fv4+jeRZ+xaBZbU4RJUVESPorK2aQqCBtWrXEcN1mBt1EdhELOWm7u7HRe
	 1oRi48nnWsbLVPsW9HbOVy1++GfiNi9zI8yeZjsreEAAI+r9Cozk63ZF6XmQ/tKO2E
	 JA5HzqucfzhJg==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 11/18] Docs/admin-guide/mm/damon/usage: document sz_ops_filter_passed
Date: Wed, 18 Dec 2024 20:03:20 -0800
Message-Id: <20241219040327.61902-12-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
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
index af70f7244700..179a9060a32e 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -90,7 +90,7 @@ comma (",").
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
     │ │ │ │ │ │ │ │ 0/type,matching,memcg_id
-    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,qt_exceeds
+    │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age
     │ │ │ │ │ │ │ │ ...
@@ -454,18 +454,16 @@ difference is applied to :ref:`stats <damos_stats>` and
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

