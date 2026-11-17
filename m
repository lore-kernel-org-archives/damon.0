Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794957790;
	b=49GceD5CgCUohvqY8j6JOVdIpU8FTIQPp6ZwoceHRqAfPZsLMB+QE1fOJLnJ5NW3V6hT
	 mxqq0M45Yqb60a17TrXl9fbCWm2Q3Ldlqm7mOvjWozPgKszBMKPF1uJaKqgzClpoRe+fe
	 nWudKyiWrIKNfDKvypuV+kIB4Myl+SeltvYZ4XNMMFJTxcnZpqHtOY9O3cCGCrki7pEJZ
	 lkXryExsg6cmgHuvW/gcY5iPwfwkaGx4ZnNPBmXKh8U05nMz7sVNAk9pO3HBsmVRF05+/
	 nUpPY79aczxjEzk8q2eLx3zBSwoA4HUbZopmtHA592NduVCRtjuB+NXgnAX3oJi6Xmw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794957790;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aIshfsi1jWhoOiNy4fegdmvBAQZ0xKiyYeyrKPd8Xbo=;
	b=lAhxSrdqWVk3Xk9RdJEguETus5BhJJCjqWaMehrw+blz9Bggy143iDjmCSHDtWnPNP6Z
	 eIneilGd6WuTURG+zlGTiwUBqk40KAmFXTsQeWAwYHJGR/oNVzDroY/IlKtooHS/Mo8Id
	 ub1Lqjto/n5fI/WmsQxlfsZU1QR06kFu9XQIIPgtIIUqetaDwPOAt3FRLnTFV6FXV90MZ
	 +47b3U4Kpp2E0Yw8LXDv33bNeawMt84cxkFysbV/GGdDLGPBx103D3uhGPC8WVHIVvby9
	 bSjdX7PReEcyBIbZoN6iAPY2B4HCryyCmVeu7uMPYGCxddzDmYaRN/10KZ/9w8LU+OA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpeJ5DQR;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3078A606A880;
	Tue, 17 Nov 2026 23:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QpeJ5DQR
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794957789;
	b=tZofsLBE9ZmvqkpVUrt/V6r6vBiXZ4Kz0uLR3fYuELIeqFZDhbIcLyXTgx51wu0ArB8E
	 /tA49rdx9Gy/q7XG9P3cY9vuyv59UQpKZlKC2SZMvNHQkTeiPiPx6tUg50EwfNEeHTA7G
	 TxAkSzDJO48nJN1b+zL0v6Vj5l86Z6AtT6ouxZzvB2Umt4ZL9sYFOUvut5qSubS/M+85n
	 frxd4tlvC2T5o2EDPfE5i0abrJWCA/rhPWk6KmuYCiKmfNYjuxO9K0pHE/9btUbHwAysy
	 uSgea3iPDpNdDhIbIGBul1iR44vRv/zpPFb1bmH/OLHBYcxsSyz1nueInuk0Jj8uFaA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794957789;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=aIshfsi1jWhoOiNy4fegdmvBAQZ0xKiyYeyrKPd8Xbo=;
	b=ZDbcY4T8i0/gOt9UQjULCYfIn4ms5YjtxpFEZFn/GCO6Oe5bSvhIbKSXlVfs/U6e36SZ
	 i2bWVeF7DpbvgnUlwybC+DbJSoosqGCz05w/R7ILfoWOafJ1rVuo4vYE9leIfRABaleJH
	 VyHq7AjuJfypQ2vI9EFhriQPur1NwF9gZDX4vEycoAaNLe4gqIKidEiNa/paLflCKQrTc
	 fMm4NloSrHLQsFlKAeA5GcT8kRBxpMfsOCRg4O7J2QU27pAGw5S8enDZHmWrGOQIwt6gN
	 igIj5U7i7n9JKyKmEHaQjMleT9jmNGfeCgHEy79Eqw6ybGEjYpCJT6SRZTer/GupNZA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 741BB1F000C8;
	Tue, 17 Nov 2026 23:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794957789;
	bh=aIshfsi1jWhoOiNy4fegdmvBAQZ0xKiyYeyrKPd8Xbo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QpeJ5DQRzFtcFo09xSyv/LP+PastLF6ctRZxiYsEqEMBQnq0VXsa9nmTbR2hxaFHn
	 Vd2xbPJOvCJfogTzbCqxFdfUus1UR7AzLyhK8aihmuTyspOH6EUnx36gVUqxN4CcI9
	 ogiANiiozzV5xJhGXgv4HC78EhOsfAbPiBG999gOQclnXqY+qxeHc5SBuj6472GKtl
	 FjNOb/MfJi/VE6lD3PehW/6TEnUnpXqJGyhwlELQ82jP8KrhnCfOB1h4wAxn7sbdzO
	 DVMImzvX5jAaqik5oKaFaBImqfoERGPjG9Psg/vKWI13DY7ObBgCtdtqaSMMldgElI
	 2SSxbeMpxl+Xg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F3BD14AB48;
	Tue, 17 Nov 2026 23:23:07 +0000 (UTC)
From: Mattathias Pinchover via B4 Relay <devnull+mattathias.pinchover.uber.com@kernel.org>
Date: Tue, 17 Nov 2026 23:22:18 +0000
Subject: [PATCH v2 4/6] Docs/mm/damon/design: update for
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
Message-Id: <20261117-damon-sz-ops-b4-v2-4-439888fa04ac@uber.com>
References: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
In-Reply-To: <20261117-damon-sz-ops-b4-v2-0-439888fa04ac@uber.com>
To: SJ Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>
Cc: damon@lists.linux.dev, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Mattathias Pinchover <mattathias.pinchover@uber.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794957787; l=1087;
 i=mattathias.pinchover@uber.com; s=20261113; h=from:subject:message-id;
 bh=sxtzpPREIDw7ZFR+5CW2rzs4hwvhtdKiGsknt4ydMYc=;
 b=xiVHw5199HmKXsAOjssCMVsuFWusG6DrqEzzM1EhmXCqsD5qfarnz5oHJ3Esi7c9q4IO2vUhk
 5Fd52nRKojmBVQKEJF5MYGEkmW+QeOfHqB2Tu/ZJ9MIKpxS0THNEGAK
X-Developer-Key: i=mattathias.pinchover@uber.com; a=ed25519;
 pk=6Bh6OEwWiU6dpON0CVcoipq8fXtEgvhsM1Tmm9CTmtY=
X-Endpoint-Received: by B4 Relay for mattathias.pinchover@uber.com/20261113
 with auth_id=1515
X-Original-From: Mattathias Pinchover <mattathias.pinchover@uber.com>
Reply-To: mattathias.pinchover@uber.com
Content-Transfer-Encoding: 7bit

From: Mattathias Pinchover <mattathias.pinchover@uber.com>

Update DAMON design document for the newly added DAMOS stat,
sz_ops_filter_passed_last.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Mattathias Pinchover <mattathias.pinchover@uber.com>
---
 Documentation/mm/damon/design.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index b676be697158..41e56af84d45 100644
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

-- 
2.54.0-uber3


