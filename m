Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74EA637881E;
	Mon,  6 Jul 2026 14:06:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783346800; cv=none; b=sS+91X/4XapBFhfxeXvjhZXUQpkWS3gSSQmsfrJ8ree6UgIPpzePPwciJsZlgZl1KiZk44Ov/xBnjuBIvO7jlU4fJCn/06T1YBy9t+J6gkOLR/y5juJWvun3ea6BFUFdpFag18VsiAlU8NchqSOeZyw1bFYrLTKgtLgfw4FD/FI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783346800; c=relaxed/simple;
	bh=GcM9WomvUelKQMvW2BzflF22wI+CxMC31EP1q4nla1w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WCrVpmVxDu7fuPtkYuc/W/rfNu71a8CE6Jd+j1mfGD7VF4ATlGqlreYkA4vmAnjdAW7vOAHEKOLsORSkyUuWWF56C6n6HlMCepmw0dOey7D6qFxxpf2LS9w/VDac2L1XlcpImhOiNgnZ037+nfOpRNlP7Nua5iMTs7W09hD9fVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZiKOy0lM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZiKOy0lM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2281C1F00AC4;
	Mon,  6 Jul 2026 14:06:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783346799;
	bh=iM2Eb2ExS7GI1ym8vhWA/m10zp74Amrd4zSKSC4zHiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZiKOy0lMeLh2PW2FXa5ojap4sMpVp3GQYl3FcPgY+K1XqA7WpjRMtbaniCqztdewO
	 Bk6x0P+9IVjzg9OFTpL5TjeuF1UxbPKaT9M1Bw+LesYdBHrMjgPGMSku3usrIjhCdl
	 BN8YFY+YuVf6JoBriEgMhOK9gbXpE2HmMMEllCpsij1gRkH1fojd0zK9YKmWMZe9H6
	 xm/SX0FbvBwr43sfM3xchsEWAXKvwG/7Vu50DENgiKmYdcQx/CCSYsHj0Q7s7+pTK3
	 8ijT5mEhl9kc0H/JjdMiJTxBmVDaMeJEAaQYXeOjdIZ4lFE2TeXEHWaZbbudoBPuED
	 qeYA5DcV1ydLg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 04/11] mm/damon/sysfs: ignore damon_stop() return value
Date: Mon,  6 Jul 2026 07:06:19 -0700
Message-ID: <20260706140628.87414-5-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260706140628.87414-1-sj@kernel.org>
References: <20260706140628.87414-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

damon_stop() return value is guaranteed to be 0.  Ignore it.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b65651498e0d1..6d7e36c9e509d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2262,12 +2262,13 @@ static int damon_sysfs_turn_damon_off(struct damon_sysfs_kdamond *kdamond)
 {
 	if (!kdamond->damon_ctx)
 		return -EINVAL;
-	return damon_stop(&kdamond->damon_ctx, 1);
+	damon_stop(&kdamond->damon_ctx, 1);
 	/*
 	 * To allow users show final monitoring results of already turned-off
 	 * DAMON, we free kdamond->damon_ctx in next
 	 * damon_sysfs_turn_damon_on(), or kdamonds_nr_store()
 	 */
+	return 0;
 }
 
 static int damon_sysfs_damon_call(int (*fn)(void *data),
-- 
2.47.3
