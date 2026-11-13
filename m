Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794547040;
	b=V65Bio6OuS0FQLHf74kLJX0pYwpCAj6fcUnnR/CCb2uWUUwzc5XTpDwgrB6ZTw71kp5j
	 Wi37ygm4+BYsUPwRZl/hZ6lpqg65vAWhZEzwfri8q1PtJ2wld7SYHvhKn+ESn3pAtKMxq
	 8NEdjioC6LmqNK3RyaOsx7mLSt5HuZdChkW6TNikfXlk7ukMYOtwklPNHp36QB/ImaYLO
	 V30cbUgpXayFHoexKaVsRkV0S5U2CIBsB1CapJifrbJ8YtE68X5xethM1aCMsj+1OYwBM
	 4XXNOFHONNqzmNCV5cQ5qpnwubmFEIVzvAEnmxSXx1xzCpRvGlh5IlKsd88VfJOBwAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794547040;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ES0HSLcfEcyNCTf+df1YGGr/NbZ75fBTnOENrmeTXX8=;
	b=crdtMl1+e62xzrSMPvsB7KtJnxOEyQH83DcgUjSjKVnFs8vc2VMx31EjRTZ4yS6BLB9N
	 yKUT5I2voqxILVttY6gYnswprEyneWQEgldKeH7LINP2u+sgOohRz6NQevoUIh8SzkXES
	 m3Tk5JmfZGfHjfCx78qz5d+8Fwb4GocmjqAIh/8J6TRjC68QRDBdaJq+528neiCT6T54c
	 h+9g4BvL4KrNSBV+yJSLHo4FB8h4uBcomU+LhpoQ/uGuCqcRAyE9JntW4ctXHq/rQFdHi
	 GVCaM82kMRnmXMClYf7DcAHt4Ewqp2K9fXNJCunaHglG353nLfYUXpvw5VX2nROSE7A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XaIq6/Vh";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38404606A323;
	Fri, 13 Nov 2026 05:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XaIq6/Vh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1B091F000C6;
	Fri, 13 Nov 2026 05:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794547040;
	bh=ES0HSLcfEcyNCTf+df1YGGr/NbZ75fBTnOENrmeTXX8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XaIq6/VhrL61o7pv5NadaXJ9pccIuJN47KjL74YT95MNpc19DOX8BKPdtJ3XEWxww
	 ccL4NS6L88QDKEYnzh0kp+z0ed028kCHmw4oKpENwNGEH9odWdbqTDnuCQb4WYK+6D
	 9go88kC1BCgFiNWao/cX3kTCi4s0wGcQx2yfJq3Tmonsa1ZrUC+cLadArFa8RH7MSB
	 o9xJSIpU0EADLlVU2RF/7KvxgRY2YzALUIVoElAkFX63Yb43eoZfRnS/xr0IXTMjgu
	 GGBS1upqk0lODyMU/zGzlQfMPMQ9O7dkiDFV8Za0RjwGU2Rl1ug0yawIvbu9ci28xx
	 fJmJm6VxTuoWw==
From: SJ Park <sj@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [PATCH 1/4] mm/damon/api: define DAMON_FILTER_TYPE_ACTIVE
Date: Thu, 12 Nov 2026 21:17:07 -0800
Message-ID: <20261113051711.89274-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261113051711.89274-1-sj@kernel.org>
References: <20261113051711.89274-1-sj@kernel.org>
X-Mailing-List: damon@lists.linux.dev
List-Id: <damon.lists.linux.dev>
List-Post: <mailto:damon@lists.linux.dev>
List-Help: <mailto:damon+help@lists.linux.dev>
List-Subscribe: <mailto:damon+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:damon+unsubscribe@lists.linux.dev>
List-Owner: <mailto:damon+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Knowing which memory is on Active LRU lists is useful for understanding
and optimally operating systems.  Extend the DAMON core layer to be
ready for support of that.  For that, define a new damon_filter_type,
DAMON_FILTER_TYPE_ACTIVE.  It has no additional arguments and therefore
no additional change in the core layer is needed.  Testing if a given
memory is on an LRU list for the type of filter should be implemented in
the operation set layer.

Signed-off-by: SJ Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index c32ef79c3acea..06bd92981af21 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -780,6 +780,7 @@ struct damon_prep {
  * @DAMON_FILTER_TYPE_PGIDLE_UNSET:	Pgidle is unset.
  * @DAMON_FILTER_TYPE_PGIDLE_SET:	Pgidle is set.
  * @DAMON_FILTER_TYPE_HUGEPAGE_SIZE:	Page is part of a hugepage.
+ * @DAMON_FILTER_TYPE_ACTIVE:		LRU-active pages.
  */
 enum damon_filter_type {
 	DAMON_FILTER_TYPE_ANON,
@@ -787,6 +788,7 @@ enum damon_filter_type {
 	DAMON_FILTER_TYPE_PGIDLE_UNSET,
 	DAMON_FILTER_TYPE_PGIDLE_SET,
 	DAMON_FILTER_TYPE_HUGEPAGE_SIZE,
+	DAMON_FILTER_TYPE_ACTIVE,
 };
 
 /**
-- 
2.47.3
