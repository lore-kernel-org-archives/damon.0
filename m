Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727191;
	b=nICxuILqOwmRvhChnSOMABj/jI+51q9AMjRwB17MFkhGaqpGSh6T1csbmH+Tn3WLeh35
	 s6py7Q4e/TagrkeHO07oxQ4SK5W6AKBAnIy0uPmIvMm5r3TCJR1V6dmFeQK+7iziiGBNy
	 4X+7LA8Vt5BP+APmTFsAOf23LMH06t7qP0jc2BfjR1jDLOVS2cMm5xSbzJ1Kcq/byK6Cg
	 Aw7xpuo1oNNOQj8HLuzOLR5CzJX1TiP8NMwNGe0pzNitDYZd5xiFj4U+vcmvfCVUeR+dS
	 0KUCC0Qu0Yywc6+XCTz7nzY0pw/udFwhVLseT3I/hC31/fwenVRyes39uM49emS24HA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yUbztBrsqn4RHPvpcYlZWejTXQHREOkSwYN78+WQ4Lg=;
	b=V68Ul5TNPrV+22jL8WvkesoOa4csHmXZ4DJ8Usr2wY4wzcp8kLwdzvIu80MeX40mxqTz
	 6awj+/0Z5O5SFfpFI1MSmRh+f3UsSwqeAxLHbA21NKkzLxkCoa9NSbPErhM1Mh04VpCU/
	 BSPcelWzCH8DAopxuR4ni7S0DorudPDEpoJbn5WxJk2Lw2xuNwPAQRLgoHB9eNTkKsqeB
	 hD1Xs8JWmih5ZZCH8LZdB9CbJNxu6VvQbFW2l5YnwouC50HjlSdkh9BjjtjRPcT0SfKW1
	 8iVI0WGi1Hum8zMPwYQFrmZF9FsExkHyyK2DfdczH9ICm/ay9XzTNka17KGxVy+d1Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdlukMeq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0AD606A31C
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 21:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XdlukMeq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DED801F00896;
	Thu, 26 Nov 2026 21:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727191;
	bh=yUbztBrsqn4RHPvpcYlZWejTXQHREOkSwYN78+WQ4Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XdlukMeq7xpgGHc27DpOm8kgjaGNYgkfnQpZ8FjwdJgWlJrW1PWW1u/sFOLrHqEvp
	 /CNhy0h/iBmCV/kO8ZarL2EN6e1En00c1b1Nnvf/QFBGipPnDmDZP62eg8GBVWR4xn
	 c6YyErTzTF9TDPw3RsKqewV4rcxNsSv+iY1obcL64PoL5QWQGp+64SG17DMtZSUq12
	 tTLRHgUcR+zcjYFGYX1A5cypHtmTEMstHiGZUBW3WjWu22qkYe0ewZ4N5eRc0D1X58
	 8yhXTLbIv+e6tZrrpAmWy60ihx6Kl47KnH6lfXxxBvpXwUXkrJcrFLhoyQOpbuORth
	 bxbKZU4kguDBw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH 3/4] mm/damon/sysfs: use damon_sysfs_cmd_names in state_show()
Date: Thu, 26 Nov 2026 13:06:16 -0800
Message-ID: <20261126210619.97634-4-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261126210619.97634-1-sj@kernel.org>
References: <20261126210619.97634-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update kdamond state file read handling function to use
damon_sysfs_cmd_names instead of damon_sysfs_cmd_strs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index e0ddf4ed5dbb3..5a91a1c3e4389 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2309,6 +2309,8 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 			struct damon_sysfs_kdamond, kobj);
 	struct damon_ctx *ctx;
 	bool running = false;
+	enum damon_sysfs_cmd cmd;
+	int i;
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
@@ -2319,9 +2321,15 @@ static ssize_t state_show(struct kobject *kobj, struct kobj_attribute *attr,
 
 	mutex_unlock(&damon_sysfs_lock);
 
-	return sysfs_emit(buf, "%s\n", running ?
-			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_ON] :
-			damon_sysfs_cmd_strs[DAMON_SYSFS_CMD_OFF]);
+	cmd = running ? DAMON_SYSFS_CMD_ON : DAMON_SYSFS_CMD_OFF;
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_cmd_names); i++) {
+		const struct damon_sysfs_cmd_name *cmd_name;
+
+		cmd_name = &damon_sysfs_cmd_names[i];
+		if (cmd_name->cmd == cmd)
+			return sysfs_emit(buf, "%s\n", cmd_name->name);
+	}
+	return -EINVAL;
 }
 
 static int damon_sysfs_set_attrs(struct damon_ctx *ctx,
-- 
2.47.3
