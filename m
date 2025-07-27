Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE8F23F429;
	Sun, 27 Jul 2025 20:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753647506; cv=none; b=A8ODzyXzaetIjarsmS6oN/Zvj0uWQKEr/6UbU1kC2WwPig9YAFZlQ8FyRoV3A0JDQ82pqmPnWM0vaA/L0cQNKgduAgQYcCArnrIet7tBngKq2BT77TE5Jwq/LEzSFNI7YoJjutIBxaCTT0+kQPL63PJiZFGbxZQEPu4QatoXZX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753647506; c=relaxed/simple;
	bh=lIN23oNIZq4gvn+3V74kVsfgrx2Y6wNkq7FOywUP7e8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CR4fsuT5lsNHpR86EJXFC089f8RQmV9VXevcVfVmp7zNam+KcVPRr1QHE/yOm580kEVEaMLUD11K7EU71/HHmEdyV+fuXaxKwNuHSiilk8MHFwKqPoQfc/R68MywIRBCs8rJVy+DNn9l8/nyuR35mvui1D7CeK2PCU3cIWE3Zes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SnVyd1ia; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SnVyd1ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97EFC4CEFA;
	Sun, 27 Jul 2025 20:18:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753647505;
	bh=lIN23oNIZq4gvn+3V74kVsfgrx2Y6wNkq7FOywUP7e8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SnVyd1iaZ6FIKe2TiI2z0l2MSfELTCCZol2515DoHHFYOTm0vguEMRVfekcMdFrp4
	 MNz8vg9AOMJ7/Xqirrg14z4v2WJN2K65r4ZAFP5hbx9xAGDq2ATFA0cAnMX6IfPOVw
	 mlc0Qs1JzsL/QIC79ERmWTZXEV1h3DwFk0Ey2tXFExsnhZfRxdz7IbWqD3x0kH9JD1
	 9BdqkLbs2YX56yNk/wnj4ajUI5nDWfujZUyUnbmu4a8p+HDkMFS2rCxHuU3I+ZSuWO
	 UHg/beRd0Lky+HxbcqIqt1JAVD2VyTiZpFGVweSJzFmIYKmLCz8NZywx+vcQIjThj3
	 U3avO1s/Otxag==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC v2 7/7] mm/damon/sysfs: support paddr_fault
Date: Sun, 27 Jul 2025 13:18:13 -0700
Message-Id: <20250727201813.53858-8-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250727201813.53858-1-sj@kernel.org>
References: <20250727201813.53858-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend DAMON sysfs interface to support the page faults based physical
address space access monitoring.  Users can use it by writing
paddr_fault to the ops file.  For simple testing, the DAMON user-space
tool can be used as below, after applying below hack.

    $ git diff
    --- a/src/_damon_sysfs.py
    +++ b/src/_damon_sysfs.py
    @@ -548,7 +548,7 @@ def write_monitoring_attrs_dir(dir_path, context):

     def write_context_dir(dir_path, context):
         err = _damo_fs.write_file(os.path.join(dir_path, 'operations'),
    -                              context.ops)
    +                              'paddr_fault')
         if err is not None:
             return err

    $ sudo ./damo start
    $ sudo ./damo report access

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 6d2b0dab50cb..b1bf43972491 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -829,6 +829,10 @@ static const struct damon_sysfs_ops_name damon_sysfs_ops_names[] = {
 		.ops_id = DAMON_OPS_PADDR,
 		.name = "paddr",
 	},
+	{
+		.ops_id = DAMON_OPS_PADDR_FAULT,
+		.name = "paddr_fault",
+	},
 };
 
 struct damon_sysfs_context {
-- 
2.39.5
