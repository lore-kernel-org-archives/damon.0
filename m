Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4143326B755
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024569; cv=pass; b=KoPpEktKjcALei32rnGZCZ2HIkOQlWKco6DGvTTtujf7XMIsO/6ghZwZs43fHO6mMC1uXctiA9IU+GHNMFAbtl/4j+E0fhYWX9qpT9rPiXUyFQFmQJgk+y4lPzSUNu7rkn3qefJHtkWZpzWzAiRX9B0dtl45EEOvkBt3YNM5a8U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024569; c=relaxed/simple;
	bh=cgiBTMTJREfr9NZlbEJek9bHXIpKX6CcaXj/YeMtBG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KhdwsUrNfoG4rrPbLom3KyCYQwEUCFZPE8Jpsf1AMDNp0vp1hgKgbgikogaCi6yq47Pw6R1G6nFGA6Hz95Xf2+ZiVQGgISQVEhZ1D1f3Kn1MBuIADpAWucrw+q88q2hdNvXxR3xLbP4nj7dIzlTg6YZtq0gjBJR1qwY2G7nsbxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=XWOS+2BX; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="XWOS+2BX"
ARC-Seal: i=1; a=rsa-sha256; t=1774024565; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=fbWEpYSnPQTKtwmxLGF8DiucdelmuuJUj9/4VuCbp+XgAewF4l+1KCKx8Fkzv67o8Ls8PTpkl+9z2CAXKZGm1TAoYBA3N8M8wHT+0RZUcXZR057gnHceIDQPGFL9qVdsja79K47phyi4xWEzAn5d5oxH41liILMxCkpScjDqh3Q=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774024565; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZOAuFTk2fYZ7Opzh+m6bCHOI9jrLB+RqVBg8xOebPgo=; 
	b=Q2yYD6NbDrV08oAoO5q/ZU7Dfusf9m7lEJVhMZZ1xji9eC29XTJjQJfMAGaGEWcpeO5khPUxAsvSUnBZ+S/L2LcTip3c1W/DVmhGcOOqOMucd6suqFkr5fHOzsp6S2jy2YfSXwq9lfitGHNvNcD0NjUeyje/fFA389pukhH0pCI=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774024565;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ZOAuFTk2fYZ7Opzh+m6bCHOI9jrLB+RqVBg8xOebPgo=;
	b=XWOS+2BXKdlYAbPn9t42aq7nKVQnYSzg/WNvGmRcVR50uBMfSETecgYHhS0XdSN6
	80u4Ki2v/rnDLWAfENyt73PNk+yOi41535uTwU78G+HpMfkZ7SPF0B6MzofZu3DGI/S
	Ur2DmBgXu9eWcivL358u1yZOF621JYGDkormrTOo=
Received: by mx.zoho.eu with SMTPS id 1774024562740540.8427781838304;
	Fri, 20 Mar 2026 17:36:02 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/3] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Fri, 20 Mar 2026 16:35:59 +0000
Message-Id: <20260320163559.178101-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320163559.178101-1-objecting@objecting.org>
References: <20260320163559.178101-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

damon_sysfs_repeat_call_fn() calls damon_sysfs_upd_tuned_intervals(),
damon_sysfs_upd_schemes_stats(), and
damon_sysfs_upd_schemes_effective_quotas() without checking
contexts->nr.  If nr_contexts is set to 0 via sysfs while DAMON is
running, these functions dereference contexts_arr[0] and cause a NULL
pointer dereference.  Add the missing check.

Fixes: d809a7c64ba8 ("mm/damon/sysfs: implement refresh_ms file internal work")
Cc: <stable@vger.kernel.org> # 6.17.x
Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index ddc30586c0e6..6a44a2f3d8fc 100644
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

