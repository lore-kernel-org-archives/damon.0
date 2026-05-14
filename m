Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC1D341AB6
	for <damon@lists.linux.dev>; Thu, 14 May 2026 16:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778776764; cv=none; b=U1mRtdDu5ysPewjC5A9+t/HkZleUdjMMaxP3GJg61gp3r7v2qbR+dhIkMlSO9oIIpIDe0L2BPhnono0UZZSCMl/eVElNoM5b1jQhSjHzBqnQesQo4DzaUInDnaWNG1TA0+sbVVYQErtmImicG+x9TgBFCaW8k9iXUo3M2eOStyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778776764; c=relaxed/simple;
	bh=XfSZL9pRngA26Yd2kjrV4oNEiPnzX/Vr6jxDeDUNHU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YbQ3YykkWSM+hFCpZCzv169AvKqK0E3XB8h2uEIYLywrMm8j1uVe4qbshabQkhN9bydJ6d7x4DC65ukwLGVZuMqRNJCA6nZcnxtO+c3J3n1PBGA4FP7qEuvvW9BEbA7H53hiy2B3esQn/+8p9lUhFhWYSg8ZjUbjgM5FMpKDyiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=UtJa3jas; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="UtJa3jas"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1778776724;
	bh=90sYDCP6cFQeYRuHYppH47Fjaln2BdNElNJWhH85jfE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=UtJa3jasIovLabVthXPoVKZliAKRpQNmUBu/k6Nij7BFGc5+9lV2r6xmdMaA4id9e
	 KbEPEtgrtO+uXpIrSOF9my+73hksJ8zj/3DzLDlvYKVlvDgKfq5ooP+JIj8idRQZLy
	 /YvAok+dPl4abOLWssA+pSBRQMxy8NtjBYW9D9Ug=
X-QQ-mid: zesmtpgz9t1778776714t909b7172
X-QQ-Originating-IP: MYsk0LT490WrBPf+tCsfOZrAcwLQNMcMIuRTkPBsWlE=
Received: from PEN1097 ( [61.183.83.60])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 15 May 2026 00:38:24 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 441675532033700949
EX-QQ-RecipientCnt: 7
From: niecheng <niecheng1@uniontech.com>
To: sj@kernel.org
Cc: akpm@linux-foundation.org,
	damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	niecheng1@uniontech.com,
	kernel@uniontech.com
Subject: [PATCH] mm/damon/core: clarify next_intervals_tune_sis update path
Date: Fri, 15 May 2026 00:37:51 +0800
Message-ID: <D3B0C1F5BB6ADCE4+20260514163751.3399513-1-niecheng1@uniontech.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260514144102.120203-1-sj@kernel.org>
References: <20260514144102.120203-1-sj@kernel.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: MrhTsisqYA8gLo8633ivgZY/ypDo46XMHXBmmZPYvzEHhjOFNwogQbNI
	SrEeJF3qD1ab7SufvyiPC1YpOJNpEWaIXiR5jvJne7bmLWwoti2rQE9tffcs/KgVdzXucAA
	Pyu9wXjszvI+JGsQBJK0gN3t3DlNc6Alf7axIuX9UoRKWk7NMBZYALKVF15gEff6oKQFTY6
	1q74V0ry03H8otDM7Ztg/Fb1pkmL5XcWw5R5IXlyHUlFvaBZ5XH2PB1et425hKMyMBVJw4F
	hwnVeh0fRoBImKAsAkbwzOaPxyzbb3xJPrcXLaou3HRPwohvGEL0mBPipu7Hp7M0LJF5aKE
	MOt5NwX2IF/PQlnhBPQx1hUiagJ5ORf3ZTMZALI+D2C2KmjMPhihKqDVfP9OqJeAONx3qCn
	6XBHJcJcO0krDVOrjRuhfq4oBMTB4nSe9dIN3F46p0S/klD2QucN8hND4tc9yiG5TeeGyt+
	RbN2NpEQACLApivxYFUJm2rL0ERyMqN7MIndnH4AL1P38YUStzEdbcHy49qPzIHLZ2bu1xz
	73FZ4ULw9DyFkTwkm9SCc6sBIfvzDezL3GvQr7JHi249QqBLHuupNecUvx/u13ThyOcRwGM
	jj8Fe9Iyw8j2xVtf6edRmBweURviYjq41lUwdrnrDadETqaXo+BY4666C70/TPCr4111YRo
	KwYVaMuVgRpK9rMi1ravoj5ki1Ibkk5yp1dOclvNaqAzFv9Cc74ozJ+y9J40REYNcC/KyHD
	jkE08AVhkv2QWknLaQ68KAYOEkLFrT1Z7toxATPgYSgkM8HC3LZWFKhJq0ZhO8ZjkS81mg2
	/CM8nhmzmxnK9p0iRNGxV3vpAH1+JH2p5uxvAijCWa2ezLAeQ7jbxNuNhJE3JX12qp3NT/S
	xefTWbR/itkWBQ2g8t2R3u+MCkSN6ZPhU+0hhViSf9WQPSyvNa+M2hTtR8y7CMoHUSmP++d
	kgLasKM2Jhs16UcgKgPLHYAYeT0SHuwYgy85E4SBtYMcu4e0pmOPFid1zNwH6C9QSzNoJl6
	YZjoQFpPNFZbVdQeNnAOHi3avHnDyK1PN+bvIzQPn50soSeySDrnVGfLXooUGGowW1TVtO+
	V2LFOAzqab7
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

damon_set_attrs() updates next_aggregation_sis and
next_ops_update_sis for online attrs updates, but it does not update
next_intervals_tune_sis there.

This can look like a missing update when reading damon_set_attrs()
alone, while next_intervals_tune_sis is actually updated in
kdamond_fn().

Add a short comment to make this explicit.

Suggested-by: SeongJae Park <sj@kernel.org>
Link: https://lore.kernel.org/linux-mm/20260514144102.120203-1-sj@kernel.org/
Signed-off-by: niecheng <niecheng1@uniontech.com>
---
 mm/damon/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3dbbbfdeff71..a21ae41ca695 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -797,6 +797,9 @@ int damon_set_attrs(struct damon_ctx *ctx, struct damon_attrs *attrs)
 		attrs->aggr_interval / sample_interval;
 	ctx->next_ops_update_sis = ctx->passed_sample_intervals +
 		attrs->ops_update_interval / sample_interval;
+	/*
+	 * next_intervals_tune_sis will be updated inside kdamond_fn().
+	 */
 
 	damon_update_monitoring_results(ctx, attrs, aggregating);
 	ctx->attrs = *attrs;
-- 
2.51.0

