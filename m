Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165384;
	b=gs5iVQE1CQ8qZEbEzKb5yD8poNwgf6cBP2N0U1KKnPjxywUoGNJ0vAjEhrWcBmppIcXD
	 7gqH3gqsggs+fSdfdY/jClNmNSHaTyAvI/3KMoOhYbn7mm95Oi3xHX7tldH4Ipzk0UXFD
	 LaJ2zxuE260Tkl0MyHDkE45OdaPMxgTp0pWq7uTg4bbt0ogNsK3TGVBEwFFbkus4Y7Iyc
	 JhQoI7swivEIs6Vj77kRA+GyWyGgjvZF8iSPNDAHpkuyJBgrwe45/rhLKcje/IbLNidEb
	 HBxAnB6cC5r2ZbVUKIdnDAxUerGijDW3OuKUE971VqS1uLHf9/QgF/+Qvd1bwtjRvxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kafHwu6q55LG1XprWuU0JCx4heKZt+x43kKCH82bMRw=;
	b=jSHfZtq2ZM1gTMjBdaZAMpKIYtcpQsjCJxKFuVA1DmjnoRqBlCmK2fLYwNIQf6QLQ0RU
	 0eaoZDfrVq0L60FM1yB2zuASLvtVHlXLbqIcY06xkMS/ytbGALNyAoM5cbXRjaRhQjCDs
	 opoUjEug2qy/IQrOa4Cg6ZX2VTspQ0UaGIOksROFevwGjxADEAJi+gPZ+jVMoD5Z+p87P
	 hpxqlG6y30/B4qbGcFWtWD3K1+TMmJMiWU3G9rinP6CYN59Gsrls3C3YCvWB4RjVgFWTA
	 xls2mKW4jBE54xI9Y7xaOfKj5iV0sOD/eAouVrJ53GLl6Vz+PLa2eOVv/QJ9hrVCj1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNRuJY05;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C110A606A31C;
	Sun,  8 Nov 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RNRuJY05
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6801D1F008A2;
	Sun,  8 Nov 2026 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165383;
	bh=kafHwu6q55LG1XprWuU0JCx4heKZt+x43kKCH82bMRw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RNRuJY05Khbnu6awMwIH8DQxPOvF7hltgBdnzqfCPDwjAuw/+YR2We/qbQPiKk2wI
	 w2XYdYDTjQtv7zNCnhrYw1vkUtoCb3YrDnpHO4F44oljuLkkCNF+lmJ2Af0+gxWpXT
	 6vWMdhiyEOM40eNyIDcv9EdgqUyv9C1cZREheNOXQW0Gr8KblCpY29G5J7mY9ANEHc
	 7DQETo4d5eStxj9bW8ZgyRK+eKIzl8h/wak/fZ1LeagjAGXNYmw+dMBMBXnzyIxi+A
	 eitvdeRw1Kxfrfzvaimj22YwyLGOFTOvMpBRpRfJUeb31Hie5J2j/OwOCPE+fCZS57
	 0JOMNge7Q2Bug==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 1/4] mm/damon/api: define DAMON_FILTER_TYPE_ACTIVE
Date: Sun,  8 Nov 2026 11:16:11 -0800
Message-ID: <20261108191615.113362-2-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261108191615.113362-1-sj@kernel.org>
References: <20261108191615.113362-1-sj@kernel.org>
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
index 1302ffb6f0bcb..858b4c6900fde 100644
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
