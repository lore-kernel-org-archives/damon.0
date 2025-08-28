Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE9A335BC1;
	Thu, 28 Aug 2025 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756401178; cv=none; b=SOrgnqUJEBWbcXNGXrZ/0WULG9dNyhBc/TTbGO9xoAboWKbcKTj3iBA7ncGYpdlcdKk0NEC6DHUhTH4A/EFAKR+Rf+KJbhAGAYfLx5/+mBlbPdRxNTLuSbzeXQXZ1elyEenedS8Rxpm/bakOh4qGng6nPBzhi5LMJH81sBs12Yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756401178; c=relaxed/simple;
	bh=E4lfMWLAM0CZUwTFNYks6zQJROy89IQivneqIvqMdBo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iUh6FFFw52vGBjC9k7RG+v829iHpsa6fv2dWcTY68XAY1ZHR5lt0hfwpAGxKcmqbrmLX8GGZebYEQlmgMirGRbBdwxeMVlUwzprI4OMHxWjvvnNHhts2kuG8zuBq9tzevZKWrsAMRLFUym/BZGsoH+pWFgEGvRYyELeGG5TbL6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R7/FmEi3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R7/FmEi3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB7D4C4CEED;
	Thu, 28 Aug 2025 17:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756401177;
	bh=E4lfMWLAM0CZUwTFNYks6zQJROy89IQivneqIvqMdBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R7/FmEi3JX7oKToun7GulU8vhzLnkqFIhzQR7knoDm40YxsaPtw3S/DU0ugsEIXrS
	 nVsn0zSsuOyutcyid5uOd71fplJLqmWkND5JgoBLgVqElhFOwpMjthWQ+L+i7dfVJQ
	 Xah1dK7wXUdq9cNO35lexfuL0KJpFX+9CukkBaY6BVzWSpo1GmvGgQ18pbwUsu4ufy
	 MBDOc5ca3BAhThC05qpw88/eOiqVmyeb7paTMRpi4pYGaSM/tE26SRd6qU0yHp+pOx
	 oZGhKjZkx1qdEa8Y0JXjhhDkdNwuXKf6uSdLyyJ3UGsfvm3JoTC/BXJcMjTnYiqv5T
	 BHQdbR4wByb4Q==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	Quanmin Yan <yanquanmin1@huawei.com>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	wangkefeng.wang@huawei.com,
	zuoze1@huawei.com
Subject: [PATCH v3 10/11] Docs/ABI/damon: document addr_unit file
Date: Thu, 28 Aug 2025 10:12:41 -0700
Message-Id: <20250828171242.59810-11-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250828171242.59810-1-sj@kernel.org>
References: <20250828171242.59810-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document addr_unit DAMON sysfs file on DAMON ABI document.

Signed-off-by: SeongJae Park <sj@kernel.org>
Signed-off-by: Quanmin Yan <yanquanmin1@huawei.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 Documentation/ABI/testing/sysfs-kernel-mm-damon | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-damon b/Documentation/ABI/testing/sysfs-kernel-mm-damon
index 6791d879759e..b6b71db36ca7 100644
--- a/Documentation/ABI/testing/sysfs-kernel-mm-damon
+++ b/Documentation/ABI/testing/sysfs-kernel-mm-damon
@@ -77,6 +77,13 @@ Description:	Writing a keyword for a monitoring operations set ('vaddr' for
 		Note that only the operations sets that listed in
 		'avail_operations' file are valid inputs.
 
+What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/addr_unit
+Date:		Aug 2025
+Contact:	SeongJae Park <sj@kernel.org>
+Description:	Writing an integer to this file sets the 'address unit'
+		parameter of the given operations set of the context.  Reading
+		the file returns the last-written 'address unit' value.
+
 What:		/sys/kernel/mm/damon/admin/kdamonds/<K>/contexts/<C>/monitoring_attrs/intervals/sample_us
 Date:		Mar 2022
 Contact:	SeongJae Park <sj@kernel.org>
-- 
2.39.5
