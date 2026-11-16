Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794856222;
	b=UNicKylMBpl1JMGGSx9I3V6jZcGDufvDVtAUHnraF3SaQ+H+eU56DG5zSPlO42ipzRKI
	 oESN9uaqjKV2d4qL3gSu72uJw8boicMBAH5V1P+BC4tB/uJTSLAenyrO/kLvCLDUWcQ92
	 Wtbp1U7fpBgmdAS4qDpxTuJuwfWg4P27hMydFkyFzYGHALBVQEYd+aG+AHixnFSzIkjIR
	 ZWl+ntlX648YIz8mSrp6wHp32DNFy8KKNRfxWRn6BtQaq8iU3kRVTUdwNB3nn1P+HJAzj
	 GvMErSu8y3vxnfVK2iPiJ51VbjijT0+PceA9pPweo4TBAEbpRenk+OBvGBsJhEg/pjw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794856222;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wz3i43bWbACcxDrn6IQ1R0IGDWvmDnWNIz0h7uvXbkg=;
	b=vgSZ3aMcDpaOUN3fnR0iqg4dG0Lajdynv5NbfeGEPV/y08VFThfgRHIxhVXxx6LFGR0j
	 GWYGCCjg0ElyOHDXzkbsnXxQaTh4/qo5EARp683J7hczZNqTn/v7gUaewibWfOPDdnZ2L
	 XZ/nrgo21dMnK9graSsZr9+oKhTcU5Qjiut3O/H2SQCAZsuD0vYzVOTK1UjvEAClbQ9y0
	 gzX2/0FZGSvCXYrH155vjZS3h0DvzA3+V8X3BPAd9Tus1Ok63CrylNvO4yXMFrrqQTM4E
	 BVlaredJiHbC5t3HfoIRG0OElevj8h3DSE3z0OxBzsXHEbkR11PfEClDBht60Crz3sA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2zSs5vd;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6D2606A33A;
	Mon, 16 Nov 2026 19:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n2zSs5vd
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794856222;
	b=htnaw3LAsFo/9Rn04Ccjq6yLTlEBa8gkMcKss2DR0hKX+R4Js1r/82dLJh9X9ljTkmuy
	 Kl9fps42TeUApB1JTXKRfzZjtCeNFWKWEeii2d0cUU4vRBNQrapMNG1ehxx7/byr1Pn+Z
	 /qd8PC8XB/fPegoTjFsdJFddTl2oRlFKnKVInhR/FFl+wiJlbMTUXSZ3AToOMbMga5ueW
	 FLImL5BTVPDhTm/dYiXI7oCHUOpbenxR+8aoYVlLt3ey74Fq2AMu2852x2e+fUEHrLmvp
	 4KTYk70cV6VQWuVLd+jg64pqmci/CT5fvCM1pZ7DSMTurDowYl2tezMvcs9T5KwfCnQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794856222;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Wz3i43bWbACcxDrn6IQ1R0IGDWvmDnWNIz0h7uvXbkg=;
	b=a8eGcGtsO4hDNQseLLmgqzUGn2CXZTJ0e7wmIKQ7LqODXEvuIvueRSGDwzs5wEJuhYLJ
	 LH//1vFfYJttiyNaPMsXbFZ0TtA/TERHsrmZOBLuLEbXUqxer1FVVDGCrnY5fNaB1sLOa
	 Q8Oipv75zxPOlwdGoFey5QyYCz8BihS3MzOULDY0AzdolX19wK28Bq71G2H8rNHILg5iQ
	 rd1SgTq8A426aIVtk6rRVqFA31pCBObrLhvJwq6l6R6LPmznOjoQ3b93qj+MfVQWR+a7p
	 z7K3GsUBViVBZx39REbExyRqu2p0hPYuWph+79D2wdUtnDJSx4wA2g04ca2F5oUyeAg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 17A291F000C4;
	Mon, 16 Nov 2026 19:10:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794856222;
	bh=Wz3i43bWbACcxDrn6IQ1R0IGDWvmDnWNIz0h7uvXbkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=n2zSs5vdSdMdudyhPG79tYKxSODhCv60mMS4VS0e0KcAwzghprh2JN3lx8hLjOp1s
	 swOF3WgFec0q9DafwkDo2rBh5mUnWbcnTCrYdr8UBNC7sYPVfM86BG5G9uph+TMV/f
	 O/JUt83jWVg41Us3LAqB//s7aXQOGZbHIeAVHfnEZlvzLBqwf3ykfJJec043lGAFfB
	 cQbWnttj7YsgAzmVPRx5FV0gMElp3dEeZMbB7ScDTIPMQ0c9sB2JNLdc77Lnp+Pbig
	 9CylRlVQXc2KiJiamL0EiciODNH0WhgVBtGbSN5LRAYC2pZpijgCcaKFgGKVNkYdpS
	 8OHYZ6wc3zk5A==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 947684A5A1;
	Mon, 16 Nov 2026 19:10:20 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Mon, 16 Nov 2026 19:10:07 +0000
