Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEDA3ECBF6;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868508; cv=none; b=uuo9dfHeomeXNX4SQTcg28iM5h8egs+EV5BaM3YcSPxNHogJWR6yjepf5RMHi5fokDcGVzZ3yG2U+HwMNcm8mHqOCMoTbEu/k8knvNmGnH3TlRMIU9jKQiHTgoWrWECpcZJUt0oQYeUlNJ/N8YrP3Hwi6PHwGYTRCoSf7TrcjZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868508; c=relaxed/simple;
	bh=FNV8xQP2YWLDSaMWy27hoOup6UGsYJXN2Gv3gecRBI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PYPQHoOQlOWmswOoSxTQ88BC0soUECyzyidYa2+EMX7ApXQUBa3XzNxpf+rDBSTnyo1SJmdyeI2dswuLGi/Ze0NQeotJbFjk5UrGmaCLxnxh07UJJT7CGxUtR63QvAsVojHmcVhBzkfD7iXho70OSXhfRjaSBM0Tr8yN5oXg3sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BTl9YSb3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BTl9YSb3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 154CFC2BCB2;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868508;
	bh=FNV8xQP2YWLDSaMWy27hoOup6UGsYJXN2Gv3gecRBI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BTl9YSb3eStnRjxhY7G8tc98WLX7BdWmhhOplI3i4Is0uFIMa+SYCogu7USM0q7aE
	 7MUaLhKdkIodqU8mJoK4Fm63Aj6I12yevY4xTszrpOdR/qlXI96B8I91VUhsPa/SZE
	 nDTpH7XBrG7roXNqejS6c4bSYKWA66eswR7SPTjPp/s8iiaKByllqAFELU0TpQZ1uS
	 y1YzEx0YFELC8sqpRpMrM4vZnuX8Wzt6ODj1k8uaAeqQMUfe5QUu/6bmDe16YbEzz+
	 Jzht0sSOLeIpt9lHSr0i7r+vLpPpMU07546RHlb0BnbJGcKWoymnAIUnLtBUEtPU3c
	 yEOSNVlt9yaLw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: [RFC PATCH 1/2] mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock
Date: Wed, 22 Apr 2026 07:35:00 -0700
Message-ID: <20260422143503.71357-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260422143503.71357-1-sj@kernel.org>
References: <20260422143503.71357-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_sysfs_scheme_filter->mmecg_path can be read and written by users,
via DAMON sysfs memcg_path file.  It can also be indirectly read, for
the parameters {on,off}line committing to DAMON.  The reads for
parameters committing are protected by damon_sysfs_lock to avoid the
sysfs files being destroyed while any of the parameters are being read.
But the user-driven direct reads and writes are not protected by any
lock, while the write is deallocating the memcg_path-pointing buffer. As
a result, the readers could read the already freed buffer
(user-after-free).  Note that the user-reads don't race when the same
open file is used by the writer, due to kernfs's open file locking.
Nonetheless, doing the reads and writes with separate open files would
be common.  Fix it by protecting both the user-direct reads and writes
with damon_sysfs_lock.

Fixes: 4f489fe6afb3 ("mm/damon/sysfs-schemes: free old damon_sysfs_scheme_filter->memcg_path on write")
Cc: <stable@vger.kernel.org> # 6.16.x
Co-developed-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 5186966dafb35..8d32a20531d49 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -533,9 +533,14 @@ static ssize_t memcg_path_show(struct kobject *kobj,
 {
 	struct damon_sysfs_scheme_filter *filter = container_of(kobj,
 			struct damon_sysfs_scheme_filter, kobj);
+	int len;
 
-	return sysfs_emit(buf, "%s\n",
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n",
 			filter->memcg_path ? filter->memcg_path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
 }
 
 static ssize_t memcg_path_store(struct kobject *kobj,
@@ -550,8 +555,13 @@ static ssize_t memcg_path_store(struct kobject *kobj,
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
 	kfree(filter->memcg_path);
 	filter->memcg_path = path;
+	mutex_unlock(&damon_sysfs_lock);
 	return count;
 }
 
-- 
2.47.3
