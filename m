Received: from invmail4.hynix.com (exvmail4.hynix.com [166.125.252.92])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63882257449
	for <damon@lists.linux.dev>; Tue,  1 Jul 2025 08:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=166.125.252.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751357984; cv=none; b=FiCYwfWhLqIEF/sbULTY9qHouWWE/smLeynEBDvASMyzV9kMuM1OyMkON/j9/d7sKEaVYAvbcMBc9nfOHQCWIn+xNzcl1TsCapHSrUd2kT2/OqArvF69LNvYXPBZlWs4BhOfuyiK2HsmOgqGzNfVJoT47H6rPHZteub74Wye4Lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751357984; c=relaxed/simple;
	bh=IxrfPd2GVOx9majyC4eQ4na+7mB3lDsc0oVVOgH8nfM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pzCfNYtxnRwj8CZZUF43Z/QmJMsdLb7gGbJHmQa+zVezPXr7CAXPEjSvS0PXis1xkvnlSk9iJtXStRGXsCJkPlrOTgEf2nm81cqBUkjQQeK8cW6Ol93WZdeiiIPdiZvqVagIAq+tu2AA7q2PZq5SlNPCVVPwn0ntQQEYF0GNIJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com; spf=pass smtp.mailfrom=sk.com; arc=none smtp.client-ip=166.125.252.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sk.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sk.com
X-AuditID: a67dfc5b-669ff7000002311f-c9-68639a132d92
From: Honggyu Kim <honggyu.kim@sk.com>
To: SeongJae Park <sj@kernel.org>,
	damon@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	kernel_team@skhynix.com,
	Honggyu Kim <honggyu.kim@sk.com>
Subject: [PATCH v2 1/4] samples/damon: fix damon sample prcl for start failure
Date: Tue,  1 Jul 2025 17:19:23 +0900
Message-ID: <20250701081927.1873-2-honggyu.kim@sk.com>
X-Mailer: git-send-email 2.43.0.windows.1
In-Reply-To: <20250701081927.1873-1-honggyu.kim@sk.com>
References: <20250701081927.1873-1-honggyu.kim@sk.com>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNLMWRmVeSWpSXmKPExsXC9ZZnoa7wrOQMgxPbdSzmrF/DZvHk/29W
	i3tr/rNaHP76hsmBxWPTqk42j02fJrF7nJjxm8XjxeaZjAEsUVw2Kak5mWWpRfp2CVwZq++s
	YypYIFBx+f951gbGLbxdjJwcEgImEhv/TWWGsb/+aWADsdkE1CSuvJzE1MXIwSEiYCUxbUds
	FyMXB7NAE6PExl+dbCBxYQE/iW2z4kHKWQRUJSZeO8YOYvMKmElcf/uTBWKkpsTj7T/ZQco5
	BcwlVt0BKxECKpn34AYLRLmgxMmZT8BsZgF5ieats5lBVkkI9LBJvNvzEGqOpMTBFTdYJjDy
	z0LSMwtJzwJGplWMQpl5ZbmJmTkmehmVeZkVesn5uZsYgUG4rPZP9A7GTxeCDzEKcDAq8fDO
	OJmUIcSaWFZcmXuIUYKDWUmEl082OUOINyWxsiq1KD++qDQntfgQozQHi5I4r9G38hQhgfTE
	ktTs1NSC1CKYLBMHp1QDo5ugwW3dEzebbMq+XWphS4qMPOe54enm7meFm0+6JS9InVVv+Vao
	98TLh77Hu+Tn8nJOv+c4q/v1D6OP/9Se8K5x/cL6PfdL3IyI0NP90U1VMxfsE7sdkZclvuNk
	5zLV6N8iThudP9llfZ576E+TuE2B84abMsv8nE+utDjhGN74aNkkVclLy5VYijMSDbWYi4oT
	AQibBLQ+AgAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNLMWRmVeSWpSXmKPExsXCNUNLT1d4VnKGQed6dYs569ewWTz5/5vV
	4vOz18wWh+eeZLW4t+Y/q8Xhr2+YHNg8Nq3qBBKfJrF7nJjxm8XjxeaZjB7fbnt4LH7xgSmA
	LYrLJiU1J7MstUjfLoErY/WddUwFCwQqLv8/z9rAuIW3i5GTQ0LAROLrnwY2EJtNQE3iystJ
	TF2MHBwiAlYS03bEdjFycTALNDFKbPzVyQYSFxbwk9g2Kx6knEVAVWLitWPsIDavgJnE9bc/
	WSBGako83v6THaScU8BcYtUdsBIhoJJ5D26wQJQLSpyc+QTMZhaQl2jeOpt5AiPPLCSpWUhS
	CxiZVjGKZOaV5SZm5pjqFWdnVOZlVugl5+duYgQG2bLaPxN3MH657H6IUYCDUYmH1yAvKUOI
	NbGsuDL3EKMEB7OSCC+fbHKGEG9KYmVValF+fFFpTmrxIUZpDhYlcV6v8NQEIYH0xJLU7NTU
	gtQimCwTB6dUA6P2usuP1k3wk3gjo7vLJsm+xLvzGyfTi/P2a32XXDcqv+0Qnrmg/NwEfR95
	t+Ld1zXXvNrM/OfI23b+zXEB1/YmOfHqeSy+Un/WzTT2gYvjl9DrrZvYVzh0fA//toXVPfXe
	jqW75yaa5N09oVL83DNg3oGm9l+cbdGfTh1+qjFbKcha+GDzo8VKLMUZiYZazEXFiQBX7YBA
	LgIAAA==
