Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7DAB3F0747
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:57:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935875; cv=pass; b=DfhznS1n+VrsCX9bTzWA2IqOZQAy3wYtS0dLfQ9AvKqkO1vH/vQyNpeiaGlg5HMjSyw8DSWulRMYxi+DDmleFNijbZ9epQmNTRRrfdC7wAHtCVopowpsT10rjy9ubS/kJfdoN9+1utmx7BXzlntQdl7g2RRdKUQcb/DYKoJY0ak=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935875; c=relaxed/simple;
	bh=JwbG40T0+NjSJqHxSwdAXN46+ePaQd8chNYzGTyPLxM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=H9O3hB02dqROq2tRI7a4zW5bhcNnBT19NDtcPuOwv6vZItoevTGaf/1k7Mbd1xebLC903bFyWWxMkUDSn3TvyTQ/oweYgm1QXKdTh1Dcnw3rUsxzFuEzoe16EaYl85/V2oPyjMabK5VAMAiLHXsoJ6+sBlkdBVjuwCLC84k0LGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=W5gcWnu/; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="W5gcWnu/"
ARC-Seal: i=1; a=rsa-sha256; t=1773935868; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=c+tKqOHY9UPTynVSBbutAl+9RnHzVGguG2Um28Y7dXBKuOWFS1y7jnvi/52w0+QfEFHdrddMrknOOSKHCqwIPHWZ8rbXdPIpMDbWxrAfmjz/KCSue4h2kGYKHBIR7Hk4/IMRjluq4REqhbGoKI5bFDblcOHUpg00ic5bwaNZzKY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773935868; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=IqBZZsdChXPych6lUYI4fPOHNYXnLYcU1he98Py/HTM=; 
	b=KguRJssY07DB9GtFnwQrBywG8WzY9Lmd0r4H5hR8QwsvyKAPEdOHNw2SOGaAC3HIgANTnmR8ZgK6od0S4UJm8Ss/ezcAimhUnaYlcsIguxpzIa07UGBQVS9lRUla70oo6WCIrOYprQw4vRigydSfUFfc6rWlaI5QiB6XsYBLxjo=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773935868;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=IqBZZsdChXPych6lUYI4fPOHNYXnLYcU1he98Py/HTM=;
	b=W5gcWnu/w4EL90obqxJ2PnFbcQYOeauhiDKhqN1sO6UBQ5uZBb1ofNh0Wz5t1uOf
	h+AJCppag9NSvtLfHBWi3q/8E2SsGvP0NypykQuMnJYa/zBqOxy1b+v5dR76b1wBvVI
	eWIE3hzRkPLnt9EtTICS2CbkErWJ80esNjmkU4YY=
Received: by mx.zoho.eu with SMTPS id 1773935865417260.7882034743719;
	Thu, 19 Mar 2026 16:57:45 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 2/4] mm/damon/sysfs: check contexts->nr before clear_schemes_tried_regions
Date: Thu, 19 Mar 2026 15:57:40 +0000
Message-Id: <20260319155742.186627-3-objecting@objecting.org>
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

The CLEAR_SCHEMES_TRIED_REGIONS command accesses contexts_arr[0]
without verifying nr_contexts >= 1, causing a NULL pointer dereference
when no context is configured. Add the missing check.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index b573b9d60784..36ad2e8956c9 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1769,6 +1769,8 @@ static int damon_sysfs_handle_cmd(enum damon_sysfs_cmd cmd,
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_TRIED_REGIONS:
 		return damon_sysfs_update_schemes_tried_regions(kdamond, false);
 	case DAMON_SYSFS_CMD_CLEAR_SCHEMES_TRIED_REGIONS:
+		if (kdamond->contexts->nr != 1)
+			return -EINVAL;
 		return damon_sysfs_schemes_clear_regions(
 			kdamond->contexts->contexts_arr[0]->schemes);
 	case DAMON_SYSFS_CMD_UPDATE_SCHEMES_EFFECTIVE_QUOTAS:
-- 
2.34.1

