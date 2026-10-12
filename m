Received: from flow-b3-smtp.messagingengine.com (flow-b3-smtp.messagingengine.com [202.12.124.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D91C35AC33
	for <damon@lists.linux.dev>; Mon, 12 Oct 2026 14:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791817047; cv=none; b=tY7nozK+pcpHn9aPkLEnbyH1oh/vvGTj+Qbu7gjRMzQSv+W+UMWU788XFol85iyIisFf6RFt+ADHobqNGHJP3zPsohLG277zshLqkPjV7jSgpSZYITUpZL46USLjBrJ0wvzLgPgpEuqrlGZm76yBFWlrD+HQesvHekum7UPPoMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791817047; c=relaxed/simple;
	bh=7C4dEkQnMLz9TMFBil12z3bVuTnUQHMzsSjRJ0bhEdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcRp5C0ByCbtGkaHfdCkOZl2DUzZeRtThN4Oqhi9gQcseiAQJQh35YjSouQe1yfqMZqTg48YmgTe9GGnO7iIbq+q9V65uNvprDQea0vsuSoFXK8FIzjJ1XkglbTVEiM41LgBuTJD0S4ukZDxCMVdheHpAivqCZXKF+Z54H40CgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in; spf=pass smtp.mailfrom=s-joshi.in; dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b=fWCjle4+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WuLhkgrY; arc=none smtp.client-ip=202.12.124.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=s-joshi.in
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=s-joshi.in header.i=@s-joshi.in header.b="fWCjle4+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WuLhkgrY"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailflow.stl.internal (Postfix) with ESMTP id 678631301223
	for <damon@lists.linux.dev>; Mon, 12 Oct 2026 10:57:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Mon, 12 Oct 2026 10:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=s-joshi.in; h=cc
	:cc:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to; s=fm1; t=1791817043; x=1791820643; bh=Pu13YpKtGky8tPdtL89/Z
	JE76RVpEXfu65dztzSTlxg=; b=fWCjle4+kDvG3CJenoGoGVOHvD28bHOluWkMM
	FXka3vmIvW3hp0I0q3moDDsyFY2DXZd7b5/udaUasfDZECbaPbe68RrmskqTaW6y
	+5DSOOcrb1uYRgLt5Kl5mlI6N7/NMMFbOqyebPe1CfpPsnZVhIVVDEf14Iu9Ftly
	eUjztaI/4m0kKbEOR52DNOiIv1js7M6XHdxpuz0A3bR3p6PJpy7P8wWAU+dXSKJC
	SsvZd3BwSVLTAT0HIIiTK8t1L+18MCXwykj2CwckleyMjTm1wwgK1mAOl9lR5Jae
	BToFurkXHhc7Ew73ilTJ4oNBJrS0uPVj4T3fcN/pRKdycOGPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791817043; x=1791820643; bh=Pu13YpKtGky8tPdtL89/ZJE76RVpEXfu65d
	ztzSTlxg=; b=WuLhkgrY+Xo+knPrPI/Ng08TLcByZnJlTaVAaUxGnV6K1FdcIu0
	clsAyHx0Xm7S3yDPZ0i2vKskN5PfqFr1YclTVMkxakt1kdSS+uIlqR0JLO2ZuHsx
	szH6gRMVh8uO3d7z2Jo6fN0yM9auRIYOuOIYy2wxfKe9s+GtJYFlW3KUdFLpq542
	AQJKKzyM5dcGeUvcT7btE7voW7tZ1uzBHDPVr1DZa/f7XbZcv37dNXwFITtvK2+p
	u6CFgLtLAsLOmAyvCAjOhkRTB/Yq5e1ph5cuZ+bhd5+1Gv9V8qdUruOgwKl5XGTu
	kAaCwpsqWm4DTbFiFqB7rC4TXg7Ux53xYLQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=s-joshi.in a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791817043; d=s-joshi.in;
	mf=PHN1aGFhc0BzLWpvc2hpLmluPg==;
	rt=PGRhbW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:jQp3LoJfm/Gji4PcKgK03LDDTqrBunE9Qe0nC087k4yLITI
	jB8OGELOAo/PoUSqDj2Queq6fPUpjr6dIdCsAQhZ2ZFOVlcUbRxi0dkfUmR8FY56
	/QSAjOP0rqXYIflsxEKcXjflOQaFi41zOuGmzcy+tIOibNBJ6UGeOiTI0ca/TUEm
	Je/x6XXC4NEUD2g4KZ5fEF1hJpk7FhE0/FFvVqruhWBfPh2KlUaRojgLoZ0Nsx/g
	8lb7LYHKWv9PrA8FaqETjAnbtfdCqdjpKrwuMKSiyY4pdDBhKHx5MlEAUpEY5pGb
	vJKoy2TtB+taieL48mh3QR7Z3LFmkE8InoRkK+w==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=cc,content-transfer-encoding,date,feedback-id,from,
	message-id,mime-version,subject,to;
Message-Instance: m=1; h=sha256:K3S4ELdJFLAySkcvaXr590/l3Nv+7PaJDetms1kIPHc=:7C4dEkQnMLz9TMFBil12z3bVuTnUQHMzsSjRJ0bhEdU=;
X-ME-Sender: <xms:U_XMasNye88xTrm3IfSKiHn3trpJTmqDo1bXMW_YU0xisNKvV8kgEw>
    <xme:U_XMasR-XAolPmOUrQOVr8E_Bvq-svdNnJIuhIfInl8XC0Z6PSiNtrnMWcM6Z1bo0
    ROylIF9QMoMEUnO508y9hKJTFqZrQ2C-bNJh6tOWtHJ4Qw0rS4fuXk2>
X-ME-Received: <xmr:U_XMaqjga76Uujkb2w00aH6Kbk1ZTWQkBVuq_3nm6we5V8vAtytmgaVACw>
X-ME-Proxy-Cause: dmFkZTEXjfH5TD6BbZhKBuZ2eKA3t7u3UNXaaE6kXK+qJSJ1FQBQL/xgKeqXzvuID6nIDq
    v1B5cfciV+B4y8D5FB3SF0E6nNt8FEUQFycJoyso8ID7CWldSXl2TsWi0XR5RtPocR2J8/
    kZ2oJ6acL5tqX+7QKX5XsayWqQ6YLVOeX4Q4t8OhqTF92tW/AJkvJkGhYW0TJWf7rb+8pi
    KhAfjtk3qCBeo+oc69WFKMjaMKWTzuCzhqD+j/hj0C5sONKbHoh9qoHG+WMr6mr7xdQhSH
    6Q7sK5b2XPTuXCQtPUBM3SUgv8KMiu2hBMn8l96di7vN85UxslUIWrFNVZ4RRCk4DH14Di
    n0zy2NRuNo77QRtfWcaqrG9+whFGuRGRpa6L1qdrULefD113KKZ2DSdZp8io4AS8J/fR4U
    RIhbv4UGU7eueeQAyenc60wk9N8qKa1XQ3jBv3bFBb5Nvak7UpkAhbSvk9jbpKE1D7fNZu
    WePNqbw/ceFBkUEZ6rReu0gfT6McDY87a7wqTTi311mOZoIgex205pLcyhl7HoK5g4ov7q
    8KhuoGsBN6wUskXp/Bd4sd4U1CKR3oBgntemSZ3FgrQ4lW66Oqcrj6qeIwwCOearLcfoer
    fRpSNRulvJ2FHd9YDXca0Ndg4KJTTJCO+4gNu6gaXN8NY9JNmVzmfLL8DapQ
X-ME-Proxy: <xmx:U_XMal-21VmYH1B1uGIREc4gA-BNlaLFGaz6C7YwQNNVGdEI_DKMtg>
    <xmx:U_XMahF3dNEUrpsrNIlJ0BnKjSG0fJQHMO04-FfRPHxgo7mn9LS1Fw>
    <xmx:U_XMaon8CVIbeVSdW_WLBiHsmf8O6Uyib8zA_VK8p0XqFO3b3Zvq0A>
    <xmx:U_XMalZ4s27t9ZjURvY1Y9xyqTld3AdQHB6VcuwPvJJNhpCmhe6PAQ>
    <xmx:U_XMav3C44gIYdD1255VPF6u631jorDfhrT5N3MEr6kn-dEjLlkNCCyd>
Feedback-ID: ia9504abf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 10:57:21 -0400 (EDT)
From: Suhaas Joshi <suhaas@s-joshi.in>
To: sj@kernel.org,
	akpm@linux-foundation.org
Cc: damon@lists.linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] mm/damon/core: Iterate over installed probes instead of DAMON_MAX_PROBES
Date: Mon, 12 Oct 2026 20:26:18 +0530
Message-ID: <20261012145636.168436-1-suhaas@s-joshi.in>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

This is v3 of a series I sent earlier. Please find changelog below.

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

 mm/damon/core.c             | 57 ++++++++++++++++-----------
 mm/damon/tests/core-kunit.h | 78 +++++++++++++++++++++++++++++++------
 2 files changed, 100 insertions(+), 35 deletions(-)


base-commit: 8b38ed9ab5b09c8ba168cbcc49524e9b380ee5c4
-- 
2.55.0

