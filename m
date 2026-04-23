Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7DD335CB89;
	Thu, 23 Apr 2026 15:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956582; cv=none; b=XLzuhxlmhxqwnYM5kf7L8IAuGxHab0+dECzcL+gPSpQnm+MK3UKfO4uCiEnWeo5tbAhhDh99WRA6JbpwDGwOuhbEqD8kkfu8op8rvx3+qfcmD+PrqCrKPsat1eBlrYdO3ymmeKR5SiHKEHnWfvSh0mZLx93yoXR2U4yqrGddUtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956582; c=relaxed/simple;
	bh=FNV8xQP2YWLDSaMWy27hoOup6UGsYJXN2Gv3gecRBI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2dtBvAt27/OYkdbQkx5LjRw8q0xAWMzmtDqGzmG7jAivxT6QOFhj4GFXR3NoOcRu4KTxUkfVM0ELgqciXNxrFPgh1WzttgMj68qax5VAJSt3T+brz9BwbqrynBXyAuyV4nn66sJ8S1GTB/MTe7UTo973URrZXOpiKqivVxD1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JrEjuLmY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JrEjuLmY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6218EC2BCB5;
	Thu, 23 Apr 2026 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776956582;
	bh=FNV8xQP2YWLDSaMWy27hoOup6UGsYJXN2Gv3gecRBI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JrEjuLmYIS4mWBTUTBGJoJulPraOsKubWUrjeWM0ZikmkxlnLi2QvPIPWUTDmKaVG
	 QTbw2+fu2ftq/9h9E/7L7eTRjXoAVTBtdg6/gf8bdItCHn9ogg+Zk5uiRJNur3ECSk
	 MvCQscxdSQ5Ys/L01MVNp/HN5W56pmwkUStjCtw5j0/GKN8lhpBjba5j5av5F7MPjt
	 EN8zDME6LGyRrdzKuNwRUobqU26TBNJ8g3HTDSw8HWts8D+MDMcw61OYij42u47WZV
	 zLj8TdQxbzOhpWnQjwr+jCInYnA6iZBiDgkzPZPIPjanOQOFvYjdLeiW0y0rTgAkIW
	 RD4hIftBJsYow==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 16 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: [PATCH 1/2] mm/damon/sysfs-schemes: protect memcg_path kfree() with damon_sysfs_lock
Date: Thu, 23 Apr 2026 08:02:51 -0700
Message-ID: <20260423150253.111520-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260423150253.111520-1-sj@kernel.org>
References: <20260423150253.111520-1-sj@kernel.org>
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
