Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7F73E92BB
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935874; cv=pass; b=PvEGMRqLOriD3dNvdoGagWJwZ7VKUTR9wU5AAisLUVRwQRm4DunkQO90sblZuu8YmgoYC1mosaSygvPbj1fCKoygm8vSirCmHhuHvGKt2BlrycbCX2z+m0rlNGpQ4BDtDdeaH6kX/yNUW/IDNhvH/yIR10igch2xJ1e/ryrl1yM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935874; c=relaxed/simple;
	bh=HNOP+AY8Je/ylVxnYb9OPN9PISdxkUDu1/hSxGJc1L8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LYhLfYxvWefLrzi9oZpybHRGGfFzDC9/3Uxy7eY2yhcWFrXDA9k724bwb/UbDC6t6U6vw/8mJVa2htplwIq1u8POqj03a+z9KLWLHU7oMcJiW3KngzYFF2JqzXW7C8846+piCssGdjJlHAeczJLp4NOCouIbz+Kk/fdMCaLuj+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=J0IrkYMM; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="J0IrkYMM"
ARC-Seal: i=1; a=rsa-sha256; t=1773935868; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CI9a1WdQDHNBO5LmDiXZ+zHg1T9l5jwDZAg9PiwfQxq60i/JHTriM5qT08U8oPIcxQD26D8OssOazDGQh8+5JiLTVu1Tyx6aEdtVVYlEJA+ja2bMOz6vlOKOzKYXwsDeJBi8e0oOlw6MT4bbE90irrgA3wW9+b1t0KMkGuLg/Ao=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773935868; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=yqwjs8HCz1qaJbZTaGQP4LkV0ZgUX/+x9dm2bkSNu3k=; 
	b=WWwwFzjHBE33VKmmHAu1r8RiQU+XbxBxfobcBz34crIsg3KHmQGau1yDNyvcWPI6xTvJkBwPqKmN2rdJy9RW6ZfGhVFS0x0hRkxws3Z+gu2ypOzg66auQRUXUrI8nGmWqgNYTHTApj5kNEVrzXxnlgM4CSQm4KWC2OdL+kCeOaY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773935868;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=yqwjs8HCz1qaJbZTaGQP4LkV0ZgUX/+x9dm2bkSNu3k=;
	b=J0IrkYMMDk78IqYe33PNM3IEF1/Ei8kjFJj8ruD+Q6IEByNziVn+7nB6vKUwWBjS
	4ZJV6b9ItM3eFui+GVQDebf0Ry0MLpXpJM2PH1tR5sLIPfGP0DWtQ9kCYAU8xftu9BF
	u5FQxWjWJvZ8nSD7wt6LmItfc6hVnTBIzdV9eh/Y=
Received: by mx.zoho.eu with SMTPS id 1773935866558314.7705252149991;
	Thu, 19 Mar 2026 16:57:46 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 4/4] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Thu, 19 Mar 2026 15:57:42 +0000
Message-Id: <20260319155742.186627-5-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319155742.186627-1-objecting@objecting.org>
References: <20260319155742.186627-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

damon_sysfs_repeat_call_fn() accesses contexts_arr[0] in
upd_tuned_intervals, upd_schemes_stats, and upd_schemes_effective_quotas
without checking nr_contexts. A user can set nr_contexts to 0 via sysfs
while DAMON is running, causing a NULL pointer dereference in the
repeat callback. Add a guard under the lock.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ddcdc4e35b27..d982f2dc7a2b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1620,9 +1620,12 @@ static int damon_sysfs_repeat_call_fn(void *data)
 
 	if (!mutex_trylock(&damon_sysfs_lock))
 		return 0;
+	if (sysfs_kdamond->contexts->nr != 1)
+		goto out;
 	damon_sysfs_upd_tuned_intervals(sysfs_kdamond);
 	damon_sysfs_upd_schemes_stats(sysfs_kdamond);
 	damon_sysfs_upd_schemes_effective_quotas(sysfs_kdamond);
+out:
 	mutex_unlock(&damon_sysfs_lock);
 	return 0;
 }
-- 
2.34.1

