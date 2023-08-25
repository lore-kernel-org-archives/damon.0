Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46839649
	for <damon@lists.linux.dev>; Fri, 25 Aug 2023 02:04:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B0C3C433C8;
	Fri, 25 Aug 2023 02:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692929083;
	bh=DGy3J8tYd2fNRF/XMycogFjHA/nAjC6h5pCTBYpzOiI=;
	h=From:To:Cc:Subject:Date:From;
	b=Hq8Ec9ZVIKKgzSO5bo2qz85hrjMHvmYvKbaBnGJgQNBALU2Yene9Vt3mQ8oOLA+VJ
	 gKBtDB2OsWoa8XQHpEbsvLT3HygLVL5ISqhfF3frSEv8HPDJaf7Ik7FX/uEedk7OV+
	 wL8Ghc8bSX0WAGnY3ZnCC8EDtjSUTmL2qyeFa2/+hB9TyUah51BY9vgnQXmsO5sdij
	 i4We3Y6q14CyEcfuTHdOz3XOPyNNtZJUpGYEH3dsQ1PXQMAqDX0wpIc0/riu6mWxIB
	 kR/jf332aRiKl3WtuGTNNA/Hlzq8oRahAR6LTsoqCq4vfdIW/I+CAuEdD7858V3TLm
	 XSfFlwbbGiHkA==
From: SeongJae Park <sj@kernel.org>
To: Kees Cook <keescook@chromium.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH] mm/damon/sysfs: add __counted_by() annotation
Date: Fri, 25 Aug 2023 02:04:41 +0000
Message-Id: <20230825020441.65431-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit dd06e72e68bc ("Compiler Attributes: Add __counted_by macro")
added __counted_by() annotation.  The underlying attribute for the
feature is still under development, but adopting it can improve the
readability of the code.  Apply it to four dynamic arrays in DAMON sysfs
code.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 808a8efe0523..36a176f38726 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -93,7 +93,7 @@ static const struct kobj_type damon_sysfs_region_ktype = {
 
 struct damon_sysfs_regions {
 	struct kobject kobj;
-	struct damon_sysfs_region **regions_arr;
+	struct damon_sysfs_region **regions_arr __counted_by(nr);
 	int nr;
 };
 
@@ -289,7 +289,7 @@ static const struct kobj_type damon_sysfs_target_ktype = {
 
 struct damon_sysfs_targets {
 	struct kobject kobj;
-	struct damon_sysfs_target **targets_arr;
+	struct damon_sysfs_target **targets_arr __counted_by(nr);
 	int nr;
 };
 
@@ -812,7 +812,7 @@ static const struct kobj_type damon_sysfs_context_ktype = {
 
 struct damon_sysfs_contexts {
 	struct kobject kobj;
-	struct damon_sysfs_context **contexts_arr;
+	struct damon_sysfs_context **contexts_arr __counted_by(nr);
 	int nr;
 };
 
@@ -1590,7 +1590,7 @@ static const struct kobj_type damon_sysfs_kdamond_ktype = {
 
 struct damon_sysfs_kdamonds {
 	struct kobject kobj;
-	struct damon_sysfs_kdamond **kdamonds_arr;
+	struct damon_sysfs_kdamond **kdamonds_arr __counted_by(nr);
 	int nr;
 };
 
-- 
2.25.1