X-CFilter-Loop: Reflected

The damon_sample_prcl_start() can fail so we must reset the "enable"
parameter to "false" again for proper rollback.

In such cases, setting Y to "enable" then N triggers the following
crash because damon sample start failed but the "enable" stays as Y.

  [ 2441.419649] damon_sample_prcl: start
  [ 2454.146817] damon_sample_prcl: stop
  [ 2454.146862] ------------[ cut here ]------------
  [ 2454.146865] kernel BUG at mm/slub.c:546!
  [ 2454.148183] Oops: invalid opcode: 0000 [#1] SMP NOPTI
  	...
  [ 2454.167555] Call Trace:
  [ 2454.167822]  <TASK>
  [ 2454.168061]  damon_destroy_ctx+0x78/0x140
  [ 2454.168454]  damon_sample_prcl_enable_store+0x8d/0xd0
  [ 2454.168932]  param_attr_store+0xa1/0x120
  [ 2454.169315]  module_attr_store+0x20/0x50
  [ 2454.169695]  sysfs_kf_write+0x72/0x90
  [ 2454.170065]  kernfs_fop_write_iter+0x150/0x1e0
  [ 2454.170491]  vfs_write+0x315/0x440
  [ 2454.170833]  ksys_write+0x69/0xf0
  [ 2454.171162]  __x64_sys_write+0x19/0x30
  [ 2454.171525]  x64_sys_call+0x18b2/0x2700
  [ 2454.171900]  do_syscall_64+0x7f/0x680
  [ 2454.172258]  ? exit_to_user_mode_loop+0xf6/0x180
  [ 2454.172694]  ? clear_bhb_loop+0x30/0x80
  [ 2454.173067]  ? clear_bhb_loop+0x30/0x80
  [ 2454.173439]  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Fixes: 2aca254620a8 ("samples/damon: introduce a skeleton of a smaple DAMON module for proactive reclamation")
Signed-off-by: Honggyu Kim <honggyu.kim@sk.com>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 samples/damon/prcl.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/samples/damon/prcl.c b/samples/damon/prcl.c
index 056b1b21a0fe..5597e6a08ab2 100644
--- a/samples/damon/prcl.c
+++ b/samples/damon/prcl.c
@@ -122,8 +122,12 @@ static int damon_sample_prcl_enable_store(
 	if (enable == enabled)
 		return 0;
 
-	if (enable)
-		return damon_sample_prcl_start();
+	if (enable) {
+		err = damon_sample_prcl_start();
+		if (err)
+			enable = false;
+		return err;
+	}
 	damon_sample_prcl_stop();
 	return 0;
 }
-- 
2.34.1

