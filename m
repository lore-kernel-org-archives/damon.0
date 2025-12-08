Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 089E5322B72;
	Mon,  8 Dec 2025 06:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765175444; cv=none; b=ZUg457CF9Et13r2airguhK/dG8gn22hp7tJamHPrJfTWfE3U/LY+5H1YqMARkoLveIIeDiSJw48VAoldR/0uf2HzD4xbCSeEElnlS6CsG4Dk1qJGvmq8jNImB9qyfe2IyJJNs3dmYkLH2tY4hC8Sq4/l7tTxsLADMimGUQg2xuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765175444; c=relaxed/simple;
	bh=I2gSrUS/ytzkCO1hJUdsffUlWhdJJTl9/yHYyXuCFtM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=epV2KDdOqDs3Ja5jlWJkhu9J/XXnGb6DnuRhtdNPykNp2KtfYXHnM/MHQ6zArgpTV1OISzp31gU2xP182I05Dq4sWKz50sGp/AsrxQ30Zsld3+c4EyXGE+9ik+l0oY8GIXthi5pM4pdNUemTbheTo7HxTy8EQLCHNrDHqgVl+xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3OgjpkR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3OgjpkR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D208FC116B1;
	Mon,  8 Dec 2025 06:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765175443;
	bh=I2gSrUS/ytzkCO1hJUdsffUlWhdJJTl9/yHYyXuCFtM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q3OgjpkR49zDj2QFoLmWOx92p1HIbZX2mIXn+c67LiZRVhV/qmtiAN6QAivmIiS4B
	 acDRY6oMBC+L0ZilJc+sJkWCdFl6QnzirMYRi4xbUIHciCmy8M8pTK/m3wfxNoDxgB
	 B9MAp6q8QV5L2+NgGWfBqAHMqeR2DF6/lspaRDe2lrRAZeEatsa23zcG4MdlpXXZHt
	 YNw7GTz9W9bblfkR6tQBFR54YxALWklwnM4OokbXLsYUZrrsJGhz8bjoUeLVTwiFIc
	 sanfNZ6mWEvnJObpLzN1GM1HOMrC7EMmHduLAzCsUvNasOziiHbeWwnizarubsYom7
	 RJ32Q0TBhwnew==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH v3 35/37] mm/damon/core: support write access sample filter
Date: Sun,  7 Dec 2025 22:29:39 -0800
Message-ID: <20251208062943.68824-36-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251208062943.68824-1-sj@kernel.org>
References: <20251208062943.68824-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now page fault events based access reports contain information about if
the access was for a read or a write.  Doing sampling results filtering
based on the information can be useful.  Introduce a new type of damon
sample filter for that.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 9 ++++++---
 mm/damon/core.c       | 5 +++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 9299fc91ba27..f9fd26f7eab8 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -790,12 +790,14 @@ struct damon_primitives_enabled {
  *
  * @DAMON_FILTER_TYPE_CPUMASK:	Filter by access-generated CPUs.
  * @DAMON_FILTER_TYPE_THREADS:	Filter by access-generated threads.
+ * @DAMON_FILTER_TYPE_WRITE:	Filter by whether the access was for writing.
  *
  * Read &struct damon_sample_control for more details.
  */
 enum damon_sample_filter_type {
 	DAMON_FILTER_TYPE_CPUMASK,
 	DAMON_FILTER_TYPE_THREADS,
+	DAMON_FILTER_TYPE_WRITE,
 };
 
 /**
@@ -836,9 +838,10 @@ struct damon_sample_filter {
  * that to make higher access pattern picture.  It can use multiple sampling
  * primitives including page table accessed bits and page fault events.  It can
  * also filter in/out specific types of sampled access events to monitor
- * accesses of specific types, such as access-generated CPUs and threads.  This
- * struct is for controlling what sampling primitives to use (enable), and what
- * sampled access events should be filtered in/out.
+ * accesses of specific types, such as access-generated CPUs, threads, and
+ * whether it was for read or writes.  This struct is for controlling what
+ * sampling primitives to use (enable), and what sampled access events should
+ * be filtered in/out.
  */
 struct damon_sample_control {
 	struct damon_primitives_enabled primitives_enabled;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e2fd17b83a92..5f29e4dee267 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -1336,6 +1336,8 @@ static int damon_commit_sample_filter_arg(struct damon_sample_filter *dst,
 				src->nr_tids);
 		dst->nr_tids = src->nr_tids;
 		break;
+	case DAMON_FILTER_TYPE_WRITE:
+		break;
 	default:
 		break;
 	}
@@ -2912,6 +2914,9 @@ static bool damon_sample_filter_matching(struct damon_access_report *report,
 			break;
 		}
 		break;
+	case DAMON_FILTER_TYPE_WRITE:
+		matched = report->is_write;
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
