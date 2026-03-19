Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6302E3EFD20
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773935872; cv=pass; b=F+eEcRkg8DPvow2J0RfQczqRpOAD5ta1CWxnUDknzcUGYmyA7tMjSOETF4XaNLIQmGIcTTyrxw18HnINpCZ5J3KWkLthNQ+8ypmxb+fDJ6bwvbllvmCuj9N4uOlpl9CK6ddeFdAxyaRiTz0UUTvNFp/MZ1nThztGRd0fU4QmaBk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773935872; c=relaxed/simple;
	bh=47Ps4uc1aNE8vYAe60YuDpBgoZTPi8UZ64vuMeXP3YU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AoCMR46qoIxZaJ4PhG4VnFtHKIhsOAH2EkKrT5W9QbLTvGSlfi2KwTaD4HGPyVNdhRK2DNlI8m9rS0/563aMUy90Goe+3IG+YdXiDbmv7QRqPdUloz64NghKgdJmZPPU3ny3gOwdJ3V05+76GcP8yJ31FFrLlwXebosqYXv4TbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=jziCpude; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="jziCpude"
ARC-Seal: i=1; a=rsa-sha256; t=1773935866; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cZWR/Rkxj1mC+DXgVZG57Be1vldOsmajFeB0+WgVBbAWDLVaEyJUWS0DssGHHobkV9JlaC9yQZMWmCEKGNcWNvSH8xbtdsIZ7kOi7oXEBQMtvJcKYTydh6nr25mQUNGwzAaw7+/uYT94NMGQO08X/kepJtyDARH+8uqjjPlHVKo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773935866; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=VCdnk7LCAdQl2Oinq44p2WouG2Ln6vJSbhR4GoqiOIc=; 
	b=FpY9eFVneWtMNhwTt6wg/IjSOUw9LAVw7w2LP5frop0WtrtvhVW1APRu6QcLEZNZgFB60nQvfGy6qEG1M7ReqtYcbkupjKnT23hvijoWc8TdMK9eXx7a+rxiO7glkQYICGGFnaS5j31doVRRzGK2ctk/QgqwujH96ahDPH0YSU8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773935866;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=VCdnk7LCAdQl2Oinq44p2WouG2Ln6vJSbhR4GoqiOIc=;
	b=jziCpudeDNVDmPyr3561UEvWdaVDVwTSd95V9uGmdiN1TUKpqm+em7I5nGHSKs3g
	fF40Zk/ylVrPhxFQ6vJwZzd8A7iuGK/uT0TCMvDULjT98mBA39e8wG7ZfidoAJonY3d
	aDy0amaHOZSDFGU9bCZ+zWvyKBW3o8zILKvv1ORE=
Received: by mx.zoho.eu with SMTPS id 1773935865996405.19165630086957;
	Thu, 19 Mar 2026 16:57:45 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 3/4] mm/damon/sysfs: check contexts->nr in update_schemes_tried_regions
Date: Thu, 19 Mar 2026 15:57:41 +0000
Message-Id: <20260319155742.186627-4-objecting@objecting.org>
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

damon_sysfs_update_schemes_tried_regions() and its callback
damon_sysfs_schemes_tried_regions_upd_one() access contexts_arr[0]
without verifying nr_contexts >= 1. This can NULL deref if damon_ctx is
non-NULL (preserved after stop) but nr_contexts has been set to 0. Add
the missing check.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/sysfs.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 36ad2e8956c9..ddcdc4e35b27 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1731,6 +1731,8 @@ static int damon_sysfs_update_schemes_tried_regions(
 
 	if (!ctx)
 		return -EINVAL;
+	if (sysfs_kdamond->contexts->nr != 1)
+		return -EINVAL;
 
 	damon_sysfs_schemes_clear_regions(
 			sysfs_kdamond->contexts->contexts_arr[0]->schemes);
-- 
2.34.1

