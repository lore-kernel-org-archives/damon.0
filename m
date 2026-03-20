Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5747336D4EF
	for <damon@lists.linux.dev>; Fri, 20 Mar 2026 16:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774024507; cv=pass; b=O+DjGN4+BxmDFv/WGo4aLQHyXqXgiUwagMiFkuLZfdO4aI1HsNw680/nMxsEX9rmzuu/x/5PFAjEFVmCWhxNF9wvKHMEHOfYKZNW1cJ2zC1p8zvpBUR8JP/oyEfahT06/hb0J1xvlfLA2njw6HZbKwmxVeAYwgmFKq6w1dHfncc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774024507; c=relaxed/simple;
	bh=cgiBTMTJREfr9NZlbEJek9bHXIpKX6CcaXj/YeMtBG8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=S9lA36yjvaXWXBqTJ40HL+SS42F2rZIOTKlvvPKmmDaDvuTaCN/QfNcNUHtBul6pX/PqYwcbWJnvoDzMHTkhDxKL3gxAXDvC/zSXOP5ABZPQsjH19YDEoFwUp5MgZZn9XC7vnaQN1uMnRiswqGIXn9/3LVvqrIvg0boAB+qEMmE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=Hv3tI7JR; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="Hv3tI7JR"
ARC-Seal: i=1; a=rsa-sha256; t=1774024502; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=ib8kwpn8dNp5OZHqnnzAbKJMATnVcFDJQg/zVJjEF1X/W6cFlqFAqO1K1iCTAYWKYS0T/lL1cbcdd7df3OTiTXx9aA8VY39fW7R9JEZneHJRIy6Y9/EGvCO5UXuILJ+MQ4fKLiv982Uz1hIXBvLH31q7bDV0jFGgCSXLuqdIJ90=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1774024502; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ZOAuFTk2fYZ7Opzh+m6bCHOI9jrLB+RqVBg8xOebPgo=; 
	b=jsnsQuHIDz3A0KEJON+y3CqSj39VA3pUL/1HvoeZwBvxeYvqUpQ2qw7u1xvYa7xZ7YjqHj+c41eqZEoaym4OSK4IsyMX9ZjMufI0AxRyqiw9vzBcySSfGECwXx8/BJXI/6ALhSDxoob7fzu8Pvs/aqhJS/d3v8/XgHeZa1E0hgg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1774024502;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ZOAuFTk2fYZ7Opzh+m6bCHOI9jrLB+RqVBg8xOebPgo=;
	b=Hv3tI7JRMvRtELu3gZiddNNmKoqDZ6PrKjuxj5ABQajrVO4wSE6xhrnmoyYdTpmO
	1j8ztNQo67K8kOPwH8LK3veR1tF6bzuetMg/2tSNsUj/9iwoZFMrYaHUH2Uhlf9Ki/D
	UTAzpBVNaBt1x/3LQd2dvkFiHrIKB4+OgO3VdU9k=
Received: by mx.zoho.eu with SMTPS id 1774024499391760.4421752723017;
	Fri, 20 Mar 2026 17:34:59 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] mm/damon/sysfs: check contexts->nr in repeat_call_fn
Date: Fri, 20 Mar 2026 16:34:56 +0000
Message-Id: <20260320163456.177750-3-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320163456.177750-1-objecting@objecting.org>
References: <20260320163456.177750-1-objecting@objecting.org>
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

