Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794165384;
	b=Yc9OOfLW4TIENcBl56iFcGDksYLibfZLdx55wn0ZLXm7eiUXAmePkMnI71fNgWpmib1i
	 l0wv1FY3J/26Fl/0H7WeMOZb+ZY6oChsGAXXIWr7IbANWPNwe/4v6fDcCnibA7S8h15n+
	 b1rSeptPtW59ft+586Hm+wJK4EFkzHGIp3Ot1ybpj2UhNxegDOpfBDLvit83o8knARKe5
	 ujOx28wYy4Q8z+AZYFrcISkRAx4J3/0SHPIgtxRS2SsOH0/rIRN6JIW0M7qiMxCwDLgpK
	 fqXhpWVOo2YfP69iyOV1YtGKw11Mq+nOulMAtv/qNEk851jhIt6vwvYj2dvs14KL+jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794165384;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=EeP31xDwtklkLCBDsJsARx3xlsMptNDNnDQPe92kOMU=;
	b=rFjhe77cYVmCJtj/8KbRK8fFFbVDkCb8T4SvB80WAacJTUPfu2k+9HIdGultxUQqDgX/
	 sCuPRq/R6X/8ZYEDu1gt39a1BNC9DB/zRVAMsGPi2mwnWCafqtoMtjPagGPnESSmGEca/
	 VBZ6ZsyUgGfraI+7e4p+OWiZG0hiRmI9aQDgwLjLQ5n9/cTFM3E5DBBT3Fq9+pwzVqqoZ
	 IUkiT4WFWV1ho4Y4vj6VcTsczaTEq2nprFC/1qitUX+e7gnZz6defxY/aFCNh8sLufj54
	 FzO2IBphFX1aKbbYMCOtQtlGImCBZ4SWiX1dl3LLjxhAzCk6qLkGeeQtwDlQB+L88nQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU7EM3I5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58A1606A338;
	Sun,  8 Nov 2026 19:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hU7EM3I5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498DE1F0089F;
	Sun,  8 Nov 2026 19:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794165384;
	bh=EeP31xDwtklkLCBDsJsARx3xlsMptNDNnDQPe92kOMU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hU7EM3I54v53dGUQvw/0DPNNvc2Vl2utnr+b2e0l7ztKjVHNigT8AnL6yE259Row/
	 vj6+DTH3Uf6JOTALlbtZuuSgjos5/t+4xYFV6kGEV3e9Js0xdfye3evfjZ00duAzDI
	 nk7IOfMWNTn3MGbWcYSXcRylbAgeLRD0+J0OlzUqcgL1/4FsbgUBlgLyuCDIiiabOP
	 MA6AKvFqInvwlPa9f5Qm9BYaqoZbAv9+KmFQVKXijUIPSogZzRyM0t+Naz5OdEAPzc
	 95RQbj7Cvh1ZDmFS56O4svbuIqJNmMc5iTIGaJ7el6lfh5XMIsiuSdtZP3CZl9ga0D
	 Vi9DCn1n54U7A==
From: SJ Park <sj@kernel.org>
To: 
Cc: SJ Park <sj@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: [RFC PATCH 4/4] Docs/mm/damon/design: update for DAMON_FILTER_TYPE_ACTIVE
Date: Sun,  8 Nov 2026 11:16:14 -0800
Message-ID: <20261108191615.113362-5-sj@kernel.org>
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

Update DAMON design document for the newly added LRU-activeness DAMON
filter type.

Signed-off-by: SJ Park <sj@kernel.org>
---
 Documentation/mm/damon/design.rst | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/mm/damon/design.rst b/Documentation/mm/damon/design.rst
index 8440c4954090e..b676be6971589 100644
--- a/Documentation/mm/damon/design.rst
+++ b/Documentation/mm/damon/design.rst
@@ -302,6 +302,7 @@ filter types.  Currently below filter types are supported.
 - ``pgidle_set``: Matches if the page for the memory is marked as access-idle.
 - ``hugepage_size``: Matches if the page for the memory is a part of a hugepage
   of a given size range.
+- ``active``: Same to that for DAMOS filters.
 
 If such probes are registered, DAMON executes the probes for each region's
 sampling memory when it does the access :ref:`sampling
-- 
2.47.3
