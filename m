Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C55FB3BD641;
	Thu,  2 Apr 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775137462; cv=none; b=BS34YN8SG2yqGOamCy4IHv3AzelhkV9vsCYwEbN7qwMpeleM02axNINrxxXNrLq5xCMZTa0xSdZfOh82pjvunSod4uluhn7oY//o4WVTvKp7PhJikVMTcWMtSb3YY4iCTTjQGe8i85wz5ruY8uVRy0i2GMcuvIuma2hRRq5hD3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775137462; c=relaxed/simple;
	bh=vWy3Mr67e/mUpyvjLCi1g5zQ4l/TF12eriSgynYdpHc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TfJOXEGuGaKN5GDvr5bl1RpdJRfk7a+knHeso9Zd4WHDKN7RaZWAnmvjYd5e4UsOi+eYYvuhDpBecUIBitDLVVkQIhMVprklNGR8l8MC07HDP4lldMd9sLDf6Xe9PyBIktbVzZbNX8wHGh8lt7bRrvH4FAdfFdEBCzuyAY+GZMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GD2w7grr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GD2w7grr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0B5CC116C6;
	Thu,  2 Apr 2026 13:44:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775137462;
	bh=vWy3Mr67e/mUpyvjLCi1g5zQ4l/TF12eriSgynYdpHc=;
	h=From:To:Cc:Subject:Date:From;
	b=GD2w7grrtrr/CZlQzleyPPGReQ7JmOI3FDQy9Qnv2i3qEpYQmSmHG2u1tdK9IB55J
	 27BCM+MqpYGj3aMVBGVj34Zbk7VK93KuJIEJ21BEI6myezF5Z65YwY0pmsoYQLV1pr
	 4d9HL3CdRGCvOCB6ihzmLaMbHwgnCH+HAzerWviXKkjPvV5JIDCZqtaDNUF/PDmN76
	 MFTyY8jOGqzZZasYLp/z4HdtVAmMEJhcyja5WjDRtBGeP1Z+Ukhuky019III8aaSU+
	 VKNl5FxVFjt1XlKqxBuYmt1hd+ZuqNTAEDL+vEnqYxowEHWO50ZQAtH+f50EqJZu+g
	 RzzZ6fOPXdLLw==
From: SeongJae Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SeongJae Park <sj@kernel.org>,
	"# 6 . 17 . x" <stable@vger.kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH v2] mm/damon/stat: deallocate damon_call() failure leaking damon_ctx
Date: Thu,  2 Apr 2026 06:44:17 -0700
Message-ID: <20260402134418.74121-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

damon_stat_start() always allocates the module's damon_ctx object
(damon_stat_context).  Meanwhile, if damon_call() in the function fails,
the damon_ctx object is not deallocated.  Hence, if the damon_call() is
failed, and the user writes Y to “enabled” again, the previously
allocated damon_ctx object is leaked.

This cannot simply be fixed by deallocating the damon_ctx object when
damon_call() fails.  That's because damon_call() failure doesn't
guarantee the kdamond main function, which accesses the damon_ctx
object, is completely finished.  In other words, if damon_stat_start()
deallocates the damon_ctx object after damon_call() failure, the
not-yet-terminated kdamond could access the freed memory
(use-after-free).

Fix the leak while avoiding the use-after-free by keeping returning
damon_stat_start() without deallocating the damon_ctx object after
damon_call() failure, but deallocating it when the function is invoked
again and the kdamond is completely terminated.  If the kdamond is not
yet terminated, simply return -EAGAIN, as the kdamond will soon be
terminated.

The issue was discovered [1] by sashiko.

[1] https://lore.kernel.org/20260401012428.86694-1-sj@kernel.org

Fixes: 405f61996d9d ("mm/damon/stat: use damon_call() repeat mode instead of damon_callback")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
Changes from RFC
(https://lore.kernel.org/20260402045928.71170-1-sj@kernel.org)
- Drop RFC tag again.
- sashiko didn't find any real issue on this version.
Changes from v1
(https://lore.kernel.org/20260402010457.66860-1-sj@kernel.org)
- Avoid sashiko-discovered use-after-free.
- Add RFC tag.

 mm/damon/stat.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/stat.c b/mm/damon/stat.c
index 5a742fc157e4..99ba346f9e32 100644
--- a/mm/damon/stat.c
+++ b/mm/damon/stat.c
@@ -245,6 +245,12 @@ static int damon_stat_start(void)
 {
 	int err;
 
+	if (damon_stat_context) {
+		if (damon_is_running(damon_stat_context))
+			return -EAGAIN;
+		damon_destroy_ctx(damon_stat_context);
+	}
+
 	damon_stat_context = damon_stat_build_ctx();
 	if (!damon_stat_context)
 		return -ENOMEM;
@@ -264,6 +270,7 @@ static void damon_stat_stop(void)
 {
 	damon_stop(&damon_stat_context, 1);
 	damon_destroy_ctx(damon_stat_context);
+	damon_stat_context = NULL;
 }
 
 static int damon_stat_enabled_store(

base-commit: 4fd04f750d79667937931314ed64c9d79b0d82ef
-- 
2.47.3
