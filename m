Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67CF212D94;
	Fri, 10 Jan 2025 18:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736535164; cv=none; b=CKfnLiYCJG2QiYI5MqQZKoFZRNYTiSVnX+xUQ3zPMSvk+1BMrH/Vdj88RNgX2gkwnTxKmRq4F/zMHEI0AgvIivjDVxct5MVXcyhaXClPsVFVRzKEXqtVwqSCWK6+FSkprAg7LrwFxkJRIE4VMAN7S913z/jiXr1AwEXmBCyC90s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736535164; c=relaxed/simple;
	bh=aQ+Bj2xTqVO3IMkQIcaZrOE0PN1bTM2On8Eb95tnIgI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KRFGaShJJGWCzp4T2wqJ5nz+zIzfcH2n80EGZ5NqTIMvw5evGmt+PQO79d2slIu7kRNQUyiJ25hws7Hi6xA3NRNhDr8HHg0mJznc9NYEnmPgBojy2kDQKJtjlJxdB0w+7AmQSttdTtZm2LfiKS0PEmLTr7FNaKf6WL/xvIVweLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CZOUza/j; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CZOUza/j"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62E3DC4CED6;
	Fri, 10 Jan 2025 18:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736535163;
	bh=aQ+Bj2xTqVO3IMkQIcaZrOE0PN1bTM2On8Eb95tnIgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CZOUza/juB/9t158ZUTYhyyXOlW+YWK8xda7ymc4LKhaB9KtBHAivnNhE7IxMe5Yn
	 9lbrtz83aZRFa8hkMUDOPbHyK57Liq/PQqHumsTR5FHTEfHKC0BcGZ3pJM94WmNYRY
	 3Zxm61uBPNoIaxDaNwc7CsldDmTTxPmwv8Qe1MCZERKqvLni4ANNMfHA5NmD8Y4gU1
	 CUCbCYeSJ5f4TMVDJll6uW1pX5XDTXCkf/Td+PWgsh+KebQWF2zhUmYEvo639aHdwB
	 PGFOyk7yPoFaO9OUaeC2rdsdfezAzUY2xOxQAteQKMTG60YshYar4DwD563v+OF4kt
	 dveLIVntFFbOA==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 3/5] Docs/admin-guide/mm/damon/usage: fix and add missing DAMOS filter sysfs files on files hierarchy
Date: Fri, 10 Jan 2025 10:52:30 -0800
Message-Id: <20250110185232.54907-4-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250110185232.54907-1-sj@kernel.org>
References: <20250110185232.54907-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

DAMOS filter directory part of DAMON sysfs files hierarchy on the usage
document is wrong.  'memcg_path' file under the directory is wrongly
written as 'memcg_id'.  Also the directory has 'addr_start', 'addr_end',
and 'target_idx' files, but the list is missing those.  Fix the wrong
name and add missing files.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index f0d0c20711d6..47a44bd348ab 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -83,7 +83,7 @@ comma (",").
     │ │ │ │ │ │ │ │ │ 0/target_metric,target_value,current_value
     │ │ │ │ │ │ │ :ref:`watermarks <sysfs_watermarks>`/metric,interval_us,high,mid,low
     │ │ │ │ │ │ │ :ref:`filters <sysfs_filters>`/nr_filters
-    │ │ │ │ │ │ │ │ 0/type,matching,memcg_id,allow
+    │ │ │ │ │ │ │ │ 0/type,matching,allow,memcg_path,addr_start,addr_end,target_idx
     │ │ │ │ │ │ │ :ref:`stats <sysfs_schemes_stats>`/nr_tried,sz_tried,nr_applied,sz_applied,sz_ops_filter_passed,qt_exceeds
     │ │ │ │ │ │ │ :ref:`tried_regions <sysfs_schemes_tried_regions>`/total_bytes
     │ │ │ │ │ │ │ │ 0/start,end,nr_accesses,age,sz_filter_passed
-- 
2.39.5
