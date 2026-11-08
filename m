Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165384;
	b=mcg/opMLaXXdW+o5oWAkkOJLVpPYW3MltkXr10a/FyljVaZkRqYJw+TiW8Sq7HKqAjxU
	 XGyGxu2vO0/OgBdIwb98HUE5AWE+mPXApITciDaeCniDEtHorxRgtmh/NgSLzwHAAUQVx
	 G7UBm8BtAEnBS0qGvD5FiQR5l4BLBZN7pSontdaiB0w8xxpNl+N/AduKxWy6B4PAQ2jaE
	 9t/qnPboCFDTyHzGdDS8D0kL5+T0nM10Wl1Xro7fN0LI+JJHSkK3xAbtmXLqiqUFpCh6O
	 ZwTlFc4WFrEFqLPMJTEyY4ALPj7qVai0MhHVcTsjhGh576BZWAlbHfeJnsapYX53oDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hDPWmvInaWp2wgeM0od2Li5jTmlC0VSnDu9Tp3ujlp4=;
	b=ZI+/9S8sq+2ltNbgzrhZccIDDLHAm9WKZ8ZZIUBeFle1fHwUaxMN1IqblLH8wXB//gVW
	 pgCm19rrFlyvg20leHjNqoXPVkm7PSiQc7fXzn3v1eFSP+2PEFjKq8e6f+WZu3PSs4M5K
	 EkUCIt86UQjzOXls6SqjIRiKkQHWJnELdNDkK/laIVR/cR01pOJMCm8w3l0K6hXRi47Zj
	 OB7lwDk2bGfxDhyNInlJNkEgKByKwjm/EZ+qYEjkbtjEKVriXifm9C361m1wEm11vELVU
	 jMOVf51TVzIX2vy0ioLWKkOnotey5WitjFlSjJ/YcIeMqxPONxoC79ky09m5JJ8RyCA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DWRYdLW0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F29606A321;
	Sun,  8 Nov 2026 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DWRYdLW0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0B51F008A1;
	Sun,  8 Nov 2026 19:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165383;
	bh=hDPWmvInaWp2wgeM0od2Li5jTmlC0VSnDu9Tp3ujlp4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DWRYdLW03GiWffLovga+Iq0EPnZ9NHj2rUQxCvGN/uZLj1mfIAYRrpUl63hEZLGh1
	 De44HsD471r11Pex1jM0Ayr9muj5myH/MAjuPC317KyAjisdknFpw7azOJP8AZrScv
	 3f1GsSNjhIF6kfVuSSMSXHRFSgP9J9DBZZlYmxKp/f1Umm7+e6icYYu91JAaHFl+DC
	 JthQKu6mwILUWW+7kI6FRkmGeGZImX7V32AtlPxZCAZl1VsX00VVxSPFXJboSKZWRM
	 mVGQvffWVcr8T2vQ06WF83ogzi7Cl1xsteTA5hpkKK2FwrJXvt4bB061o6p1q3bqpP
	 kGG21wZE41Unw==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	damon@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 2/4] mm/damon/ops-common: implement DAMON_FILTER_TYPE_ACTIVE operation
Date: Sun,  8 Nov 2026 11:16:12 -0800
Message-ID: <20261108191615.113362-3-sj@kernel.org>
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

Implement DAMON_FILTER_TYPE_ACTIVE operation.  Use folio_test_active()
to show if the folio of the given memory is on an active LRU list.  The
implementation is made on ops-common, so both vaddr and paddr gain the
support of the filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 mm/damon/ops-common.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
index b9571f53e538c..2216a0023154f 100644
--- a/mm/damon/ops-common.c
+++ b/mm/damon/ops-common.c
@@ -574,6 +574,13 @@ bool damon_ops_filter_match(struct damon_filter *filter, struct folio *folio)
 		matched = filter->range_min <= folio_sz &&
 			folio_sz <= filter->range_max;
 		break;
+	case DAMON_FILTER_TYPE_ACTIVE:
+		if (!folio) {
+			matched = false;
+			break;
+		}
+		matched = folio_test_active(folio);
+		break;
 	default:
 		break;
 	}
-- 
2.47.3
