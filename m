Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B9361DA7;
	Thu, 23 Apr 2026 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776956583; cv=none; b=bCCYUE7h8yX8lLSP6CEosHBJq5LS+k1guZlXbMXSpdSv+sqGi070XSC4xsOOPqlPQrDhJXuHqdgrxTjnEMx3iseAoX2kPaKN70mifv9tbfS71HbbZbKMnS5BdpwiaLEHb4v3obtzN0MuZQ9ojrSSLnwj6mPvuhIuVfAQfFuH6fo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776956583; c=relaxed/simple;
	bh=pgIYrrAK6X9JUhNoZ3jKTnGdrjt9Atw8Bt+OO+9uPx4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nWMYvdQq473+cjL7ex7N+HrIic33L2RHhTzAG9TK40leDdcDwtzu/CylwM5K8q3+u4odyZQOqwoyky5nme4LMAw3RK5/HmH27SWhINjSp3A6RjWsU6nXy0+AIuIAJ2HAkXTAZ2y0tdWiBl+c7TW80yeYHhU/gacr3KfaUoYyXuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bPORGTu8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bPORGTu8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C76B9C2BCB3;
	Thu, 23 Apr 2026 15:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776956583;
	bh=pgIYrrAK6X9JUhNoZ3jKTnGdrjt9Atw8Bt+OO+9uPx4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bPORGTu8YrJGGYX+HnAjs4fhHzD34EJaP8VvY8cmPf2H1h2K+ynmjdiqsDJRpNLx3
	 oAm8LmDxiObij537YgRsVv9oM6ALhzLZkIQDw1MEvXIvNKegud7BicI9LVHanw4j7R
	 3t2gL/IrQucxdYlwOPIdTfmG1QMwtO6BtcCK1qYkgnmzXqXjInGFKvYrEhKnmXyCyH
	 1ZaFAbhm8Ku55oGUt7sPh1Bc9RRftEt7WR0RJUwyCPEkJCbaEisbwjOAlB55phTjfx
	 ZP00VagCX+shexDpBGPApTmnSfdHaW0XBr33sR3yM7T8Ucy3gX/c1EwD3zf2KJV69W
	 mA0XhtYkvvv5g==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 19 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: [PATCH 2/2] mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
Date: Thu, 23 Apr 2026 08:02:52 -0700
Message-ID: <20260423150253.111520-3-sj@kernel.org>
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

damon_sysfs_quot_goal->path can be read and written by users, via DAMON
sysfs 'path' file.  It can also be indirectly read, for the parameters
{on,off}line committing to DAMON.  The reads for parameters committing
are protected by damon_sysfs_lock to avoid the sysfs files being
destroyed while any of the parameters are being read.  But the
user-driven direct reads and writes are not protected by any lock, while
the write is deallocating the path-pointing buffer. As a result, the
readers could read the already freed buffer (user-after-free).  Note
that the user-reads don't race when the same open file is used by the
writer, due to kernfs's open file locking.  Nonetheless, doing the reads
and writes with separate open files would be common.  Fix it by
protecting both the user-direct reads and writes with damon_sysfs_lock.

Fixes: c41e253a411e ("mm/damon/sysfs-schemes: implement path file under quota goal directory")
Cc: <stable@vger.kernel.org> # 6.19.x
Co-developed-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: Junxi Qian <qjx1298677004@gmail.com>
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 8d32a20531d49..245d63808411a 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1197,8 +1197,13 @@ static ssize_t path_show(struct kobject *kobj,
 {
 	struct damos_sysfs_quota_goal *goal = container_of(kobj,
 			struct damos_sysfs_quota_goal, kobj);
+	int len;
 
-	return sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	if (!mutex_trylock(&damon_sysfs_lock))
+		return -EBUSY;
+	len = sysfs_emit(buf, "%s\n", goal->path ? goal->path : "");
+	mutex_unlock(&damon_sysfs_lock);
+	return len;
 }
 
 static ssize_t path_store(struct kobject *kobj,
@@ -1213,8 +1218,13 @@ static ssize_t path_store(struct kobject *kobj,
 		return -ENOMEM;
 
 	strscpy(path, buf, count + 1);
+	if (!mutex_trylock(&damon_sysfs_lock)) {
+		kfree(path);
+		return -EBUSY;
+	}
 	kfree(goal->path);
 	goal->path = path;
+	mutex_unlock(&damon_sysfs_lock);
 	return count;
 }
 
-- 
2.47.3
