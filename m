Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765F922D7A8;
	Wed, 16 Apr 2025 04:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744777566; cv=none; b=k7IKyEaasr7Axi+l02Ei8CYDyssA9ewiYDx7P9sY7rj4aptbnchfv3XhBEK7+TUcC0YzGWARi0rgZWR0YkprmJ/YnA+YPP4f/F30QAZyIcXDAoHd3SGLOHlYozJf4IkEkFjsAfsQbRIPVd9DInk8DfB0UD7kBLc9QgfmB8N6/cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744777566; c=relaxed/simple;
	bh=gTYFPTKVeiLrjsKHoO4pSEKq3DJORWxzfKSpIOcjMaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PMQUl5KQxMAFvDjNqsAH5ZQqzXud3HoeR2ynuKCFsNAFu5m/biOVjAsL5I6jj8RL0X4WJ0euBDg5yGyscz9kmiECZOtGMVnqAtFoZcIL8Ue7ex5PXhqCYcLEr1aIZ+vQqBpsC4Cd9jYLnrbtp98/eGJAUNRSTA+guo8OOHiw4rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N7en+Pxz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N7en+Pxz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 272B2C4CEEC;
	Wed, 16 Apr 2025 04:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744777566;
	bh=gTYFPTKVeiLrjsKHoO4pSEKq3DJORWxzfKSpIOcjMaE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N7en+PxzKcRRBHhvIXSVBYX4N8Bj1OKXNXS8nTBkNWMQj5EReGiWsYxV8RwCa9tW6
	 q4SgY+Nx+cY0eXA2ZvMO59Z48LSeusitAqVSZQ71qEYjjZyc8Kgonqu6oGyzeryiay
	 g72OkIXWCh+D5RZeQcJFPOV8Rz+c7wTNyyzbQV7EbtLecxqZZ43B07MhDlg5L5vdis
	 hCyFup72ae3K051TFjWIjIAtbtUJlBeWwRvCqumQn5lbVJXG5Wa4pXQ7qq8nlUeyhs
	 p+gUDjcK1iwOh9W+gq5vmidX8V/Fmh+V4xnq4YJ1FwyySeaFzsLUJqH2oaUUtynzbO
	 PSrUmikBoky7A==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Ze Zuo <zuoze1@huawei.com>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 09/10] Docs/admin-guide/mm/damon/usage: document addr_unit file
Date: Tue, 15 Apr 2025 21:25:50 -0700
Message-Id: <20250416042551.158131-10-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250416042551.158131-1-sj@kernel.org>
References: <20250416042551.158131-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Document addr_unit DAMON sysfs file on DAMON usage document.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 11 +++++++----
 Documentation/mm/damon/design.rst            |  2 ++
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index ced2013db3df..7638bbaf9939 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -61,7 +61,7 @@ comma (",").
     │ :ref:`kdamonds <sysfs_kdamonds>`/nr_kdamonds
     │ │ :ref:`0 <sysfs_kdamond>`/state,pid
     │ │ │ :ref:`contexts <sysfs_contexts>`/nr_contexts
-    │ │ │ │ :ref:`0 <sysfs_context>`/avail_operations,operations
+    │ │ │ │ :ref:`0 <sysfs_context>`/avail_operations,operations,addr_unit
     │ │ │ │ │ :ref:`monitoring_attrs <sysfs_monitoring_attrs>`/
     │ │ │ │ │ │ intervals/sample_us,aggr_us,update_us
     │ │ │ │ │ │ │ intervals_goal/access_bp,aggrs,min_sample_us,max_sample_us
@@ -179,9 +179,9 @@ details).  At the moment, only one context per kdamond is supported, so only
 contexts/<N>/
 -------------
 
-In each context directory, two files (``avail_operations`` and ``operations``)
-and three directories (``monitoring_attrs``, ``targets``, and ``schemes``)
-exist.
+In each context directory, three files (``avail_operations``, ``operations``
+and ``addr_unit``) and three directories (``monitoring_attrs``, ``targets``,
+and ``schemes``) exist.
 
 DAMON supports multiple types of :ref:`monitoring operations
 <damon_design_configurable_operations_set>`, including those for virtual address
@@ -196,6 +196,9 @@ You can set and get what type of monitoring operations DAMON will use for the
 context by writing one of the keywords listed in ``avail_operations`` file and
 reading from the ``operations`` file.
 
+``addr_unit`` file is for setting and getting the :ref:`address unit
+<damon_design_addr_unit>` parameter of the operations set.
+
 .. _sysfs_monitoring_attrs:
 
 contexts/<N>/monitoring_attrs/
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 696a4d738cb3..56bfc0abff36 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -137,6 +137,8 @@ the interference is the responsibility of sysadmins.  However, it solves the
 conflict with the reclaim logic using ``PG_idle`` and ``PG_young`` page flags,
 as Idle page tracking does.
 
+.. _damon_design_addr_unit:
+
 Address Unit
 ------------
 
-- 
2.39.5
