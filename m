Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795727191;
	b=bO3BL7BfKs20rW7pOvpkc7XR5KKsSRgscpyBAaqkBui8dKOEYH8GGP75FjRgjAdBwFip
	 JKcmY3jGiDKm3Z39SsMiwAKfRQ48R0bvKsneeq6Veb5NYBLHVUy/kMZMy0HS4x9W8yy9W
	 w1+M9YChLWKX0NHjxz1sUf4V8VIUrpwQJoELsbtCc1Rj9zMrAhQNy1xizIrPOQUbeIYje
	 BTQwpzQyAWN+F/H67Cz0HL0XAsMAxjY0m7xFnewBBmsv4jGAOTknp1SIkW1dJ68A1hoqu
	 Ohiahssa4JWE7uRkW/53ftJIZv66psG6ShLH3CgFv8EptB+HLX7bkre8W1bW8cJy2RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795727191;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5C1Fnmr3G939IHc82nwcjXrz6u8/TH6WDAdqRMpaBxg=;
	b=zYX1TBaPY9tuDN2pkUcy3BPWkP+0/T5K2sJovrcwv8OqEASn8aLWqfnItUhvVk3culS7
	 SJuLkkddnKJewfQSCCcYR1Y+JnBR8WIHKjkyVKfi/Sdhz9XxxpRsaGicuqJtg16PQzzeT
	 JRObd/A/q9Vu8t0eOuddTfYQ4cesMIyzveX4+5AFIxGyh57Ndwp922x0ESE8onbfp0If2
	 byq3aETLD4cI3/tVh6scaf7S3TOAaqUz4xJqBZvL640It112d92H0LfBQ/fZop0wcvaZg
	 1cV3QR2uEcjlwuCHUowcWTNBurPqD82OKG+/z38r+8o7OnggR3hxhFlE/QZj+br02ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xmi5SGfd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4525606A321
	for <damon@lists.linux.dev>; Thu, 26 Nov 2026 21:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Xmi5SGfd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B3461F00897;
	Thu, 26 Nov 2026 21:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795727190;
	bh=5C1Fnmr3G939IHc82nwcjXrz6u8/TH6WDAdqRMpaBxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xmi5SGfdU0kzg0I+KEwljZ3BnPTv8vnJLZ2NblUdjVNMx8vqIJNniF2GrOUz1K87O
	 ZSrBzHWQZoHhc9+WXblmSbIpI3D0G+tR8taErL3DIa3E5ixcbXjDOtg5U6NOKQRW2h
	 kHHg/XW9ewZpbJ7sDdC3U6hYtZPz2NYCGaoU77vc+cDTh8wjq/dzKznCs6wIW7SjKV
	 iXAfkTrTckgon9Y1V4npdN8FGubP3dZRT1IsxDvTC8D7YqR6oNedsy0JQAba0OCcmu
	 qMI4e9CAeifoQU7P43hZY8YUdIOSF77LpxDRFSjszc/WdPje8M0tOFTgqueE3gWxiO
	 TZgC1OJF+xgEQ==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] mm/damon/sysfs: use damon_sysfs_cmd_names in state_store()
Date: Thu, 26 Nov 2026 13:06:15 -0800
Message-ID: <20261126210619.97634-3-sj@kernel.org>
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

Update kdamond state file write handling function to use
damon_sysfs_cmd_names instead of damon_sysfs_strs.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index c76063b703a4a..e0ddf4ed5dbb3 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2848,14 +2848,17 @@ static ssize_t state_store(struct kobject *kobj, struct kobj_attribute *attr,
 {
 	struct damon_sysfs_kdamond *kdamond = container_of(kobj,
 			struct damon_sysfs_kdamond, kobj);
-	enum damon_sysfs_cmd cmd;
 	ssize_t ret = -EINVAL;
+	int i;
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return -EBUSY;
-	for (cmd = 0; cmd < NR_DAMON_SYSFS_CMDS; cmd++) {
-		if (sysfs_streq(buf, damon_sysfs_cmd_strs[cmd])) {
-			ret = damon_sysfs_handle_cmd(cmd, kdamond);
+	for (i = 0; i < ARRAY_SIZE(damon_sysfs_cmd_names); i++) {
+		const struct damon_sysfs_cmd_name *cmd_name;
+
+		cmd_name = &damon_sysfs_cmd_names[i];
+		if (sysfs_streq(buf, cmd_name->name)) {
+			ret = damon_sysfs_handle_cmd(cmd_name->cmd, kdamond);
 			break;
 		}
 	}
-- 
2.47.3
