Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE003ED5D0;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776868508; cv=none; b=Q0FA+Ta5WZrMN3HWXSSGYOMVH8C+6YGvbKdzxEmO5ccbtGuu8UP8IwRJrjdU07KNyauUyOFTd2l17GYuU7PNVGigEyC6YSuMX0qWG80/nuAN5maZXB3bTarj4MVMI9Q+eR6XiFyXc4BFvwv/Vi6LdWNsVZfqXBVFRXxhLYbHhnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776868508; c=relaxed/simple;
	bh=phPSB3hsN5vcta7v48KcUcyjcHZo8DALfnPrjPsZe8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4Js+KhDo5p59pqFiuxPJOwwC7FRmTId4MY1H5inY2RCv2HGxEN3Vo7D8Z2zGdnL8x3rCjbW30szCDW5Gwj7y3o7tA1HTPfV/AYvZms7yEeu0DlRO0j+eYRcPOCZdThxPKv3Z6nYarsyvMUMYJPQZqwuvYEPKdFYl9NKneoCFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pomsCqr1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pomsCqr1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 767A6C2BCB4;
	Wed, 22 Apr 2026 14:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776868508;
	bh=phPSB3hsN5vcta7v48KcUcyjcHZo8DALfnPrjPsZe8Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pomsCqr1yF5C/tYG71y0u5knBxZDPNu8jOtVIz8EULIbQ/BnIhYMFquAqfIrBrsmc
	 uiSK8toywvsJI50TlUAzEtP7y0pAzGCHCmUGtSPbT9TMpiimgZoeE/XQeXFfXM4ZvM
	 ndVypsrEmtwcqpdA9QHaU98HU4WcWzvFwmot2DDK/S1NFfB/VYi1eKrE3vcQDI2AF4
	 W6ebe39N0NmhMT07OvfcPrLMVDL85n0ArqhBszKLldyuDEr6RqdppAwphxSA8isIrW
	 gu8YiLT7b4/1+I68ihHiTS4wBxvnWppLdQC3TBU1vmQoAUA28ofVWRGR/+WdH7f5Xn
	 koRpV4sM6CnGQ==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 19 . x" <stable@vger.kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	Junxi Qian <qjx1298677004@gmail.com>
Subject: [RFC PATCH 2/2] mm/damon/sysfs-schemes: protect path kfree() with damon_sysfs_lock
Date: Wed, 22 Apr 2026 07:35:01 -0700
Message-ID: <20260422143503.71357-3-sj@kernel.org>
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

damon_sysfs_quot_goal->path can be read and written by users, via DAMON
sysfs memcg_path file.  It can also be indirectly read, for the
parameters {on,off}line committing to DAMON.  The reads for parameters
committing are protected by damon_sysfs_lock to avoid the sysfs files
being destroyed while any of the parameters are being read.  But the
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