Subject: [PATCH 4/6] Docs/mm/damon/design: update for
 sz_ops_filter_passed_last
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261116-damon-sz-ops-b4-v1-4-1cffe7227e6d@uber.com>
References: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
In-Reply-To: <20261116-damon-sz-ops-b4-v1-0-1cffe7227e6d@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794856219; l=2118;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=nwHjZVHHDRBT1eHlqqDWBt5BJ2Vcy+5/DHoQlewkkIE=;
 b=b0tvkQypc2c7AsnCXE+pq9rOaYIeO3iDB0Oj8qy+Oo2BDDoOAEgQn7E9EZf8uFy1tHQ24VVWB
 X5KJIE6CiWvBDh8V8PfnZmpjaQE2zudNNk0YZuofHhRxEiKtyhq8L1E
X-Developer-Key: i=mattathias.pinchover@uber.com; a=ed25519;
 pk=6Bh6OEwWiU6dpON0CVcoipq8fXtEgvhsM1Tmm9CTmtY=
X-Endpoint-Received: by B4 Relay for mattathias.pinchover@uber.com/20261113
 with auth_id=1515
X-Original-From: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reply-To: mattathias.pinchover@uber.com
Content-Transfer-Encoding: 7bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Update DAMON design document for the newly added DAMOS stat,
sz_ops_filter_passed_last.  Also explain that, unlike other
stats, it is not accumulated from the beginning of the scheme's
execution but shows the value of the last apply interval.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
---
 Documentation/mm/damon/design.rst | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index b676be697158..e40b8c1a3461 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -876,6 +876,8 @@ scheme's execution.
 - ``sz_tried``: Total size of regions that the scheme is tried to be applied.
 - ``sz_ops_filter_passed``: Total bytes that passed operations set
   layer-handled DAMOS filters.
+- ``sz_ops_filter_passed_last``: Bytes that passed operations set
+  layer-handled DAMOS filters in the last ``apply_interval``.
 - ``nr_applied``: Total number of regions that the scheme is applied.
 - ``sz_applied``: Total size of regions that the scheme is applied.
 - ``qt_exceeds``: Total number of times the quota of the scheme has exceeded.
@@ -903,6 +905,13 @@ to exclude anonymous pages and the region has only anonymous pages, or if the
 action is ``pageout`` while all pages of the region are unreclaimable, applying
 the action to the region will fail.
 
+Unlike other stats, ``sz_ops_filter_passed_last`` is not
+accumulated from the beginning of the scheme's execution.  It is updated at the
+end of each :ref:`apply_interval <damon_design_damos>` with the amount of
+``sz_ops_filter_passed`` increase in the interval.  Hence it shows the size of
+memory that passed the operations set layer-handled filters in the last
+completed ``apply_interval``.
+
 Unlike normal stats, ``max_nr_snapshots`` is set by users.  If it is set as
 non-zero and ``nr_snapshots`` equals or is greater than ``max_nr_snapshots``,
 the scheme is deactivated.  Note that, unlike watermarks, even if a scheme's

-- 
2.54.0-uber3


