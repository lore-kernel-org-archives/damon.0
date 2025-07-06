Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8FDD2BEFFD;
	Sun,  6 Jul 2025 20:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751832038; cv=none; b=J9uvbUBS6+nItXFcbTJNgMGZCtNFc9Gp6mTaGEppF7WwfyK/ZrWVPCkdh1u/do/pjVVF6qFgTl9RaOqteKlKgUAqwdjdaV44DEHmAwsIgHb0CnV3lOpoVdrojSiV1+Y0Xr3WMe2YlVOLHkXibhPIoWaJp1ZSqoE1yl/yLjXULF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751832038; c=relaxed/simple;
	bh=kLOfiDb8Ht5Pc8uz232F1LSFeR+9kLoSLkkKWHCAI6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CBArUQ3+fZX9E1PsRfyzIWrKML6HWpqITzFg6VvhD4LAxSpIElwqI6M2w4LXAtr2j/i3Ga2XQT9B2F0Er/J6dJ5JQ7wwt6cigAupwgAzsJ3v6iXp/1NGHcXAemSrEgnBCTj3ngOpHj4nxywJH/v60nWB/q6vUMVCDgp5R2u050M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZRaIKFXz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRaIKFXz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC664C4CEF2;
	Sun,  6 Jul 2025 20:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751832037;
	bh=kLOfiDb8Ht5Pc8uz232F1LSFeR+9kLoSLkkKWHCAI6o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZRaIKFXzcU07eh1mdY2khZ0+YNhmNoYObMGqNWDba45n2BlbuEkeqD1PVAk4iK1WL
	 jb2tkMYAZtZU25BgswhJ9W12rvJzuUrP4jBMfAaHFpmCulGeRS9QEquMuZK9ZPH1Bp
	 NXLp7dVzMRyzpo3TX1nle9+UXSF+f4NrgJ8ujAf66PYOulrvzc8/aDdtPie5Fkmd1i
	 +2LcHYO913Ruui3vWSlRy8KluXD2pA5KtDmA8aLQoAeWd5+OkUNXsEOM5FRbJJcuSe
	 Ksel7wrXbzlVhK4HRdosao13Bm8SGEIzmwyGax3WEU/4ktM5Z5kpz9UsNFdAbT6tRx
	 K85LQXeO7STcw==
From: SeongJae Park <sj@kernel.org>
To: 
Cc: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	kernel-team@meta.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 12/14] mm/damon/core: destroy targets when kdamond_fn() finish
Date: Sun,  6 Jul 2025 13:00:16 -0700
Message-Id: <20250706200018.42704-13-sj@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250706200018.42704-1-sj@kernel.org>
References: <20250706200018.42704-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When kdamond_fn() completes, the targets are kept.  Those are kept to
let callers do additional cleanups if they need.  There are no such
additional cleanups though.  DAMON sysfs interface deallocates those in
before_terminate() callback, to reduce unnecessary memory usage, for
[f]vaddr use case.  Just destroy the targets for every case in the core
layer.  This saves more memory and simplifies the logic.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6d526c5263d3..719373bcfaad 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -2617,6 +2617,7 @@ static int kdamond_fn(void *data)
 		running_exclusive_ctxs = false;
 	mutex_unlock(&damon_lock);
 
+	damon_destroy_targets(ctx);
 	return 0;
 }
 
-- 
2.39.5
