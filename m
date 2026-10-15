Received: from flow-a8-smtp.messagingengine.com (flow-a8-smtp.messagingengine.com [103.168.172.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41605293ED
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 13:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792072572; cv=none; b=InQ2F6+3IPJLGOOgyrqTsQ7GsX66nUl2eO+eyIl4cOp7DIIJ8Jkn4++218hPGoExo1IVDBT/GK6z9SYIMPALk9cG27OQ3cgPqeTS5BTSe+abnES6yUuq1YhE7S2WmJOs71SXNKXXKUcBkJh8S7BZ6qCHkeKwEma7AhmDHswiq10=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792072572; c=relaxed/simple;
	bh=yVu6IvLdlbItjVbGSeytArgWjbLhLMf049inMbErsd0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MDkdR8Ipok5PDigmSufiSIij7s6uW0TjF1Iwi3vz3ejNZ5VktIdI3ocsQAKgmVFgDHYgTdE5IanYufriNY9AMpZM4v+3036d7ao6NdlTSw0YhuCy2i2fPVX0bvSeXu6GhRw7INRTtqM+H87OrtB3IuXGC6tIdAAl1L8cukt8+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=CVZiHBK3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HjLxytqe; arc=none smtp.client-ip=103.168.172.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="CVZiHBK3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HjLxytqe"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailflow.phl.internal (Postfix) with ESMTP id 03CDB13801A5
	for <damon@lists.linux.dev>; Thu, 15 Oct 2026 09:56:10 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 15 Oct 2026 09:56:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1792072569; x=1792076169; bh=6Iz0SjV1j14iXIROKiV1q
	9pod0znZkHcJbWWiOIXZmo=; b=CVZiHBK3lRFcJwycltw5lNqnUDrWkkXK6Z3FW
	n37bF6hXONm4/TGr++Oi/xMEqvex/KbMJzOzNegj29k8KeOQLfO0XdehS+vSf29g
	w8+kMirUNVbSlMeGG3shDyDXHxTmSxAcakk/s6bV8cjkdXtG1fI0rQRnqUEDV+VR
	qG3bIYWh5wRLiCEiz3jF9e4nNeLuPsxsiPreTaiIIjb0f3DXkdwZa32zF8PpkRox
	Mj+A7O4sGPm9lnbq2VOOMnyl9xKSeDHkku6aP3qdp9fd5jLAAh+bRlwO4H4Y6ZRJ
	FXiLELr0gFbbdOHtwSIapskCJvQ48/4uosDVLwJkxkaZuK1fQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1792072569; x=1792076169; bh=6Iz0SjV1j14iXIROKiV1q9pod0znZkHcJbW
	WiOIXZmo=; b=HjLxytqe9kiMUEwdZsMTwttwuZyKJ+MYCF2PCMY9dX7uOrFAs4D
	ddLIfZPa5V95+CskHlFauiDl3Jn+9cACUt6dUJn0pxuKs2g5Imq3pP+WayAH2oWS
	RROuHKcUGRazK0yHUuBdpGlMzaqaFr8HfZRgRnSt858We/69U8hU7guS54m3pYjZ
	LP0p9nJrt1/NaZghTttnrQ47cBWbyBkwlz1SOlSwCo2vgRDDAZrd0xKPngAHT5En
	dT3GXxbehY/EuOFSVuoiLrXoNr+03ffzhDbb7pIA2+w7Rq2FKKeqmvrWcds5FZKE
	bl1i0pBlnwyMS29ZkWIaQyQJ2R//sVxAD/g==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1792072569; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:S4Y0CECghgkk83gYLRxUEZW6f+ZwPf/jB0PIlV2k+XP1Tnd
	A0AUIKKbcR7jdyB0r9f0WVnsb+pJRlmkJyF4ClbYmgfwrepY2DZl89eJSJhBNs6W
	l3yibAEDAFhFZkKnSEhI62DQp0bFrFAXqvwIR/RE3A2oJXhMlZtgQwUMCmxO4jdm
	kvRq8/9DEfHqrktrhvv5LUnuPbqJoK/qbiD3EeMdoi83QPD4wt2k2KSmMeZSBu0C
	CR3u+NvFj4bxMx7pTj3ziJCLZKkAUqVnlq+SonNkDg/N+5dRoquoGMiRNGE9/SSB
	1NamMjFLr4S5sWZDITUcpSfp70pe2aKxHRNNa3A==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:3jnYft+Dh/qHjAkkCdxyFgGWgxlFEGjjq4ysYZhssbw=:yVu6IvLdlbItjVbGSeytArgWjbLhLMf049inMbErsd0=;
X-ME-Sender: <xms:edvQasCCxVT_BlnWZmfZAADer7YCSKtzVeO3vXGLwVvFZprwChvjpg>
    <xme:edvQan2bfniD9c65BFFzSEoviNOyFFQh_upymh7-lYZsKxSxC2JrbU5vWPtmp3Lh9
    EeRaZ9wpfI9bmdzSHdf06F1XN36-YAwPTbAUu7h4qG4UiaiKllPrFI>
X-ME-Received: <xmr:edvQam1RTDF8lUuylYMBt4ur1EeujR-MKXjivCEMXMj0TTbRHUGWuedLEw>
X-ME-Proxy-Cause: dmFkZTFMuPxk0+Wh0qun9tazji9kwhFpFI+8qyirmz22zfT2QMxLUvh9TE3VKO1Q6/d7Kc
    LsBd8rEgRoTWF10LBwEOOGSaXLAI+It4wZP4vNDmU3coAW4qLn/s8ZVCCrVLzU6n17fsC3
    1JmF+bd86tOabjc0lpAXKg2NQ5wJknYTpwG3fsXDbP2vq1pTc/TCzJxkK6b3f0oi6z+YDc
    /bBl7L51PnsOrIfHRhwlIW8A5LhNxTP4fFXdyDfPB34GP4qUZADUlH5xvOOamtkK5PEvw6
    PCldTt8QbCbdFwduMf9PnWO97z8iw0RcXDm0kKpDLr65NA7/MahSk4penFXWeQO7yU+UZu
    3CAU38I36GOyOzugBHb0ZHH8hvltGn1RZmhRF6o13YVJNOCgnKIFCLhiMQZFO68r9BvpXT
    wclLHnCeowclg03JfDpXwZKqxyaMB3FCdOzqAPnqrev2GsiA8lwoVC9xAy5IQ24NLMGEfB
    TMTGckuyT8Uti0IWBKsCWOw6QDYJ6ZmhARheQMgk+Rn3VrejTDuOZxv5Te2NeooVtzENLo
    2hXODHBEZ3IXq67OrD669b7EYKsegFtH9aX51tyma3DWtqrdsNwC1nLNA6mlH2E2uchLHs
    UImeg9664C7UXhf3SNNYL6nBGTU1ZuXMd9G4AEY8pXY6IMAA2//hM3cbQJZA
X-ME-Proxy: <xmx:edvQakC4UrRt2vRwYgVH6nPLYMbPqPjanlEGoB7maFNPEOFxGOZBxw>
    <xmx:edvQat5pyoEaa_AXaDvVarHyMXnB83WRsUJpExx_jazsJFpyG3CIsQ>
    <xmx:edvQatKLwjncucxVN5yzx6W5uMrFkYxVaHVWPcCQMvqKRvj6T_Fwnw>
    <xmx:edvQamsQUE5bRHWW0jtE8X4jeXqy6DdjLdbSG4_Z-JmJIvZSufcOLQ>
    <xmx:edvQanYR9i9xB1Wii1XgzIQ4BGJJ5Dl1gYok_EF0-PYXSWBwT_9CnOWO>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Oct 2026 09:56:08 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] mm/damon/core: Iterate over installed probes instead of DAMON_MAX_PROBES
Date: Thu, 15 Oct 2026 19:25:23 +0530
Message-ID: <20261015135533.18761-1-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v4 of a series I sent earlier. Please find changelog below.

There were two "todo: " items of the same nature in mm/damon/core.c. Both
of these suggested that we should iterate over only installed probes while
updating (last_)probe_hits[] during merging/splitting regions, instead of
iterating over the entire array, which may have empty/unused indices.

So this patch series does exactly that. It replaces the for-loop over
[0, DAMON_MAX_PROBES) with a damon_for_each_probe() over the probe list of
the context.

These patches are based off mm-new. They pass all KUnit tests related to
damon. I have boot tested (but nothing beyond) on qemu-x86_64. Please do
let me know if I should do any specific tests and link the logs here.

The series has been tested with mm-new fetched on Oct 14, 2026.

Changes v3 -> v4:
1. In some places, kunit_skip() was being called before freeing resources.
   This is correctly ordered now.
2. In some places, regions were not being freed. In v4, they are being freed.
Link to v3: https://lore.kernel.org/damon/20261012145636.168436-1-suhaas@s-joshi.in/T/#t

Changes v2 -> v3:
1. In test functions, new probe and context allocations happen after target,
   region etc have been allocated. Further, target is added to the context.
   These 2 changes help in reducing allocation code and improving simplicity
   and readability of the patches. This change is true for both patches.
   (on SJ suggestion)
2. Earlier, if a function's argument list required multiple lines, I was aligning
   these lines to the opening paranthesis of the function. In v3, these begin
   after 2 tab spaces. (On SJ suggestion)
3. damon_test_last_region_quota_reset() uses the older version of damos_skip_charged_region().
   Make it use the new version.
Link to v2: https://lore.kernel.org/damon/20261008151944.113714-1-suhaas@s-joshi.in/

Changes v1 -> v2:
1. simplified commit message of patch 1 (on Liew's suggestion)
2. wrapped all lines at 80 characters (on SJ's suggestion)
3. added comments for new argument in function (on SJ's suggestion)
4. added damon_ctx_destroy() in r2 failure case in damon_test_merge_two()
   (on SJ/Sashiko/Liew suggestion)
Link to v1: https://lore.kernel.org/damon/20261007154851.45368-1-suhaas@s-joshi.in/


Suhaas Joshi (2):
  mm/damon/core: Use only installed probe in damon_merge_two_regions()
  mm/damon/core: Copy only installed probe in damon_split_region_at()

 mm/damon/core.c             | 57 +++++++++++++++----------
 mm/damon/tests/core-kunit.h | 84 +++++++++++++++++++++++++++++++------
 2 files changed, 106 insertions(+), 35 deletions(-)


base-commit: beaba65d5704418b6fa03c96a389bc2c2b6702b8
-- 
2.55.0

