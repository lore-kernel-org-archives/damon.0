Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42DE04BB287;
	Mon, 21 Sep 2026 15:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790003758; cv=none; b=mIrIaivjpuQVnvV8Y0+G4DFYIGbZVQpAp3vpNVDkNgW28M8kbVPp2mVlAF3jGZlzD4fVNePe3ZqVVsKPd4ZWmO9De7VHVDPLZQUo5nty47eb6jxGH4dyBG+t9u6fcOdBhea8qv0pUB9+vAk68tJLC7g1e+ibTLmkJwzyAqDQLLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790003758; c=relaxed/simple;
	bh=DPR6iEnvXIpGGW6aHlRtdrZzFLc7F2m+arCoUmoWzHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpZYnK9x95EfLhTL26IwuMjFfDdrriU7AyQ1rj/LSFCUbySGUMMzTdYexE7D+lUK15u2CjM6UYhRqKLBJ3FyjAIMjRFV1hc5xC6xWoGmffLPf+2Txt2+Wfk+8v3VTx6a63smXVCHltgc/YzHMRxz0EqePX+dxe0AnOkF1GA6XFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQw77VEM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQw77VEM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B9781F00898;
	Mon, 21 Sep 2026 15:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790003757;
	bh=Xha6SzRmwzcqbwA6Ea+IAg1MkYKVwpH9imxtGliuizI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IQw77VEM7Ou5+88h9368Ql7ab8uQ+ELYghiXetB2nFdIaW20TrqvhSVvDZDnP6weD
	 EZlwRZVorUuoVbcT6lf8sSnxox/NM/KaANsgNBEGiUSW0absBAa9Q6ORDB3Zu+PZKW
	 lTQplllX1zVhK/PNK2QEI/+LQLaURhvqRBj4HcAgukS0ggS/ADGkYE8y7OivwNDItJ
	 WQChuFPbSVxWfXltkHCpsEiukWlPQRdw43GxOg+1/Lr0Gg2GHJHfdV9fBR59BwDtBm
	 UBvIs+hADqU3Gj38Gkf9XeV356wnbw6bLGfvy3cjTYSCy34K8o596NLeYFZyDJWpl6
	 2H89KZgPcb/pg==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Xuewen Wang <wangxuewen@kylinos.cn>,
	Adrian Huang <adrianhuang0701@gmail.com>,
	Karthikeyan KS <karthiproffesional@gmail.com>,
	Liew Rui Yan <aethernet65535@gmail.com>,
	SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 2/4] mm/damon/sysfs: propagate damon_call() error in turn_damon_on
Date: Mon, 21 Sep 2026 08:15:44 -0700
Message-ID: <20260921151547.78472-3-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260921151547.78472-1-sj@kernel.org>
References: <20260921151547.78472-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xuewen Wang <wangxuewen@kylinos.cn>

damon_sysfs_turn_damon_on() ignored the return value of damon_call()
for the repeat call control registration and always returned the stale
result of damon_start() (0 at that point). When damon_call() fails,
e.g., the kdamond is already exiting, the user still gets success from
the state file write while monitoring is not actually on.

Save and return the damon_call() result instead. No rollback of
damon_start() is needed since a failed damon_call() guarantees the
context is stopped.

Signed-off-by: Xuewen Wang <wangxuewen@kylinos.cn>
Reviewed-by: SJ Park <sj@kernel.org>
Signed-off-by: SJ Park <sj@kernel.org>
---
Changes from v1
- v1: https://lore.kernel.org/20260915093928.3389096-1-wangxuewen@kylinos.cn
- Collect R-b: from SJ.
- Rebase to the latest mm-new.

 mm/damon/sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 43519afb9eb7..70a4b64fb8ea 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2607,7 +2607,8 @@ static int damon_sysfs_turn_damon_on(struct damon_sysfs_kdamond *kdamond)
 	repeat_call_control->data = kdamond;
 	repeat_call_control->repeat = true;
 	repeat_call_control->dealloc_on_cancel = true;
-	if (damon_call(ctx, repeat_call_control))
+	err = damon_call(ctx, repeat_call_control);
+	if (err)
 		kfree(repeat_call_control);
 	return err;
 }
-- 
2.47.3
