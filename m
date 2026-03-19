Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8313E92BB
	for <damon@lists.linux.dev>; Thu, 19 Mar 2026 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773936991; cv=pass; b=Y0qvUzxy1PTNVtOIwoBE0Tw/veLPtlQjx9f0tqQ5XhJTgK7g2WXNURLV/CzMoiyTmWjOT3Ed4lQ7T1kWq1QZjH22Wode1lzPAibwWuJhXmOV+LBhtS3zHyVpoUUULFEuNpZRO1Ym2Y8858L2O2xN58IDaldWmSIqp7LI8qkDiQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773936991; c=relaxed/simple;
	bh=Z1kJg7SXIlGXq32b2kil3/eiq518IMmrsRSnWZdxFIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oLuvyQWrf4dU/ArTypylc2amM48B02gR7aQw7Id9E3M8Wg21KydkmtoV8tAJL7S6/ePYzYF6ZJGBDkO9FeSncmiM3YlchqoX3QwIsMI5Feziatgz0KxTWOXCn3L1VFNe6dEmydcLNA7qGV+cw4a+JTmC/un7+mG8cfHxBeE6G3o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=TE3K/LFo; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="TE3K/LFo"
ARC-Seal: i=1; a=rsa-sha256; t=1773936985; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=E7g3oCSFjixydjiK7IdOAi8wuNnmgbl27IcyR3fZJdawkRR48AJtpscaPFp5citgx3tG3CAXwKoLQEpEWhp7HAQ0CnvopcIL5iVPI4SB3KsLuKIRrPwpzpn5SNASMfZ79gPZa3o9Hh9C85AD/AxXhBwEkId4vUnxgRW/A2Xc7Vg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773936985; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=d0jtuyetNK/baxruuDK5kI/GjeQFrtkqpHG/Vh82qoY=; 
	b=bAg+iOT+f5bsdX8pmCKmn5rTvTgSiOhYTkzYzfyac36NqAoUyqDS5xgWV+bSLPAXccAjJGMpitL70hmEbFy2u8+8nK2Ld+tcYvCj9C/UyAcmKka9MO1Qr46zhyFUq2hnixzf8/FHlbo932CYYRscFMxqvWofGBAGEqwtAIAtrvA=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773936985;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=d0jtuyetNK/baxruuDK5kI/GjeQFrtkqpHG/Vh82qoY=;
	b=TE3K/LFo03tMXXAYjw3auNwMi7W6mnVYIQA5rHIU/blAiNEh4DMnz1Vn7zv+TS2i
	7p542x41uXAT4bIE2HMDLkv2G8qriU6ckvXqv2v9p3cpw8cuQuqB54LbwJ0q5L6YjOv
	FDg6xF9hEcvASJBxSi/h7MD8Th2NN1jwGZslD59c=
Received: by mx.zoho.eu with SMTPS id 1773936982644744.0596713495183;
	Thu, 19 Mar 2026 17:16:22 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 1/2] mm/damon/reclaim: reject non-power-of-2 addr_unit
Date: Thu, 19 Mar 2026 16:16:19 +0000
Message-Id: <20260319161620.189392-2-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260319161620.189392-1-objecting@objecting.org>
References: <20260319161620.189392-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

DAMON_MIN_REGION_SZ / addr_unit is used as min_region_sz, which is
passed to ALIGN() and ALIGN_DOWN() in core.c. These macros require
power-of-2 alignment. When addr_unit is not a power of 2 (e.g., 3),
the division produces a non-power-of-2 min_region_sz, causing silent
undefined behavior in ALIGN before damon_commit_ctx() gets a chance
to reject it.

Validate that addr_unit is a power of 2 in the store function so the
user gets immediate -EINVAL feedback instead of a silent failure.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 mm/damon/reclaim.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 43d76f5bed44..9b55df304e51 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -321,7 +321,7 @@ static int damon_reclaim_addr_unit_store(const char *val,
 
 	if (err)
 		return err;
-	if (!input_addr_unit)
+	if (!input_addr_unit || !is_power_of_2(input_addr_unit))
 		return -EINVAL;
 
 	addr_unit = input_addr_unit;
-- 
2.34.1

