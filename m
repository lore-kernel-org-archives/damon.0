Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E465219992E;
	Thu, 19 Dec 2024 04:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734581024; cv=none; b=drdjvLKbfsa8SLDGz8a7LVJqaxtC8pdwePAZkJUyxUr7l2B4OYcUPnqYZsPCamsz7tWi/vFLhWCc9cfLNmrY83H6ZC3RcxZek3nGJRpdpxSDsF/MMOZAlQ9N0IJOwJfFMzPsHZGUHV1hEHFP96JsvMGGJ/waA6mFYLv+9RgCtkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734581024; c=relaxed/simple;
	bh=870oJTBXZdVt9AT5feGTAshGBO42oNB2tnBh+kdf9pU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=duUxkHxkebN/kzCa1s1hFoYAmbPLymjH3xI9fJ2CQOt5lShg4iXZnlUM6h85NvHOxtCApZ3xHFoRCz5mhfUUM1FNF8D8hSFU9bAz47v5NjoK0Ypc6dbaCAfb7RdSx02a+9rbVEvwHSR7NMtbItzsqrLWBt5ONFEWXXUBFPmsvD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlR11qQK; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlR11qQK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 636A9C4CED4;
	Thu, 19 Dec 2024 04:03:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734581023;
	bh=870oJTBXZdVt9AT5feGTAshGBO42oNB2tnBh+kdf9pU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AlR11qQKkpzyBTQiNLszI6jcdKv/J1EWDO9SjdrivcgOlH5rxhbckRGbfZe2FbiaM
	 a8x4tU2XvnmKsuiGDsK8gF/whIEhzVaXGsbJDgQk4AfZJrYbonz2kx8zbUAg13Kp2B
	 9TZwVLkhLuPW6CzZpL5Xw4rxSqaGTfgH0byKfAwsAR6agFFyc9LHSj1Y7FC0KUexGJ
	 70R0u8m3b2edUS2OxLyOMeWognAaGXuwyRsgB3LsoHGkiLiyKELVULuSsEhpg4nQew
	 l8c22bHynMak/3i/RggiuhQUNOYJYzJJwGVn89+oD5LiGtvwE9z//yNT0t+ab5wcDe
	 d4AHq3FbGrKCA==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: kernel-team@meta.com,
	SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 04/18] Docs/admin-guide/mm/damon/usage: link damos stat design doc
Date: Wed, 18 Dec 2024 20:03:13 -0800
Message-Id: <20241219040327.61902-5-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241219040327.61902-1-sj@kernel.org>
References: <20241219040327.61902-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DAMON sysfs usage document should focus on usage, rather than the detail
of the stat metric itself.  Add a link to the design document on usage
section for DAMOS stat.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 Documentation/admin-guide/mm/damon/usage.rst | 3 ++-
 Documentation/mm/damon/design.rst            | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/mm/damon/usage.rst b/Documentation/admin-guide/mm/damon/usage.rst
index d9be9f7caa7d..af70f7244700 100644
--- a/Documentation/admin-guide/mm/damon/usage.rst
+++ b/Documentation/admin-guide/mm/damon/usage.rst
@@ -457,7 +457,8 @@ schemes/<N>/stats/
 DAMON counts the total number and bytes of regions that each scheme is tried to
 be applied, the two numbers for the regions that each scheme is successfully
 applied, and the total number of the quota limit exceeds.  This statistics can
-be used for online analysis or tuning of the schemes.
+be used for online analysis or tuning of the schemes.  Refer to :ref:`design
+doc <damon_design_damos_stat>` for more details about the stats.
 
 The statistics can be retrieved by reading the files under ``stats`` directory
 (``nr_tried``, ``sz_tried``, ``nr_applied``, ``sz_applied``, and
diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8710fa71ad71..e2666124e382 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -539,6 +539,8 @@ To know how user-space can set the watermarks via :ref:`DAMON sysfs interface
 <sysfs_interface>`, refer to :ref:`filters <sysfs_filters>` part of the
 documentation.
 
+.. _damon_design_damos_stat:
+
 Statistics
 ~~~~~~~~~~
 
-- 
2.39.5

